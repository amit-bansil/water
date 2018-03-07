/**
 * VMDL2. Created on Jan 19, 2003 by Amit Bansil. Copyright 2002 The Center for
 * Polymer Studies, All rights reserved.
 */
package org.cps.framework.core.io;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.collection.CollectionChangeEvent;
import org.cps.framework.core.event.core.GenericListener;
import org.cps.framework.core.event.core.GenericObservable;
import org.cps.framework.core.event.property.BoundPropertyRO;
import org.cps.framework.core.event.property.BoundPropertyRW;
import org.cps.framework.core.event.property.DefaultBoundPropertyRW;
import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.core.event.property.ValueChangeListener;
import org.cps.framework.util.lang.misc.VersionNumber;

/**
 * handles loading and saving of a document represented by registered document
 * data objects to and from a URL. Also manages versioning, providing as much
 * backward compatibilty as possible. TODO progress
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public final class DocumentManager {

	//------------------------------------------------------------------------
	//GLOBAL CONSTANTS
	//------------------------------------------------------------------------
	/**
     * When true any unneccessary information such as debugging data is excluded
     * from files.
     */
	public static final boolean COMPRESS_OUTPUT = true;

	/**
     * Versioning flag. As new document types are introduced this can be
     * checking the header for this flag can be used to check for backward
     * compatibilty.
     */
	private static final String DOCUMENT_V1_TYPE = "CPS 1.0 Document";

	//------------------------------------------------------------------------
	//LOGGING
	//------------------------------------------------------------------------

	private static final Logger log = Logger.getLogger(DocumentManager.class
			.getName());
	static {
		if (log.isLoggable(Level.CONFIG)) {
			log.config("Document Type=" + DOCUMENT_V1_TYPE);
			log.config("CompressOutput Type=" + COMPRESS_OUTPUT);
		}
	}

	//------------------------------------------------------------------------
	

	private final String appName;

	private final VersionNumber appVersion;

	//document data
	private final SaveableDataHolder dataHolder = new SaveableDataHolder();
	private final BoundPropertyRW<Boolean> stateSaved;
	private final BoundPropertyRW<VirtualFile> documentFile 
		= new DefaultBoundPropertyRW<VirtualFile>();

	private final GenericListener<?> stateChangeL=new GenericListener(){
        public void eventOccurred(Object arg0){
            stateSaved.set(Boolean.FALSE);
        }
	};
	private final Collection<GenericObservable> curStates=
		new ArrayList();
	public DocumentManager(VersionNumber appVersion, String appName) {
		this.appVersion = appVersion;
		this.appName = appName;
		
		//startout false to avoid adding listeners, inital load
		//makes this meaningless anyways...
		stateSaved = new DefaultBoundPropertyRW<Boolean>(false,Boolean.FALSE);
		stateSaved.addListener(new ValueChangeListener<Boolean>(){
            public void eventOccurred(ValueChangeEvent<Boolean> e){
                BoundCollectionRO<GenericObservable<?>> states=
                    dataHolder.stateObservables();
                if(e.getNewValue().booleanValue()){//stateSaved==true
                    assert curStates.isEmpty();
                    curStates.addAll(states.get());
                    for(GenericObservable<?> o:curStates)o.addListener(stateChangeL);
                    //trickyness here is b/c adding/removing a stateobservable
                    //cheetah bugs require this ugly casting
                    //constitutes a state change
                    states.addListener((GenericListener<CollectionChangeEvent<GenericObservable<?>>>)stateChangeL);
                }else if(!curStates.isEmpty()){
                    states.removeListener((GenericListener<CollectionChangeEvent<GenericObservable<?>>>)stateChangeL);
                    for(GenericObservable<?> o:curStates)o.removeListener(stateChangeL);
                    curStates.clear();
                }
            }
		});
		
	}

	/**
     * TEST error checking code
     * 
     * @param f file to load from, can't be null
     * @throws IOException
     */
	private final void _loadDocument(VirtualFile f) throws IOException {
		log.log(Level.INFO, "loading {0}", f);
		if (f == null) throw new NullPointerException("no document specified");
		//open stream-???will in get closed on error properly???
		InputStream _in;
		try {
			_in = f.getInputStream();
			log.log(Level.FINEST, "file opened");
		} catch (IOException e) {
			throw new LocalizedIOException("open_file_failed", null, e);
		}
		//readdata
		try {

			ObjectInputStreamEx in = new ObjectInputStreamEx(
					new BufferedInputStream(_in));

			readHeader(in);

			//now that we know we are (probably) ok lets kill the old before
            // opening the new
			if (documentFile.get() != null) doClose();
			try {
				dataHolder.read(in);
				dataHolder.initialize();
			} catch (IOException e) {
			    //really should not fail loading here
				loadBlankDocument();
				throw e;
			}
			documentFile.set(f);
			stateSaved.set(Boolean.TRUE);
		} finally {
			_in.close();
		}
	}

	private final void _save(VirtualFile f) throws IOException {
		OutputStream _out;
		try {
			_out = f.getOutputStream();
		} catch (IOException e) {
			throw new LocalizedIOException("unwriteable_file", null, e);
		}
		//readdata
		try {
			ObjectOutputStreamEx out = new ObjectOutputStreamEx(
					new BufferedOutputStream(_out), COMPRESS_OUTPUT);
			//write header
			out.writeUTF(DOCUMENT_V1_TYPE);
			out.writeUTF(appName);
			out.writeUTF(appVersion.toString());

			dataHolder.write(out);
			
			out.flush();
			
			documentFile.set(f);
			stateSaved.set(Boolean.TRUE);
		} finally {
			_out.close();
		}
	}

	private final void doClose() {
		log.log(Level.FINE, "closing document");
		final Iterator iter = dataHolder.getData().values().iterator();
		while (iter.hasNext()) {
			((DocumentData) iter.next()).loadBlank();
		}
	}

	public final BoundPropertyRO<VirtualFile> documentFile() {
		return documentFile;
	}

	public final void finishedRegisteringDocumentData() {
		log.log(Level.FINE, "document data registration complete");
		dataHolder.finishedRegisteringData();
	}

	//close-reverts everything
	public final void loadBlankDocument() {
		log.log(Level.INFO, "loading blank document");
		//do close
		doClose();
		documentFile.set(null);
		stateSaved.set(Boolean.TRUE);
	}

	public final void loadDocument(VirtualFile f) throws IOException {
		try {
			_loadDocument(f);
		} catch (IOException e) {
			log.log(Level.SEVERE, "load document '{0}' failed:{1}",
					new Object[]{f.getName(), e});
			log.log(Level.INFO,"exeption details",e);
			throw e;
		}
	}

	private void readHeader(ObjectInputStreamEx in) throws IOException {
		log.log(Level.FINEST, "loading header");
		//read header
		//as new header types are created switch on doc type
		String docType = in.readUTF();
		if (!docType.equals(DOCUMENT_V1_TYPE))
				throw new LocalizedIOException("unknown_type", new Object[][]{ {
						"type", docType}}, null);
		log.log(Level.FINE, "doctype={0]", docType);
		String appName_l = in.readUTF();
		if (!appName_l.equals(this.appName))
				throw new LocalizedIOException("unexpected_app",
						new Object[][]{ {"expected_app", this.appName},
								{"given_app", appName_l}}, null);

		log.log(Level.FINE, "doc app={0]", appName_l);
		String appVersion_l = in.readUTF();
		log.log(Level.FINE, "doc app.version={0]", appVersion_l);
		try {
			if (VersionNumber.parse(appVersion_l).compareTo(this.appVersion) == 1)
					throw new LocalizedIOException("newer_version",
							new Object[][]{ {"current_app", appName_l},
									{"current_version", this.appVersion},
									{"given_version", appVersion_l}}, null);
		} catch (ParseException e) {
			throw new IOException("couldn't read appVersion " + appVersion_l
					+ ":" + e);
		}

	}

	public final void registerDocumentData(String name, DocumentData d) {
		log.log(Level.FINE, "document data '{0}' registered", name);
		dataHolder.registerData(name, d);
		
	}

	//reload-when is document loaded
	public final void reloadDocument() throws IOException {
		if (documentFile.get() == null)
				throw new IllegalStateException("no document loaded");
		log.log(Level.FINER, "reloading document");
		loadDocument(documentFile.get());
	}

	/**
     * @throws IllegalStateException if url==null||url is not writeable
     * @throws IOException
     */
	public final void saveDocument() throws IOException {
		VirtualFile f = documentFile.get();
		if (f == null) throw new IllegalStateException("no file");
		if (!f.canWrite())
				throw new IllegalStateException("can't write " + f.getName());
		saveDocument(f);
	}

	/**
     * @param f
     * @throws NullPointerException is f==null
     * @throws IOException
     */
	public final void saveDocument(VirtualFile f) throws IOException {
		log.log(Level.INFO, "saving document to {0}", f);
		try {
			_save(f);
		} catch (IOException e) {
			log.log(Level.SEVERE, "error saving document to {0}:{1}",
					new Object[]{f, e});
			log.log(Level.INFO,"exeption details",e);
			throw e;
		}
	}
	public final BoundPropertyRO<Boolean> stateSaved(){
	    return stateSaved;
	}
}

/*
 * CREATED ON:    Apr 28, 2006 4:05:38 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.gui.resources;

import cps.jarch.util.misc.LangUtils;
import cps.jarch.util.misc.LogEx;
import cps.jarch.util.notes.Constant;
import cps.jarch.util.notes.Nullable;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Enumeration;

/**
 * <p>
 * Loads resources from the class path. Resources are identified by paths
 * composed of names separated by <code>SEPARATOR_CHAR</code> relative to an
 * owning package. Paths are specified/returned without trailing or
 * leading separators.
 * </p>
 * 
 * @version $Id: ResourceResolver.java 78 2005-12-28 22:30:33Z bansil $
 * @author Amit Bansil
 */
public class ResourceLoader {
	private static final LogEx<ResourceLoader> log = LogEx.createClassLog(ResourceLoader.class);
	// ------------------------------------------------------------------------
	private final String basePath;
	/**
	 * @return path relative to which resources are loaded for this. No trailing
	 *         or leading separator.
	 */

	public final @Constant String getBasePath() {
		return basePath;
	}
	// ------------------------------------------------------------------------
	// creation
	/**
	 * Create ResourceLoader for loading resources relative to owner's package.
	 */
	public static final ResourceLoader create(Class owner) {
		return new ResourceLoader(owner.getPackage().getName().replace('.', SEPARATOR_CHAR));
	}
	/**
	 * character for separating elements of a resource's path.
	 */
	private static final char SEPARATOR_CHAR = '/';
	
	ResourceLoader(String basePath) {
		this.basePath=basePath;
	}
	
	/**
	 * @return ResourceLoader that loads resources from subPath.
	 */
	public final ResourceLoader deriveChild(String subPath) {
		return new ResourceLoader(basePath+SEPARATOR_CHAR+subPath);
	}
	
	// ------------------------------------------------------------------------
	// find resource
	
	/**
	 * @throws Error
	 *             if resource is not found. otherwise returns result of
	 *             {@link #tryFindResource}.
	 */
	public final URL findExpectedResource(String name) {
		URL ret=tryFindResource(name);
		if(ret==null)throw new Error("could not find "+name+" in "+this);
		return ret;
	}
	
	/**
	 * @return URL for accessing resource specified by <code>name</code>.
	 *         If multiple resources exist for that name 1 is arbitrarily selected and
	 *         a warning is output. If an <code>IOException</code> occurs while 
	 *         loading the resource it is logged and <code>null</code> is returned. If 
	 *         no resource is found for that name <code>null</code> is returned.
	 */
	public final @Nullable URL tryFindResource(String name) {
		log.debugEnter(this,"name", name);
		
		String fullPath=basePath+SEPARATOR_CHAR+name;
		LangUtils.checkArgNotNull(fullPath);
		try {
			Enumeration<URL> ret = ResourceLoader.class.getClassLoader().getResources(
				fullPath);

			// OPTIMIZED for length==0||length==1
			if (ret == null || !ret.hasMoreElements()) return null;
			URL first = ret.nextElement();
			if (!ret.hasMoreElements()) return first;
			else {
				// TODO clearer error
				log.warning(this, "'{0}' is ambiguous, resolves to '{1}' and '{2}'",
					fullPath, ret.nextElement(), first);
				return first;
			}
		} catch (IOException e) {
			log.warning(this, "IOException while finding resource: {0}", e, fullPath);
			return null;
		}
	}
	
	// ------------------------------------------------------------------------
	// stream loading
	
	public final @Nullable InputStream tryLoadStream(String name) {
		URL ret=tryFindResource(name);
		
		try {
			return ret.openStream();
		} catch (IOException e) {
			log.warning(this, "IOException while openingResource resource: {0}", e, this);
			return null;
		}
	}
	public final InputStream loadStream(String name)throws IOException{
		URL ret=tryFindResource(name);
		if(ret==null)throw new IOException("stream "+name+" not found in "+this);
		return ret.openStream();
	}
	public final InputStream loadExpectedStream(String name) {
		try {
			return loadStream(name);
		} catch (IOException e) {
			throw new Error("unexpected IOException while loading " + name + " in "
					+ this, e);
		}
	}
	// ------------------------------------------------------------------------
	// object methods
	
	@Override public final String toString() {
		return "ResourceLoader["+basePath+"]";
	}
	@Override public int hashCode() {
		return basePath.hashCode();
	}
	@Override public boolean equals(Object obj) {
		if (this == obj) return true;
		if (obj == null) return false;
		
		if (getClass() != obj.getClass()) return false;
		
		final ResourceLoader other = (ResourceLoader) obj;
		
		return LangUtils.equals(other.basePath, basePath);
	}
}
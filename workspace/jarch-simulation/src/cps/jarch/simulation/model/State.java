/*
 * CREATED ON:    Jan 27, 2006 4:02:35 PM
 * CREATED BY:    bansil 
 */
package cps.jarch.simulation.model;

import cps.jarch.data.io.ObjectInputStreamEx;
import cps.jarch.data.io.ObjectOutputStreamEx;
import cps.jarch.data.value.tools.Converter.ConversionException;
import cps.jarch.util.misc.IOUtils;
import cps.jarch.util.misc.LogEx;
import cps.jarch.util.notes.Constant;
import cps.jarch.util.notes.Nullable;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * <p>A strict mapping from a fixed set of {@link Key}s to editable values.
 * </p>
 * @version $Id$
 * @author bansil
 */
public class State{
	private static final LogEx<State> log = LogEx.createClassLog(State.class);
	
	// ------------------------------------------------------------------------
	private final HashMap<Key, Object> data;
	//used to mark keys that map to null
	private final Object NULL_VALUE=new Object();
	
	// ------------------------------------------------------------------------
	/**
	 * Create state that allows keys in <code>keys</code>.
	 * @throws IllegalArgumentException if two keys have the same name.
	 */
	@SuppressWarnings("unchecked") public State(Iterable<Key> keys) {
		data=new HashMap<Key, Object>();
		//make sure we have no repeated names
		buildNameToKeyMap(keys);
		//initialize all keys to default
		for(Key key:keys)data.put(key, key.getDefaultValue());
	}
	/**
	 * copy constructor. Shallow copy is in effect deep since keys & values are immutlabe.
	 */
	public State(State state) {
		this.data=new HashMap<Key, Object>(state.data);
	}
	// ------------------------------------------------------------------------
	// get/set
	/**
	 * get value associated with key.
	 * 
	 * @throws IllegalArgumentException
	 *             if key is not allowed in this map.
	 */
	@SuppressWarnings("unchecked") public @Nullable <T> T get(Key<T> key) {
		checkKeyAllowed(key);
		Object ret=data.get(key);
		assert ret!=null;
		
		if(ret==NULL_VALUE)return null;
		else return (T)ret;
	}
	/**
	 * @return true iff this key is allowed to be set/get on this State.
	 */
	public final boolean isKeyAllowed(Key k) {
		return data.get(k)!=null;
	}
	/**
	 * @return all the keys that are allowed on this state.
	 */
	public final @Constant Iterable<Key> getAllowedKeys(){
		return data.keySet();
	}
	/**
	 * Set <code>value</code> associated with <code>key</code>.
	 * 
	 * @throws IllegalArgumentException
	 *             if <code>key</code> is not an allowed key for this state.
	 * @throws Exception
	 *             if <code>value</code> does not pass <code>key</code>'s
	 *             check.
	 */
	public @Nullable <T> T set(Key<T> key,T value)throws Exception{
		checkKeyAllowed(key);
		key.checkValue(value);
		return get(key);
	}

	private final void checkKeyAllowed(Key key) {
		if(!isKeyAllowed(key))throw new IllegalArgumentException(
				"key "+key+" is not allowed in this");
	}
	
	// ------------------------------------------------------------------------
	// io
	@SuppressWarnings("unchecked") public static final State read(Iterable<Key> keys,
			ObjectInputStreamEx in) throws IOException {
		in.beginSection(SECTION_NAME, SECTION_VERSION);
		final int entryCount = in.readInt();

		Map<String, Key> keysByName = buildNameToKeyMap(keys);

		State state = new State(keys);
		for (int i = 0; i < entryCount; i++) {
			String keyName = in.readUTF();
			String value = in.readUTF();
			Key key = keysByName.get(keyName);

			try {
				if (key == null)
					throw new IllegalArgumentException("no key for that name was found");
				Object valueT = key.getToStringConverter().unconvert(value);
				state.set(key, valueT);
			} catch (Exception e) {
				log.warning(null, "key name={0} value=''{1}'' "
						+ "cannot be set, the default will be used instead", e, keyName,
					value);
			}
		}

		in.endSection(SECTION_NAME);
		
		return state;
	}
	private static final String SECTION_NAME="State";
	private static final int SECTION_VERSION=1;
	@SuppressWarnings("unchecked") public final void write(ObjectOutputStreamEx out)
			throws IOException {
		out.beginSection(SECTION_NAME, SECTION_VERSION);
		Set<Map.Entry<Key, Object>> entries = data.entrySet();
		out.writeInt(entries.size());
		for (Map.Entry<Key, Object> e : entries) {
			Key k = e.getKey();
			out.writeUTF(k.getDescription().getName().toString());
			try {
				out.writeUTF((String) k.getToStringConverter().convert(e.getValue()));
			} catch (ConversionException ex) {
				// should not happen
				throw IOUtils.newIOE("unexpected conversion exception", ex);
			}
		}
		out.endSection(SECTION_NAME);
	}
	// ------------------------------------------------------------------------
	/**
	 * @return Map from name of each key in keys to the respective key.
	 * @throws IllegalArgumentException
	 *             if a name is repeated.
	 */
	@SuppressWarnings("unchecked") public static final Map<String, Key> buildNameToKeyMap(
			Iterable<Key> keys) {
		Map<String, Key> keysByName = new HashMap();
		for (Key key : keys)
			if (keysByName.put(key.getDescription().getName().toString(), key) != null)
				throw new IllegalArgumentException("name '" + key.getDescription()
						+ "' is repeated in " + keys);
		return keysByName;
	}
	
}

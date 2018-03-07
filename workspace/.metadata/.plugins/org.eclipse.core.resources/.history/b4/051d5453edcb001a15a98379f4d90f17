/*
 * Created on Feb 22, 2003
 */
package cps.jarch.util.collections;


import cps.jarch.util.misc.LangUtils;
import cps.jarch.util.notes.Constant;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * A map wrapper that aggressively prevents possibly incorrect use. It throws
 * exceptions when values are either unexplicitly overwritten or unavailable.
 * <code>null</code> values are not allowed. Although the exceptions are meant
 * primarily for error checking purposes, if an action fails the map is restored
 * to its state before the action was taken so that the client may catch the
 * exception and recover.
 * 
 * @param <K>
 *            key type
 * @param <V>
 *            value type
 * 
 * @author Amit Bansil
 */
public final class SafeMap<K, V> {
	// ------------------------------------------------------------------------
	// fields
	// ------------------------------------------------------------------------

	// the underlying map as well as a read only decorator to it
	private final Map<K, V> map, mapRO;

	// ------------------------------------------------------------------------
	// constructors
	// ------------------------------------------------------------------------

	/**
	 * creates SafeMap backed by a HashMap. 
	 * 
	 * @see HashMap#HashMap(int, float)
	 */
	public SafeMap(int initialCapacity, float loadFactor) {
		map = new HashMap<K, V>(initialCapacity, loadFactor);
		mapRO = Collections.unmodifiableMap(map);
	}
	/**
	 * creates SafeMap backed by a HashMap. 
	 * 
	 * @see HashMap#HashMap()
	 */
	public SafeMap() {
		map = new HashMap<K, V>();
		mapRO = Collections.unmodifiableMap(map);
	}
	/**
	 * creates SafeMap backed by a HashMap. 
	 * 
	 * @see HashMap#HashMap(int)
	 */
	public SafeMap(int initialCapacity) {
		map = new HashMap<K, V>(initialCapacity);
		mapRO = Collections.unmodifiableMap(map);
	}
	/**
	 * creates SafeMap copied from <code>m</code>.
	 */
	public SafeMap(SafeMap<K,V> m) {
		map = new HashMap<K, V>(m.map);
		mapRO = Collections.unmodifiableMap(map);
	}

	// ------------------------------------------------------------------------
	// access


	/**
	 * @return unmodifiable access to the underlying map. constant.
	 */
	@Constant public final Map<K, V> getMap() {
		return mapRO;
	}

	/**
	 * @see Map#containsKey(java.lang.Object)
	 */
	public final boolean containsKey(K key) {
		return map.containsKey(key);
	}

	/**
	 * assigns a <code>value</code> to an unused <code>key</code>.
	 * 
	 * @throws IllegalArgumentException
	 *             if a <code>key</code> is already associated with value even
	 *             if that value is the same as the new <code>value</code>
	 */
	public void put(K key, V value) {
		LangUtils.checkArgNotNull(value, "value");

		V r = map.put(key, value);
		if (r != null) {
			map.put(key, r); // restore
			throw new IllegalArgumentException("key " + key
					+ " already used by " + r + " so " + value
					+ " could not be added");
		}
	}

	/**
	 * dissociates a previously created <code>key</code> <code>value</code> association.
	 * 
	 * @throws IllegalArgumentException
	 *             if key not associated with value
	 */
	public void remove(K key, V value) {
		LangUtils.checkArgNotNull(value, "value");

		V r = map.remove(key);
		if (r != value) {
			map.put(key, r); // restore
			throw new IllegalArgumentException("key " + key + " contains " + r
					+ " not " + value + " so was not removed");
		}
	}

	/**
	 * remove a <code>key</code> that has been associated with a value. It is
	 * safer to use <code>remove(key,value)</code> when it is known what value
	 * is associated with <code>key</code>.
	 * 
	 * @throws IllegalArgumentException
	 *             if no value was associated with key
	 * @return value associated with key, not <code>null</code>
	 */
	public V remove(K key) {
		V r = map.remove(key);
		if (r == null)
			throw new IllegalArgumentException("key " + key
					+ " can't be removed until it is added");
		return r;
	}

	/**
	 * @return value associated with <code>key</code>, not <code>null</code>
	 * @throws IllegalArgumentException
	 *             if <code>key</code> is not associated with a value.
	 */
	public V get(K key) {
		V ret = map.get(key);
		if (ret == null)
			throw new IllegalArgumentException("key " + key + " not defined");
		return ret;
	}

	/**
	 * clears underlying map.
	 * @see Map#clear()
	 */
	public final void clear() {
		map.clear();
	}
}

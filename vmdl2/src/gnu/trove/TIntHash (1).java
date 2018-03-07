///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2001, Eric D. Friedman All Rights Reserved.
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
///////////////////////////////////////////////////////////////////////////////

package gnu.trove;

import java.io.Serializable;

/**
 * An open addressed hashing implementation for int primitives.
 *
 * Created: Sun Nov  4 08:56:06 2001
 *
 * @author Eric D. Friedman
 * @version $Id: TIntHash.java,v 1.9 2002/07/08 00:51:20 ericdf Exp $
 */

abstract public class TIntHash extends TPrimitiveHash
    implements Serializable {

    /** the set of ints */
    protected transient int[] _set;

    /**
     * Creates a new <code>TIntHash</code> instance with the default
     * capacity and load factor.
     */
    public TIntHash() {
        super();
    }

    /**
     * Creates a new <code>TIntHash</code> instance whose capacity
     * is the next highest prime above <tt>initialCapacity + 1</tt>
     * unless that value is already prime.
     *
     * @param initialCapacity an <code>int</code> value
     */
    public TIntHash(int initialCapacity) {
        super(initialCapacity);
    }

    /**
     * Creates a new <code>TIntHash</code> instance with a prime
     * value at or near the specified capacity and load factor.
     *
     * @param initialCapacity used to find a prime capacity for the table.
     * @param loadFactor used to calculate the threshold over which
     * rehashing takes place.
     */
    public TIntHash(int initialCapacity, float loadFactor) {
        super(initialCapacity, loadFactor);
    }

    /**
     * initializes the hashtable to a prime capacity which is at least
     * <tt>initialCapacity + 1</tt>.  
     *
     * @param initialCapacity an <code>int</code> value
     * @return the actual capacity chosen
     */
    protected int setUp(int initialCapacity) {
        int capacity;

        capacity = super.setUp(initialCapacity);
        _set = new int[capacity];
        return capacity;
    }
    
    /**
     * Searches the set for <tt>val</tt>
     *
     * @param val an <code>int</code> value
     * @return a <code>boolean</code> value
     */
    public boolean contains(int val) {
        return index(val) >= 0;
    }

    /**
     * Executes <tt>procedure</tt> for each element in the set.
     *
     * @param procedure a <code>TObjectProcedure</code> value
     * @return false if the loop over the set terminated because
     * the procedure returned false for some value.
     */
    public boolean forEach(TIntProcedure procedure) {
        byte[] states = _states;
        int[] set = _set;
        for (int i = set.length; i-- > 0;) {
            if (states[i] == FULL && ! procedure.execute(set[i])) {
                return false;
            }
        }
        return true;
    }

    /**
     * Releases the element currently stored at <tt>index</tt>.
     *
     * @param index an <code>int</code> value
     */
    protected void removeAt(int index) {
        super.removeAt(index);
        _set[index] = (int)0;
    }

    /**
     * Locates the index of <tt>val</tt>.
     *
     * @param val an <code>int</code> value
     * @return the index of <tt>val</tt> or -1 if it isn't in the set.
     */
    protected int index(int val) {
        int hash, probe, index, length;
        int[] set;
        byte[] states;

        states = _states;
        set = _set;
        length = states.length;
        hash = HashFunctions.hash(val) & 0x7fffffff;
        index = hash % length;

        if (states[index] != FREE &&
            (states[index] == REMOVED || set[index] != val)) {
            // see Knuth, p. 529
            probe = 1 + (hash % (length - 2));

            do {
                index -= probe;
                if (index < 0) {
                    index += length;
                }
            } while (states[index] != FREE &&
                     (states[index] == REMOVED || set[index] != val));
        }

        return states[index] == FREE ? -1 : index;
    }

    /**
     * Locates the index at which <tt>val</tt> can be inserted.  if
     * there is already a value equal()ing <tt>val</tt> in the set,
     * returns that value as a negative integer.
     *
     * @param val an <code>int</code> value
     * @return an <code>int</code> value
     */
    protected int insertionIndex(int val) {
        int hash, probe, index, length;
        int[] set;
        byte[] states;

        states = _states;
        set = _set;
        length = states.length;
        hash = HashFunctions.hash(val) & 0x7fffffff;
        index = hash % length;

        if (states[index] == FREE) {
            return index;       // empty, all done
        } else if (states[index] == FULL && set[index] == val) {
            return -index -1;   // already stored
        } else {                // already FULL or REMOVED, must probe
            // compute the double hash
            probe = 1 + (hash % (length - 2));
            // starting at the natural offset, probe until we find an
            // offset that isn't full.
            do {
                index -= probe;
                if (index < 0) {
                    index += length;
                }
            } while (states[index] == FULL && set[index] != val);

            // if the index we found was removed: continue probing until we
            // locate a free location or an element which equal()s the
            // one we have.
            if (states[index] == REMOVED) {
                int firstRemoved = index;
                while (states[index] != FREE &&
                       (states[index] == REMOVED || set[index] != val)) {
                    index -= probe;
                    if (index < 0) {
                        index += length;
                    }
                }
                return states[index] == FULL ? -index -1 : firstRemoved;
            }
            // if it's full, the key is already stored
            return states[index] == FULL ? -index -1 : index;
        }
    }

} // TIntHash

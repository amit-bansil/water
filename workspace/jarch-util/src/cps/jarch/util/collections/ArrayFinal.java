package cps.jarch.util.collections;


import cps.jarch.util.misc.LangUtils;
import cps.jarch.util.misc.LogEx;
import cps.jarch.util.notes.Constant;
import cps.jarch.util.notes.Hook;
import cps.jarch.util.notes.NotThreadSafe;
import cps.jarch.util.notes.Nullable;
import cps.jarch.util.notes.ThreadSafe;

import java.util.Arrays;
import java.util.Collection;
import java.util.Iterator;
import java.util.NoSuchElementException;

/**
 * <p>
 * A constant array. If the element type <code>T</code> is or could be tagged as a
 * {@link cps.jarch.util.notes.Immutable} so is the
 * <code>ArrayFinal</code>.
 * </p>
 * <p>
 * Classes desiring to provide readonly access to an array that is changing may
 * find it more efficient to internally use a {@link java.util.List} and expose
 * only the pertinent methods such as {@link java.util.Collection#toArray()} and
 * {@link java.util.Collection#iterator()} or the entire <code>Collection</code>
 * protected through a
 * {@link java.util.Collections#unmodifiableList(java.util.List)}.
 * </p>
 * <p>
 * <b>Implementation:</b> Rather than simply providing read only access to an
 * array this class keeps track of subset of the elements of a larger
 * <code>data</code> array defined by <code>startIndex</code> and
 * <code>length</code>. All operations consider only this subset of elements.
 * This setup allows for very fast implementations of methods like
 * {@link ArrayFinal#subArray(int, int)} as well as the
 * {@link cps.jarch.util.collections.ArrayFinal.Builder} class.
 * </p>
 * <p>
 * The immutability of this class makes all methods
 * {@link cps.jarch.util.notes.ThreadSafe} although the underlying
 * objects may not be {@link cps.jarch.util.notes.ThreadSafe}.
 * </p>
 * 
 * @author Amit Bansil
 * @version $Id: ArrayFinal.java 570 2005-09-11 22:32:52Z bansil $.
 */
public final class ArrayFinal<T> implements Iterable<T>{
	private static final LogEx<ArrayFinal> log = LogEx.createClassLog(ArrayFinal.class);
	// ------------------------------------------------------------------------
	// members
	
    private final int length;
    private final int startIndex;
    //only elements startingIndex through starIndex+length-1 are considered in data
    private final T[] data;
    
    // ------------------------------------------------------------------------
    
    /**
	 * private constructor, just sets fields. care must be taken not to modify
	 * data between <code>startIndex</code> and <code>length</code>. Callers should also ensure
	 * <code>data</code> is not <code>null</code> and contains <code>startIndex</code>
	 * and <code>length</code>.
	 */
	private ArrayFinal(T[] data, int startIndex, int length) {
		assert data!=null;
		assert startIndex >= 0 &&
			length > 0 &&
			data.length >= startIndex+length;
		
        this.startIndex = startIndex;
        this.data = data;
        this.length = length;
    }
	
	// ------------------------------------------------------------------------
	// access
	
	@ThreadSafe public boolean contains(@Nullable T t) {
		return indexOf(t)!=-1;
	}
	/**
	 * @return index of first occurrence of <code>t</code> in this array or
	 *         <code>-1</code> if not found. <code>t</code> may be <code>null</code>.
	 *         <code>get(indexOf(t)).equals(t)</code> for all elements t of this.
	 */
	@ThreadSafe public int indexOf(@Nullable T t) {
		for(int i=startIndex;i<startIndex+length;i++) {
			if(LangUtils.equals(t, data[i]))return i-startIndex;
		}
		return -1;
	}
	
	/**
	 * @return element at <code>index</code>.
	 * @throws ArrayIndexOutOfBoundsException
	 *             if <code>index</code> is not in [0,<code>getLength()</code>].
	 */
	@ThreadSafe public final T get(int index) {
    	if(index<0)throw new ArrayIndexOutOfBoundsException(
    		"index "+index+" < 0");
    		
        final int i = startIndex + index;
        if (i >= length) throw new ArrayIndexOutOfBoundsException(
                "index '" + i + "' > length '" + length + '\'');
        return data[i];
    }
    /**
     * @return length of array. length >= 0.
     */
	@ThreadSafe @Constant public final int getLength() {
    	assert length>=0;
        return length;
    }

    /**
	 * copy <code>outLength</code> elements from this starting at
	 * <code>srcStartIndex</code> to <code>out</code> starting at
	 * <code>outStartIndex</code>.
	 * 
	 * @throws ArrayIndexOutOfBoundsException
	 *             if copying would cause access of data outside array bounds.
	 */
	@ThreadSafe public final void toArray(int srcStartIndex, T[] out,
			int outStartIndex, int outLength) {
		try {
			System.arraycopy(data, srcStartIndex + startIndex, out, outStartIndex,
				outLength);
			assert out!=null;
		} catch (IndexOutOfBoundsException e) {
			log.warning(this, "System.arraycopy failed", e);
			// clarify exception
			if (srcStartIndex < 0)
				throw new ArrayIndexOutOfBoundsException("srcStartIndex " + srcStartIndex
						+ " < 0");
			if (outStartIndex < 0)
				throw new ArrayIndexOutOfBoundsException("outStartIndex " + outStartIndex
						+ " < 0");
			if (outLength < 0)
				throw new ArrayIndexOutOfBoundsException("outLength " + outLength
						+ " < 0");

			if (srcStartIndex + outLength >= length)
				throw new ArrayIndexOutOfBoundsException("last index " + srcStartIndex
						+ outLength + " >= this.length " + length);

			if (outStartIndex+outLength >= out.length)
				throw new ArrayIndexOutOfBoundsException("outStartIndex " + outStartIndex
						+ " >= out.length " + out.length);
			
			//should not happen
			throw new Error(e);
		}
	}
	
    // --------------------------------------------------------------------------
	/**
	 * @return a new <code>ArrayFinal</code> with a <code>newStartIndex</code>
	 *         and <code>newLength</code>.
	 * @throws ArrayIndexOutOfBoundsException
	 *             <code>if(newStartIndex<0||newLength+newStartIndex>getLength())</code>
	 */
	@ThreadSafe public final ArrayFinal<T> subArray(int newStartIndex,
			int newLength) {
		if (newStartIndex < 0 || newLength + newStartIndex > length)
			throw new ArrayIndexOutOfBoundsException();
		return new ArrayFinal<T>(data, startIndex + newStartIndex, newLength);
	}
    // --------------------------------------------------------------------------
    //composite

	@ThreadSafe public static <T> ArrayFinal<T> composite(ArrayFinal<T> a,
                                                  ArrayFinal<T> b) {
        return composite(a.data, a.startIndex, a.length, b.data, b.startIndex, b.length);
    }

	@ThreadSafe public static <T> ArrayFinal<T> composite(ArrayFinal<T> a, T[] b) {
        return composite(a.data, a.startIndex, a.length, b, 0, b.length);
    }

	@ThreadSafe public static <T>ArrayFinal<T> composite(T[] a, ArrayFinal<T> b) {
		return composite(a, 0, a.length, b.data, b.startIndex, b.length);
	}
    /**
	 * @return a new <code>ArrayFinal</code> created by packing the elements
	 *         of <code>b</code> from <code>bStartIndex</code> to
	 *         <code>bLength+bStartIndex-1</code> after the elements of
	 *         <code>a</code> from <code>aStartIndex</code> to
	 *         <code>aStartIndex+aLength-1</code>.
	 * @throws IndexOutOfBoundsException
	 *             if copy causes access out of the bounds of <code>a</code>
	 *             or <code>b</code>.
	 */
	@ThreadSafe @SuppressWarnings("unchecked")  public static <T>ArrayFinal<T> composite(
			T[] a, int aStartIndex, int aLength, T[] b, int bStartIndex, int bLength) {
		T[] data = (T[]) new Object[aLength + bLength];
		System.arraycopy(a, aStartIndex, data, 0, aLength);
		System.arraycopy(b, bStartIndex, data, aLength, bLength);
		return new ArrayFinal<T>(data, 0, aLength + bLength);
	}
    // --------------------------------------------------------------------------
	// create

	/**
	 * @return a new <code>ArrayFinal</code> created from <code>length</code>
	 *         elements copied from <code>data</code> starting at
	 *         <code>startIndex</code>.
	 * @param startIndex
	 *            default is 0.
	 * @param length
	 *            default is <code>data.length</code>
	 */
	@ThreadSafe @SuppressWarnings({"unchecked"}) public static final <T>ArrayFinal<T> create(
			T[] data, int startIndex, int length) {
		T[] ret = (T[]) new Object[length];
		System.arraycopy(data, startIndex, ret, 0, length);
		return new ArrayFinal<T>(ret, 0, length);
	}
	@ThreadSafe public static final <T>ArrayFinal<T> create(T... data) {
		return create(data, 0, data.length);
	}
    /**
	 * create <code>ArrayFinal</code> from {@link Collection}
	 * <code>data</code>, avoiding a potentially redundant array copy.
	 */
	@ThreadSafe @SuppressWarnings("unchecked")  public static final <T>ArrayFinal<T> create(
			Collection<T> data) {
		final int l = data.size();
		return new ArrayFinal<T>(data.toArray((T[]) new Object[l]), 0, l);
	}
    //--------------------------------------------------------------------------
    /**
     * @see Iterable#iterator()
     * Note that this method returns a new iterator each time it is invoked. That
     * iterator object CAN'T be safely accessed from multiple threads although this
     * method can be.
     */
	@ThreadSafe public Iterator<T> iterator() {
        return new IndexedIterator<T>(length){
            @Override protected T _getNext(int i) {
                return get(i);
            }
        };
    }
    // ------------------------------------------------------------------------
    // object implementation

    /**
	 * @see java.lang.Object#equals(java.lang.Object)
	 * This method is thread safe unless for some very odd reason the equals comparison
	 * of one of the array's elements was not.
	 */
	@Override
	public boolean equals(Object obj) {
		//quick test
		if(obj==this)return true;
		//cast to this class
		//will correctly return false if(obj==null) since (null instanceof AnyClass)==false 
		if (obj instanceof ArrayFinal) {
			ArrayFinal a = (ArrayFinal) obj;
			//compare significant fields
			//length
			if(a.length!=length)return false;
			//data
			for(int i=0;i<startIndex+length;i++) {
				if(!LangUtils.equals(data[startIndex+i],a.data[a.startIndex+i]))
					return false;
			}
			
			return true;
		}else return false;
	}

	/**
	 * @see java.lang.Object#hashCode()
	 * @see Arrays#hashCode(Object[]) where implementations was adapted from.
	 *      note that result is not cached since changes to the underlying
	 *      objects may change <code>hashCode</code>.
	 * This method is thread safe unless for some very odd reason the hashcode comparison
	 * of one of the array's elements was not.
	 */
	@Override public int hashCode() {
        int result = 1;
 
        for (Object element : this)
            result = 31 * result + (element == null ? 0 : element.hashCode());
 
        return result;
	}
	
    /**
	 * @see java.lang.Object#toString()
	 * @see Arrays#toString(Object[]) where implementations was adapted from.
	 */
	@Override
	public String toString() {
        if (length == 0)
            return "[]";
 
        StringBuilder buf = new StringBuilder();
 
        for (int i = startIndex; i < startIndex+length; i++) {
            if (i == 0)
                buf.append('[');
            else
                buf.append(", ");
 
            buf.append(String.valueOf(data[i]));
        }
 
        buf.append("]");
        return buf.toString();
	}
	
    //--------------------------------------------------------------------------
    //builder
	/**
	 * utility class to create <code>ArrayFinal</code> objects. First add
	 * elements and then call <code>create</code>. Possibly repeat. Much more
	 * efficient that using a <code>List</code> and the
	 * {@link ArrayFinal#create(Collection)} method but also does not support
	 * the full range of modifications a <code>List</code> permits. 
	 * This class is generally not thread safe.
	 */
	public static final class Builder<ST> {
        private ST[] data;
        private int size;
        
        public Builder(int initialSize) {
            this(initialSize, 1.1f, 0);
        }
		/**
		 * creates Builder.
		 * @param initialCapacity number of elements to allocate at first.
		 * @param expandFactor default is 1.1f 
		 * @param expandAmount default is 0
		 */
        @SuppressWarnings({"unchecked"})
        public Builder(int initialCapacity, float expandFactor, int expandAmount) {
            if (expandAmount < 0 || expandFactor < 1.0f) {
                throw new IllegalArgumentException("negative expansion");
            }
            data = (ST[]) new Object[initialCapacity];
            size = 0;
        }

        //--------------------------------------------------------------------------
        public ArrayFinal<ST> create() {
            return new ArrayFinal<ST>(data, 0, size);
        }
		/**
		 * @return an ArrayFinal containing elements <code>startIndex</code>
		 *         through <code>startIndex+length-1</code>.
		 * @throws ArrayIndexOutOfBoundsException
		 *             if those elements are not yet defined.
		 */
         public ArrayFinal<ST> create(int startIndex, int length) {
			if (startIndex >= length)
				throw new ArrayIndexOutOfBoundsException("startIndex '" + startIndex
						+ "' > size '" + size + '\'');
			if (startIndex + length >= size)
				throw new ArrayIndexOutOfBoundsException("lastIndex '"
						+ (startIndex + length) + "' > size '" + size + '\'');
			if (startIndex < 0 || length < 0)
				throw new ArrayIndexOutOfBoundsException("negative argument");
			
			return new ArrayFinal<ST>(data, startIndex, length);
		}
        // --------------------------------------------------------------------------

        @NotThreadSafe public final void add(@Nullable ST v) {
            ensureCapacity(size + 1);
            data[size] = v;
            size++;
        }

        @NotThreadSafe  public final void addAll(ST[] v) {
            addAll(v, 0, v.length);
        }
        @NotThreadSafe  public final void addAll(ArrayFinal<? extends ST> f) {
        	addAll(f.data,f.startIndex,f.length);
        }
        /**
		 * append the subset of elements in <code>v</code> from
		 * <code>startIndex</code> to <code>startIndex+length-1</code> to
		 * this builder, resizing if needed. <code>v</code> may contain
		 * <code>null</code> elements. subsequent calls to
		 * <code>create()</code> will contain these elements in addition to
		 * any previous elements added.
		 */
        @NotThreadSafe public final void addAll(ST[] v, int startIndex, int length) {
            ensureCapacity(size + length);
            System.arraycopy(v, startIndex, data, size, length);
            size += length;
        }

        //--------------------------------------------------------------------------
        
        /**
		 * current number elements in this <code>Builder</code> as distinct
		 * from the <code>capacity</code> which is the maximum number of
		 * elements that can be added to the builder before resizing.
		 */
         public final int size() {
            return size;
        }

        /**
		 * Increases the capacity of this <tt>Builder</tt> instance, which is
		 * the number of elements that can be added before resizing the, if
		 * necessary, to ensure that it can hold at least the number of elements
		 * specified by the minimum capacity argument.
		 * 
		 * @see java.util.ArrayList#ensureCapacity(int) for original
		 *      implementation.
		 * @param minCapacity
		 *            the desired minimum capacity.
		 */
        @SuppressWarnings({"unchecked"})
        @NotThreadSafe public void ensureCapacity(int minCapacity) {
            int oldCapacity = data.length;
            if (minCapacity > oldCapacity) {
                Object oldData[] = data;
                int newCapacity = (oldCapacity * 3) / 2 + 1;
                if (newCapacity < minCapacity)
                    newCapacity = minCapacity;
                data = (ST[]) new Object[newCapacity];
                System.arraycopy(oldData, 0, data, 0, size);
            }
        }
    }

	//------------------------------------------------------------------------
	/**
	 * Simple iterator that traverses an indexed list of known length.
	 */
	private static abstract class IndexedIterator<LT> implements Iterator<LT> {
	    public IndexedIterator(int length) {
	        this.length = length;
	    }

	    private int i;
	    private final int length;

	    public final boolean hasNext() {
	        return i < length;
	    }

	    public final LT next() {
	        if (!hasNext()) throw new NoSuchElementException();
	        LT ret = _getNext(i);
	        i++;
	        return ret;
	    }

	    /**
	     * @param index guaranteed to be less than length and exactly one more than previous.
	     * @return t at index.
	     */
	    @Hook protected abstract LT _getNext(int index);

	    /**
	     * @throws UnsupportedOperationException
	     */
	    public final void remove() {
	        throw new UnsupportedOperationException();
	    }
	}

}
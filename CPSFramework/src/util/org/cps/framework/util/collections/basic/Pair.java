/*
 * Pair.java
 * CREATED:    Jul 9, 2004 7:33:15 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.collections.basic;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class Pair<T1,T2> {
    private final T1 mObj1;
    private final T2 mObj2;

    public Pair(T1 obj1, T2 obj2) {
        mObj1 = obj1;
        mObj2 = obj2;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (!(obj instanceof Pair)) {
            return false;
        }

        Pair key = (Pair)obj;

        return
            (mObj1 == null ?
             key.mObj1 == null : mObj1.equals(key.mObj1)) &&
            (mObj2 == null ?
             key.mObj2 == null : mObj2.equals(key.mObj2));
    }

    public int hashCode() {
        return
            (mObj1 == null ? 0 : mObj1.hashCode()) +
            (mObj2 == null ? 0 : mObj2.hashCode());
    }

    public String toString() {
        return "[" + mObj1 + ':' + mObj2 + ']';
    }
}
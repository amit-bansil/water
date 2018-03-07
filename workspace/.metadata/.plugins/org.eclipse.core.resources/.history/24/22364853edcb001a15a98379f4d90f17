package cps.jarch.util.misc;

/*
 * Copyright 2002-2005 The Apache Software Foundation.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


/**
 * <p>Thrown to indicate that a block of code has not been implemented.
 * This exception supplements <code>UnsupportedOperationException</code>
 * by providing a more semantically rich description of the problem.</p>
 * 
 * <p><code>NotImplementedException</code> represents the case where the
 * author has yet to implement the logic at this point in the program.
 * This can act as an exception based todo tag.
 * Because this logic might be within a catch block, this exception
 * supports exception chaining.</p>
 * 
 * <p>The nesting logic from the apache implementation has been stripped.</p>
 * 
 * <pre>
 * public void run() {
 *   try {
 *     // do something that throws an Exception
 *   } catch (Exception ex) {
 *     // don't know what to do here yet
 *     throw new NotImplementedException("todo", ex);
 *   }
 * }
 * </pre>
 * 
 * @author Matthew Hawthorne
 * @author Stephen Colebourne
 * @author Amit Bansil
 * @since 2.0
 * @version $Id: NotImplementedException.java 520 2005-08-30 19:51:09Z bansil $
 */
public class NotImplementedException
        extends UnsupportedOperationException {

    //-----------------------------------------------------------------------
    /**
     * Constructs a new <code>NotImplementedException</code> with default message.
     * 
     * @since 2.1
     */
    public NotImplementedException() {
        super("Code is not implemented");
    }

    /**
     * Constructs a new <code>NotImplementedException</code> referencing
     * the specified class.
     * 
     * @param clazz  the <code>Class</code> that has not implemented the method
     */
    public NotImplementedException(Class clazz) {
        super((clazz == null ?
                "Code is not implemented" :
                "Code is not implemented in " + clazz));
    }

    /**
     * Constructs a new <code>NotImplementedException</code> referencing
     * the specified class.
     * 
     * @param clazz  the <code>Class</code> that has not implemented the method
     */
    public NotImplementedException(Class clazz,String method) {
        super((clazz == null ?
        		"Method '"+method+"' is not implemented" :
                "Method '"+method+"' is not implemented in " + clazz));
    }
    public NotImplementedException(String method) {
        this(null,method);
    }
}

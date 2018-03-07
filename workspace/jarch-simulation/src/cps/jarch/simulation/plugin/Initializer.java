/*
 * CREATED ON:    Dec 22, 2005 9:30:48 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.simulation.plugin;

import cps.jarch.gui.resources.ResourceLoader;
import cps.jarch.util.misc.ListReader;
import cps.jarch.util.misc.LogEx;
import cps.jarch.util.misc.StringUtils;
import cps.jarch.util.notes.UsesDefault;

import java.io.IOException;
import java.util.List;

/**
 * <p>TODO document Initializer
 * </p>
 * @version $Id: Initializer.java 74 2005-12-28 22:30:22Z bansil $
 * @author Amit Bansil
 */
public class Initializer {
	private static final LogEx<Initializer> log = LogEx.createClassLog(Initializer.class);
	
	/**
	 * Used to determine what to do if a class can't be found.
	 */
	public static enum ClassType{
		/**
		 * do nothing if class not found.
		 */
		OPTIONAL,
		/**
		 * error if class is not found.
		 */
		REQUIRED,
		/**
		 * warn if class is not found.
		 */
		EXPECTED}
	private static final ClassType DEFAULT_CLASS_TYPE=ClassType.REQUIRED;
	
	@UsesDefault public static final void initializeClasses(Class parent) {
		initializeClasses(parent,parent.getClassLoader());
	}
	/**
	 * Loads classes from text file associated with <code>parent</code> using
	 * <code>classLoader</code>. The text file should be in a resource named after
	 * parent except ending in '.list'. i.e. 'cps.util.AbaZaba'->'cps/util/AbaZaba.list'.
	 * Each line of the list should be formatted 'className [classType]' where
	 * className is the fully qualified name of the class to (try) to load and
	 * classType is one of the ClassType constants which determines
	 * what to do if className can't be found. ClassType defaults to ClassType.REQUIRED.
	 * 
	 * @param classLoader
	 *            ClassLoader to use. Defaults to
	 *            <code>parent.class.getClassLoader()</code>;
	 * 
	 * @throws Error
	 *             if the list associated with owner cannot be found
	 *             
	 * @throws Error
	 *             if an IOException occurs while parsing the list.
	 * 
	 * @throws ExceptionInInitializerError
	 *             if an initialization provoked by this method fails
	 * 
	 * @throws Error
	 *             if for some class classType==REQUIRED yet its
	 *             <code>className</code> is not found.
	 */
	public static final void initializeClasses(Class parent,ClassLoader classLoader) {
		log.debugEnterStatic("parent, classLoader", parent, classLoader);
		try {
			List<String> classList = ListReader.asList(ResourceLoader.create(parent).loadExpectedStream(
				parent.getSimpleName()+ ListReader.EXTENSION));
			for (String s : classList) {
				String[] l = StringUtils.split(s);
				try {
					if (l.length > 2)
						throw new IllegalArgumentException("too many arguments");
					
					String className=l[1];
					
					ClassType classType;
					if(l.length==2) {
						String classTypeString=l[1];
						//throws IAE if classTypeString is illegal
						classType=ClassType.valueOf(classTypeString.toUpperCase());
					}
					else classType=DEFAULT_CLASS_TYPE;
					
					initializeClass(className,classType,classLoader);					
				}catch(Exception e) {
					IOException ioe=new IOException("could not parse "+l);
					ioe.initCause(e);
					throw ioe;
				}
			}
		} catch (IOException e) {
			throw new Error("could not parse " + parent+ ListReader.EXTENSION, e);
		}
	}
	
	@UsesDefault public static final boolean initializeClass(String className,
			ClassType type) {
		return initializeClass(className, type,Initializer.class.getClassLoader());
	}
	/**
	 * Load class specified by <code>className</code> and initialize it.
	 * 
	 * @param classType
	 *            determines what to do if <code>className</code> is not found
	 *            as specified in ClassType.
	 * 
	 * @param classLoader
	 *            ClassLoader to use. Defaults to
	 *            <code>Intializer.class.getClassLoader()</code>
	 * 
	 * @throws ExceptionInInitializerError
	 *             if the initialization provoked by this method fails
	 * 
	 * @throws Error
	 *             if <code>classType==REQUIRED</code> and
	 *             <code>className</code> is not found.
	 * 
	 * @return <code>true</code> iff successful, <code>false</code> iff
	 *         <code>classType==OPTIONAL||classType==EXPECTED</code> and
	 *         <code>className</code> is not found.
	 */
	public static final boolean initializeClass(String className, ClassType classType,
			ClassLoader classLoader) {
		log.debugEnterStatic("className, classType, classLoader", className,
			classType, classLoader);
		
		try {
			//load & initialize className
			Class.forName(className, true, classLoader);
		} catch (ClassNotFoundException e) {
			String m="could not initialize '" + className
			+ " because it was not found";
			switch (classType) {
				case REQUIRED:
					throw new Error(e);
				case EXPECTED:
					log.warning(null,m, e);
					break;
				case OPTIONAL:
					log.debug(m,e);
					return false;
			}
		}
		return true;
	}
}
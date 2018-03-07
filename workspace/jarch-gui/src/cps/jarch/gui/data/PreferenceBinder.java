/*
 * PreferenceBinder.java
 * CREATED:    Jun 16, 2005 4:39:32 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-gui
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.data;

import cps.jarch.data.event.Unlinker;
import cps.jarch.data.event.tools.Link;
import cps.jarch.data.value.CheckedValue;
import cps.jarch.data.value.RejectedValueException;
import cps.jarch.gui.util.EDTWorker;
import cps.jarch.util.misc.LangUtils;
import cps.jarch.util.misc.LogEx;

import javax.swing.SwingUtilities;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.EventObject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.prefs.PreferenceChangeEvent;
import java.util.prefs.PreferenceChangeListener;
import java.util.prefs.Preferences;

/**
 * Binds preference data to a {@link cps.jarch.data.value.RWValue}.
 * All operations must be called on EDT.
 */
public final class PreferenceBinder implements Unlinker {

	/**
	 * all changes to prefs. as well as initial values are logged at
	 * Level.CONFIG.
	 */
	private static final LogEx<PreferenceBinder> log = LogEx
		.createClassLog(PreferenceBinder.class);

	// ------------------------------------------------------------------------
	// Constructor
	// ------------------------------------------------------------------------

	public static final PreferenceBinder createSystemBinder(Class root) {
		return new PreferenceBinder(root, true);
	}

	public static final PreferenceBinder createUserBinder(Class root) {
		return new PreferenceBinder(root, false);
	}

	/**
	 * creates PreferenceBinder. TODO make it impossible to bind the same node
	 * to different binders.
	 * 
	 * @param rootClass
	 *            the Class that owns these preferences. All preferences will be
	 *            stored below a node named after it.
	 * @param systemOrElseUser
	 *            if these Preferences should be stored at the system or user
	 *            level.
	 */
	private PreferenceBinder(Class rootClass, boolean systemOrElseUser) {
		// create root
		Preferences rootPackageNode;
		if (systemOrElseUser) rootPackageNode = Preferences
			.systemNodeForPackage(rootClass);
		else rootPackageNode = Preferences.userNodeForPackage(rootClass);
		this.rootPrefNode = rootPackageNode.node(rootClass.getSimpleName());

		log.debug(this,"binder created");

		// bind changes in prefs to properties
		this.rootPrefNode
			.addPreferenceChangeListener(new PreferenceChangeListener() {
				@SuppressWarnings("unchecked")
				public void preferenceChange(final PreferenceChangeEvent evt) {
					processPreferenceChange(evt);
				}
			});
	}

	// ------------------------------------------------------------------------
	// binding
	// ------------------------------------------------------------------------

	// root preference node where prefs are stored.
	private final Preferences rootPrefNode;

	// bind prop->pref bindings stored to allow unbind
	private final List<Unlinker> bindings = new ArrayList<Unlinker>();

	// properties by name used for pref->prop binding
	private final Map<String, CheckedValue<String>> propertiesByKey = new HashMap<String, CheckedValue<String>>();

	/**
	 * binds boundProperty prop to preference with name using converter. The
	 * propertie's value is used as the default for the preference, if the
	 * preference contains a different value, however, that value is pushed back
	 * to the property. If the pref contains an illegal value the pref and
	 * proprety are left unchanged.<br>
	 * if the converter cannot convert prop's value an error is shown and the
	 * property is left unbound.
	 * 
	 * @throws Error
	 *             if a property is already bound to name
	 * @throws IllegalArgumentException
	 *             if prop.isNullable!=conveter.isNullable
	 * 
	 */
	public final void bind(final CheckedValue<String> prop,
			final String prefKey) {
		EDTWorker.checkThread();

		log.debug(this,
			"binding property to preference: " + "key=[{0}] property=[{2}]",
			prefKey, prop);

		// make sure name is not already bound
		CheckedValue<String> old = propertiesByKey.get(prefKey);
		if (old != null)
			throw new Error("can't bind key to two propeties: "
					+ "newPropert=[" + prop + "] key=[" + prefKey
					+ "] binder=[" + rootPrefNode + "] oldProperty=[" + old
					+ ']');

		// bind pref->prop
		propertiesByKey.put(prefKey, prop);
		String propValue=prop.get();
		// get preference value using property value as default
		// this may cause processPreferenceChange which gets ignored
		String prefValue = rootPrefNode.get(prefKey,propValue);

		// push pref to prop if it is different,otherwise just log
		boolean isDefault;
		if (!LangUtils.equals(prefValue, propValue)) {
			pushPrefToProp(prop, prefKey, prefValue);
			isDefault = false;
		} else {
			// otherwise just note that we are using the default
			isDefault = true;
		}
		logPrefChange(prefKey, prefValue, isDefault ? "(default)" : "(initial)");

		// bind prop->pref
		final Link valueLink = new Link() {
			@Override public void signal(EventObject event) {
				EDTWorker.checkThread();
				String newValue = prop.get();
				logPrefChange(prefKey, newValue, "(from property)");
				// this will cause a processPreferenceChange which gets ignored
				rootPrefNode.put(prefKey, newValue);
			}
		};
		prop.connect(valueLink);

		// allow unding prop->pref
		bindings.add(new Unlinker() {
			public void unlink() {
				log.debug(PreferenceBinder.this,
					"unbinding property: {0}", prefKey);
				prop.disconnect(valueLink);
			}
		});
	}

	/**
	 * breaks all bindings made so far.
	 * 
	 * @see cps.jarch.data.event.Unlinker#unlink()
	 */
	public void unlink() {
		EDTWorker.checkThread();

		log.debug(this,"unbinding all properties");

		for (Unlinker b : bindings)
			b.unlink();
		bindings.clear();
		propertiesByKey.clear();
	}

	@SuppressWarnings("unchecked")
	private void processPreferenceChange(final PreferenceChangeEvent evt) {
		// force EDT
		if (!SwingUtilities.isEventDispatchThread()) {
			try {
				SwingUtilities.invokeAndWait(new Runnable() {
					public void run() {
						log.debug(PreferenceBinder.this,
							"synchronously redelegating external pref change to EDT:"
									+ "event=[{0}] sourceThread=[{1}]", evt,
							Thread.currentThread());
						processPreferenceChange(evt);
					}
				});
			} catch (InterruptedException e) {
				// should not happen
				throw new Error(e);
			} catch (InvocationTargetException e) {
				// should not happen
				throw new Error(e);
			}
			return;
		}
		// find target property
		CheckedValue<String> prop = propertiesByKey.get(evt
			.getKey());
		// ignore changes for keys we don't have a property for
		if (prop == null) {
			log.warning(this,"change to unbound pref: {0}",
				evt.getKey());
			return;
		}
		String oldValue = prop.get();
		pushPrefToProp(prop, evt.getKey(),evt.getNewValue());

		// unchecked:
		if (prop.get().equals(oldValue)) {
			// trace if no change
			log.debug(this,
				"redundant pref change ignored: key={0} value={1}",
				evt.getKey(), evt.getNewValue());
        } else {
			logPrefChange(evt.getKey(), evt.getNewValue(), "(external)");
		}

	}

	private final void logPrefChange(String key, String newValue, String source) {
		log.config(this,"preference set: {0}={1} {2}", key, newValue,
			source);
	}

	/**
	 * tries to push prefValue from prefKey to prop using converter. logs a
	 * warning on conversion failure, leaving the prop unchanged.
	 */
	private void pushPrefToProp(final CheckedValue<String> prop, final String prefKey, String prefValue) {
		try {
			prop.checkedSet(prefValue);
		} catch (RejectedValueException e) {
			log.warning(this,
				"exception sending preference: prop[{0}] key[{1}]", e,
				prefKey, prop);
		}
	}


	@Override
	public String toString() {
		return getClass().getSimpleName() + "-root=[" + rootPrefNode + ']';
	}
}
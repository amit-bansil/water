/*
 * Application.java
 * CREATED:    Jan 8, 2005 8:11:55 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELESTFramework
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.application;

import cps.jarch.application.gui.GUIManager;
import cps.jarch.application.io.DocumentManager;
import cps.jarch.data.event.GenericLink;
import cps.jarch.data.event.tools.Condition;
import cps.jarch.data.event.tools.ConditionChecker;
import cps.jarch.data.event.tools.SourceImp;
import cps.jarch.gui.components.SplashScreen;
import cps.jarch.gui.util.EDTWorker;

import java.util.EventObject;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.prefs.Preferences;

/**
 * TODO execute startup on separate thread with progress shown on startup
 * screen?
 * 
 * @version $Id: Application.java 560 2005-09-07 19:39:18Z bansil $
 * @author Amit Bansil
 */
public abstract class Application {
	private static final Logger log = Logger.getLogger(Application.class
		.getName());

	// ------------------------------------------------------------------------
	// CONSTRUCTOR
	// ------------------------------------------------------------------------
	/**
	 * creates Application. must be called from EDT.
	 */
	public Application() {
		EDTWorker.checkThread();

		// load description
		log.finest("loading app description");
		description = loadDescription();
		log.log(Level.INFO, "starting {0}", description.getFullName());

		// show splash screen
		if (description.getSplashImage() != null) {
			splash = new SplashScreen(description.getSplashImage(),
				new Runnable() {
					public void run() {
						completeStartup();
					}
				});
		} else {
			completeStartup();
		}
	}

	private SplashScreen splash;

//	@SuppressWarnings({"InstanceVariableUsedBeforeInitialized"})
    protected final void completeStartup() {
		log.finest("starting error log");
		//ErrorFileGUI.startup();

		try {
			// OPTIMIZE load in a separate thread and show progress

			// bind components
			log.finer("loading io manager");
			io = new DocumentManager(description);
			// TODO allow for system root prefs as well
			log.finest("loading prefs");
			final String prefName = Application.class.getName() + '.'
					+ description.getIDName();
			log.log(Level.CONFIG, "prefs root={0}", prefName);
			prefs = Preferences.userRoot().node(prefName);
			log.finer("loading gui");
			gui = new GUIManager(this);
			log.finer("registering components");
			registerComponents();

			io.initialize();

			initialized = true;
			log.finer("preStartup");
			preStartup();
			log.finer("startup");
			gui.startup();

		} catch (Throwable t) {
			log
				.log(Level.SEVERE, "uncaught exception during initialization",
					t);
			forceShutdown();
		}
		log.finer("done loading");
		if(splash!=null) {
			splash.close();
			splash = null;
		}
	}

	private final ApplicationDescription description;

	public final ApplicationDescription getDescription() {
		return description;
	}

	// ------------------------------------------------------------------------
	// subsystems
	// ------------------------------------------------------------------------

	private DocumentManager io = null;

	private GUIManager gui = null;

	private Preferences prefs = null;

	public DocumentManager getDocumentManager() {
		if (shutdown)
			throw new IllegalStateException(
				"can't access subsystems after shutdown");
		if (io == null)
			throw new IllegalStateException("illegal forward ref to io");
		return io;
	}

	public Preferences getPrefs() {
		if (shutdown)
			throw new IllegalStateException(
				"can't access subsystems after shutdown");
		if (prefs == null)
			throw new IllegalStateException("illegal forward ref to prefs");
		return prefs;
	}

	public GUIManager getGUIManager() {
		if (shutdown)
			throw new IllegalStateException(
				"can't access subsystems after shutdown");
		if (gui == null)
			throw new IllegalStateException("illegal forward ref to gui");
		return gui;
	}

	// ------------------------------------------------------------------------
	// hooks
	// ------------------------------------------------------------------------

	/**
	 * called once by constructor, create description.
	 * 
	 * @return ApplicationDescription
	 */
	protected abstract ApplicationDescription loadDescription();

	/**
	 * called after creating managers to bind app specific subsystems
	 * 
	 */
	protected abstract void registerComponents();

	/**
	 * postinitialization, pre show, usually load initial config here
	 */
	protected void preStartup() {
		// TODO show a 'welcome screen' if the prefs are for it and let the user
		// pick an initial config.
		getDocumentManager().loadBlankDocument();
	}

	// ------------------------------------------------------------------------
	// shutdown
	// ------------------------------------------------------------------------
	private SourceImp shutdownSourceSupport = new SourceImp(
		this);

	private ConditionChecker shutdownConditionCheck = new ConditionChecker();

	/**
	 * notice that constraints will not be checked if the shutdown is forced.
	 * 
	 */
	public final void addPreShutdownConstraint(Condition condition) {
		if (initialized)
			throw new IllegalStateException(
				"can't register shutdownhooks after init");
		log.log(Level.FINEST, "registering preShutdown constraint", condition);
		shutdownConditionCheck.addCondition(condition);
	}

	public final void connectShutdownLink(GenericLink<EventObject> l) {
		if (initialized)
			throw new IllegalStateException(
				"can't register shutdownhooks after init");
		log.log(Level.FINEST, "registering shutdownhook link", l);
		shutdownSourceSupport.connect(l);
	}

	/**
	 * calls shutdown bypassing constraints. Only allowed once.
	 */
	public final void forceShutdown() {
		if (!shutdown(true)) throw new Error("could not force shutdown");
	}

	/**
	 * execute shutdown hooks, if constraints are passed. Otherwise a
	 * VetoException is thrown. Constraints often prompt user.
	 * @throws IllegalStateException if called from non EDT
	 */
	public final boolean tryShutdown() {
		EDTWorker.checkThread();
		return shutdown(false);
	}

	private final boolean shutdown(boolean force) {
		if (shutdown) throw new IllegalStateException("already shutdown");
		log.fine("starting shut down");

		if (!force)
			if (!shutdownConditionCheck.checkConditions()) return false;

		shutdownSourceSupport.sendEvent();

		// not neccessary
		shutdownSourceSupport = null;
		shutdownConditionCheck = null;
		io = null;
		gui = null;
		prefs = null;
		shutdown = true;

		log.finest("closing log");
		//ErrorFileGUI.shutdown();
		log.finer("done shutting down");
		// ERROR why are we not shutindown normally after a file has been opened
		// try running in debugger and looking where the threads are..
		// System.exit(0);
		return true;
	}

	// ------------------------------------------------------------------------
	// state
	// ------------------------------------------------------------------------

	private boolean initialized = false, shutdown = false;

	public final boolean isInitialized() {
		return initialized;
	}

	public final boolean isShutdown() {
		return shutdown;
	}
}
/*
 * CREATED ON:    Sep 6, 2005 4:20:51 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.simulation.script;

import cps.jarch.application.Application;
import cps.jarch.util.notes.Hook;
//TODO finish
/**
 * <p>
 * An {@link cps.jarch.application.Application} that presents a
 * {@link cps.jarch.simulation.script.PanelScript}.
 * </p>
 * 
 * @version $Id$
 * @author Amit Bansil
 */
public abstract class ScriptedApplication extends Application{
	/*private final PanelScript script=new PanelScript("appName","appTitle"){
		@Override protected void _run() {
			ScriptedApplication.this._run();
		}

		@Override protected void _exit() {
			forceShutdown();
		}
		
	};*/
	
	@Hook protected abstract void _run();

	@Override protected void registerComponents() {
		//script.requestStart();
	}
}
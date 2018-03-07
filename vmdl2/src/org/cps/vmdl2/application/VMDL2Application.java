package org.cps.vmdl2.application;

/*
 * CREATED: Jul 26, 2004 AUTHOR: Amit Bansil Copyright 2004 The Center for
 * Polymer Studies, Boston University, all rights reserved.
 */

import org.cps.framework.core.application.core.Application;
import org.cps.framework.core.application.core.ApplicationBuilder;
import org.cps.framework.core.application.core.ApplicationDescription;
import org.cps.framework.util.resources.accessor.ResourceAccessor;
import org.cps.umd.display.UMDDisplay;
import org.cps.vmdl2.particleRenderer.BoxDrawer;
import org.cps.vmdl2.particleRenderer.Renderer;

import java.io.File;

/**
 */
public class VMDL2Application extends ApplicationBuilder{
    private static final ApplicationDescription appDesc;
    static{
    	ApplicationBuilder.showSplashScreen(
    			"org/cps/vmdl2/application/images/vmdl2-splash.gif");
        appDesc=new ApplicationDescription(ResourceAccessor
                .load(VMDL2Application.class),"VMDL2");
    }

    public VMDL2Application(File start){
        super(start);
    }

    public static void main(String[] args){
        new VMDL2Application(ApplicationBuilder.parseMainArgs(args));
    }

    protected ApplicationDescription _createDescription(){
        return appDesc;
    }
    protected void _registerComponents(final Application app){
    	//Renderer renderer=new Renderer(app);
    	UMDDisplay display=new UMDDisplay();
    	SimulationManager sim=new SimulationManager(app,display);
    	new SimulationGUI(app,sim,display);
    }
}
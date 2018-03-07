/*
 * CREATED: Jul 26, 2004 AUTHOR: Amit Bansil Copyright 2004 The Center for
 * Polymer Studies, Boston University, all rights reserved.
 */
package org.cps.framework.test.core.application;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.SwingUtilities;

import org.cps.framework.core.application.core.Application;
import org.cps.framework.core.application.core.ApplicationBuilder;
import org.cps.framework.core.application.core.ApplicationDescription;
import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.core.GenericObservable;
import org.cps.framework.core.event.queue.RunnableEx;
import org.cps.framework.core.event.util.EventUtils;
import org.cps.framework.core.gui.event.GuiEventUtils;
import org.cps.framework.core.gui.event.SwingToCPSObservable;
import org.cps.framework.core.io.DocumentData;
import org.cps.framework.core.io.ObjectInputStreamEx;
import org.cps.framework.core.io.ObjectOutputStreamEx;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

/**
 */
public class TestApplication extends ApplicationBuilder{
    private static final ApplicationDescription appDesc;
    static{
        appDesc=new ApplicationDescription(ResourceAccessor
                .load(TestApplication.class),"TestApp");
    }

    public TestApplication(File start){
        super(start);
    }

    public static void main(String[] args){
        new TestApplication(ApplicationBuilder.parseMainArgs(args));
    }

    protected ApplicationDescription _createDescription(){
        return appDesc;
    }
    JTextArea area;
    SwingToCPSObservable areaChangeObservable;
    void setText(final String text){
		SwingUtilities.invokeLater(new Runnable(){
		    public void run(){
		        area.getDocument().removeDocumentListener(areaChangeObservable);
				area.setText(text);
				area.getDocument().addDocumentListener(areaChangeObservable);
		    }
		});
    }
    protected void _registerComponents(final Application app){
        try{
            SwingUtilities.invokeAndWait(new Runnable(){
                public void run(){
                    area=new JTextArea(10,40);
                    app.getGUI().getContentPane().add(new JScrollPane(area));
                }
            });
        }catch(InterruptedException e1){
            //unexpected exception
            throw new Error(e1);
        }catch(InvocationTargetException e1){
            //unexpected exception
            throw new Error(e1);
        }
        
        
        areaChangeObservable=new SwingToCPSObservable(
                "textchanged",true,this);
        final BoundCollectionRO<GenericObservable<?>> areaChangeObservableCol=
            EventUtils.singletonCollection(
                    (GenericObservable<?>)areaChangeObservable.getObservable());
        area.getDocument().addDocumentListener(areaChangeObservable);
        app.getDocumentManager().registerDocumentData("text",
                new DocumentData() {
					public void loadBlank() {
					   setText("");
					}
					
					public void write(ObjectOutputStreamEx out) throws IOException {
						try{
                            out.writeUTF(GuiEventUtils.invokeAndWait(new RunnableEx<String>(){
                                public String run()throws Exception{
                                    return area.getText();
                                }
                            }));
                        }catch(InvocationTargetException e){
                            //unexpected exception
                            throw new Error(e);
                        }
					}
					
					public void read(ObjectInputStreamEx in) throws IOException {
						setText(in.readUTF());
					}
					
					public void initialize() {
						//empty
					}
					
					public BoundCollectionRO<GenericObservable<?>> getStateObjects() {
						return areaChangeObservableCol;
					}
        		});
    }
}
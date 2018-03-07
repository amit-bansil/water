/*
 * VirtualFileDialog.java CREATED: Jan 3, 2004 3:02:22 AM AUTHOR: Amit Bansil
 * PROJECT: CPSFramework Copyright 2004 The Center for Polymer Studies, Boston
 * University, all rights reserved.
 */
package org.cps.framework.core.gui.dialogs;

import org.cps.framework.core.gui.components.SimpleWindow;
import org.cps.framework.core.gui.event.GuiEventUtils;
import org.cps.framework.core.io.LocalVirtualFile;
import org.cps.framework.core.io.VirtualFile;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

import java.awt.Component;
import java.awt.Dialog;
import java.awt.FileDialog;
import java.awt.Frame;
import java.awt.Window;
import java.io.File;

/**
 * @version 0.1
 * @author Amit Bansil TODO initial directory preference
 */
public class VirtualFileDialog extends WorkspaceDialog<VirtualFile>{
    private final int         mode;

    private final String      typeName;

    private final String      typeExtension;

    private final VirtualFile initial;
    //TODO prefrences/better default
    private static String     lastDir =null;

    //TODO enum type
    public static final int   MODE_OPEN =0, MODE_SAVE=1;

    public VirtualFileDialog(ResourceAccessor parentRes, String name, int mode,
            String typeExtension, String typeName, VirtualFile initial){
        super(parentRes,name);
        this.mode=mode;
        this.typeName=typeName;
        this.typeExtension=typeExtension;
        this.initial=initial;
    }

    protected VirtualFile _show(Component parent){
        GuiEventUtils.checkThread();

        Window parentWindow=SimpleWindow.getContainingWindow(parent);

        final FileDialog dialog;
        if(parentWindow instanceof Frame){
            dialog=new FileDialog((Frame)parentWindow);
        }else if(parentWindow instanceof Dialog){
            dialog=new FileDialog((Dialog)parentWindow);
        }else dialog=new FileDialog(SimpleWindow.getGenericFrame());

        //initial
        if(initial!=null){
            dialog.setFile(initial.getName());
            if(initial instanceof LocalVirtualFile){
                LocalVirtualFile v=(LocalVirtualFile)initial;
                String parentDir=v.getFile().getAbsoluteFile().getParent();
                if(parent!=null) lastDir=parentDir;
            }
        }
        if(lastDir!=null) dialog.setDirectory(lastDir);
        dialog.setMode(mode==MODE_OPEN ? FileDialog.LOAD : FileDialog.SAVE);
        dialog.setTitle(getDescription().getTitle().replace("{type_name}",
                typeName));
        dialog.setVisible(true);
        String file=dialog.getFile();
        if(file==null) return null;

        String dir=dialog.getDirectory();
        
        if(mode==MODE_SAVE&&!file.endsWith("."+typeExtension)) file=file+"."
                +typeExtension;
        File f=new File(dir,file);
        //String lastLastDir=lastDir;
        lastDir=dir;

        //TODO determine what platforms this is neccessary on
        /*if(f.exists()&&mode==MODE_SAVE){
            Object c=new ConfirmDialog(res.composite(new Object[][]{{
                    "file_name",file}}),"save.overwrite",false,
                    ConfirmDialog.WARNING_TYPE)._show(parent);
            if(c==ConfirmDialog.CHOICE_NO){
                VirtualFile r=(VirtualFile)_show(parent);
                if(r==null){
                    lastDir=lastLastDir;
                    return null;
                }else return r;
            }
        }*/
        return new LocalVirtualFile(f);

    }

    private static final ResourceAccessor res =WorkspaceDialog
                                                      .getDialogResources()
                                                      .getChild("fileDialog");
    //TODO why no initial???
    public static final VirtualFileDialog createOpenDialog(
            String typeExtension, String typeName){
        return new VirtualFileDialog(res,"open",MODE_OPEN,typeExtension,
                typeName,null);
    }

    public static VirtualFileDialog createSaveAsDialog(String typeExtension,
            String typeName, VirtualFile initial){
        return new VirtualFileDialog(res,"save",MODE_SAVE,typeExtension,
                typeName,initial);
    }
}
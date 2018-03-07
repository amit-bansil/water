package Intermol3D;

import javax.swing.ButtonGroup;
import javax.swing.JComboBox;
import javax.swing.JMenu;
import javax.swing.JRadioButtonMenuItem;

import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.util.Hashtable;

public class SharedChoice{
    private Hashtable menuItems=new Hashtable();
    private ButtonGroup menuItemGroup = new ButtonGroup();
    private JComboBox combo;
    private ItemChoiceListener handler;

    public SharedChoice(String[] choices, JMenu menu, JComboBox comboBox,
    ItemChoiceListener handle){
            combo=comboBox;	
            handler=handle;

            ItemListener menuListener=new ItemListener(){
                    public void itemStateChanged(ItemEvent e){
                            if(e.getStateChange()==e.SELECTED){
                                    handler.itemChosen(((javax.swing.JRadioButtonMenuItem)e.getItem()).getText());
                                    combo.setSelectedItem(((javax.swing.JRadioButtonMenuItem)e.getItem()).getText());		
                            }
                    }
            };
            //create Menu Items and add elements to combobox
            JRadioButtonMenuItem menuItem;
            boolean fst=true;
            for(int i=0;i<choices.length;i++){
                    combo.addItem(choices[i]);

                    menuItem=new JRadioButtonMenuItem(choices[i]);



                    menuItems.put(choices[i],menuItem);
                    menuItemGroup.add(menuItem);
                    menu.add(menuItem);
                    if(fst){
                            menuItem.setSelected(true); fst=false;
                    }
                    menuItem.addItemListener(menuListener);
            }

            combo.addItemListener(new ItemListener(){
                    public void itemStateChanged(ItemEvent e){
                            if(e.getStateChange()==e.SELECTED){
                                    String evt=(String)(e.getItem());
                                    handler.itemChosen(evt);
                                    ((JRadioButtonMenuItem)menuItems.get(evt)).setSelected(true);
                            }
                    }
            });
    }

    public SharedChoice(String[] choices, JMenu menu, JComboBox comboBox,
    ItemChoiceListener handle,int selection){
            combo=comboBox;	
            handler=handle;

            ItemListener menuListener=new ItemListener(){
                    public void itemStateChanged(ItemEvent e){
                            if(e.getStateChange()==e.SELECTED){
                                    handler.itemChosen(((javax.swing.JRadioButtonMenuItem)e.getItem()).getText());
                                    combo.setSelectedItem(((javax.swing.JRadioButtonMenuItem)e.getItem()).getText());		
                            }
                    }
            };
            //create Menu Items and add elements to combobox
            JRadioButtonMenuItem menuItem;
            for(int i=0;i<choices.length;i++){
                    combo.addItem(choices[i]);

                    menuItem=new JRadioButtonMenuItem(choices[i]);



                    menuItems.put(choices[i],menuItem);
                    menuItemGroup.add(menuItem);
                    menu.add(menuItem);
                    if(i==selection){
                            menuItem.setSelected(true);
                    }
                    menuItem.addItemListener(menuListener);
            }
            combo.setSelectedItem(choices[selection]);
            combo.addItemListener(new ItemListener(){
                    public void itemStateChanged(ItemEvent e){
                            if(e.getStateChange()==e.SELECTED){
                                    String evt=(String)(e.getItem());
                                    handler.itemChosen(evt);
                                    ((JRadioButtonMenuItem)menuItems.get(evt)).setSelected(true);
                            }
                    }
            });
    }
}
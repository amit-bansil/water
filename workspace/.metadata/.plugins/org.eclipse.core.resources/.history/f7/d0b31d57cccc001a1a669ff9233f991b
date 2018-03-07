package Intermol3D;
import javax.swing.JComboBox;

import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

class SystemParameters{
    private final SliderGroupEx value1,value2;
    private final JComboBox movieModeCombo;
    private final IData data;
    //constants for sliders
    private static final int TEMP=0,PRESSURE=1,DENSITY=2,ENERGY=3;
    private static final int MIN=0,MAX=1,CONV=2;
    private static final double sliderConstants[][]=new double[][]{
    {1d,2000d,1},
    {-1000d,1000d,1},
    {.0099999d,0.999999d,1000000d},
    {0d,10d,100}};
    //sliders can only be integer values so a conversion between the
    //value it contains and the actual value is required the class 'sliderGroupEx'
    //should be reffered to.

    private final String sliderNames[];
    private final String sliderTips[];
    private int s1,s2;

    SystemParameters(final SliderGroupEx fr1,final SliderGroupEx fr2,final JComboBox mvc,final IData dat){
        this.data=dat; movieModeCombo=mvc; value1=fr1; value2=fr2;
        sliderNames=new String[]{
            Const.trans("slider.temp"),
            Const.trans("slider.pres"),
            Const.trans("slider.dens"),
            Const.trans("slider.energy")};
        sliderTips=new String[]{
            Const.trans("slider.temp.tip"),
            Const.trans("slider.pres.tip"),
            Const.trans("slider.dens.tip"),
            Const.trans("slider.energy.tip")};
        movieModeCombo.addItem(Const.trans("mode.kdkt"));
        movieModeCombo.addItem(Const.trans("mode.kdke"));
        movieModeCombo.addItem(Const.trans("mode.kpkt"));
        movieModeCombo.addItem(Const.trans("mode.kpke"));

        movieModeCombo.addItemListener(new ItemListener(){
            public void itemStateChanged(ItemEvent e){
                if(e.getStateChange()==e.SELECTED){
                    String evt=(String)(e.getItem());
                    if(evt.equals(Const.trans("mode.kdkt"))){
                        setSliders(DENSITY,TEMP);
                        data.setMode(data.MODE_KDKT);
                    }else if(evt.equals(Const.trans("mode.kdke"))){
                        setSliders(DENSITY,ENERGY);
                        data.setMode(data.MODE_KDKE);
                    }else if(evt.equals(Const.trans("mode.kpkt"))){
                        setSliders(PRESSURE,TEMP);
                        data.setMode(data.MODE_KPKT);
                    }else if(evt.equals(Const.trans("mode.kpke"))){
                        setSliders(PRESSURE,ENERGY);
                        data.setMode(data.MODE_KPKE);
                    }
                }
            }
        });
        setSliders(DENSITY,TEMP);

    }
    private void setSliders(int s2,int s1){
        
        this.s1=s1; this.s2=s2;
        value1.setLabel(sliderNames[s1]);
        value1.setToolTipText(sliderTips[s1]);
        value1.setRealBounds(sliderConstants[s1][MAX],sliderConstants[s1][MIN],sliderConstants[s1][CONV]);

        value2.setLabel(sliderNames[s2]);
        value2.setToolTipText(sliderTips[s2]);
        value2.setRealBounds(sliderConstants[s2][MAX],sliderConstants[s2][MIN],sliderConstants[s2][CONV]);
        
        if(this.s1==ENERGY) value1.setEnabled(false);
        else value1.setEnabled(true);
        
        step();
    }
    public void step(){
        if(s1==TEMP)
            value1.setRealValue(data.getTemp());
        else
            value1.setRealValue(data.getEnergy());
        
        if(s2==DENSITY)
            value2.setRealValue(data.getDensity());
        else
            value2.setRealValue(data.getPressure());
        
    }
    public void start(){
        if(s1==TEMP)
            data.setTemp(value1.getRealValue());
        else
            data.setEnergy(value1.getRealValue());

        if(s2==DENSITY)
            data.setDensity(value2.getRealValue());
        else
            data.setPressure(value2.getRealValue());


        value1.setEnabled(false);
        value2.setEnabled(false);
        movieModeCombo.setEnabled(false);
        movieModeCombo.setEnabled(false);
    }
    public void stop(){
        value2.setEnabled(true);
        if(s1!=ENERGY) value1.setEnabled(true);
        movieModeCombo.setEnabled(true);
        movieModeCombo.setEnabled(true);
    }

}
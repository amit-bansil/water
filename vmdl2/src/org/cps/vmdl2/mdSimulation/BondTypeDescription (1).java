package org.cps.vmdl2.mdSimulation;

/**
 * Title:        Universal Molecular Dynamics
 * Description:
 * Copyright:    Copyright (c) 2001
 * Company:      Boston University
 * @author Amit Bansil
 * @version 0.0a
 */
//referred to from simulation type data
public abstract class BondTypeDescription {
    public static final int H_BOND_ORDER=0,SINGLE_BOND_ORDER=1,DOUBLE_BOND_ORDER=2,
       TRIPLE_BOND_ORDER=3;

    public static final int LINE_BOND_RADIUS=0,HIDDEN_BOND_RADIUS=-1;

    public final boolean isHBond(){return getOrder()==H_BOND_ORDER; }
    public final boolean isVisible(){ return getRadius()==HIDDEN_BOND_RADIUS; }
    public final boolean isLine(){return getRadius()==LINE_BOND_RADIUS; }

    public abstract float[] getColor();
    public abstract float getRadius();
    public abstract int getOrder();

}
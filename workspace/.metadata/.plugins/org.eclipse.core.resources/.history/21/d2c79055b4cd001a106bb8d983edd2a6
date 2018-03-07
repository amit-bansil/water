package Intermol3D;

import javax.swing.JOptionPane;

public final class IWarning{
	private final Intermol3D i3d;
	public IWarning(Intermol3D i3d){
		this.i3d=i3d;
	}
	
	public synchronized int simulationError(String s){
		Object[] options = { "Pause", "Reset" };
     	return JOptionPane.showOptionDialog(null, s,
     		"Simulation Error", JOptionPane.DEFAULT_OPTION, JOptionPane.WARNING_MESSAGE,
            null, options, options[0]);
	}
}
package cps.water.simulation;

public final class ShakeFailException extends Exception{
	public ShakeFailException(){
            super("Failed to recreate molecular structures probably due to extreme velocities");
        }
}
package Intermol3D;

public final class ShakeFailException extends RuntimeException{
	public ShakeFailException(){
            super("Failed to recreate molecular structures probably due to extreme velocities");
        }
}
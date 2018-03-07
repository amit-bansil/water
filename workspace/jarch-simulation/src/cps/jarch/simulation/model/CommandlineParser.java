/*
 * CREATED ON:    Jan 27, 2006 7:10:16 PM
 * CREATED BY:    bansil 
 */
package cps.jarch.simulation.model;

import cps.jarch.util.misc.NotImplementedException;
import cps.jarch.util.notes.Nullable;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * Saves and loads a state from a list of command line parameters.
 * </p>
 * 
 * @version $Id$
 * @author bansil
 */
public class CommandlineParser {
	private final State state;
	public final State getState() {
		return state;
	}
	
	public CommandlineParser(State state) {
		//TODO implement CommandlineParser.CommandlineParser
		throw new NotImplementedException(CommandlineParser.class, "CommandlineParser");
		/*this.state=state;
		for(Key key:state.getAllowedKeys()) {
			Character l=key.getDescription().getLetter();
			String trigger;
			if (l!=null) {
				trigger=l.toString();
			} else {
				trigger=key.getDescription().getName().toString();
			}
		}*/
	}
	public final String[] toCommandline() {
		//TODO implement CommandlineParser.toCommandline
		throw new NotImplementedException(CommandlineParser.class, "toCommandline");
	}
	public final void fromCommandline(String[] commandLine) {
		//TODO
	}
	
	private final Map<String,Key> optionsByTrigger=new HashMap<String, Key>();
	/**
	 * @return An option trigger, whatever that is.
	 */
	public final @Nullable Key getOptionTrigger(Key key) {
		return optionsByTrigger.get(key);
	}
	
	public static final int getOptionArgs(Key key) {
		if(key instanceof Key.BooleanKey)return 0;
		else return 1;
	}  
}

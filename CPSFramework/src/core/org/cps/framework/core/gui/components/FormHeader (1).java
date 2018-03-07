/*
 * MessageDisplay.java
 * CREATED:    Aug 15, 2004 6:25:29 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.components;

import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.collection.CollectionChangeAdapter;
import org.cps.framework.core.event.collection.CollectionListener;
import org.cps.framework.core.event.util.EventUtils;
import org.cps.framework.core.gui.action.SwingWorkspaceAction;
import org.cps.framework.core.gui.event.GuiEventUtils;
import org.cps.framework.util.collections.basic.SafeMap;

import javax.swing.Box;
import javax.swing.JEditorPane;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.ScrollPaneConstants;
import javax.swing.SwingConstants;

import java.awt.Color;
import java.awt.Component;
import java.util.Stack;

/**
 * GUI Only
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class FormHeader {
	public static final Color BACKGROUND_COLOR = Color.WHITE;//TODO proper L&F

	private final SafeMap<FormMessage, MessageComponent> tabsByMessage = new SafeMap();

	private final CollectionListener extraMessagesListener = new CollectionChangeAdapter<FormMessage>() {
		public void elementAdded(FormMessage m) {
			addMessage(m, tabsByMessage.getMap().size());
		}

		public void elementRemoved(FormMessage m) {
			removeMessage(m);
		}
	};

	private BoundCollectionRO<FormMessage> extraMessages = null;

	public BoundCollectionRO<FormMessage> getExtraMessages() {
		GuiEventUtils.checkThread();
		return extraMessages;
	}

	public void setExtraMessages(BoundCollectionRO<FormMessage> extraMessages) {
		GuiEventUtils.checkThread();
		if (this.extraMessages != null)
				EventUtils.unhookListener(this.extraMessages,
						extraMessagesListener);
		this.extraMessages = extraMessages;
		if (this.extraMessages != null)
				EventUtils.hookupListener(this.extraMessages,
						extraMessagesListener);
	}

	private FormMessage primaryMessage;

	public FormMessage getPrimaryMessage() {
		GuiEventUtils.checkThread();
		return primaryMessage;
	}

	public void setPrimaryMessage(FormMessage primaryMessage) {
		GuiEventUtils.checkThread();
		if (this.primaryMessage != null) removeMessage(this.primaryMessage);
		this.primaryMessage = primaryMessage;
		if (this.primaryMessage != null) addMessage(this.primaryMessage, 0);
	}

	private final JTabbedPane tabbedPane;

	public final Component getComponent() {
		GuiEventUtils.checkThread();
		return tabbedPane;
	}

	public FormHeader() {
		GuiEventUtils.checkThread();
		tabbedPane = new JTabbedPane(SwingConstants.TOP,
				JTabbedPane.SCROLL_TAB_LAYOUT);
	}

	private final Stack<MessageComponent> oldComponents = new Stack();

	private final void addMessage(FormMessage m, int n) {
		MessageComponent c = oldComponents.isEmpty() ? new MessageComponent()
				: oldComponents.pop();
		c.link(m);
		tabsByMessage.put(m, c);
		//		UNCLEAR would full title be a better tip
		tabbedPane.insertTab(m.getShortTitle(), m.hasIcon() ? m.getIcon()
				: null, c.getComponent(), m.getDescription(), n);
		tabbedPane.setBackgroundAt(n, BACKGROUND_COLOR);
		selectLast();
	}

	private final void removeMessage(FormMessage m) {
		MessageComponent c = tabsByMessage.remove(m);
		tabbedPane.remove(c.getComponent());
		selectLast();
		c.unlink();
		oldComponents.push(c);
	}

	private final void selectLast() {
		tabbedPane.setSelectedIndex(tabsByMessage.getMap().size());
	}

	private static final class MessageComponent {
		public MessageComponent() {
			text = new JEditorPane("text/html", "");
			buttonBarBox=Box.createHorizontalBox();
			buttonBarBox.add(Box.createHorizontalGlue());

			Box box=Box.createVerticalBox();
			box.add(text);
			box.add(Box.createVerticalGlue());
			box.add(buttonBarBox);
			scroll = new JScrollPane(box,
					ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER,
					ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED);
		}

		private final JEditorPane text;

		private final Box buttonBarBox;

		private Component buttonBarC;

		private ButtonBar.UnOrdered buttonBar;

		private final JScrollPane scroll;

		public Component getComponent() {
			return scroll;
		}

		public void link(FormMessage m) {
			text.setText(m.getDescription());
			if (m.hasMoreInfo() || !m.getActions().isEmpty()) {
				buttonBar = new ButtonBar.UnOrdered(true, false);
				if (m.hasMoreInfo())
						buttonBar.registerButton(SwingWorkspaceAction
								.moreInfoAction(m, text));
				for (SwingWorkspaceAction a : m.getActions()) {
					buttonBar.registerButton(a);
				}
				buttonBarC = buttonBar.build();
				buttonBarBox.add(buttonBarC);
			}
		}

		public void unlink() {
			text.setText("");
			if (buttonBar != null) {
				buttonBarBox.remove(buttonBarC);
				buttonBarC = null;
				buttonBar.unlink();
				buttonBar = null;
			}
		}
	}
}
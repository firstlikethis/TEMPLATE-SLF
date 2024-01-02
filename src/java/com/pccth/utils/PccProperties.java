package com.pccth.utils;

import java.util.Enumeration;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

/**
 * @author prawith
 * @since 2004-08-24
 * @version 1.0
 */
public class PccProperties {
	private static final ResourceBundle RESOURCES =
		ResourceBundle.getBundle("appcfg");

	public static final String getResourceString(String parm)
		throws MissingResourceException {
		return RESOURCES.getString(parm);
	}

	public static final int getResourceInt(String parm)
		throws MissingResourceException {
		return Integer.parseInt(RESOURCES.getString(parm));
	}

	public static final double getResourceDouble(String parm)
		throws MissingResourceException {
		return Double.parseDouble(RESOURCES.getString(parm));
	}

	public static final boolean getResourceBoolean(String parm)
		throws MissingResourceException {
		return (new Boolean(RESOURCES.getString(parm))).booleanValue();
	}

	public static final Enumeration getResourceKeys() {
		return RESOURCES.getKeys();
	}
}

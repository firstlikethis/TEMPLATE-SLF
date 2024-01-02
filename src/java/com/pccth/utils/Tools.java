package com.pccth.utils;



import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.NumberFormat;

import java.text.SimpleDateFormat;

import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.StringTokenizer;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;

import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;

/**
 * Store tools for develop application
 *
 * @version 1.00 25 Mar 2002
 * @author Prawith Thowphant
 */
public class Tools {

    private static final String SSOVersion = PccProperties.getResourceString("SSOVersion");
    private static final String RDBVersion = PccProperties.getResourceString("RDBVersion");
    private static final String TCLVersion = PccProperties.getResourceString("TCLVersion");
    private static final String REGVersion = PccProperties.getResourceString("REGVersion");
    private static final String LICVersion = PccProperties.getResourceString("LICVersion");
    private static final String INCVersion = PccProperties.getResourceString("INCVersion");
    private static final String PRCVersion = PccProperties.getResourceString("PRCVersion");
    private static final String RTNVersion = PccProperties.getResourceString("RTNVersion");



    public static String thaiDecimal(double dVal) {
        NumberFormat form;
        String strVal, strBath, strStang;
        StringBuffer thaiValue = new StringBuffer("");
        int strLen;

        if (dVal == 0.0) {
            return "à¸¨à¸¹à¸?à¸¢à¹?à¸?à¸²à¸?";

            // à¹?à¸?à¸¥à¸µà¹?à¸¢à¸?à¸?à¹?à¸²à¸?à¸²à¸? input à¹?à¸«à¹?à¹?à¸?à¹?à¸? String à¹?à¸?à¸£à¸¹à¸?à¹?à¸?à¸?à¸¡à¸µà¸?à¸¨à¸?à¸´à¸¢à¸¡à¸ªà¸­à¸?à¸?à¸³à¹?à¸«à¸?à¹?à¸?
        }
        form = NumberFormat.getInstance();
        ((DecimalFormat) form).applyPattern("0.00");
        strVal = form.format(dVal);

        // à¹?à¸?à¹?à¸?à¸?à¹?à¸²à¸?à¸³à¸?à¸§à¸?à¹?à¸?à¹?à¸¡à¸­à¸­à¸?à¸?à¸²à¸?à¸?à¸¨à¸?à¸´à¸¢à¸¡ à¹?à¸¥à¹?à¸§à¸?à¸³à¸?à¸²à¸£ reverse à¸?à¹?à¸²à¸?à¸±à¹?à¸?à¸ªà¸­à¸?à¹?à¸?à¸£à¸µà¸¢à¸¡à¹?à¸?à¸¥à¸?à¹?à¸?à¹?à¸?à¸?à¸±à¸§à¸­à¸±à¸?à¸©à¸£
        strLen = strVal.length();
        strBath =
                new String(new StringBuffer(strVal.substring(0, strLen - 3)).reverse());
        strStang =
                new String(new StringBuffer(strVal.substring(strLen - 2)).reverse());

        // à¸?à¸£à¸§à¸?à¸ªà¸­à¸?à¸?à¹?à¸²à¸ªà¸?à¸²à¸?à¸?à¹?
        if (strStang.compareTo("00") == 0) {
            thaiValue.insert(0, "à¸?à¹?à¸§à¸?");
        } else {
            thaiValue.insert(0, "à¸ªà¸?à¸²à¸?à¸?à¹?");
            thaiValue.insert(0, digitAlpha(strStang));
        }

        // à¸?à¸£à¸§à¸?à¸ªà¸­à¸?à¸?à¹?à¸²à¸?à¸²à¸?
        if (strBath.compareTo("0") != 0) {
            thaiValue.insert(0, "à¸?à¸²à¸?");
            thaiValue.insert(0, digitAlpha(strBath));
        }

        return thaiValue.toString();
    }

    /**
     * à¹?à¸?à¸¥à¸µà¹?à¸¢à¸?à¸?à¹?à¸² double à¹?à¸«à¹?à¹?à¸?à¹?à¸?à¸?à¸³à¸­à¹?à¸²à¸?à¸ à¸²à¸©à¸²à¹?à¸?à¸¢
     *
     * @param dVal à¸?à¹?à¸²à¸?à¸µà¹?à¸?à¹?à¸­à¸?à¸?à¸²à¸£à¹?à¸?à¸¥à¸µà¹?à¸¢à¸? à¸ªà¸²à¸¡à¸²à¸£à¸?à¸?à¹?à¸­à¸¢à¸?à¸§à¹?à¸²à¸¨à¸¹à¸?à¸¢à¹?à¹?à¸?à¹?
     * @return à¸?à¸³à¸­à¹?à¸²à¸?à¸ à¸²à¸©à¸²à¹?à¸?à¸¢
     */
    public static String thaiDecimalNoBath(double dVal) {
        NumberFormat form;
        String strVal, strBath, strStang;
        StringBuffer thaiValue = new StringBuffer("");




        int strLen, pointPos;

        if (dVal == 0.0) {
            return "à¸¨à¸¹à¸?à¸¢à¹?";

            // à¹?à¸?à¸¥à¸µà¹?à¸¢à¸?à¸?à¹?à¸²à¸?à¸²à¸? input à¹?à¸«à¹?à¹?à¸?à¹?à¸? String à¹?à¸?à¸£à¸¹à¸?à¹?à¸?à¸?à¸¡à¸µà¸?à¸¨à¸?à¸´à¸¢à¸¡à¸ªà¸­à¸?à¸?à¸³à¹?à¸«à¸?à¹?à¸?
        }
        form = NumberFormat.getInstance();
        ((DecimalFormat) form).applyPattern("0.0########");
        strVal = form.format(dVal);

        // à¹?à¸?à¹?à¸?à¸?à¹?à¸²à¸?à¸³à¸?à¸§à¸?à¹?à¸?à¹?à¸¡à¸­à¸­à¸?à¸?à¸²à¸?à¸?à¸¨à¸?à¸´à¸¢à¸¡ à¹?à¸¥à¹?à¸§à¸?à¸³à¸?à¸²à¸£ reverse à¸?à¹?à¸²à¸?à¸±à¹?à¸?à¸ªà¸­à¸?à¹?à¸?à¸£à¸µà¸¢à¸¡à¹?à¸?à¸¥à¸?à¹?à¸?à¹?à¸?à¸?à¸±à¸§à¸­à¸±à¸?à¸©à¸£
        strLen = strVal.length();
        pointPos = strVal.indexOf(".");
        System.out.println("pointPos = " + pointPos + "|strVal=" + strVal);
        strBath =
                new String(new StringBuffer(strVal.substring(0, pointPos)).reverse());
        strStang =
                new String(new StringBuffer(strVal.substring(pointPos + 1)).reverse());

        // à¸?à¸£à¸§à¸?à¸ªà¸­à¸?à¸?à¹?à¸²à¸ªà¸?à¸²à¸?à¸?à¹?
        if (strStang.compareTo("0") != 0) {
            thaiValue.insert(0, digitAlphaNoUnit(strStang));
            thaiValue.insert(0, "à¸?à¸¸à¸?");
        }

        // à¸?à¸£à¸§à¸?à¸ªà¸­à¸?à¸?à¹?à¸²à¸?à¸²à¸?
        if (strBath.compareTo("0") != 0) {
            thaiValue.insert(0, digitAlpha(strBath));
        }

        return thaiValue.toString();
    }

    /**
     * à¹?à¸?à¸¥à¸µà¹?à¸¢à¸?à¸?à¹?à¸²à¸?à¸²à¸?à¸?à¸±à¸§à¹?à¸¥à¸?à¹?à¸«à¹?à¹?à¸?à¹?à¸?à¸?à¸³à¸­à¹?à¸²à¸?à¸ à¸²à¸©à¸²à¹?à¸?à¸¢
     *
     * @return à¸?à¸³à¸­à¹?à¸²à¸?à¸ à¸²à¸©à¸²à¹?à¸?à¸¢
     */
    public static String digitAlpha(String strVal) {
        String thaiDigit[] = {"à¸¨à¸¹à¸?à¸¢à¹?", "à¸«à¸?à¸¶à¹?à¸?", "à¸ªà¸­à¸?", "à¸ªà¸²à¸¡", "à¸ªà¸µà¹?", "à¸«à¹?à¸²", "à¸«à¸?", "à¹?à¸?à¹?à¸?", "à¹?à¸?à¸?",
            "à¹?à¸?à¹?à¸²", "à¹?à¸­à¹?à¸?", "à¸¢à¸µà¹?", "à¸¥à¸?"
        };
        String thaiUnit[] = {"à¸¥à¹?à¸²à¸?", "à¸ªà¸´à¸?", "à¸£à¹?à¸­à¸¢", "à¸?à¸±à¸?", "à¸«à¸¡à¸·à¹?à¸?", "à¹?à¸ªà¸?"};
        StringBuffer digitValue = new StringBuffer("");








        int strLen, iUnit;
        char charVal;

        // à¸?à¹?à¸²à¸?à¹?à¸²à¸?à¸µà¹?à¹?à¸?à¹?à¸£à¸±à¸?à¹?à¸?à¹?à¸?à¹?à¸¥à¸?à¸¨à¸¹à¸?à¸¢à¹?à¸?à¸±à¸§à¹?à¸?à¸µà¸¢à¸§ à¸?à¸°à¸ªà¹?à¸?à¸?à¹?à¸²à¸?à¸¥à¸±à¸?à¹?à¸?à¹?à¸?à¸?à¸³à¸§à¹?à¸² "à¸¨à¸¹à¸?à¸¢à¹?"
        strLen = strVal.length();
        if (strLen == 0 && strVal.charAt(0) == '0') {
            digitValue.insert(0, thaiDigit[0]);
            return digitValue.toString();
        }

        // à¸§à¸?à¹?à¸?à¸¥à¸?à¸?à¸±à¸§à¹?à¸¥à¸?à¹?à¸?à¹?à¸?à¸?à¸±à¸§à¸­à¸±à¸?à¸©à¸£à¸?à¸?à¸«à¸¡à¸?à¸?à¸¸à¸?à¸?à¸±à¸§
        for (int i = 0; i < strLen; i++) {
            charVal = strVal.charAt(i);

            // à¸«à¸²à¸«à¸¥à¸±à¸?à¸?à¸µà¹?à¸?à¸­à¸?à¸?à¸±à¸§à¹?à¸¥à¸?
            iUnit = i % 6;

            // à¸?à¹?à¸²à¸?à¹?à¸²à¸?à¸±à¸§à¹?à¸¥à¸?à¹?à¸?à¹?à¸?à¸¨à¸¹à¸?à¸¢à¹? à¹?à¸¡à¹?à¸?à¹?à¸­à¸?à¹?à¸ªà¸?à¸?à¸?à¸±à¸§à¸­à¸±à¸?à¸©à¸£
            if (charVal == '0') {
                if (iUnit == 0 && i > 0) {
                    digitValue.insert(0, thaiUnit[iUnit]);
                }
                continue;
            }

            // à¸?à¹?à¸²à¹?à¸?à¹?à¸?à¹?à¸?à¸£à¸·à¹?à¸­à¸?à¸«à¸¡à¸²à¸¢à¸¥à¸? à¸?à¸°à¹?à¸ªà¸?à¸?à¸?à¸³à¸§à¹?à¸² "à¸¥à¸?" à¹?à¸¥à¹?à¸§à¸«à¸¢à¸¸à¸?
            if (charVal == '-') {
                digitValue.insert(0, thaiDigit[12]);
                break;
            }

            if (i > 0) // à¸?à¹?à¸²à¹?à¸¡à¹?à¹?à¸?à¹?à¸«à¸¥à¸±à¸?à¸«à¸?à¹?à¸§à¸¢à¸?à¸°à¹?à¸ªà¸?à¸?à¸?à¸·à¹?à¸­à¸«à¸¥à¸±à¸?
            {
                digitValue.insert(0, thaiUnit[iUnit]);

                // à¸?à¹?à¸²à¸«à¸¥à¸±à¸?à¸ªà¸´à¸?à¹?à¸?à¹?à¸?à¹?à¸¥à¸?à¸«à¸?à¸¶à¹?à¸? à¹?à¸¡à¹?à¸?à¹?à¸­à¸?à¹?à¸ªà¸?à¸?à¸?à¸±à¸§à¸­à¸±à¸?à¸©à¸£
            }
            if (iUnit == 1 && charVal == '1') {
                continue;

                // à¸?à¸£à¸§à¸?à¸ªà¸­à¸?à¸§à¹?à¸²à¸?à¹?à¸²à¸«à¸¥à¸±à¸?à¸ªà¸´à¸? à¸«à¸£à¸·à¸­à¸«à¸¥à¸±à¸?à¸£à¹?à¸­à¸¢à¸¡à¸µà¸?à¹?à¸²à¹?à¸«à¹?à¹?à¸ªà¸?à¸?à¹?à¸¥à¸?à¸«à¸?à¸¶à¹?à¸?à¸?à¸µà¹?à¸«à¸¥à¸±à¸?à¸«à¸?à¹?à¸§à¸¢à¸§à¹?à¸² "à¹?à¸­à¹?à¸?"
            }
            if (iUnit == 0 && charVal == '1') {
                boolean testOne = false;
                for (int j = i + 1; j < strLen; j++) {
                    if (j - i == 3) {
                        break;
                    }
                    if (strVal.charAt(j) > '0') {
                        testOne = true;
                        break;
                    }
                }
                if (testOne) {
                    digitValue.insert(0, thaiDigit[10]);
                } else {
                    digitValue.insert(0, thaiDigit[1]);
                }
            } else if (iUnit == 1 && charVal == '2') {
                digitValue.insert(0, thaiDigit[11]);
                // à¹?à¸ªà¸?à¸?à¸?à¸³à¸§à¹?à¸² "à¸¢à¸µà¹?" à¸?à¹?à¸²à¸«à¸¥à¸±à¸?à¸ªà¸´à¸?à¹?à¸?à¹?à¸?à¹?à¸¥à¸?à¸ªà¸­à¸?
            } else {
                digitValue.insert(0, thaiDigit[charVal - '0']);
                // à¹?à¸ªà¸?à¸?à¸?à¸±à¸§à¸­à¸±à¸?à¸©à¸£à¸?à¸­à¸?à¹?à¸¥à¸?
            }
        }

        return digitValue.toString();
    }

    /**
     * à¹?à¸?à¸¥à¸µà¹?à¸¢à¸?à¸?à¹?à¸²à¸?à¸²à¸?à¸?à¸±à¸§à¹?à¸¥à¸?à¹?à¸«à¹?à¹?à¸?à¹?à¸?à¸?à¸³à¸­à¹?à¸²à¸?à¸ à¸²à¸©à¸²à¹?à¸?à¸¢
     *
     * @return à¸?à¸³à¸­à¹?à¸²à¸?à¸ à¸²à¸©à¸²à¹?à¸?à¸¢
     */
    public static String digitAlphaNoUnit(String strVal) {
        String thaiDigit[] = {"à¸¨à¸¹à¸?à¸¢à¹?", "à¸«à¸?à¸¶à¹?à¸?", "à¸ªà¸­à¸?", "à¸ªà¸²à¸¡", "à¸ªà¸µà¹?", "à¸«à¹?à¸²", "à¸«à¸?", "à¹?à¸?à¹?à¸?", "à¹?à¸?à¸?",
            "à¹?à¸?à¹?à¸²", "à¹?à¸­à¹?à¸?", "à¸¢à¸µà¹?", "à¸¥à¸?"
        };
        StringBuffer digitValue = new StringBuffer("");
        int strLen;
        char charVal;

        // à¸?à¹?à¸²à¸?à¹?à¸²à¸?à¸µà¹?à¹?à¸?à¹?à¸£à¸±à¸?à¹?à¸?à¹?à¸?à¹?à¸¥à¸?à¸¨à¸¹à¸?à¸¢à¹?à¸?à¸±à¸§à¹?à¸?à¸µà¸¢à¸§ à¸?à¸°à¸ªà¹?à¸?à¸?à¹?à¸²à¸?à¸¥à¸±à¸?à¹?à¸?à¹?à¸?à¸?à¸³à¸§à¹?à¸² "à¸¨à¸¹à¸?à¸¢à¹?"
        strLen = strVal.length();
        if (strLen == 0 && strVal.charAt(0) == '0') {
            digitValue.insert(0, thaiDigit[0]);
            return digitValue.toString();
        }

        // à¸§à¸?à¹?à¸?à¸¥à¸?à¸?à¸±à¸§à¹?à¸¥à¸?à¹?à¸?à¹?à¸?à¸?à¸±à¸§à¸­à¸±à¸?à¸©à¸£à¸?à¸?à¸«à¸¡à¸?à¸?à¸¸à¸?à¸?à¸±à¸§
        for (int i = 0; i < strLen; i++) {
            charVal = strVal.charAt(i);

            digitValue.insert(0, thaiDigit[charVal - '0']);
            // à¹?à¸ªà¸?à¸?à¸?à¸±à¸§à¸­à¸±à¸?à¸©à¸£à¸?à¸­à¸?à¹?à¸¥à¸?
        }

        return digitValue.toString();
    }

    /**
     * à¹?à¸?à¸¥à¸µà¹?à¸¢à¸? Encoding Type à¸?à¸²à¸? Unicode à¹?à¸?à¹?à¸? MS874
     *
     * @param s Unicode String
     * @return MS874 String
     */
    public static String UnicodeToMS874(String s) {
        if (s == null) {
            return "";
        }
        StringBuffer stringbuffer = new StringBuffer(s);
        for (int i = 0; i < s.length(); i++) {
            char c = stringbuffer.charAt(i);
            if ('\u0E01' <= c && c <= '\u0E5B') {
                stringbuffer.setCharAt(i, (char) (c - 3424));
            }
        }

        return stringbuffer.toString();
    }

    /**
     * à¹?à¸?à¸¥à¸µà¹?à¸¢à¸? Encoding Type à¸?à¸²à¸? MS874 à¹?à¸?à¹?à¸? Unicode
     *
     * @param s MS874 String
     * @return Unicode String
     */
    public static String MS874ToUnicode(String s) {
        if (s == null) {
            return "";
        }
        StringBuffer stringbuffer = new StringBuffer(s);
        for (int i = 0; i < s.length(); i++) {
            char c = stringbuffer.charAt(i);
            if ('\241' <= c && c <= '\373') {
                stringbuffer.setCharAt(i, (char) (c + 3424));
            }
        }

        return stringbuffer.toString();
    }

    /**
     * à¹?à¸?à¸¥à¸µà¹?à¸¢à¸?à¸?à¹?à¸² Double à¹?à¸«à¹?à¹?à¸?à¹?à¸? String à¸?à¸²à¸¡à¸£à¸¹à¸?à¹?à¸?à¸?à¸?à¸µà¹?à¸?à¹?à¸­à¸?à¸?à¸²à¸£
     *
     * @param x the double to print
     * @param fmt the format string
     * @return String à¸?à¸µà¹?à¹?à¸?à¸¥à¸?à¸£à¸¹à¸?à¹?à¸?à¸?à¹?à¸¥à¹?à¸§
     */
    public static String dtoa(double x, String fmt) {
        NumberFormat form;

        form = NumberFormat.getInstance();
        ((DecimalFormat) form).applyPattern(fmt);
        return form.format(x);
    }

    /**
     * à¹?à¸?à¸¥à¸µà¹?à¸¢à¸?à¸?à¹?à¸² String à¹?à¸«à¹?à¹?à¸?à¹?à¸? String à¸?à¸²à¸¡à¸£à¸¹à¸?à¹?à¸?à¸?à¸?à¸µà¹?à¸?à¹?à¸­à¸?à¸?à¸²à¸£
     *
     * @param x the double to print
     * @param fmt the format string
     * @return String à¸?à¸µà¹?à¹?à¸?à¸¥à¸?à¸£à¸¹à¸?à¹?à¸?à¸?à¹?à¸¥à¹?à¸§
     */
    public static String dtoa(String x, String fmt) {
        if (x == null || x.compareTo("") == 0
                || x.compareToIgnoreCase("null") == 0) {
            return "";
        }
        NumberFormat form;

        form = NumberFormat.getInstance();
        ((DecimalFormat) form).applyPattern(fmt);
        return form.format(new Double(x).doubleValue());
    }

    /**
     * à¹?à¸?à¸·à¹?à¸­à¹?à¸?à¹?à¸?à¸±à¸?à¸«à¸²à¸?à¹?à¸² double à¸¥à¸?à¸?à¸±à¸?à¹?à¸¥à¹?à¸§à¸?à¹?à¸²à¸?à¸µà¹?à¹?à¸?à¹?à¹?à¸¡à¹?à¸?à¸¹à¸?à¸?à¹?à¸­à¸?
     *
     * @param d_val1 à¸?à¸±à¸§à¸?à¸±à¹?à¸?
     * @param d_val2 à¸?à¸±à¸§à¸¥à¸?
     * @return à¸?à¸¥à¸¥à¸±à¸?à¸?à¹?à¸?à¸­à¸?à¸?à¸²à¸£à¸¥à¸?
     */
    public static double minusDouble(double d_val1, double d_val2) {
        NumberFormat form;
        final double d_100 = 100.0D;
        double d_return = 0;
        String s_val1, s_val2, s_val3;






        long l_val1, l_val2, l_val3;
        int strLen;

        if (d_val1 == -0.00) {
            d_val1 = 0.00;
        }
        if (d_val2 == -0.00) {
            d_val2 = 0.00;
        }
        form = NumberFormat.getInstance();
        ((DecimalFormat) form).applyPattern("0.00");

        s_val1 = form.format(d_val1);
        strLen = s_val1.length();
        s_val2 = s_val1.substring(0, strLen - 3);
        s_val3 = s_val1.substring(strLen - 2);
        s_val1 = s_val2.concat(s_val3);
        l_val1 = Long.parseLong(s_val1);

        s_val1 = form.format(d_val2);
        strLen = s_val1.length();
        s_val2 = s_val1.substring(0, strLen - 3);
        s_val3 = s_val1.substring(strLen - 2);
        s_val1 = s_val2.concat(s_val3);
        l_val2 = Long.parseLong(s_val1);

        l_val3 = l_val1 - l_val2;
        d_return = (double) l_val3 / d_100;

        return d_return;
    }

    /**
     * à¸?à¸£à¸§à¸?à¸ªà¸­à¸?à¸§à¸±à¸?à¸?à¸µà¹?à¸§à¹?à¸²à¸?à¸¹à¸?à¸?à¹?à¸­à¸?à¸«à¸£à¸·à¸­à¹?à¸¡à¹?
     *
     * @param sDate à¸§à¸±à¸?à¸?à¸µà¹?à¸?à¸µà¹?à¸?à¹?à¸­à¸?à¸?à¸²à¸£à¸?à¸£à¸§à¸?à¸ªà¸­à¸? à¸£à¸¹à¸?à¹?à¸?à¸? dd/mm/yyyy (à¸?à¸µ à¸?.à¸¨.)
     * @return ture or false
     */
    public static boolean validDate(String sDate) {
        String dd = sDate.substring(0, 2);
        String mm = sDate.substring(3, 5);
        String yyyy = sDate.substring(6);
        int day[][] = {{31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
            {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
        };

        int year = Integer.valueOf(yyyy).intValue() - 543;
        int i =
                ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) ? 0 : 1;

        if (day[i][(Integer.valueOf(mm).intValue()) - 1]
                < Integer.valueOf(dd).intValue()) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * Send e-mail
     *
     * @param to Recipient
     * @param subject Subject
     * @param body Content
     */
    public static void sendMail(String to, String subject, String body) {
        String smtpServer = null;
        String from = null;
        String cc = null;
        String toSuffix = null;
        String footer = null;

        try {
            /*
             * Get the SMTP Server and Sender Address
             */
            smtpServer = PccProperties.getResourceString("SMTPServer");
            from = PccProperties.getResourceString("SendAddress");
            cc = PccProperties.getResourceString("CcAddress");
            toSuffix = PccProperties.getResourceString("ToSuffix");
            if (toSuffix == null) {
                toSuffix = "@ed.go.th";
            }
            footer = "";

            // Get system properties
            Properties props = System.getProperties();

            // -- Attaching to default Session, or we could start a new one --
            // -- Could use Session.getTransport() and Transport.connect()
            // , but assume we're using SMTP --

            // -- Setup mail server --
            props.put("mail.smtp.host", smtpServer);
            Session session = Session.getDefaultInstance(props, null);

            // -- Create a new message --
            MimeMessage msg = new MimeMessage(session);

            // -- Set the FROM and TO fields --
            msg.setFrom(new InternetAddress(from));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to + toSuffix, false));

            // -- We could include CC recipients too --
            if (cc != null && cc.compareTo("") != 0) {
                msg.setRecipients(Message.RecipientType.CC, InternetAddress.parse(cc, false));

                // -- Set the subject and body text --
            }
            msg.setSubject(subject);

            // -- Fill message --
            msg.setText(body + footer);

            // -- Set some other header information --
            msg.setSentDate(new Date());

            // -- Send the message --
            Transport.send(msg);
        } catch (Exception ex) {
            System.out.println("*****************************************");
            System.out.println(ex);
            ex.printStackTrace();
            System.out.println("*****************************************");
        }
    }

    /**
     * @param to
     * @param subject
     * @param body
     * @param fileAttachment
     */
    public static void sendMail(String to, String subject, String body,
            String fileAttachment) {
        String smtpServer = null;
        String from = null;
        String cc = null;
        String toSuffix = null;
        String footer = null;

        try {
            /*
             * Get the SMTP Server and Sender Address
             */
            smtpServer = PccProperties.getResourceString("SMTPServer");
            from = PccProperties.getResourceString("SendAddress");
            cc = PccProperties.getResourceString("CcAddress");
            toSuffix = PccProperties.getResourceString("ToSuffix");
            if (toSuffix == null) {
                toSuffix = "@ed.go.th";
            }
            footer = "";

            // Get system properties
            Properties props = System.getProperties();

            // -- Attaching to default Session, or we could start a new one --
            // -- Could use Session.getTransport() and Transport.connect()
            // , but assume we're using SMTP --

            // -- Setup mail server --
            props.put("mail.smtp.host", smtpServer);
            Session session = Session.getDefaultInstance(props, null);

            // -- Create a new message --
            MimeMessage msg = new MimeMessage(session);

            // -- Set the FROM and TO fields --
            msg.setFrom(new InternetAddress(from));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to + toSuffix, false));

            // -- We could include CC recipients too --
            if (cc != null && cc.compareTo("") != 0) {
                msg.setRecipients(Message.RecipientType.CC, InternetAddress.parse(cc, false));

                // -- Set the subject and body text --
            }
            msg.setSubject(subject);

            // -- Create the message part --
            MimeBodyPart messageBodyPart = new MimeBodyPart();

            // -- Fill message --
            messageBodyPart.setText(body + footer);

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(messageBodyPart);

            // -- Part two is attachment --
            messageBodyPart = new MimeBodyPart();
            DataSource source = new FileDataSource(fileAttachment);
            messageBodyPart.setDataHandler(new DataHandler(source));
            messageBodyPart.setFileName(fileAttachment);
            multipart.addBodyPart(messageBodyPart);

            // -- Put parts in message --
            msg.setContent(multipart);

            // -- Set some other header information --
            msg.setSentDate(new Date());

            // -- Send the message --
            Transport.send(msg);
        } catch (Exception ex) {
            System.out.println("*****************************************");
            System.out.println(ex);
            ex.printStackTrace();
            System.out.println("*****************************************");
        }
    }

    /**
     * Gets the office name in short formf
     *
     * @param officeName office name
     * @return a String
     */
    public static String shortOfficeName(String officeName) {
        if (officeName.indexOf("à¸ªà¸³à¸?à¸±à¸?à¸?à¸²à¸?à¸ªà¸£à¸£à¸?à¸ªà¸²à¸¡à¸´à¸?") != -1) {
            return officeName.substring(17);
        } else {
            return officeName;
        }
    }

    /**
     * à¹?à¸?à¸¥à¸µà¹?à¸¢à¸?à¸?à¹?à¸² double à¸?à¸µà¹?à¹?à¸?à¹?à¸? String à¹?à¸?à¸£à¸¹à¸?à¹?à¸?à¸?à¸?à¹?à¸²à¸? à¹? à¹?à¸«à¹?à¹?à¸?à¹?à¸? double à¹?à¸?à¹?à¸?
     * '1,500.50' à¹?à¸?à¹?à¸? 1500.50
     *
     * @param str String double
     * @return a double
     */
    public static double decimalFormatToDouble(String str) {
        double doubleVal = 0;
        if (str == null || str.trim().compareTo("") == 0
                || str.trim().compareToIgnoreCase("null") == 0) {
            return doubleVal;
        }
        try {
            doubleVal = NumberFormat.getInstance().parse(str).doubleValue();
        } catch (Exception e) {
            System.out.println("Exception in method decimalFormatToDouble [" + str + "]= " + e);
        }
        return doubleVal;
    }

    /**
     * à¹?à¸?à¸¥à¸µà¹?à¸¢à¸?à¸?à¹?à¸² int à¸?à¸µà¹?à¹?à¸?à¹?à¸? String à¹?à¸?à¸£à¸¹à¸?à¹?à¸?à¸?à¸?à¹?à¸²à¸? à¹? à¹?à¸«à¹?à¹?à¸?à¹?à¸? double à¹?à¸?à¹?à¸?
     * '1,500.50' à¹?à¸?à¹?à¸? 1500
     *
     * @param str String int
     * @return a int
     */
    public static int intFormatToInt(String str) {
        int intVal = 0;
        if (str == null || str.trim().compareTo("") == 0
                || str.trim().compareToIgnoreCase("null") == 0) {
            return intVal;
        }
        try {
            intVal = NumberFormat.getInstance().parse(str).intValue();
        } catch (Exception e) {
            System.out.println("Exception in method intFormatToInt [" + str + "]= " + e);
        }
        return intVal;
    }

    /**
     * à¹?à¸?à¸¥à¸µà¹?à¸¢à¸?à¸£à¸¹à¸?à¹?à¸?à¸?à¸?à¸­à¸? Tin à¹?à¸«à¹?à¸­à¸¢à¸¹à¹?à¹?à¸?à¸£à¸¹à¸?à¹?à¸?à¸? X-XXXX-XXXX-X
     *
     * @param tin String
     * @return a String
     */
    public static String tinFormat(String tin) {
        if (tin.length() < 10) {
            return tin;
        }
        StringBuffer strbuff = new StringBuffer("");

        strbuff.append(tin.substring(0, 1) + "-" + tin.substring(1, 5) + "-" + tin.substring(5, 9) + "-" + tin.substring(9, 10));

        return strbuff.toString();
    }

    /**
     * à¹?à¸?à¸¥à¸µà¹?à¸¢à¸?à¸£à¸¹à¸?à¹?à¸?à¸?à¸?à¸­à¸? Tin à¹?à¸?à¸£à¸¹à¸?à¹?à¸?à¸? X-XXXX-XXXX-X à¹?à¸«à¹?à¹?à¸?à¹?à¸?à¸£à¸¹à¸?à¹?à¸?à¸? XXXXXXXXXX
     *
     * @param tin String
     * @return a String
     */
    public static String tinFormatToFormal(String tin) {
        if (tin.length() < 13) {
            return tin;
        }
        StringBuffer strbuff = new StringBuffer("");
        tin = tin.substring(0, 1) + tin.substring(2, 6) + tin.substring(7, 11) + tin.substring(12);
        strbuff.append(tin);
        return strbuff.toString();
    }

    /**
     * à¹?à¸?à¸¥à¸µà¹?à¸¢à¸?à¸£à¸¹à¸?à¹?à¸?à¸?à¸?à¸­à¸? Pin à¹?à¸«à¹?à¸­à¸¢à¸¹à¹?à¹?à¸?à¸£à¸¹à¸?à¹?à¸?à¸? X-XXXX-XXXXX-XX-X
     *
     * @param pin String
     * @return a String
     */
    public static String pinFormat(String pin) {
        if (pin.length() < 13) {
            return pin;
        }
        StringBuffer strbuff = new StringBuffer("");

        strbuff.append(pin.substring(0, 1) + "-" + pin.substring(1, 5) + "-" + pin.substring(5, 10) + "-" + pin.substring(10, 12) + "-"
                + pin.substring(12, 13));

        return strbuff.toString();
    }
    
    public static String accnoFormat(String accno) {
        if (accno.length() < 10) {
            return accno;
        }
        StringBuffer strbuff = new StringBuffer("");

        strbuff.append(accno.substring(0, 3) + "-" + accno.substring(3, 4) + "-" + accno.substring(4, 9) + "-" + accno.substring(9, 10)); 

        return strbuff.toString();
    }

    /**
     * à¹?à¸?à¸¥à¸µà¹?à¸¢à¸?à¸£à¸¹à¸?à¹?à¸?à¸?à¸?à¸­à¸? Pin à¹?à¸?à¸£à¸¹à¸?à¹?à¸?à¸? X-XXXX-XXXXX-XX-X à¹?à¸«à¹?à¹?à¸?à¹?à¸?à¸£à¸¹à¸?à¹?à¸?à¸?
     * XXXXXXXXXXXXX
     *
     * @param pin String
     * @return a String
     */
    public static String pinFormatToFormal(String pin) {
        if (pin.length() < 17) {
            return pin;
        }
        StringBuffer strbuff = new StringBuffer("");
        pin = pin.substring(0, 1) + pin.substring(2, 6) + pin.substring(7, 12) + pin.substring(13, 15) + pin.substring(16);
        strbuff.append(pin);
        return strbuff.toString();
    }

    /**
     * à¸?à¸£à¸§à¸?à¸ªà¸­à¸?à¸?à¹?à¸²à¸?à¸­à¸? String à¸?à¸µà¹?à¸ªà¹?à¸?à¹?à¸?à¹?à¸²à¸«à¸²à¸?à¹?à¸?à¹?à¸? Null à¸?à¸°à¹?à¸?à¸¥à¸µà¹?à¸¢à¸?à¹?à¸«à¹?à¹?à¸?à¹?à¸?à¸?à¹?à¸²à¸§à¹?à¸²à¸?
     *
     * @param value String
     * @return a String
     */
//	  public static String chkNull(String value) 
//	  {    	
//	  	  if(value!=null)
//	  	  {	
//	  	  	value=value.replaceAll("\\'"," ");
//	  	  }else 
//	  	  	{
//	  	  		value="";
//	  	  	}	  	
//	      return value;
//	  }
    public static String chkNull(String value) {
        return (value == null ? "" : value.trim().replaceAll("\\'", " "));
    }

    /**
     * à¸?à¸£à¸§à¸?à¸ªà¸­à¸?à¸?à¹?à¸²à¸?à¸­à¸? String à¸?à¸µà¹?à¸ªà¹?à¸?à¹?à¸?à¹?à¸²à¸«à¸²à¸?à¹?à¸?à¹?à¸? Null à¸?à¸°à¸ªà¹?à¸?à¸?à¹?à¸²à¸?à¸¥à¸±à¸?à¸?à¹?à¸²à¸?à¸­à¸? double
     * à¸?à¸µà¹?à¸ªà¹?à¸?à¸¡à¸²<br> à¸«à¸²à¸?à¸?à¹?à¸²à¸?à¸­à¸? String à¸?à¸µà¹?à¸ªà¹?à¸?à¹?à¸?à¹?à¸²à¸¡à¸²à¹?à¸¡à¹?à¹?à¸?à¹?à¸? Null
     * à¸?à¸°à¸?à¸³à¸?à¸²à¸£à¹?à¸?à¸¥à¸µà¹?à¸¢à¸?à¸?à¹?à¸²à¸?à¸­à¸? String à¹?à¸«à¹?à¹?à¸?à¹?à¸? double
     *
     * @param strValue String
     * @param doubleZero double
     * @return a double
     */
    public static double chkNull(String strValue, double doubleZero) {
        return ((strValue == null || strValue.trim().compareTo("") == 0
                || strValue.trim().compareToIgnoreCase("null") == 0) ? doubleZero : decimalFormatToDouble(strValue));
    }

    public static String chkNullInt(String value) {
        return ((value == null || value.trim().compareTo("") == 0
                || value.trim().compareToIgnoreCase("null") == 0) ? "null" : (Tools.intFormatToInt(value.trim()) + ""));
    }

    public static String chkNullDouble(String value) {
        return ((value == null || value.trim().compareTo("") == 0
                || value.trim().compareToIgnoreCase("null") == 0) ? "null" : (Tools.decimalFormatToDouble(value.trim()) + ""));
    }

    /**
     * Method getServerDate
     *
     * @return String : yyyy/MM/dd à¸?à¸²à¸£à¹?à¸?à¹?à¸?à¸²à¸? : à¸?à¸¶à¸?à¸?à¹?à¸­à¸¡à¸¹à¸¥ à¸§à¸±à¸? à¹?à¸?à¸·à¸­à¸? à¸?à¸µ à¸?.à¸¨.
     * à¹?à¸?à¸¢à¸£à¸¹à¸?à¹?à¸?à¸?à¸?à¸µà¹? return à¸?à¸±à¹?à¸?à¸?à¸·à¸­ yyyy/mm/dd
     */
    public static String getServerDate() {
        String retDate = null;
        try {
            Calendar calendar = Calendar.getInstance();
            Date utilDate = calendar.getTime();
            Date date = new Date(utilDate.getTime());
            SimpleDateFormat template = new SimpleDateFormat("yyyy/MM/dd");
            retDate = template.format(date);
        } catch (Exception ex) {
            System.out.println("Error Exception : method getCurrentDate in Class Tools : " + ex.getMessage());
            ex.printStackTrace();
        }
        return retDate;
    }

    public static String getIP() {
        String IP = null;
        try {
            java.net.InetAddress i = java.net.InetAddress.getLocalHost();
            /*
             * System.out.println(i); // name and IP address
             * System.out.println(i.getHostName()); // name
             * System.out.println(i.getHostAddress()); // IP address only
             */
            IP = i.getHostAddress();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return IP;
    }

    public static String chkNullToZero(String value) {
        return ((value == null || value.trim().compareTo("") == 0 || value.trim().compareToIgnoreCase("null") == 0) ? "0" : (value.trim()));
    }

    /**
     * Method trimSpace param1 str à¹?à¸?à¹?à¸? " à¸? à¸­à¸¢à¸¸à¸?à¸¢à¸² à¹?à¸?à¸£à¸´à¸? à¸?à¸²à¸?à¸µ " return
     * "à¸?à¸­à¸¢à¸¸à¸?à¸¢à¸²à¹?à¸?à¸£à¸´à¸?à¸?à¸²à¸?à¸µ" By Jjay
     */
    public static String trimSpace(String str) {
        String noSpace = "";
        if (str.equals("")) {
            return noSpace;
        }
        StringTokenizer token = new StringTokenizer(str, " ");
        int loop = 0;
        while (token.hasMoreTokens()) {
            loop++;
            String token1 = token.nextToken();
            noSpace += token1;
        }
        return noSpace;
    }

    /**
     * @author naja Method xChgDateEngToThai
     * @param data String
     * @return value String
     */
    public static String xChgDateEngToThai(String data) {
        String value = "";
        if (data.length() >= 10) {
            value = data.substring(8, 10) + "/" + data.substring(5, 7) + "/" + (Integer.parseInt(data.substring(0, 4)) + 543);
        }
        return value;
    }

    /**
     * @author naja Method xChgDateEngToThaiTimeStamp
     * @param data String
     * @return value String
     */
    public static String xChgDateEngToThaiTimeStamp(String data) {
        String value = "";
        if (data.length() > 10) {
            value = data.substring(8, 10) + "/" + data.substring(5, 7) + "/" + (Integer.parseInt(data.substring(0, 4)) + 543) + " " + data.substring(11);
        }
        return value;
    }

    public static String addZero(String data, int iSize) {
        String dataTmp = "";
        for (int i = data.length(); i < iSize; i++) {
            dataTmp += "0";
        }
        return dataTmp + data;
    }

    public static String printPageNo(int sManrecord, int scountpage, String pageNo, String sgrouppage, String sprevpage, int startrecord, int endrecord, int record_Group) {
        StringBuffer sbPage = new StringBuffer("");
        sbPage.append("<table width='100%' align='center' border='0' id='tableb3' cellspacing='0' cellpadding='0'>\n");
        sbPage.append("<tr class='trHeader2'>\n");
        sbPage.append("<td width='20%' class=ms14 align ='left'>&nbsp;à¸?à¸³à¸?à¸§à¸?à¸?à¹?à¸­à¸¡à¸¹à¸¥à¸?à¸±à¹?à¸?à¸«à¸¡à¸?&nbsp;<font class='ms14org_b'>" + sManrecord + "</font>&nbsp;à¸£à¸²à¸¢à¸?à¸²à¸£/à¸?à¸³à¸?à¸§à¸?à¸«à¸?à¹?à¸²&nbsp;<font class='ms14org_b'>" + scountpage + "</font>&nbsp;à¸«à¸?à¹?à¸²</td>\n");
        int ii_pagegroup = 0;
        int ii_countpagegroup = 1;
        int ii_chkcount = 0;
        int iii_prev = 0;
        int iii_startprev = 0;
        int iii_pageprev = 0;
        int iii_next = 0;
        int iii_startnext = 0;
        int iii_pagenext = 0;
        int iii_rec_prev = 0;
        boolean falgprev = false;
        if (sManrecord > 0) {//aTin_size != null &&

            int detailpage = 0;
            if (pageNo.equals("1")) {
                detailpage = 1;
                iii_prev = 1;
                iii_next = 1;
            } else {
                detailpage = Integer.parseInt(pageNo);
                iii_prev = Integer.parseInt(sgrouppage);
                iii_next = Integer.parseInt(sgrouppage);
            }
            if (sgrouppage.equals("")) {
                sgrouppage = "1";
            }
            iii_startnext = (iii_next * record_Group);// iii_next*record_Group à¹?à¸?à¹?à¸?à¸?à¹?à¸²total à¹?à¸?à¸·à¹?à¸­ pageà¸?à¸±à¸?à¹?à¸? (50 record and 5 page)

            iii_startprev = ((iii_next - 2) * record_Group);// ((iii_next-2)*record_Group) à¹?à¸?à¹?à¸?à¸?à¹?à¸²total à¹?à¸?à¸·à¹?à¸­ pageà¸¢à¹?à¸­à¸?à¸?à¸¥à¸±à¸? (50 record and 5 page)

            if (!sprevpage.equals("")) {
                iii_pageprev = Integer.parseInt(sprevpage) - 5;//à¹?à¸?à¸·à¹?à¸­ pageà¸¢à¹?à¸­à¸?à¸?à¸¥à¸±à¸?

                if (iii_pageprev <= 0) {
                    iii_pageprev = 1;
                }
            } else {
                iii_pageprev = 1;
            }
            sbPage.append("<td width=\"11%\">&nbsp;</td>");
//		sbPage.append("<td width=\"11%\" align=\"left\" ><font color=\"#000000\">&nbsp;à¹?à¸¥à¸·à¸­à¸?à¸?à¸¹à¸«à¸?à¹?à¸²à¸?à¸µà¹?&nbsp; </font>");
//		sbPage.append("<INPUT type=\"text\" id=\"txtPage\" maxlength=\"4\" style=\"width:20%\" value=\""+detailpage+"\" onKeyPress=\"chkNumber1();\">&nbsp; <input type=\"button\" name=\"btOk\" value=\"&nbsp;à¹?à¸?&nbsp;\" onclick=\"Gopage("+scountpage+");\">&nbsp; </td>\n");
            if (iii_startprev < 0) {
                sbPage.append("<td width=\"3%\" align=\"left\" ><font color=\"#000000\">&lt;&nbsp;à¸¢à¹?à¸­à¸?à¸?à¸¥à¸±à¸?</font></td>\n");
            } else {
                sbPage.append("<td width=\"3%\" class=\"ms14org_b\" align=\"left\" onclick = \"CurrentShowData('" + iii_startprev + "','" + iii_pageprev + "','" + (iii_prev - 1) + "','" + iii_pageprev + "')\" style=\"cursor:hand\">&lt;&nbsp;à¸¢à¹?à¸­à¸?à¸?à¸¥à¸±à¸?</td>\n");
            }
            for (int pagec = 1; pagec <= scountpage; pagec++) {
                ii_chkcount++;
                if (ii_chkcount > 5) {// à¸?à¸³à¸?à¸§à¸? page à¸?à¸µà¹?à¹?à¸?à¸§à¹?

                    ii_countpagegroup++;// countgroup à¸?à¸³à¸?à¸§à¸? page

                    ii_chkcount = 1;
                } else {
                    if (pagec == scountpage) {
                        if (ii_chkcount > 5) {// à¸?à¸³à¸?à¸§à¸? page à¸?à¸µà¹?à¹?à¸?à¸§à¹?

                            ii_countpagegroup++;
                        }
                    }
                }
                if (!sgrouppage.equals("")) {
                    if (Integer.parseInt(sgrouppage) == ii_countpagegroup) {//à¸?à¹?à¸²à¹?à¸?à¹?à¸²à¸?à¸±à¸?à¹?à¸?à¸§à¹? page à¸?à¸±à¹?à¸?

                        iii_pagenext = pagec;// iii_next = pagec à¹?à¸?à¸·à¹?à¸­ pageà¸?à¸±à¸?à¹?à¸?

                        if (!falgprev) {
                            iii_rec_prev = pagec;
                            falgprev = true;
                        }
                        if (detailpage == pagec) {
                            sbPage.append("<td width=\"2%\" align=\"right\" ><B><font color=\"#000000\">[" + pagec + "]</font></B></td>\n");
                        } else {
                            sbPage.append("<td width=\"2%\" class=\"ms14org_b\" align=\"right\" onclick = \"CurrentShowData('" + startrecord + "','" + pagec + "','" + ii_countpagegroup + "','" + iii_rec_prev + "')\" style=\"cursor:hand\">" + pagec + "</td>\n");
                        }
                    }
                }
            }
            if (iii_startnext >= sManrecord) {
                sbPage.append("<td width=\"3%\" align=\"right\"><font color=\"#000000\">à¸?à¸±à¸?à¹?à¸?&nbsp;&gt;</font></td>\n");
            } else {
                sbPage.append("<td width=\"3%\" class=\"ms14org_b\" align=\"right\" onclick =\"CurrentShowData('" + (iii_startnext) + "','" + (iii_pagenext + 1) + "','" + (iii_next + 1) + "','" + (iii_rec_prev + 5) + "')\" style=\"cursor:hand\">à¸?à¸±à¸?à¹?à¸?&nbsp;&gt;</td>\n");
            }
        }
        sbPage.append("</tr>\n");
        sbPage.append("</table>\n");
        sbPage.append("<SCRIPT>\n");
        sbPage.append("function chGopage(pagen,mpage){\n");
        sbPage.append("var p=pagen;\n");
        sbPage.append("if(pagen>mpage){\n");
        sbPage.append("alert(\"à¸?à¸£à¸¸à¸?à¸²à¹?à¸¥à¸·à¸­à¸?à¹?à¸¥à¸?à¸«à¸?à¹?à¸²à¹?à¸«à¸¡à¹?\");\n");
        sbPage.append("}else{ \n");
        sbPage.append(" CurrentShowData('" + startrecord + "',pagen,'','') \n");
        sbPage.append(" }\n");
        sbPage.append("}\n");

        sbPage.append("function chkNumber1(){\n");
        sbPage.append("e_k=event.keyCode\n");
        sbPage.append("if (!((e_k >= 48) &&(e_k <= 57))) {\n");
        sbPage.append("event.returnValue = false;\n");
        sbPage.append("}\n");
        sbPage.append("}\n");
        sbPage.append("function Gopage(mp){\n");
        sbPage.append("var page=document.getElementById(\"txtPage\").value; \n");
        sbPage.append("chGopage(page,mp);\n");
        sbPage.append("}\n");
        sbPage.append("</SCRIPT>\n");
        return sbPage.toString();
    }

    /*
     * public static String beforeSubmitForm(HttpServletRequest request){ String
     * contextPath = request.getContextPath(); StringBuffer strOut = new
     * StringBuffer(); strOut.append("<script type=\"text/javascript\">\n");
     * strOut.append("for (var i = 0; i < document.forms.length; i++) {\n");
     * strOut.append("	var form = document.forms[i];\n"); strOut.append("
     * form.realSubmit = form.submit;\n"); strOut.append("	form.submit =
     * function () {\n"); strOut.append("	var oldAction = form.action;\n");
     * strOut.append("	oldAction =
     * oldAction.replace(\""+contextPath+"\",\"\");\n"); strOut.append("
     * form.action = \""+contextPath+"/ControlJspServlet\";\n"); strOut.append("
     * var objForm = form;\n"); strOut.append("	try{\n"); strOut.append("	var
     * obj = document.getElementById(\"url\");\n"); strOut.append("
     * objForm.removeChild(obj);\n"); strOut.append("	}catch(err){}\n");
     * strOut.append("	var newElement = document.createElement(\"<input
     * name='url' type='hidden' value='\"+oldAction+\"'>\");\n");
     * strOut.append("	objForm.appendChild(newElement); \n"); strOut.append("
     * this.realSubmit();\n"); strOut.append("	} \n"); strOut.append("} \n");
     * strOut.append("</script>\n"); return strOut.toString(); }
     */
    public static String beforeSubmitForm(HttpServletRequest request, String formName) {
        String contextPath = request.getContextPath();
        StringBuffer strOut = new StringBuffer();
        strOut.append("<script type=\"text/javascript\">\n");
        strOut.append("		document." + formName + ".realSubmit = document." + formName + ".submit;\n");
        strOut.append("		document." + formName + ".submit = function () {\n");
        strOut.append("			var oldAction = document." + formName + ".action;\n");
        //strOut.append("			oldAction = oldAction.replace(\""+contextPath+"\",\"\");\n");
        strOut.append("			oldAction = oldAction.substring(oldAction.indexOf(\"" + contextPath + "\")+\"" + contextPath + "\".length);\n");
        strOut.append("			document." + formName + ".action = \"" + contextPath + "/ControlJspServlet\";\n");
        //strOut.append("			document.getElementById(\""+formName+"\");\n");
        strOut.append("			var objForm = document." + formName + ";\n");
        strOut.append("			try{\n");
        strOut.append("				var obj = document.getElementById(\"url\");\n");
        strOut.append("				objForm.removeChild(obj);\n");
        strOut.append("			}catch(err){}\n");
        strOut.append("			var input = document.createElement('input');\n");
        strOut.append("			input.setAttribute('id', 'url');\n");
        strOut.append("			input.setAttribute('type', 'hidden');\n");
        strOut.append("			input.setAttribute('name', 'url');\n");
        strOut.append("			input.setAttribute('value', oldAction);\n");
        //strOut.append("			var parent = document.getElementById('children');\n");
        strOut.append("			objForm.insertBefore(input, null);\n");
        //strOut.append("			alert(\"oldAction22=\"+oldAction);\n");
        //strOut.append("			var newElement = document.createElement(\"<input name='url' id='url' type='hidden' value='\"+oldAction+\"'>\");\n");
        //strOut.append("			alert(\"oldAction=\"+oldAction);\n");
        //strOut.append("			objForm.appendChild(newElement); \n");
        //strOut.append("			alert(\"oldAction2=\"+oldAction);\n");
        strOut.append("			this.realSubmit();\n");
        strOut.append("		} \n");
        strOut.append("</script>\n");
        return strOut.toString();
    }

    public static String beforeReplacePage(HttpServletRequest request, String formName) {
        String replaceForm = "replaceForm";
        String contextPath = request.getContextPath();
        StringBuffer strOut = new StringBuffer();
        strOut.append("<script type=\"text/javascript\">\n");
        strOut.append("	window.location.replace = function(url){\n");
        strOut.append("		try{\n");
        strOut.append("			var objForm = document.getElementById(\"" + replaceForm + "\");\n");
        strOut.append("			document.removeChild(objForm);\n");
        strOut.append("		}catch(err){}\n");
        strOut.append("		url = url.replace(\"" + contextPath + "\",\"\");\n");
        strOut.append("			var objForm = document.createElement('form');\n");
        strOut.append("			objForm.setAttribute('id', '" + replaceForm + "');\n");
        strOut.append("			objForm.setAttribute('name', '" + replaceForm + "');\n");
        strOut.append("			objForm.setAttribute('action', '" + contextPath + "/ControlJspServlet');\n");
        strOut.append("			objForm.setAttribute('method', 'post');\n");
        strOut.append("			var input = document.createElement('input');\n");
        strOut.append("			input.setAttribute('id', 'url');\n");
        strOut.append("			input.setAttribute('type', 'hidden');\n");
        strOut.append("			input.setAttribute('name', 'url');\n");
        strOut.append("			input.setAttribute('value', url);\n");
        strOut.append("			objForm.insertBefore(input, null);\n");
        strOut.append("		document.appendChild(objForm);\n");
        strOut.append("		objForm.submit();\n");
        strOut.append("}\n");
        strOut.append("</script>\n");
        return strOut.toString();
    }

    public static String beforeReplacePage(HttpServletRequest request) {
        return beforeReplacePage(request, "replaceForm");
    }

    public static void printLinkToMenuPage(HttpServletRequest request, HttpServletResponse response, String alertMsg, String linkTo) throws Exception {
        String contextPath = request.getContextPath();
        PrintWriter out = response.getWriter();
        out.println("<HTML>\n");
        out.println("<HEAD>\n");
        out.println("<TITLE> à¸?à¸?à¸?à¹?à¸­à¸?à¸´à¸?à¸?à¸¥à¸²à¸? </TITLE>\n");
        out.println("</HEAD>\n");
        out.println("<SCRIPT LANGUAGE=\"JavaScript\">\n");
        out.println("<!--\n");
        out.println("function GoForward() {\n");
        out.println("   alert(\"" + alertMsg + "\");\n");
        out.println("   document.formBackMenu.submit();\n");
        out.println("}\n");
        out.println("//-->\n");
        out.println("</SCRIPT>\n");
        out.println("<BODY onload=\"GoForward();\">\n");
        out.println("<form action='" + contextPath + "/ControlJspServlet' method='post' name='formBackMenu'>\n");
        out.println("<input type='hidden' name='url' value='" + linkTo + "'> ");
        out.println("</form>\n");
        out.println("</BODY>\n");
        out.println("</HTML>\n");
    }

    public static String dateTimeToDb(String dateTime) {
        if (dateTime != null && dateTime.compareTo("") != 0) {
            if (dateTime.startsWith("'") || dateTime.startsWith("\"")) {
                dateTime = dateTime.substring(1);
                if (dateTime.endsWith("'") || dateTime.endsWith("\"")) {
                    dateTime = dateTime.substring(0, dateTime.length() - 1);
                }
            }
            if (dateTime.indexOf("/") != -1) {
                dateTime = (Integer.parseInt(dateTime.substring(6, 10)) - 543) + "-"
                        + dateTime.substring(3, 5) + "-" + dateTime.substring(0, 2)
                        + dateTime.substring(10);
            }
            if (dateTime.length() > 0) {
                if (dateTime.length() > 26) {
                    return "'" + dateTime.substring(0, 26) + "'";	//$ à¹?à¸?à¹?à¹?à¸? 19 à¹?à¸?à¹?à¸? 26 (18/7/54)

                } else {
                    return "'" + dateTime + "'";
                }
            } else {
                return "null";
            }
        } else {
            return "null";
        }
    }

    public static String dateToDb(String date) {
        if (date != null && date.compareTo("") != 0) {
            if (date.startsWith("'") || date.startsWith("\"")) {
                date = date.substring(1);
                if (date.endsWith("'") || date.endsWith("\"")) {
                    date = date.substring(0, date.length() - 1);
                }
            }
            if (date.length() > 10) {
                return dateTimeToDb(date);
            }
            if (date.indexOf("/") != -1) {
                date = (Integer.parseInt(date.substring(6)) - 543) + "-"
                        + date.substring(3, 5) + "-" + date.substring(0, 2);
            }
            if (date.length() > 0) {
                return "'" + date + "' ";
            } else {
                return "null";
            }
        } else {
            return "null";
        }
    }

    public static boolean checkNumber(String sValue) {
        double dTmpValue = 0.00;
        try {
            dTmpValue = Double.parseDouble(sValue.replaceAll(",", ""));
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * à¸?à¸£à¸§à¸?à¸ªà¸­à¸?à¹?à¸¥à¸?à¸?à¸£à¸°à¸?à¸³à¸?à¸±à¸§à¸?à¸£à¸°à¸?à¸²à¸?à¸?
     *
     * @param pin String
     * @return a String
     */
    public static boolean checkPin(String sValue) {
        boolean bCheck = false;








        int cal_pin, j,
                pin_num;
        int i, tmpMod;
        cal_pin = 0;
        j = 13;
        pin_num = 0;
        if (Tools.checkNumber(sValue)) {
            if (sValue.length() == 13) {
                for (i = 0; i < sValue.length(); i++) {
                    if (i != 12) {
                        cal_pin += Integer.parseInt(sValue.substring(i, i + 1)) * j;
                        --j;
                    }
                }
                tmpMod = cal_pin % 11;
                pin_num = (11 - tmpMod) % 10;
                if (sValue.substring(sValue.length() - 1).compareTo((pin_num + "")) == 0) {
                    bCheck = true;
                }
            }
        }
        return bCheck;
    }
    
    public static void main(String[] args) throws SQLException {
        System.out.print("Build OK");
    }
    
}

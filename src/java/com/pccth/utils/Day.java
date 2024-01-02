package com.pccth.utils;

import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 * Store dates and perform date arithmetic
 * (another Date class, but more convenient that 
 * java.util.Date or java.util.Calendar)
 * @version 1.03 25 Oct 1997
 * @author Cay Horstmann
 * @modify Prawith Thowphant
 */

public class Day {
	private int milisecond;
	private int second;
	private int minute;
	private int hour;
	private int day;
	private int month;
	private int enYear;
	private int thYear;
	private char e_t;
	private static final String fullMonth[][] = 
		{{"มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน", "กรกฎาคม", "สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม" },
		 {"January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }};
	// edit add static 09/06/2551 
	private static final String shortMonth[][] = 
		{{"ม.ค.", "ก.พ.", "มี.ค.", "เม.ย.", "พ.ค.", "มิ.ย.", "ก.ค.", "ส.ค.", "ก.ย.", "ต.ค.", "พ.ย.", "ธ.ค." },
		 {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" }};
	/////////////////
	private final String dayName[][] =
		{{"อาทิตย์", "จันทร์", "อังคาร", "พุธ", "พฤหัสบดี", "ศุกร์", "เสาร์"},
		 {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",  "Friday", "Saturday"}};

  	/**
    *  Constructs today's date
    */  

	public Day()
	{
	   GregorianCalendar todaysDate = new GregorianCalendar();
	   enYear = todaysDate.get(Calendar.YEAR);
	   thYear = enYear + 543;
	   month = todaysDate.get(Calendar.MONTH) + 1;
	   day = todaysDate.get(Calendar.DAY_OF_MONTH);
	   hour = todaysDate.get(Calendar.HOUR_OF_DAY);
	   minute = todaysDate.get(Calendar.MINUTE);
	   second = todaysDate.get(Calendar.SECOND);
	   milisecond = todaysDate.get(Calendar.MILLISECOND);
	   e_t = 'T';
	}

	/**
	* Constructs a specific date
	* @param yyyy year (full year, e.g., 1996, 
    * <i>not</i> starting from 1900)
    * @param m month
    * @param d day
	* @param e_t 'E'(English) or 'T'(Thai)
    * @exception IllegalArgumentException if yyyy m d not a valid date
    */

	public Day(int yyyy, int m, int d, char e_t) 
	{
	   if (e_t  == 'e' || e_t == 'E') {
		   this.e_t = 'E';
		   enYear = yyyy;
		} else {
			this.e_t = 'T';
			enYear = yyyy - 543;
		}
		thYear = enYear + 543;
		month = m;
		day = d;
		if (!isValid())
			throw new IllegalArgumentException();
	}

	/**
	* Advances this day by n days. For example. 
    * d.advance(30) adds thirdy days to d
    * @param n the number of days by which to change this
    * day (can be < 0)
    */

	public void advance(int n)
	{
		fromJulian(toJulian() + n);
	}

	/**
	* Gets the millisecond within the second
    * @return the millisecond within the second (0...999)
    */

	public int getMilisecond()
	{
		return milisecond;
	}

	/**
	* Gets the second within the minute
    * @return the second within the minute (0...59)
    */

	public int getSecond()
	{
		return second;
	}

	/**
	* Gets the minute within the hour
    * @return the minute within the hour (0...59)
    */

	public int getMinute()
	{
		return minute;
	}

	/**
	* Gets the hour of the day
    * @return the hour of the day (0...23)
    */

	public int getHour()
	{
		return hour;
	}

	/**
	* Gets the day of the month
    * @return the day of the month (1...31)
    */

	public int getDay()
	{
		return day;
	}

	/**
    * Gets the month
    * @return the month (1...12)
    */

	public int getMonth()
	{
		return month;
	}

	/**
    * Gets the Year in A.D.
    * @return the Year in A.D. (counting from 0, <i>not</i> from 1900)
    */

	public int getYearEng()
	{
		return enYear;
	}

	/**
    * Gets the Year in B.E.
    * @return the Year in B.E. (counting from 0, <i>not</i> from 2443)
    */

	public int getYearThai()
	{
		return thYear;
	}

	/**
    * Sets the year type (A.D. or B.E.)
	* @param e_t 'E'(English) or 'T'(Thai)
    */

	public void setYearType(char e_t)
	{
		if (e_t == 'E' || e_t == 'e')
		   this.e_t = 'E';
		else
			this.e_t = 'T';
	}

	/**
    * Gets the day of the week
    * @return the day of the weekday (0 = Sunday, 1 = Monday, ..., 
    * 6 = Saturday)
    */

	public int weekday()
	{
		return (toJulian() + 1)% 7;
	}

   /**
    * The number of days between this and day parameter 
    * @param b any date
    * @return the number of days between this and day parameter 
    * and b (> 0 if this day comes after b)
    */

	public int daysBetween(Day b)
	{
		return toJulian() - b.toJulian();
	}

	/**
    * A string representation of the day
    * @return a string representation of the day
    */

	public String toString()
	{
		if (e_t == 'E')
			return toString("yyyy-mm-dd hh:mn:ss.zz");
		else
			return toString("dd/mm/yyyy hh:mn:ss.zz");
	}

	/**
    * A string representation of the day
	* @param dateForm date format
	* The valid values are<br>
	* "day" for day of week<br>
	* "d" or "dd" for date<br>
	* "m" or "mm" for month in number<br>
	* "mon" for month in short name<br>
	* "month" for month in full name<br>
	* "yy" or "yyyy" for year
	* "hh" for hour<br>
	* "mn" for minute<br>
	* "ss" for second<br>
	* "zz" for milisecond<br>
	* " " or "/" or "-" or ":" or "." or "," for separator.<br>
	* e.g. "yyyy-mm-dd hh:mn:ss", "dd/mm/yyyy", "dd mon yy", "dd month yyyy".
    * @return a string representation of the day
    */

	public String toString(String dateFormat)
	{
		StringBuffer theDate = new StringBuffer("");
		StringBuffer theFormat = new StringBuffer("");
		final String separator = " /-:.,";
		int strLen = dateFormat.length();
		char charVal;

		
		for (int i=0; i < strLen; i++) {
			charVal = dateFormat.charAt(i);
			if (separator.indexOf((int)charVal) == -1) {
				theFormat.append(charVal);
			} else {
				if (theFormat.length() > 0) {
					theDate.append(getValue(theFormat.toString()));
					theFormat.delete(0,theFormat.length());
				}
				theDate.append(charVal);
			}
		}

		if (theFormat.length() > 0)
			theDate.append(getValue(theFormat.toString()));

		return theDate.toString();
	}

	/**
    * Gets the String value by format
	* @param theFormat e.g. day, dd, mm, mon, month, yy, yyyy, hh, mn, ss
	* @return the String value
    */

	private String getValue(String theFormat)
	{
		int arrIndex, year;
		String returnValue = null;
		
		if (e_t == 'T') {
			arrIndex = 0;
			year = thYear;
		} else {
			arrIndex = 1;
			year = enYear;
		}

		if (theFormat.compareToIgnoreCase("d") == 0)
			returnValue = ""+day;
		else if (theFormat.compareToIgnoreCase("dd") == 0)
			returnValue = ((day<10) ? "0" : "")+day;
		else if (theFormat.compareToIgnoreCase("day") == 0)
			returnValue = dayName[arrIndex][weekday()];
		else if (theFormat.compareToIgnoreCase("m") == 0)
			returnValue = ""+month;
		else if (theFormat.compareToIgnoreCase("mm") == 0)
			returnValue = ((month<10) ? "0" : "")+month;
		else if (theFormat.compareToIgnoreCase("mon") == 0)
			returnValue = shortMonth[arrIndex][month-1];
		else if (theFormat.compareToIgnoreCase("month") == 0)
			returnValue = fullMonth[arrIndex][month-1];
		else if (theFormat.compareToIgnoreCase("yy") == 0) {
			year %= 100;
			returnValue = ((year<10) ? "0" : "")+year;
		} else if (theFormat.compareToIgnoreCase("yyyy") == 0)
			returnValue = ""+year;
		else if (theFormat.compareToIgnoreCase("hh") == 0)
			returnValue = ((hour<10) ? "0" : "")+hour;
		else if (theFormat.compareToIgnoreCase("mn") == 0)
			returnValue = ((minute<10) ? "0" : "")+minute;
		else if (theFormat.compareToIgnoreCase("ss") == 0)
			returnValue = ((second<10) ? "0" : "")+second;
		else if (theFormat.compareToIgnoreCase("zz") == 0)
			returnValue = ((milisecond<100) ? ((milisecond<10) ? "00" : "0") : "")+milisecond;
		else
			returnValue = theFormat;		

		return returnValue;
	}

	/**
    * Makes a bitwise copy of a Day object
    * @return a bitwise copy of a Day object
    */

	public Object clone()
	{
		try {
			return super.clone();
		} catch (CloneNotSupportedException e) {  // this shouldn't happen, since we are Cloneable
			return null;
		}   
	}

	/**
    * Computes the number of days between two dates
    * @return true if this is a valid date
    */
    
	private boolean isValid()
	{
		Day t = new Day();
		t.fromJulian(this.toJulian());
		return t.day == day && t.month == month && t.enYear == enYear;
	}

	/**
    * @return The Julian day number that begins at noon of this day
    * Positive year signifies A.D., negative year B.C. 
    * Remember that the year after 1 B.C. was 1 A.D.
    *
    * A convenient reference point is that May 23, 1968 noon
    * is Julian day 2440000.
    *
    * Julian day 0 is a Monday.
    *
    * This algorithm is from Press et al., Numerical Recipes
    * in C, 2nd ed., Cambridge University Press 1992
    */

	private int toJulian()
	{
		int jy = enYear;
		if (enYear < 0)
			jy++;
		int jm = month;
		if (month > 2)
			jm++;
		else {
			jy--;
			jm += 13;
		}
		int jul = (int) (java.lang.Math.floor(365.25 * jy) + java.lang.Math.floor(30.6001*jm) + day + 1720995.0);

		int IGREG = 15 + 31*(10+12*1582); // Gregorian Calendar adopted Oct. 15, 1582

		if (day + 31 * (month + 12 * enYear) >= IGREG) { // change over to Gregorian calendar
			int ja = (int)(0.01 * jy);
			jul += 2 - ja + (int)(0.25 * ja);
		}
		return jul;
   }

	/**
    * Converts a Julian day to a calendar date
    * @param j  the Julian date
    * This algorithm is from Press et al., Numerical Recipes
    * in C, 2nd ed., Cambridge University Press 1992
    */

	private void fromJulian(int j)
	{
		int ja = j;
		int JGREG = 2299161;
		/* the Julian date of the adoption of the Gregorian
            calendar    
		*/   

		if (j >= JGREG) { // cross-over to Gregorian Calendar produces this correction
			int jalpha = (int)(((float)(j - 1867216) - 0.25) / 36524.25);
			ja += 1 + jalpha - (int)(0.25 * jalpha);
		}
		int jb = ja + 1524;
		int jc = (int)(6680.0 + ((float)(jb-2439870) - 122.1) / 365.25);
		int jd = (int)(365 * jc + (0.25 * jc));
		int je = (int)((jb - jd)/30.6001);
		day = jb - jd - (int)(30.6001 * je);
		month = je - 1;
		if (month > 12)
			month -= 12;
		enYear = jc - 4715;
		if (month > 2)
		  --enYear;
		if (enYear <= 0)
			--enYear;
		thYear = enYear + 543;
	}
	
	/**
     * @param sTimeStamp
     * @return
     */
    public static String TimeStampToDateThai(String sTimeStamp) {
        if (sTimeStamp.length() < 16)
            return "";

        String sDayName = "", sYear = "", sMonth = "", sDay = "", sTime = "";
        int iMonth = 0;

        sYear = sTimeStamp.substring(0, 4);
        sMonth = sTimeStamp.substring(5, 7);
        sDay = sTimeStamp.substring(8, 10);
        sTime = sTimeStamp.substring(11, 16);

        iMonth = Integer.parseInt(sMonth);
        sDayName =
            "วันที่ : " + Integer.parseInt(sDay) + " " + fullMonth[0][iMonth -
            1] + " " + (Integer.parseInt(sYear) + 543) + "  เวลา : " + sTime;
        return sDayName;
    }
    
    /**
     * ใช้สำหรับเปลี่ยนรูปแบบวันที่จาก dd/mm/yyyy หรือ yyyy-mm-dd
     * ให้เป็น dd/mm/yyyy
     * @param string รูปแบบ dd/mm/yyyy หรือ yyyy-mm-dd
     * @return Thai brief date format เช่น 03/01/2512
     */
    public static String thaiBriefDateFormat(String string) {
        String returnValue = "";
        if (string == null || string.compareTo("") == 0 ||
            string.length() < 10)
            return returnValue;

        int index = string.indexOf("-");
        if (index != -1) {
            if (index < 4) {
                string = ("0000" + string).substring(index, string.length()+4-index);
            }
            returnValue =
                string.substring(8, 10) + "/" + string.substring(5, 7) + "/" +
                Tools.dtoa(Integer.parseInt(string.substring(0, 4)) + 543, "0000");
        } else {
            returnValue = string.substring(0, 6) + string.substring(6, 10);
        }
        return returnValue;
    }
    
    /**
     * ใช้สำหรับเปลี่ยนรูปแบบวันที่จาก dd/mm/yyyy หรือ yyyy-mm-dd
     * ให้เป็น d mon yy
     * @param string รูปแบบ dd/mm/yyyy หรือ yyyy-mm-dd
     * @return Thai short date format เช่น 3 ม.ค. 12
     */
    public static String thaiShortDateFormat(String string) {
        String returnValue = "";
        if (string == null || string.compareTo("") == 0 ||
            string.length() < 10)
            return returnValue;

        if (string.indexOf("-") != -1) {
            returnValue =
                Tools.dtoa(string.substring(8, 10), "0") + " " + shortMonth[0][Integer
                .parseInt(string.substring(5, 7)) - 1] + " " +
                (Integer.parseInt(string.substring(0, 4)) + 543 - 2500);
        } else {
            returnValue =
                Tools.dtoa(string.substring(0, 2), "0") + " " + shortMonth[0][Integer
                .parseInt(string.substring(3, 5)) - 1] + " " +
                string.substring(8, 10);
        }
        return returnValue;
    }
    // เพิ่มเติม 09/06/2551 ////
    public static String dateToDb(String date) {
        if (date != null && date.compareTo("") != 0) {
            if (date.startsWith("'") || date.startsWith("\"")) {
                date = date.substring(1);
                if (date.endsWith("'") || date.endsWith("\"")) {
                    date = date.substring(0, date.length()-1);
                }
            }
            if (date.length() > 10)
                return dateTimeToDb(date);
            if (date.indexOf("/") != -1) {
                date = (Integer.parseInt(date.substring(6)) - 543) + "-" +
                    date.substring(3, 5) + "-" + date.substring(0, 2);
            }
            return date;
        } else {
            return "Null";
        }
    }
    
    public static String dateTimeToDb(String dateTime) {
        if (dateTime != null && dateTime.compareTo("") != 0) {
            if (dateTime.startsWith("'") || dateTime.startsWith("\"")) {
                dateTime = dateTime.substring(1);
                if (dateTime.endsWith("'") || dateTime.endsWith("\"")) {
                    dateTime = dateTime.substring(0, dateTime.length()-1);
                }
            }
            if (dateTime.indexOf("/") != -1) {
                dateTime = (Integer.parseInt(dateTime.substring(6, 10)) - 543) + "-" +
                    dateTime.substring(3, 5) + "-" + dateTime.substring(0, 2) +
                    dateTime.substring(10);
            }
            return dateTime.substring(0, 19);
        } else {
            return "Null";
        }
    }
	//////////////////////////
	/**
	 * Gets the fullMonth
	 * @return Returns a String[][]
	 */
	public String getFullMonth(int i, int j ) {
		return fullMonth[i][j];
	}	/**
	 * Gets the shortMonth
	 * @return Returns a String[][]
	 */
	public String getShortMonth(int i, int j ) {
		return shortMonth[i][j];
	}	
}
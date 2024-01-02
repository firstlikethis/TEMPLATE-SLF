package com.pccth.utils;

public class CalDate {
	private int year1, year2, month1, month2, date1, date2;
	private int returnYear, returnMonth, returnDay;
	private boolean endOfMonth1, endOfMonth2;
	private String sDate = "" ,eDate = "";

	public static void main(String[] args) 	{
		CalDate calyearmonthday = 
			new CalDate(Integer.parseInt(args[0]), Integer.parseInt(args[1]),
				Integer.parseInt(args[2]), Integer.parseInt(args[3]), Integer.parseInt(args[4]),
				Integer.parseInt(args[5]));
		calyearmonthday.calculate();
		System.out.println("From " + calyearmonthday.date1 + "/" + 
			calyearmonthday.month1 + "/" + calyearmonthday.year1 + " ถึง " +
			calyearmonthday.date2 + "/" + calyearmonthday.month2 + "/" + 
			calyearmonthday.year2 + " คิดเป็น " + calyearmonthday.returnYear + " ปี " + 
			calyearmonthday.returnMonth + " เดือน " + calyearmonthday.returnDay + " วัน");
	}

	public CalDate() {
	}

	public CalDate(int date1, int month1, int year1, int date2, int month2, int year2) {
		this.year1 = year1;
		this.month1 = month1;
		this.date1 = date1;
		this.year2 = year2;
		this.month2 = month2;
		this.date2 = date2;
	}
	
	public CalDate(String sDate,String eDate){
		if (sDate.length() == 10&&eDate.length()==10){		
				this.sDate = sDate;
				this.eDate = eDate;
		
				this.date1 = Integer.parseInt(sDate.substring(0,2));
				this.month1 = Integer.parseInt(sDate.substring(3, 5));
				this.year1 = Integer.parseInt(sDate.substring(6));
				this.date2 = Integer.parseInt(eDate.substring(0,2));
				this.month2 = Integer.parseInt(eDate.substring(3, 5));
				this.year2 = Integer.parseInt(eDate.substring(6));
		}
	}

	public void calculate() {
		String end_date="", begin_date="";
		String tmpMonth1 = "0",tmpDay1 = "0",tmpMonth2 = "0",tmpDay2 = "0";
		if(month2 < 10)
			tmpMonth2 += month2+"";
		else
			tmpMonth2 = month2+"";
			
		if(month1 < 10)
			tmpMonth1 += month1+"";
		else
			tmpMonth1 = month1+"";
			
		if(date2 < 10)
			tmpDay2 += date2+"";
		else
			tmpDay2 = date2+"";
			
		if(date1 < 10)
			tmpDay1 += date1+"";
		else
			tmpDay1 = date1+"";
		
		end_date = year2 +  tmpMonth2 + tmpDay2 ;
		begin_date = year1 + tmpMonth1 + tmpDay1 ;
//System.out.println("end_date == "+end_date+"&& begin_date == "+begin_date);
		if(Integer.parseInt("0"+end_date)==0 && Integer.parseInt("0"+begin_date)==0){
			year1 = 0;
			month1 = 0;
			date1 = 0;
			year2 = 0;
			month2 = 0;
			date2 = 0;
			returnYear = 0;
			returnMonth = 0;
			returnDay = 0;
			return;
		}else{		
			if (Integer.parseInt("0"+end_date) < Integer.parseInt("0" + begin_date)){
				year1 = 0;
				month1 = 0;
				date1 = 0;
				year2 = 0;
				month2 = 0;
				date2 = 0;
				returnYear = 0;
				returnMonth = 0;
				returnDay = 0;
				return;
			}
		}
		
		int day[][] = {{31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
							{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}};
        int  year = year1 - 543;
		int i1 = ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)?0:1;

		if (date1 == day[i1][month1-1])
			endOfMonth1 = true;
		else
			endOfMonth1 = false;

        year = year2 - 543;
		int i2 = ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)?0:1;

		if (date2 == day[i2][month2-1])
			endOfMonth2 = true;
		else
			endOfMonth2 = false;

		returnYear = year2 - year1;
		returnMonth = month2 - month1;
//		System.out.println("returnYear = " + returnYear);
//		System.out.println("returnMonth = " + returnMonth);

		if (endOfMonth1 || endOfMonth2) {
			if (endOfMonth1 && endOfMonth2) {
				returnDay = 1;
			} else if (endOfMonth1) {
				if (date2 == day[i2][month2-1])
					returnDay = 0;
				else {
					returnMonth--;
					returnDay = date2 + 1;
				}
			} else if (endOfMonth2) {
				if (date1 == 1) {
					returnMonth++;
					returnDay = 0;
				} else {
					returnDay = (day[i1][month1-1] - date1) + 1;
				}
			}
		} else {
			returnDay = (date2 + 1) - date1;
			if (returnDay < 0) {
				returnMonth--;
				returnDay = (day[i1][month1-1] - date1) + 1 + date2;
			}
		}

		if (returnMonth < 0) {
			returnMonth += 12;
			returnYear--;
		} else if (returnMonth == 12) {
			returnMonth = 0;
			returnYear++;
		}
	}
	/**
	 * Gets the returnYear
	 * @return Returns a int
	 */
	public int getReturnYear() {
		return returnYear;
	}
	/**
	 * Sets the returnYear
	 * @param returnYear The returnYear to set
	 */
	public void setReturnYear(int returnYear) {
		this.returnYear = returnYear;
	}

	/**
	 * Gets the returnMonth
	 * @return Returns a int
	 */
	public int getReturnMonth() {
		return returnMonth;
	}
	/**
	 * Sets the returnMonth
	 * @param returnMonth The returnMonth to set
	 */
	public void setReturnMonth(int returnMonth) {
		this.returnMonth = returnMonth;
	}

	/**
	 * Gets the returnDay
	 * @return Returns a int
	 */
	public int getReturnDay() {
		return returnDay;
	}
	/**
	 * Sets the returnDay
	 * @param returnDay The returnDay to set
	 */
	public void setReturnDay(int returnDay) {
		this.returnDay = returnDay;
	}
	
	/**
		 * Method CountDate.นับจำนวนวันตั้งแต่ sDate ถึง eDate
		 * @param sDate	: ("01/01/2547")
		 * @param eDate	: ("01/01/2547")
		 * @return int
		 */
		public  int getCountDate(){
			int dd = 0, mm = 0,yyyy = 0,iDate1 = 0 , iDate2 = 0 ;
			String dd1 = "", mm1 = "",yyyy1 = "",dd2 = "", mm2 = "",yyyy2 = "",dd3 = "", mm3 = "",yyyy3 = "";
			int i = 1;
			String toDate = "";
			if (sDate.length() == 10&&eDate.length()==10){		
				dd = Integer.parseInt(sDate.substring(0,2));
				mm = Integer.parseInt(sDate.substring(3, 5));
				yyyy = Integer.parseInt(sDate.substring(6));
				
				dd2 = sDate.substring(0,2);
				mm2 =sDate.substring(3, 5);
				yyyy2 = sDate.substring(6);
				iDate1 = Integer.parseInt(yyyy2+mm2+dd2);
				
				dd3 = eDate.substring(0,2);
				mm3 =eDate.substring(3, 5);
				yyyy3 = eDate.substring(6);
				
				iDate2 = Integer.parseInt(yyyy3+mm3+dd3);
				
				if(iDate2 >= iDate1 && yyyy >= 2500 && Integer.parseInt(yyyy3) >=  2500){
					toDate = sDate;
					Day today = new Day(yyyy,mm,dd,'T');
					 while (toDate.compareTo(eDate)!=0){  
						today.advance(1);
						dd1 =  (today.getDay()<10)?"0"+today.getDay():today.getDay()+"" ;
						mm1 = (today.getMonth()<10)?"0"+today.getMonth():today.getMonth()+"";
						yyyy1 = today.getYearThai()+"";
						toDate = dd1 +"/"+mm1 + "/"+yyyy1 ;
						i++;
					}
					return i; 
				}else{
					return 0;
				}
			}else{
				return 0;
			}
		}
}

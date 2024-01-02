/*
 * Created on 23 มี.ค. 2553
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.pccth.utils;

/**
 * @author POMKUNG
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class ErrorWarningMsg {
	private static String msgList[] = {
			"ท่านไม่มีสิทธิใช้โปรแกรมนี้ กรุณาติดต่อเจ้าหน้าที่กยศ.",
			"เนื่องจากไม่ได้อยู่ในช่วงการส่งไฟล์เอกสาร Excel File\\nกรุณาติดต่อกองทุนฯ",
			"เนื่องจากไม่ได้อยู่ในช่วงการรับไฟล์เอกสาร Excel File\\nกรุณาติดต่อกองทุนฯ",
			"พบข้อผิดพลาดระหว่างดำเนินการ กรุณายื่นแบบคำขอใหม่อีกครั้ง",
			"ไม่สามารถดำเนินการต่อได้ กรุณาติิดต่อ กยศ เพื่อทำการกำหนดรายได้ครอบครัว",
			"ไม่สามารถเลือกระดับการศึกษาที่ต่ำกว่าระดับการศึกษาเดิมได้",
			"ไม่สามารถดำเนินการต่อได้ เนื่องจากไม่ได้อยู่ในช่วงระยะเวลา หรือเกินระยะเวลาที่ทางกองทุนฯ กำหนดไว้",
			"พบข้อผิดพลาดระหว่างดำเนินการ กรุณาลงทะเบียนอีกครั้ง",
			"จอภาพนี้ให้เฉพาะอนุกรรมการ 1,2 หรือพื้นที่เขตการศึกษาใช้งานเ่ท่านั้น "
	};
	
	private static String urlList[] = {
			"/jsp/SLFMenu.jsp",
			"/jsp/SLFMenuControl.jsp",
			"/jsp/SLFLoginS.jsp",
			"/html/index.html"
	};
	
	
	/**
	 * @return Returns the msgList.
	 */
	public static String[] getMsgList() {
		return msgList;
	}
	
	public static String getMsgList(int index) {
		return msgList[index];
	}
	/**
	 * @return Returns the urlList.
	 */
	public static String[] getUrlList() {
		return urlList;
	}
	
	public static String getUrlList(int index) {
		return urlList[index];
	}
}

<%@ page contentType="text/html; charset=windows-874" language="java" import="java.sql.*" errorPage="" %>

<%@ page import="java.io.*,java.util.*,javax.mail.*"%>

<%@ page import="javax.mail.internet.*,javax.activation.*"%>

<%@ page import="javax.servlet.http.*,javax.servlet.*" %>



<%@page import="java.sql.SQLException"%>

<%@page import="java.util.Properties"%>

<%@page import="javax.activation.*"%>

<%@page import="java.util.Random"%>

<%@page import="java.io.Writer"%>

<%@page import="java.io.OutputStreamWriter"%>

<%@page import="java.net.URL"%>

<%@page import="java.net.HttpURLConnection"%>



<%!

    public static String doPOSTRequestHttps(String urlWs, String param, String BasicAuthen, boolean isJSON) throws Exception {



        String charset = "UTF-8";



        StringBuffer respTclWs = new StringBuffer("");

        BufferedReader in = null;



        HttpURLConnection con = (HttpURLConnection) new URL(urlWs).openConnection();

        //HttpURLConnection httpConnection = (HttpURLConnection) new URL(urlWs+param).openConnection(); 

        con.setRequestMethod("POST");



        if (!BasicAuthen.equals("")) {

            con.setRequestProperty("Authorization", BasicAuthen);

        }



        con.setRequestProperty("Accept-Charset", charset);



        if (isJSON) {

            con.setRequestProperty("Content-Type", "application/json;charset=" + charset);

            //httpConnection.setRequestProperty("Content-Type", "application/json");

        } else {

            //con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=" + charset);

			con.setRequestProperty("Content-Type", "text/xml;charset=" + charset);

        }



        con.setDoInput(true);

        con.setDoOutput(true);



        Writer post = new OutputStreamWriter(con.getOutputStream(), charset);

        post.write(param);

        //post.write("\r\n");

        post.close();

        con.connect();

        in = new BufferedReader(new InputStreamReader(con.getInputStream(), charset));



        String line = null;

        while ((line = in.readLine()) != null) {

            respTclWs.append(line);

        }



        if (in != null) {

            try {

                in.close();

            } catch (IOException ex) {

            }

        }



        return respTclWs.toString();



    }



    public static String convertPhoneFormat(String text) {

		String phone="";

		try{

			phone = text.replaceAll("[- ]", "");

			String tphone = phone.substring(0, 1);

	

			if (tphone.equals("0")) {

				phone = "66" + phone.substring(1, 10);

			}

		

		}catch(Exception e){

			phone="";

			//out.print("<br>Err106 SLFResetPass_UNIV= "+phone+">>>"+e+"<br>");

        	System.out.println("Err106 SLFResetPass_UNIV.jsp=" + phone+">>>"+e);

		}



        //phone="66"+phone.substring(1, 10);

        //System.out.println("Phone=" + tphone);

        return phone;

    }



%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=windows-874" />

<title></title>

</head>



<body>

<form name="form1" method="post" action="SLFPRO001.jsp">

<%

	String contextPath = request.getContextPath();

	request.setCharacterEncoding("windows-874"); 

	

	String pin1="ทดสอบ";//request.getParameter("pin1");

	String title2="ทดสอบ";//request.getParameter("title2");  
	String fname="ทดสอบ";//request.getParameter("fname");   
	String lname="ทดสอบ";//request.getParameter("lname");  

	String bdate="10/10/1111"; //request.getParameter("bdate");

	String email="suratu@studentloan.or.th"; //request.getParameter("email");

	String mobile_no="0000000000";//equest.getParameter("mobile_no");

	String mobile_no_add="0000000";//request.getParameter("mobile_no_add");

	String pname="ทดสอบ";//request.getParameter("pname");

	String datepicker="10/10/1111";//request.getParameter("datepicker");

	

   String result;

   String mm="";



   String to = email;

   String from = "e-news@studentloan.or.th";

   String host = "studentloan.or.th"; //String host = "SRV03.studentloan.or.th";

   String mailTxt="";

   

   String url = "https://ugw1.truecorp.co.th/api/smsg2";

	String StrBase64 = "Basic MjMyMDQyMTEwMDpYQkJhc1c3bg==";

	String content = "";

			//String mobile_no=mobile_no;

	String phone=convertPhoneFormat(mobile_no);

			//out.print("<script>alert('"+phone+"');</script>");

	String sms = "กยศ.จะลดเบี้ยปรับให้ท่านในวันที่"+datepicker+" ";

	String param="";

	content = ""

						+ "<?xml version='1.0' encoding='utf-8'?>\n\r"

						+ "<message>\n\r"

						+ "<sms type='mt'>\n\r"

						+ "<service-id>2320421100</service-id>\n\r"

						+ "<destination>\n\r"

						+ "<address>\n\r"

						+ "<number type='international'>"+phone+"</number>\n\r"

						+ "</address>\n\r"

						+ "</destination>\n\r"

						+ "<source>\n\r"

						+ "<address>\n\r"

						+ "<number type='abbreviated'>40001791</number>\n\r"

						+ "<originate type='international'>66942135318</originate>\n\r"

						+ "<sender>StudentLoan</sender>\n\r"

						+ "</address>\n\r"

						+ "</source>\n\r"

						+ "<ud type='text' encoding='unicode'>" + sms + "</ud>\n\r"

						+ "<scts>2009-05-21T11:05:29+07:00</scts>\n\r"

						+ "<dro>true</dro>\n\r"

						+ "</sms>\n\r"

						+ "</message>";

																																

		param = content;

	//	doPOSTRequestHttps(url, param, StrBase64, false);

																															

																															



   Properties properties = System.getProperties();



   properties.setProperty("mail.smtp.host", host);

 

   Session mailSession = Session.getDefaultInstance(properties);

   

	mailTxt=" 	กองทุนเงินให้กู้ยืมเพื่อการศึกษา ได้รับข้อมูลของท่านแล้ว โดยมีรายละเอียด ดังนี้ \n "+			

					" 	 	เลขบัตรประจำตัวประชาชน : "+pin1+" \n "+ 	//" 	 	เลขบัตรประจำตัวประชาชน : 3101600572271 \n "+ 			

					" 	 	ชื่อ-นามสกุล : "+title2+" "+fname+" "+lname+" \n "+ 		//" 	 	ชื่อ-นามสกุล : ทดสอบ \n "+ 			

					" 	 	วันเดือนปีเกิด : "+bdate+" \n "+ 	//" 	 	วันเดือนปีเกิด : 01/01/2564 \n "+ 			

					" 	 	อีเมล : "+email+" \n "+  //" 	 	อีเมล : ฟa@a.com \n "+ 			

					" 	 	เบอร์โทรศัพท์มือถือ : "+mobile_no+" \n "+ 	 //" 	 	เบอร์โทรศัพท์มือถือ : 025647889 \n "+

					" 	 	เบอร์โทรศัพท์ที่ติดต่อสะดวก : "+mobile_no_add+" \n "+ 	 //" 	 	เบอร์โทรศัพท์ที่ติดต่อสะดวก : 027894562 \n "+ 

					" 	 	มาตราการที่เลือก : ลดเบี้ยปรับร้อยละ 100 กรณีปิดบัญชีในคราวเดียว  \n "+ //" 	 	มาตราการที่เลือก : "+pname+" \n "+		//" 	 	มาตราการที่เลือก : ลดเบี้ย \n "+																										   

					" 	 	วันที่นัดชำระหนี้ : "+datepicker+" \n "+   //" 	 	วันที่นัดชำระหนี้ : 23/26/2564 \n "+ 

			

					" 	เมื่อผู้กู้ยืมเงินได้แจ้งความประสงค์จะขอปิดบัญชี โดยขอ ลดเบี้ยปรับร้อยละ 100 กรณีปิดบัญชีในคราวเดียว ในวันใดให้ผู้กู้ยืมเงินตรวจสอบจำนวนเงินที่ต้องชำระหนี้ปิดบัญชี "+			

					" และทำการชำระหนี้ปิดบัญชีที่สาขาธนาคารกรุงไทย /ธนาคารอิสลามแห่งประเทศไทยทุกสาขาในเวลาทำการของธนาคาร ตั้งแต่เวลา 13.00 น. เป็นต้นไป  ของวันที่นัดชำระหนี้เท่านั้น "+

					" หากผู้กู้ยืมเงินได้ตรวจสอบจำนวนหนี้แล้ว พบว่ากองทุน ยังมิได้มีการลดเบี้ยปรับให้ ให้ติดต่อเจ้าหน้าที่กองทุนโดยเร็ว (เบอร์โทรศัพท์ 02-016-2600 ต่อ 550-588) หรือ Line @คดีและบังคับคดี "+

				" 	 หากผู้กู้ยืมเงินไม่สามารถชำระหนี้ปิดบัญชีในวันที่ได้นัดชำระหนี้ ถือว่าผู้กู้ยืมเงินทำผิดเงื่อนไขและจะไม่ได้รับส่วนลดเบี้ยปรับโดยกองทุนจะนำส่วนลดเบี้ยปรับที่จะลดให้ เพิ่มกลับเข้าไปในบัญชีลูกหนี้เช่นเดิม "+

				" หากผู้กู้ยืมเงินประสงค์ขอส่วนลดเบี้ยปรับอีก ให้ทำการลงทะเบียนใหม่ตามขั้นตอนที่กองทุนกำหนด \n";



   try{

      // Create a default MimeMessage object.

      MimeMessage message = new MimeMessage(mailSession);

      // Set From: header field of the header.

      message.setFrom(new InternetAddress(from));

      // Set To: header field of the header.

      message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

      // Set Subject: header field

      message.setSubject("ผลการลงทะเบียน", "TIS-620");

      // Now set the actual message

      message.setText(mailTxt, "TIS-620");

      // Send message

      Transport.send(message);

      result = "Sent message successfully....";

	  

	  out.print(result);

	  //out.print("<script>alert('ท่านดำเนินการลงทะเบียนขอรับสิทธิ์ลดเบี้ยปรับเรียบร้อยเเล้ว กรุณาตรวจสอบอีเมล์');</script>");

	  mm="Y";

   }catch (Exception mex) {

      mex.printStackTrace();

      result = "Error: unable to send message....";	

	  out.print(mex);

   }



%>





</form>



<script>



				var f1 = document.form1;

				alert('ท่านดำเนินการลงทะเบียนขอรับสิทธิ์ลดเบี้ยปรับเรียบร้อยเเล้ว กรุณาตรวจสอบอีเมล์');

				//f1.action="SLFPRO001.jsp";

				f1.submit();



</script>

<%

//out.print("<script>gotoForm1();</scirpt>");



%>

</body>

</html>
<%@ page contentType="text/html; charset=windows-874" language="java" import="java.util.Date" import="java.text.SimpleDateFormat" import="java.text.DecimalFormat"%>



<%!

		public String getRight(String tmpStr, int tmpInt){  // ����� tmpInt ���Ѻ�ӹǹ����ѡ�÷���ͧ���

		 	String myRight="";

		 	myRight=tmpStr.substring(0,tmpInt);

			return myRight;

		 }

		 

		 public String getLeft(String tmpStr, int tmpInt){  // ����� tmpInt ���Ѻ�ӹǹ����ѡ�÷���ͧ���

		 	String myLeft="";

		 	myLeft=tmpStr.substring(tmpStr.length()-tmpInt,tmpStr.length());

			return myLeft;

		 }

		 

		 public String getNull(String tmp1){

			String tmpNull="";

			tmpNull=(tmp1==null)?("0.00"):(tmp1);

			return tmpNull;

		 }

		 

		public String getNull_Name(String tmp1){

			String tmpNull="";

			tmpNull=(tmp1==null)?(""):(tmp1);

			return tmpNull;

		}

		

		public String getNull_Name2(String tmp1){

			String tmpNull="";

			tmpNull=(tmp1==null)?("&nbsp;"):(tmp1);

			return tmpNull;

		}

		

		public String format_number(String tmp1){

			DecimalFormat f2 = new DecimalFormat("#,###,###");

			return f2.format(Integer.parseInt(tmp1));

		}

		

		public String format_Double(String tmp1){

			DecimalFormat f2 = new DecimalFormat("#,###,###.00");

			return f2.format(Double.parseDouble(tmp1));

		}

		

		public String format_Date(Date tmp1){

			Date now = new Date();

			SimpleDateFormat sf = new SimpleDateFormat ("dd MMMMM yyyy");

			String sff=sf.format(tmp1);

			

			return sff;

			//out.println("<br>Current Date: " + sf.format(now));

		}

		

		public String getM1(String tmp){

			String tmpM=tmp;

			if(tmp.equals("���")||tmp.equals("�.�")){

				tmpM="01";

			}else if(tmp.equals("���")||tmp.equals("�.�")){

				tmpM="02";

			}else if(tmp.equals("�չ")||tmp.equals("��.")){

				tmpM="03";

			}else if(tmp.equals("���")||tmp.equals("��.")){

				tmpM="04";

			}else if(tmp.equals("���")||tmp.equals("�.�")){

				tmpM="05";

			}else if(tmp.equals("�Զ")||tmp.equals("��.")){

				tmpM="06";

			}else if(tmp.equals("�á")||tmp.equals("�.�")){

				tmpM="07";

			}else if(tmp.equals("�ԧ")||tmp.equals("�.�")){

				tmpM="08";

			}else if(tmp.equals("�ѹ")||tmp.equals("�.�")){

				tmpM="09";

			}else if(tmp.equals("���")||tmp.equals("�.�")){

				tmpM="10";

			}else if(tmp.equals("���")||tmp.equals("�.�")){

				tmpM="11";

			}else if(tmp.equals("�ѹ")||tmp.equals("�.�")){

				tmpM="12";

			}

			

			return tmpM;

		}

		

		public String getDate(String tmp){

			String ch="";

			String tmpDate=tmp;

	

			if(tmpDate.indexOf("/")>=0){

				ch="/";

			}else if(tmpDate.indexOf("-")>=0){

				ch="-";

			}else if(tmpDate.indexOf(" ")>=0){

				ch="\\s";

			}

			String [] arrayD=tmpDate.split(ch);

			String arM="";

			try{

				arM=getM1(arrayD[1].substring(0,3));

			}catch(Exception e1){			

				arM=arrayD[1];//arM=getM1(arrayD[1].substring(0,2));			

			}

			

			String tmpD="";   int tmpY=0;

			

			if(arrayD[2].length()==2){

				tmpY=Integer.parseInt(arrayD[2])+2500;

				tmpD=tmpY+"/"+arM+"/"+arrayD[0];  //tmpD=arrayD[0]+"/"+arM+"/"+tmpY;

			}else{

				tmpD=arrayD[2]+"/"+arM+"/"+arrayD[0];

			}	

			return tmpD;

		}

		

		public String getMonth(String tmp){

			String tmpM=tmp;

			if(tmp.equals("01")||tmp.equals("1")){

				tmpM="���Ҥ�";

			}else if(tmp.equals("02")||tmp.equals("2")){

				tmpM="����Ҿѹ��";

			}else if(tmp.equals("03")||tmp.equals("3")){

				tmpM="�չҤ�";

			}else if(tmp.equals("04")||tmp.equals("4")){

				tmpM="����¹";

			}else if(tmp.equals("05")||tmp.equals("5")){

				tmpM="����Ҥ�";

			}else if(tmp.equals("06")||tmp.equals("6")){

				tmpM="�Զع�¹";

			}else if(tmp.equals("07")||tmp.equals("7")){

				tmpM="�á�Ҥ�";

			}else if(tmp.equals("08")||tmp.equals("8")){

				tmpM="�ԧ�Ҥ�";

			}else if(tmp.equals("09")||tmp.equals("9")){

				tmpM="�ѹ��¹";

			}else if(tmp.equals("10")){

				tmpM="���Ҥ�";

			}else if(tmp.equals("11")){

				tmpM="��Ȩԡ�¹";

			}else if(tmp.equals("12")){

				tmpM="�ѹ�Ҥ�";

			}

			

			return tmpM;

		}

		

		public String getDateToThai(String tmp){

			String ch="";

			String tmpDate=tmp;

	

			if(tmpDate.indexOf("/")>=0){

				ch="/";

			}else if(tmpDate.indexOf("-")>=0){

				ch="-";

			}else if(tmpDate.indexOf(" ")>=0){

				ch="\\s";

			}

			String [] arrayD=tmpDate.split(ch);

			String arM="";

			String tmpD="";   int tmpY=0;

			

			tmpY=Integer.parseInt(arrayD[0])+543;  //�ŧ�繻� ��

			tmpD=arrayD[2]+" "+getMonth(arrayD[1])+" "+tmpY;

			return tmpD;

		}

		

		public boolean checkPinFormat(String id){	
		if(id.equals("9999999999999")){
			return true;	
		}else{

			

				if (id.length() != 13){

					return false;

				}		 

				int sum = 0;

				/* x13, x12, x11, ... */

				for (int i = 0; i < 12; i++){

					sum += Integer.parseInt(String.valueOf(id.charAt(i))) * (13 - i);

				}

			 /* complements(12, sum mod 11) */

			 return id.charAt(12) - '0' == ((11 - (sum % 11)) % 10);	

			}
		
		}


%>

<%

	//out.print(getDateToThai("2014-12-11"));

	/*

		out.print("3909800850241  "+checkPinFormat("3909800850241"));

		out.print("<br>");

		out.print("3101600572271  "+checkPinFormat("3101600572271"));

		out.print("<br>");

		out.print("1111111111011  "+checkPinFormat("1111111111011"));

		out.print("<br>");

		out.print("1615555  "+checkPinFormat("1615555"));

		*/

%>


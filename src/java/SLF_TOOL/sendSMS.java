/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SLF_TOOL;

import java.io.*;
//import java.net.HttpURLConnection;
import java.net.*;
//import java.net.URLConnection;
//import java.util.ResourceBundle;
import java.util.Enumeration;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

import java.io.StringReader;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;

/**
 *
 * @author trisornv
 */
public class sendSMS {

    //private static final ResourceBundle RESOURCES = ResourceBundle.getBundle("slf_cfg");
    public static String doGETRequest(String address) throws IOException { //ดึงค่าจาก web ไม่มีการส่งค่าใดๆ

        URL url;
        url = new URL(address);
        URLConnection connection;
        connection = url.openConnection();
        HttpURLConnection httppost = (HttpURLConnection) connection;

        String reply;

        InputStream in = httppost.getInputStream();

        StringBuffer sb = new StringBuffer();

        try {

            int chr;
            while ((chr = in.read()) != -1) {
                sb.append((char) chr);
            }
            reply = sb.toString();

        } finally {
            in.close();
        }

        return reply;
    }

    public static String doPOSTRequest(String address, String content, boolean isJSON) throws IOException { //ส่งparameter ไปบันทึก หรือดึงข้อมูลได้

        URL url = new URL(address);
        URLConnection connection = url.openConnection();
        HttpURLConnection httpConn = (HttpURLConnection) connection;

        httpConn.setDoInput(true);
        httpConn.setDoOutput(true);

        httpConn.setRequestMethod("POST");

        if (isJSON) {
            httpConn.setRequestProperty("Content-Type", "application/json");
        }

        byte[] outputInBytes = content.getBytes("TIS-620");

        OutputStream os = connection.getOutputStream();
        os.write(outputInBytes); // write content

        os.close();

        String response; // read response

        InputStream in = httpConn.getInputStream();
        StringBuffer sb = new StringBuffer();

        try {

            int chr;

            while ((chr = in.read()) != -1) {
                sb.append((char) chr);
            }

            response = sb.toString();

        } finally {
            in.close();
        }
        //System.out.println("101=" + response);
        return response;
    }

    public static String sentSMS(String PhoneList, String Message) {

        String tmpStatus = "";

        String aishost = "", aiscmd = "", aisfrom = "", aisreport = "", aischarge = "", aiscode = "", aisctype = "";

        try {

            ResourceBundle props = ResourceBundle.getBundle("slf_cfg");
            //slf_cfg ชื่อ ไฟล์ properties

            aishost = props.getString("aishost"); //ชื่อฟิวใน ไฟล์ properties
            aiscmd = props.getString("aiscmd");
            aisfrom = props.getString("aisfrom");
            aisreport = props.getString("aisreport");
            aischarge = props.getString("aischarge"); //ชื่อฟิวใน ไฟล์ properties
            aiscode = props.getString("aiscode");
            aisctype = props.getString("aisctype");

            //System.out.println("hostapi=" + aishost);
            // ResourceBundle.clearCache();

            String Parameter = "";

            Parameter = "CMD=" + aiscmd + "&FROM=" + aisfrom + "&TO=" + convertPhoneFormat(PhoneList) + "&REPORT=" + aisreport + "&CHARGE=" + aischarge + "&CODE=" + aiscode
                    + "&CTYPE=" + aisctype + "&CONTENT=" + convert2unicode(Message);
            
            // + "&CTYPE=" + aisctype + "&CONTENT=" + convert2unicode(Message);

            String API_URL = aishost;

            System.out.println("Data to send=" + aishost+Parameter);

            //System.out.println("Send Status=" + doPOSTRequest(API_URL, Parameter, false));
            //return doPOSTRequest(API_URL, Parameter, false);

            tmpStatus = doPOSTRequest(API_URL, Parameter, false); //เรียก service SMS

            //tmpStatus = Parameter;

            //System.out.println("tmpStatus=" + tmpStatus);

            //tmpStatus = "<XML><STATUS>OK</STATUS><DETAIL>SUCCESS</DETAIL><SMID>1357412663</SMID></XML>";

            //props.clearCache();
            
            System.out.println("tmpStatus=" + tmpStatus);

            return getXMLStatus(tmpStatus);

        } catch (Exception io) {
            return io.toString();
        } finally {
        }

    }

    public static String getXMLStatus(String XMLString) {
        //XMLString="<XML><STATUS>OK</STATUS><DETAIL>SUCCESS</DETAIL><SMID>1357412663</SMID></XML>";
        String tmpStatus = "";
        try {

            InputSource is = new InputSource();
            is.setCharacterStream(new StringReader(XMLString));

            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();

            Document doc = dBuilder.parse(is);
            doc.getDocumentElement().normalize();

            System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
            NodeList nList = doc.getElementsByTagName("XML");
            System.out.println("----------------------------");

            for (int temp = 0; temp < nList.getLength(); temp++) {
                Node nNode = nList.item(temp);
                System.out.println("\nCurrent Element :" + nNode.getNodeName());

                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element) nNode;
                    System.out.println("XML : "
                            + eElement.getAttribute("XML"));
                    System.out.println("STATUS : "
                            + eElement.getElementsByTagName("STATUS").item(0).getTextContent());

                    tmpStatus = eElement.getElementsByTagName("STATUS").item(0).getTextContent();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e.toString());
        }

        if (tmpStatus.equals("OK")) {
            tmpStatus = "Status=0";
        } else {
            tmpStatus = "Status=Err";
        }

        return tmpStatus;
    }

    public static String convertPhoneFormat(String text) {
        String phone = text.replaceAll("[- ]", "");
        String tphone = phone.substring(0, 1);

        if (tphone.equals("0")) {
            phone = "66" + phone.substring(1, 10);
        }

        //phone="66"+phone.substring(1, 10);
        //System.out.println("Phone=" + tphone);

        return phone;
    }

    public static String convert2unicode(String text) {
        int ascii = 0;
        String temp = "";
        StringBuffer strbuf = new StringBuffer();
        //System.out.println(text.length());
        for (int i = 0; i <= text.length() - 1; i++) {
            ascii = (int) text.charAt(i);
            //System.out.println(ascii);
            temp = Integer.toHexString(0x10000 | ascii).substring(1).toUpperCase();
            strbuf.append("%" + temp.substring(0, 2));
            strbuf.append("%" + temp.substring(2, 4));
            //System.out.println(Integer.toHexString(0x10000 | ascii)
            //		.substring(1).toUpperCase());
        }
        //System.out.println(strbuf.toString());
        //System.out.println("************");
        return strbuf.toString();
    }

    public static void main(String[] args) throws IOException {
        /*
         * String url = "http://www.cat4sms.com/api/api.php";
         *
         * String Username = "smscattest01", Password = "1L3MGZ", dest_number =
         * "0878283416", message = "Test_sms", Sender_Name = "CAT4SMS",
         * ScheduledDelivery = "", Credit_type = "standard"; //1207011545
         * (ปีเดือนวันชั่วโมงนาที)
         *
         * String postData = ""; postData = "username=" + Username +
         * "&password=" + Password + "&msisdn=" + dest_number + "&message=" +
         * message + "&sender=" + Sender_Name + "" + "&ScheduledDelivery=" +
         * ScheduledDelivery + "&force=" + Credit_type;
         *
         * System.out.println("Data to send=" + postData);
         *
         * System.out.println("Send Status=" + doPOSTRequest(url, postData,
         * false));
         */
        /*
         * String Username = "studentloan"; String Password = "Test@1234";
         * String PhoneList = "0984264669;"; String Message = "TestSentSMS";
         * String SenderName = "ClickNext";
         *
         * //Message = URLEncoder.encode(Message, "TIS-620");
         *
         * //String Parameter = "?User=" + Username + "&Password=" + Password;
         * String Parameter = "User=" + Username + "&Password=" + Password;
         *
         * Parameter += "&Msnlist=" + PhoneList + "&Msg=" + Message + "&Sender="
         * + SenderName;
         *
         * String API_URL =
         * "http://member.smsmkt.com/SMSLink/SendMsg/index.php";
         *
         */
        /*
         * URL url = new URL(API_URL + Parameter); BufferedReader in = new
         * BufferedReader(new InputStreamReader(url.openStream())); String
         * Result = in.readLine(); System.out.print(Result); in.close();
         */

        System.out.println("Send SMS:=" + sentSMS("66984264669", "สวัสดีครับ"));

        //System.out.println("Data to send=" + Parameter);

        // System.out.println("Send Status=" + doPOSTRequest(API_URL, Parameter, false));
        //System.out.println("Send Status=" + doGETRequest("http://member.smsmkt.com/SMSLink/SendMsg/index.php?User=studentloan&Password=Test@1234&Msnlist=0984264669&Msg=TestSentSMS&Sender=ClickNext"));


    }
}

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SLF_TOOL;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.ResourceBundle;

/**
 *
 * @author trisornv
 */
public class sendSMS30112561 {

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

        return response;
    }

    public static String sentSMS(String PhoneList, String Message) {

        String Username = "", Password = "", SenderName = "";
        String hostapi = "";
        //String PhoneList = "0984264669;";
        //String Message = "TestSentSMS";


        try {
            /*
            ResourceBundle props = ResourceBundle.getBundle("slf_cfg"); //slf_cfg ชื่อ ไฟล์ properties

            hostapi = props.getString("smshost"); //ชื่อฟิวใน ไฟล์ properties
            Username = props.getString("User");
            Password = props.getString("pass");
            SenderName = props.getString("Sender");
            */
            
            hostapi = "http://member.smsmkt.com/SMSLink/SendMsg/index.php";
            Username = "studentloan";
            Password = "Test@1234";
            SenderName = "ClickNext";

            System.out.println("hostapi=" + hostapi);
           // ResourceBundle.clearCache();

            String Parameter = "User=" + Username + "&Password=" + Password;

            Parameter += "&Msnlist=" + PhoneList + "&Msg=" + Message + "&Sender=" + SenderName;

            //String API_URL = "http://member.smsmkt.com/SMSLink/SendMsg/index.php";
            
            String API_URL=hostapi;
            
            System.out.println("Data to send=" + Parameter);

            //System.out.println("Send Status=" + doPOSTRequest(API_URL, Parameter, false));
             return doPOSTRequest(API_URL, Parameter, false);

            //props.clearCache();
        
        } catch (Exception io) {
            System.out.println(io);
        } finally {
        }
        return "";
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
        String Username = "studentloan";
        String Password = "Test@1234";
        String PhoneList = "0984264669;";
        String Message = "TestSentSMS";
        String SenderName = "ClickNext";

        //Message = URLEncoder.encode(Message, "TIS-620");

        //String Parameter = "?User=" + Username + "&Password=" + Password;
        String Parameter = "User=" + Username + "&Password=" + Password;

        Parameter += "&Msnlist=" + PhoneList + "&Msg=" + Message + "&Sender=" + SenderName;

        String API_URL = "http://member.smsmkt.com/SMSLink/SendMsg/index.php";
        /*
         * URL url = new URL(API_URL + Parameter); BufferedReader in = new
         * BufferedReader(new InputStreamReader(url.openStream())); String
         * Result = in.readLine(); System.out.print(Result);
        in.close();
         */

        System.out.println("Data to send=" + Parameter);

        System.out.println("Send Status=" + doPOSTRequest(API_URL, Parameter, false));
        //System.out.println("Send Status=" + doGETRequest("http://member.smsmkt.com/SMSLink/SendMsg/index.php?User=studentloan&Password=Test@1234&Msnlist=0984264669&Msg=TestSentSMS&Sender=ClickNext"));

        /*
         * URL : http://smsmkt.com/ User Name : studentloan Pass Word :
         * Test@1234 Sender Name : ClickNext
         */

    }
}

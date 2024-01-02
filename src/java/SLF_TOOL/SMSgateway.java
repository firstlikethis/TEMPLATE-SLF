/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SLF_TOOL;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

/**
 *
 * @author T
 */
public class SMSgateway {

    public String sendSmS(String API_URL, String param) throws MalformedURLException, IOException {

        URL url = new URL(API_URL);
        URLConnection connection = url.openConnection();
        HttpURLConnection httpConn = (HttpURLConnection) connection;

        httpConn.setDoInput(true);
        httpConn.setDoOutput(true);

        httpConn.setRequestMethod("POST");

        byte[] outputInBytes = param.getBytes("TIS-620");
        OutputStream os = connection.getOutputStream();
        os.write(outputInBytes); // write content
        os.close();

        String response1 = "";
        
        InputStream in = httpConn.getInputStream();
        StringBuffer sb = new StringBuffer();

        try {

            int chr;

            while ((chr = in.read()) != -1) {
                sb.append((char) chr);
            }
            response1 = sb.toString();
        } finally {
            in.close();            
        }
        //out.print("response=" + response1);

        return response1;
    }
    
    public static void main(String args[]) throws Exception {
        System.out.println("aaa");
    }
    
    
}

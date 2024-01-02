// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   sendMail.java

package SLF_TOOL;

import java.io.*;
import java.util.Properties;
import java.util.ResourceBundle;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;

public class sendMail
{

    public sendMail()
    {
    }

    public String sendAutomail(String mailAddr, String txtsubject, String txtbody, String ContextPath, String FileAtt, boolean AttFile)
        throws UnsupportedEncodingException
    {
        String to = mailAddr;
        String output = "";
        ResourceBundle slfprops = ResourceBundle.getBundle("slf_cfg");
        String from = slfprops.getString("Mailfrom");
        String host = slfprops.getString("SMTPhost");
        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.port", "25");
        Session session = Session.getDefaultInstance(props);
        try
        {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(javax.mail.Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(txtsubject, "UTF-8");
            MimeMultipart multipart = new MimeMultipart();
            MimeBodyPart messageBodyPart = new MimeBodyPart();
            String htmlText = "";
            multipart.addBodyPart(messageBodyPart);
            messageBodyPart.setText(txtbody, "UTF-8");
            if(AttFile)
            {
                messageBodyPart = new MimeBodyPart();
                javax.activation.DataSource source = new FileDataSource(ContextPath + FileAtt);
                messageBodyPart.setDataHandler(new DataHandler(source));
                messageBodyPart.setFileName(FileAtt);
                multipart.addBodyPart(messageBodyPart);
            }
            message.setContent(multipart);
            Transport.send(message);
            System.out.println("Sent message successfully....");
            output = "Sent Mail OK";
        }
        catch(MessagingException e)
        {
            System.out.print(e.toString());
            output = e.toString();
            throw new RuntimeException(e);
        }
        return output;
    }

    public static void main(String args[])
        throws IOException
    {
        sendMail send1 = new sendMail();
        System.out.println(send1.sendAutomail("trisornv@studentloan.or.th", "\u0E2B\u0E31\u0E27\u0E40\u0E23\u0E37\u0E48\u0E2D\u0E07", "\u0E17\u0E14\u0E2A\u0E2D\u0E1A \n\n dd", "./web/jsp/slf/Notify_file/", "a.zip", true));
        String str = new String("\u0E17\u0E14\u0E2A\u0E2D\u0E1A".getBytes("ISO8859-1"), "tis-620");
        System.out.println(str);
    }
}

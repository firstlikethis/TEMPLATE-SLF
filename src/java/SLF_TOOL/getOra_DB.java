// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   getOra_DB.java

package SLF_TOOL;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.*;
import javax.sql.DataSource;

public class getOra_DB
{

    public getOra_DB()
    {
    }

    public static Connection getConnection(boolean autoCommit) throws NamingException, SQLException, Exception{
        Connection conn = null;
        try
        {
            Context ctx1 = new InitialContext();
            Context envContext = (Context)ctx1.lookup("java:/comp/env");
            //DataSource ds1 = (DataSource)envContext.lookup("jdbc/SLFORA123");
            //DataSource ds1 = (DataSource)envContext.lookup("jdbc/SLFORA");
            DataSource ds1 = (DataSource)envContext.lookup("jdbc/SLFORA12");
            conn = ds1.getConnection();
            conn.setAutoCommit(autoCommit);
        }
        catch(Exception ee){
            System.out.println(ee);
            System.out.println("Where is your Oracle JDBC Driver?");
            ee.printStackTrace();
        }
      
        
        return conn;
    }

    public static void main(String args[])
        throws Exception
    {
        Connection con = null;
        try
        {
            con = getConnection(false);
            con.close();
        }
        catch(Exception e)
        {
            System.out.print((new StringBuilder()).append("err=").append(e.toString()).toString());
        }
    }
}

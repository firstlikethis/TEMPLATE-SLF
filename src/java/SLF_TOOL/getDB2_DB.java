/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SLF_TOOL;

import javax.naming.*;
import javax.naming.*;
import javax.naming.*;
import java.sql.*;
import javax.sql.*;
import java.util.*;
import java.io.*;

/**
 *
 * @author TRISORN123
 */
public class getDB2_DB {

    public static Connection getConnection(boolean autoCommit) throws NamingException, SQLException, Exception {

        Connection conn = null;
        //DataSource ds = null;
        
        try {
            
             //For Tomcat Webserver
            
                Context ctx1 = new InitialContext();
                Context envContext = (Context) ctx1.lookup("java:/comp/env");                   
            
                //javax.sql.DataSource ds1 = (javax.sql.DataSource) envContext.lookup("jdbc/SLFERP");
                javax.sql.DataSource ds1 = (javax.sql.DataSource) envContext.lookup("jdbc/SLF04");
                
                conn=ds1.getConnection();
                conn.setAutoCommit(autoCommit);
            
         
             

        } catch (Exception ee) {
            System.out.println(ee);
            System.out.println("Where is your DB2 JDBC Driver?");
            ee.printStackTrace();
            //return; 
        } finally {
        }

        return conn;
    }

    public static void main(String args[]) throws Exception {
        Connection con = null;
        try {
            con = getDB2_DB.getConnection(false);

            con.close();
        } catch (Exception e) {
            System.out.print(e.toString());
        }
    }
}

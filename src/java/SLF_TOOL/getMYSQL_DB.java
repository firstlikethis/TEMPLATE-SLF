/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SLF_TOOL;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class getMYSQL_DB {
    
    public static Connection getConnection(boolean autoCommit) throws SQLException{
        Connection con = null;
        
        try {
            
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/tydb?user=root&password=root123456");
            //con.setAutoCommit(autoCommit);
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(getMYSQL_DB.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            /*
            if(con!=null){
                con.close();
            }
            */
        }
        
        return  con;
    }

    public static void main(String[] args) throws SQLException {
        
        Connection con=null;
        
        try{
            con=getMYSQL_DB.getConnection(false);
            System.out.println(con);
        }catch(Exception e){
            
        }
        
        /*
        Connection con = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/tydb?user=root&password=root123456");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(getMYSQL_DB.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if(con!=null){
                con.close();
            }
        }
        */

    }
    
}

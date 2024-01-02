package SLF_TOOL;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;

public class getName {
	
	public static String getStudentName(Connection conn, String pin, String addr_seq, String last_name) throws Exception {
		//Connection conn, 		
		
	String student_name;
        Statement stmt=null;
        ResultSet rs=null;
        String sql, sql2;
        student_name = "";  
        /*
        String jdbcClassName="com.ibm.db2.jcc.DB2Driver";
        String url="jdbc:db2://192.168.100.13:50000/SLF04";
        String user="db2dev";
        String password="db2dev";
 
        Connection conn = null;
        */
        try{
        	
        	//Class.forName(jdbcClassName);          
            //conn = DriverManager.getConnection(url, user, password);
        	
        	if(last_name.equals("true")){        		
        		sql2=" a.ADDR_SEQ=(select max(addr_seq) from SLF_MASTER.HIS_RENAME where pin='"+pin+"') ";        		
        	}else{        		  
        		sql2=" a.ADDR_SEQ="+ addr_seq +" ";
        	}
        	
        	sql = "SELECT  b.TITLE_NAME||''|| a.hr_name||'  '||a.hr_surname as name "+ 
        		  "FROM SLF_MASTER.HIS_RENAME a "+ 
                          "left join slf_master.TITLENAME b on a.HR_TITLE=b.title_code "+
                  "where a.pin='"+pin+"' AND "+ sql2 + 
                  "with ur";
        	
        	stmt = conn.createStatement();
        	rs = stmt.executeQuery(sql);
        	//System.out.println(sql);
        	if(rs.next()){        		
        		student_name=rs.getString("name");
        	}
 
        }catch(Exception e){
        	System.out.println("Err 2 "+e);
        }finally{
        	if(rs!=null){
        		rs.close();
        	}
        	if(stmt!=null){
        		stmt.close();
        	}        
        }
        
        return student_name;
	}

	public static void main(String[] args) {
		
		//test getStudentName
		/*
		String test="";
		
		try{
			test=getStudentName("1100200272699","1","");
			
		}catch(Exception e){
			System.out.println("ERR 1 "+e);
		}
		
		System.out.println(test);
		
		
		System.out.println("OK");
		*/
	}

}

/*
 * Created on 27 มี.ค. 2007
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package com.pccth.utils;

/**
 * @author Power by rock
 * 
 * 
 */
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.SQLWarning;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.pccth.utils.DBUtil;

public class DB {


	final static String module = DB.class.getName();
    
	public static int executeUpdate(String sql){
		Connection con = null;
		Statement stmt = null;
		int retInt = 0;
		int count = 0;
		boolean ret = false;
		try{
			  con = DBUtil.getConnection(false);
			  try{
		    	
				  con.setAutoCommit(false) ;
				  stmt = con.createStatement();	
				  retInt  = stmt.executeUpdate(sql);
				  SQLWarning warn = stmt.getWarnings() ;
					if (warn != null)
						System.out.println("Message: " + warn.getMessage()) ;
				  con.commit() ;
				  con.setAutoCommit(true) ;
		          
			   }catch(SQLException ex) {
				  //System.err.println("SQLException: " + ex.getMessage()) ;
				  con.rollback() ;
				  con.setAutoCommit(true) ;
			   }
		}catch(Exception e){
			finallize(con,stmt,null);
		}finally{
			finallize(con,stmt,null);
		}
		return retInt;
	}
	
	/**
	 * @param sql
	 * @param con
	 * @return
	 */
	public static int executeUpdateWithCon(String sql,Connection con) throws SQLException{ 
		Statement stmt = null;
		int retInt = 0;
		int count = 0;
		boolean ret = false;
		try{
			  try{
				  stmt = con.createStatement();	
				  retInt  = stmt.executeUpdate(sql);
				  SQLWarning warn = stmt.getWarnings() ;
					if (warn != null)
						System.out.println("Message: " + warn.getMessage()) ;	  
			   }catch(SQLException ex) {
				   if (stmt != null) stmt.close();
                                   con.rollback();
				  System.err.println("SQLException: " + ex.getMessage()) ;
			   }catch(Exception e){
                                 System.err.println("DB Exception: " + e.getMessage()) ;
                                  con.rollback();
                           }
			   
		}catch(SQLException e){
                           System.err.println("DB DB2== Exception: " + e.getMessage()) ;
                           con.rollback();
			//finallize(con,stmt,null);
		}finally{
			try{
				if (stmt != null) stmt.close();
			}catch(Exception e){
                            System.err.println("finally Exception: " + e.getMessage()) ;
			}
			//finallize(con,stmt,null);
		}
		return retInt;
	}
	/**
	 * @author rOcK
	 * Desc : Want return some error on database
	 * @return ArrayList(Map) 
	 * 			   1. Warn : Warning Message 
	 * 			   2. Excp : Exception SQL Message
	 * 	           3. Success : 0 is fail 
	 * 						    1 is Success
	 * 
	 */
	public static ArrayList executeUpdateWantMessageReturn(String sql){
			Connection con = null;
			Statement stmt = null;
			ArrayList list = new ArrayList();
			//m.put("Excp","");
			int count = 0;
			boolean ret = false;
			try{
				Map m = new HashMap();
				  con = DBUtil.getConnection(false);
				  try{
					  con.setAutoCommit(false) ;
					  stmt = con.createStatement();	
					  int re = stmt.executeUpdate(sql);
					  if(re ==1){
					  	m.put("Success","1");
					  }
					  SQLWarning warn = stmt.getWarnings() ;
						if (warn != null){
							m.put("Warn","Message: " + warn.getMessage()) ;
							System.out.println("Message: " + warn.getMessage());
						}
					  list.add(m);
					  con.commit() ;
					  con.setAutoCommit(true) ;
		          
				   }catch(SQLException ex) {
					  m.put("Excp","SQLException: " + ex.getMessage().replace('\'',' ').replace('"',' ').replace(',',' ')) ;
					  m.put("Success","0");
					  list.add(m);
					  System.err.println("SQLException: " + ex.getMessage());
					  con.rollback() ;
					  con.setAutoCommit(true) ;
				   }
			}catch(Exception e){
				finallize(con,stmt,null);
			}finally{
				finallize(con,stmt,null);
			}
			return list;
		}
		
	/**
	 * @author rOcK
	 * Desc : Still have some hole bug for checking return value.
	 * 
	 */
	public static int executeUpdateArray(String sql[]){
		Connection con = null;
		Statement stmt = null;
		int retInt = 0;
		
		try{			
			
			con = DBUtil.getConnection(false);
			  try{
		    	
				  con.setAutoCommit(false) ;
				  stmt = con.createStatement();	
				  for(int i=0;i<sql.length;i++){
//						System.out.println(i+". sqlArray is : "+ sql[i]);
						stmt.executeUpdate(sql[i]);	
						SQLWarning warn = stmt.getWarnings() ;
						if (warn != null)
							System.out.println("Message: " + warn.getMessage()) ;
					}
				  con.commit() ;
				  con.setAutoCommit(true) ;
				  retInt  = 1;
			   }catch(SQLException ex) {
				  //System.err.println("SQLException: " + ex.getMessage()) ;
				  con.rollback() ;
				  con.setAutoCommit(true) ;
			   }
		}catch(Exception e){
			finallize(con,stmt,null);
		}finally{
			finallize(con,stmt,null);
		}
		return retInt;
	}	
	
	
	public static ArrayList executeQueryAdv(String sql){
		Connection con = null;
		Statement stmt = null;
		ArrayList list = new ArrayList();
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		try{
			con = DBUtil.getConnection(false);
			
			stmt = con.createStatement();		
			rs = stmt.executeQuery(sql);
			rsmd = rs.getMetaData();
			int colCount = rsmd.getColumnCount();
			String[] colNames = new String[colCount];
			String toCap = null;
			for (int j = 1; j <= colCount; j++){
				//colNames[j-1] = rsmd.getColumnName(j);
				toCap = rsmd.getColumnName(j);
				colNames[j-1] = toCap.toUpperCase();
			}
			int rowNum = 0;

			while(rs.next()){
				//Represent Row Object
				Map map = new HashMap();			
				
				for(int i = 1;i<= colCount;i++){
					Object obj = rs.getObject(i);
					if (obj instanceof Date) {
//						System.out.println("colname : "+colNames[i-1]+" getObject :"+obj.toString()+" : string = ["+rs.getString(i)+"]");
						obj = rs.getString(i);
					}
					map.put(colNames[i-1],obj);					
				}		
				
				list.add(rowNum,map);
				//Represent Table Object
				
				rowNum++;
			}//End Records
			
			  SQLWarning warn = stmt.getWarnings() ;

				  //System.out.println("Message: " + warn.getMessage()) ;
			  SQLWarning warning = rs.getWarnings() ;
			  if (warning != null)
				 warning = warning.getNextWarning() ;
				 //System.out.println("Message: " + warn.getMessage()) ;
	
		}catch(Exception e){

		}finally{
			finallize(con,stmt,rs);
		}		
		
		return list;
	}
	
	private  static ArrayList executeQuery(String sql){
		Connection con = null;
		Statement stmt = null;
		ArrayList list = new ArrayList();
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		try{
			con = DBUtil.getConnection(false);
			stmt = con.createStatement();		
			rs = stmt.executeQuery(sql);
			rsmd = rs.getMetaData();
			int colCount = rsmd.getColumnCount();
			String[] colNames = new String[colCount];
			String toCap = null;
			for (int j = 1; j <= colCount; j++){
				toCap = rsmd.getColumnName(j);
				colNames[j-1] = toCap.toUpperCase();
			}
			while(rs.next()){
				//Represent Row Object
				Map map = new HashMap();
				int rowNum = 0;
				for(int i = 1;i<= colCount;i++){
					map.put(colNames[i-1],rs.getObject(i));	
				}
				//Represent Table Object
				list.add(rowNum,map);
				
				rowNum++;
			}//End Records
		}catch(Exception e){

		}finally{
			finallize(con,stmt,rs);
			
		}
		return list;
		
	}
	
	public  static ArrayList executeQueryWithCon(String sql,Connection con){
			Statement stmt = null;
			ArrayList list = new ArrayList();
			ResultSet rs = null;
			ResultSetMetaData rsmd = null;
			try{
				stmt = con.createStatement();		
				rs = stmt.executeQuery(sql);
				rsmd = rs.getMetaData();
				int colCount = rsmd.getColumnCount();
				String[] colNames = new String[colCount];
				String toCap = null;
				for (int j = 1; j <= colCount; j++){
					toCap = rsmd.getColumnName(j);
					colNames[j-1] = toCap.toUpperCase();
				}
				while(rs.next()){
					//Represent Row Object
					Map map = new HashMap();
					int rowNum = 0;
					for(int i = 1;i<= colCount;i++){
						map.put(colNames[i-1],rs.getObject(i));	
					}
					//Represent Table Object
					list.add(rowNum,map);
				
					rowNum++;
				}//End Records
			}catch(Exception e){

			}finally{
				try{
					if (rs != null) rs.close();
					if (stmt != null) stmt.close();
				}catch(Exception e){
					System.out.println("Close Statement Error " + e);
				}
				//finallize(con,stmt,rs);
			
			}
			return list;
		
		}
	
	public static void finallize(Connection con,Statement stmt,ResultSet rs){
		try{
			//System.out.println("call finallize----------------");
			if (rs != null) rs.close();
			if (stmt != null) stmt.close();
			if (con != null){
                            con.commit();
                            con.close();
                        }
		}catch(Exception ex){}
		
	}

}

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package SLF_TOOL;

import java.sql.*;
import SLF_TOOL.*;
//import java.sql.ResultSet;
//import java.sql.Statement;
//import java.sql.SQLException;
//import java.util.Vector;

/**
 *
 * @author TRISORN123
 */
public class SLF_BATCH {
    //valible for SLF_BATCH_SLF
    String Batch_id="", univ_id="", academic_year="", semester="", fund_id="", bank_id="";
    int qty_pin=0;    
    double total_money=0.00;
    String upd_user="", upd_date=null;
    
    //valible for SLF_BATCH_DETAIL_SLF
    String pin="", stu_no="", stu_name="", edu_level="", class_year="", stu_type="", contract_no="", register_no="";
    double edu_amt=0.00, stu_amt=0.00, living_amt=0.00, total_amt=0.00;   
    
    
    public void setPin(String pin) {
		this.pin = pin;
    }
     
        
    public String genBatch_ID(Connection con, String titleBatch, String academic_year, String semester, String univ_id, String fund_id, String Bank_ID, String Batch_type)throws SQLException, Exception{
        //public String genBatch_ID(String academic_year1)throws SQLException, Exception{
        Statement st = null;
        ResultSet rs=null;
	String sql = "";
        String tmp_id="";
        int line1=0;             
       
        SLF_TOOL tool=new SLF_TOOL();
        
        //B+academic_year+semester+fund_id+univ_id+running_number 5 หลัก
        //ตัวอย่าง B25581100106100001
        
        
        try{
			st = con.createStatement();
                        
                        //sql="Select batch_id from SLF_BATCH.SLF_BATCH_SLF "+
                        sql="Select REPLACE(batch_id,' ','') from SLF_BATCH.SLF_BATCH_SLF "+
                            "where academic_year='"+academic_year+"' and semester='"+semester+"' and univ_id='"+univ_id+"' "+
                                   "and fund_id='"+fund_id+"' and Bank_ID='"+Bank_ID+"' and batch_type='"+Batch_type+"' "+
                            "order by batch_id desc "+
                            "fetch first 1 rows only "+
                            "with ur";
                        
                        st=con.createStatement();
                        rs=st.executeQuery(sql);
                         
                        if(rs.next()){
                            
                           tmp_id=Integer.toString(Integer.parseInt(tool.getLeft(rs.getString(1),5))+1);
                           
                           line1=5-tmp_id.length();
			   
			   for(int i=1; i<=line1;i++){
				tmp_id="0"+tmp_id;
			   }
                           
                           //tmp_id=titleBatch+academic_year+semester+fund_id+univ_id+tmp_id;
                           tmp_id=titleBatch+fund_id+Batch_type+academic_year+semester+univ_id+tmp_id;
                           
                        }else{
                           //tmp_id=titleBatch+academic_year+semester+fund_id+univ_id+"00001";
                            tmp_id=titleBatch+fund_id+Batch_type+academic_year+semester+univ_id+"00001";
                        }
                        
                       // rs.close();
                        //st.close();
	}catch(SQLException e){
			System.out.println("insert SQLException Error : " + e);
			System.out.println("SQL : " + sql);
			throw e;
	}catch(Exception e){
			System.out.println("insert Exception Error : " + e);
			System.out.println("SQL : " + sql);
			throw e;
	}finally{
			try{
				if (st != null)
					st.close();
			}catch(Exception e){
				System.out.println("insert Close Exception Error : " + e);
				throw e;
			}
	}
        
        return tmp_id;
        
    }
    
    
    public String genBatch_ID2(Connection con, String titleBatch, String academic_year, String semester, String univ_id, String fund_id, String Bank_ID, String Batch_type)throws SQLException, Exception{
        //public String genBatch_ID(String academic_year1)throws SQLException, Exception{
        Statement st = null;
        ResultSet rs=null;
	String sql = "";
        String tmp_id="";
        int line1=0;             
       
        SLF_TOOL tool=new SLF_TOOL();
        
        //B+academic_year+semester+fund_id+univ_id+running_number 5 หลัก
        //ตัวอย่าง B25581100106100001
        
        
        try{
			st = con.createStatement();
                        
                        //sql="Select batch_id from SLF_BATCH.SLF_BATCH_SLF "+
                        sql="Select REPLACE(batch_id,' ','') from SLF_BATCH.SLF_BATCH_SLF_ADD "+
                            "where academic_year='"+academic_year+"' and semester='"+semester+"' and univ_id='"+univ_id+"' "+
                                   "and fund_id='"+fund_id+"' and Bank_ID='"+Bank_ID+"' "+
                            "order by batch_id desc "+
                            "fetch first 1 rows only "+
                            "with ur";
                        
                        st=con.createStatement();
                        rs=st.executeQuery(sql);
                         
                        if(rs.next()){
                            
                           tmp_id=Integer.toString(Integer.parseInt(tool.getLeft(rs.getString(1),5))+1);
                           
                           line1=5-tmp_id.length();
			   
			   for(int i=1; i<=line1;i++){
				tmp_id="0"+tmp_id;
			   }
                           
                           //tmp_id=titleBatch+academic_year+semester+fund_id+univ_id+tmp_id;
                           tmp_id=titleBatch+fund_id+Batch_type+academic_year+semester+univ_id+tmp_id;
                           
                        }else{
                           //tmp_id=titleBatch+academic_year+semester+fund_id+univ_id+"00001";
                            tmp_id=titleBatch+fund_id+Batch_type+academic_year+semester+univ_id+"00001";
                        }
                        
                       // rs.close();
                        //st.close();
	}catch(SQLException e){
			System.out.println("insert SQLException Error : " + e);
			System.out.println("SQL : " + sql);
			throw e;
	}catch(Exception e){
			System.out.println("insert Exception Error : " + e);
			System.out.println("SQL : " + sql);
			throw e;
	}finally{
			try{
				if (st != null)
					st.close();
			}catch(Exception e){
				System.out.println("insert Close Exception Error : " + e);
				throw e;
			}
	}
        
        return tmp_id;
        
    }
    
    public int insert_update(Connection con, String SQL)throws SQLException, Exception{
        Statement st = null;
        int rowUpdate=0;
        try{
			st = con.createStatement();
                        
                        rowUpdate = st.executeUpdate( SQL );
	}catch(SQLException e){
			System.out.println("insert SQLException Error : " + e);
			System.out.println("SQL : " + SQL);
			throw e;
	}catch(Exception e){
			System.out.println("insert Exception Error : " + e);
			System.out.println("SQL : " + SQL);
			throw e;
	}finally{
			try{
				if (st != null){
					st.close();
                                }
			}catch(Exception e){
				System.out.println("insert Close Exception Error : " + e);
				throw e;
			}
	}
                
        return rowUpdate;
        
    }
    
    public int insert_BatchDetial(Connection con, String ACADEMIC_YEAR, String SEMESTER, String UNIV_ID, String FUND_ID,
                            String PIN, String STU_NO, String STU_NAME, String EDU_LEVEL, String CLASS_YEAR,
                            String STU_TYPE, String BATCH_ID, String CONTRACT_NO, String REGISTER_NO, String EDU_AMT,
                            String STU_AMT, String LIVING_AMT, String TOTAL_AMT) throws SQLException, Exception{
        Statement st = null;
	String sql = "";
        int rowUpdates=0;
		try{
			st = con.createStatement();
                        /*
			sql = "insert into " + DBUtil.schemaSlf + ".request_status " +
				  "(academic_year, semester, pin, seq_no, upd_user, upd_date) " +
				  "values( '" + academic_year + "', '" +  semester + "', '" +  pin + "', " + seq_no + ", '" + upd_user + "', "+ upd_date + " )";
			*/
                         rowUpdates = st.executeUpdate( sql );
		}catch(SQLException e){
			System.out.println("insert SQLException Error : " + e);
			System.out.println("SQL : " + sql);
			throw e;
		}catch(Exception e){
			System.out.println("insert Exception Error : " + e);
			System.out.println("SQL : " + sql);
			throw e;
		}finally{
			try{
				if (st != null)
					st.close();
			}catch(Exception e){
				System.out.println("insert Close Exception Error : " + e);
				throw e;
			}
		}
		return rowUpdates;
    }
    
    public static void main(String[] args){
                
    }
}

package SLF_TOOL;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Locale;

import com.pccth.utils.DBUtil;


/*
 * Created on 13 มี.ค. 2553
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/**
 * @author TOOM
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class SLFSB0021 
{
	
	public static void main(String[] args) 
	{
		Connection con = null;
		String academic_year="";		
		try{
			
			con=DBUtil.getConnection(false);	
System.out.println("= Start  Programe Batch SLFSB0021=");		
		    ProcessStepOne(con);
		    ProcessStepTwo(con);	
System.out.println("= End  Programe Batch SLFSB0021=");		
		}catch(Exception e)
		{		e.printStackTrace();
				try{
						con.rollback();
				}catch(Exception ee)
					{ee.printStackTrace();}	
		}finally
		{
			try {
				if (con != null) 
				{
					con.commit();
					con.close();
				}
				} catch (Exception e) 
					{e.printStackTrace();}
		}		
	}
	
	private static void ProcessStepOne(Connection con) 
	{
		String sql="";
		Statement stmt=null, stmt1=null;
		ResultSet rs=null;
		try{
			sql=" select * from SLF_MASTER.CONTROL_STATUS  with ur";
			//sql=" select * from SLF_MASTER.CONTROL_STATUS where academic_year='2555'  with ur";
			stmt=con.createStatement();
			rs=stmt.executeQuery(sql);
			String academic_year="",semester="";
			while(rs.next())
			{
				academic_year=chkNull(rs.getString("ACADEMIC_YEAR"));
				semester=chkNull(rs.getString("SEMESTER"));
				stmt1=con.createStatement();
				sql="Delete From SLF.SUM_PERSON Where ACADEMIC_YEAR ='"+academic_year+"' AND SEMESTER='"+semester+"'  ";
				stmt1.executeUpdate(sql);
System.out.println("Step 1. Delete From SLF.SUM_PERSON=="+getTime()+":"+sql);			
				sql="Delete From SLF.SUM_AMOUNT Where ACADEMIC_YEAR ='"+academic_year+"' AND SEMESTER='"+semester+"'  ";
				stmt1.executeUpdate(sql);
System.out.println("Step 2. Delete From SLF.SUM_AMOUNT=="+getTime()+":"+sql);				
				/*if(semester.equals("1"))
				{
					sql="  Insert Into SLF.SUM_PERSON (ACADEMIC_YEAR,  SEMESTER,  UNIV_OFFICE_ID,  "  +
						"  STU_NO,isalam,  UNIV_QTY,  SEQ1, SEQ2,   SEQ3, SEQ4 ,   "  +
						"  SEQ6, SEQ8,  SEQ9,  SEQ10,  SEQ11,   SEQ12,"  +
						"  UPD_USER, UPD_DATE)"  +
						"  Select '"+academic_year+"', '1', v.univ_office_id,c.stu_no,case when c.isalam is null then '' else c.isalam end , "  +
						"  count(distinct c.univ_id) as sCountUniv, count(*),"  +
						"  sum(case when conf_status > 1 then 1 else 0 end ), "  +
						"  sum(case when conf_status > 2 then 1 else 0 end ),  "  +
						"  sum(case when (conf_status > 3  and req_status = 'Y')  then 1 else 0 end ),  "  +
						"  sum(case when (conf_status > 4  and req_status = 'Y')  then 1 else 0 end ), "  +
						"  sum(case when (conf_status > 6  and req_status = 'Y')  then 1 else 0 end ), 0,"  +
						"  sum(case when conf_status > 8 then 1 else 0 end ),   		"  +
						"  sum(case when conf_status > 10 then 1 else 0 end ),   		"  +
						"  sum(case when conf_status > 11 then 1 else 0 end ), 'PCCOPER1', current timeStamp"  +
						"  From  SLF.CONFIRM_FORM c Left Outer Join slf_master.university v "  +
						"  On c.UNIV_ID = v.UNIV_ID"  +
						"  Where c.ACADEMIC_YEAR ='"+academic_year+"' AND c.SEMESTER ='1'"  +
						"  Group By v.univ_office_id,c.stu_no,case when c.isalam is null then '' else c.isalam end With UR" ;
				}else
					{
					sql="  Insert Into SLF.SUM_PERSON (ACADEMIC_YEAR,  SEMESTER,  UNIV_OFFICE_ID,  "  +
						"  STU_NO,isalam,  UNIV_QTY,  SEQ1, SEQ2,   SEQ3, SEQ4 ,   "  +
						"  SEQ6, SEQ8,  SEQ9,  SEQ10,  SEQ11,   SEQ12,"  +
						"  UPD_USER, UPD_DATE)"  +
						"  Select '"+academic_year+"', '"+semester+"', v.univ_office_id,c.stu_no,case when c.isalam is null then '' else c.isalam end, "  +
						"  count(distinct c.univ_id) as sCountUniv,"  +
						"  0, 0, 0, 0, 0, 0, count(*) as seq9,"  +
						"  sum(case when conf_status > 9 then 1 else 0 end ) as seq10,"  +
						"  sum(case when conf_status > 10 then 1 else 0 end ) as seq11,  "  +
						"  sum(case when conf_status > 11 then 1 else 0 end ) as seq12, "  +
						"  'PCCOPER1', current timeStamp "  +
						"  From  SLF.CONFIRM_FORM c Left Outer Join slf_master.university v "  +
						"  On c.UNIV_ID = v.UNIV_ID"  +
						"  Where c.ACADEMIC_YEAR ='"+academic_year+"' AND c.SEMESTER ='"+semester+"'"  +
						"  Group By v.univ_office_id,c.stu_no,case when c.isalam is null then '' else c.isalam end With UR" ;
					}
					*/
				
				sql="  Insert Into SLF.SUM_PERSON (ACADEMIC_YEAR,  SEMESTER,  UNIV_OFFICE_ID,  "  +
					"  STU_NO,fund_id,isalam,  UNIV_QTY,  SEQ1, SEQ2,   SEQ3, SEQ4 ,   "  +
					"  SEQ6, SEQ8,  SEQ9,  SEQ10,  SEQ11,   SEQ12,"  +
					"  UPD_USER, UPD_DATE)"  +
					" Select c.academic_year, c.semester,v.univ_office_id,c.stu_no,'2','',count(distinct c.univ_id)"+
					" ,sum(case when c.semester ='1'  then 1 else 0 end) as seq1   "+
					" ,sum(case when c.semester ='1' and c.conf_status > 1 then 1 else 0 end) as seq2  "+
					" ,sum(case when c.semester ='1'  and c.conf_status > 2 then 1 else 0 end) as seq3    "+
					" ,sum(case when c.semester ='1'  and c.conf_status > 3 and c.req_status = 'Y' then 1 else 0 end) as seq4  "+
					" ,sum(case when c.semester ='1'  and c.conf_status > 4 and c.req_status = 'Y' then 1 else 0 end) as seq6   "+
					" ,sum(case when c.semester ='1'  and c.conf_status > 6 and c.req_status = 'Y' then 1 else 0 end) as seq8  "+
					" ,sum(case when c.semester in ('2','3') and c.conf_status > 8 then 1 else 0 end) as seq9   "+
					" ,sum(case when c.conf_status > 9 then 1 else 0 end ) as seq10  "+
					" ,sum(case when c.conf_status > 10 then 1 else 0 end ) as seq11   "+
					" ,sum(case when c.conf_status > 11 then 1 else 0 end ) as seq12 , 'PCCOPER1', current timeStamp "+
					" from  SLF.CONFIRM_FORM c, slf_master.v_university v   left outer join slf_master.v_university v on v.univ_id = c.univ_id  "+
					" where and c.academic_year = '"+academic_year+"' and c.semester = '"+semester+"'  "+
					" group by c.academic_year, c.semester,v.univ_office_id,c.stu_no  "+
					" union   "+
					" Select c.academic_year, c.semester,v.univ_office_id,c.stu_no,'5','',count(distinct c.univ_id)"+
					" ,sum(case when c.semester ='1'  then 1 else 0 end) as seq1   "+
					" ,sum(case when c.semester ='1' and c.conf_status > 1 then 1 else 0 end) as seq2  "+
					" ,sum(case when c.semester ='1'  and c.conf_status > 2 then 1 else 0 end) as seq3    "+
					" ,sum(case when c.semester ='1'  and c.conf_status > 3 and c.req_status = 'Y' then 1 else 0 end) as seq4  "+
					" ,sum(case when c.semester ='1'  and c.conf_status > 4 and c.req_status = 'Y' then 1 else 0 end) as seq6   "+
					" ,sum(case when c.semester ='1'  and c.conf_status > 6 and c.req_status = 'Y' then 1 else 0 end) as seq8  "+
					" ,sum(case when c.semester in ('2','3') and c.conf_status > 8 then 1 else 0 end) as seq9   "+
					" ,sum(case when c.conf_status > 9 then 1 else 0 end ) as seq10  "+
					" ,sum(case when c.conf_status > 10 then 1 else 0 end ) as seq11   "+
					" ,sum(case when c.conf_status > 11 then 1 else 0 end ) as seq12 , 'PCCOPER1', current timeStamp "+
					" from  ICL55.CONFIRM_FORM c, slf_master.v_university v   left outer join slf_master.v_university v on v.univ_id = c.univ_id  "+
					" where and c.academic_year = '"+academic_year+"' and c.semester = '"+semester+"'  "+
					" group by c.academic_year, c.semester,v.univ_office_id,c.stu_no  with ur; ";
					
System.out.println("Step 3. Insert Into SLF.SUM_PERSON= Start ="+sql);		
System.out.println("Step 3.1 Insert Into SLF.SUM_PERSON= Start ="+getTime());	
				  stmt1.executeUpdate(sql);	
System.out.println("Step 3.2 Insert Into SLF.SUM_PERSON= End ="+getTime());	
				
				sql="  Insert Into SLF.SUM_AMOUNT (ACADEMIC_YEAR, SEMESTER, SEQ_NO,fund_id,isalam, EDU_OLD_01, STU_OLD_01, LIV_OLD_01, EDU_NEW_01, STU_NEW_01, LIV_NEW_01, EDU_OLD_02, STU_OLD_02, LIV_OLD_02, EDU_NEW_02, STU_NEW_02, LIV_NEW_02, UPD_USER, UPD_DATE)"  +
					"  select r.academic_year, r.semester, r.seq_no,'2','', "  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '01' "  +
					"  		then (EDU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '01' "  +
					"  		then (STU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '01' "  +
					"  		then (LIVING_AMT) else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '01' "  +
					"  		then (EDU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '01' "  +
					"  		then (STU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '01' "  +
					"  		then (LIVING_AMT) else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '02' "  +
					"  		then (EDU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '02' "  +
					"  		then (STU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '02' "  +
					"  		then (LIVING_AMT) else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '02' "  +
					"  		then (EDU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '02' "  +
					"  		then (STU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '02' "  +
					"  		then (LIVING_AMT) else 0 end),'PCCOPER1', current timeStamp "  +
					"  from slf.CEILING_SELECT C"  +
					"  	inner join slf_master.v_university U on c.univ_id = u.univ_id"  +
					"  	inner join slf.request_status r on c.pin = r.pin "  +
					"  		and c.academic_year = r.academic_year and r.semester ='"+semester+"' "  +
					//"  	inner join slf.confirm_form f on c.academic_year = f.academic_year  "  +
					//"  		and c.semester = f.semester  and c.pin = f.pin "  +
					"  where c.academic_year ='"+academic_year+"' "  +
					"  AND r.seq_no in(2,3,4,6,8)"  +
					"  group by r.academic_year, r.semester, r.seq_no "  +
					"  union"  +
					"  select r.academic_year, r.semester, r.seq_no,'5','', "  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '01' "  +
					"  		then (EDU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '01' "  +
					"  		then (STU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '01' "  +
					"  		then (LIVING_AMT) else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '01' "  +
					"  		then (EDU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '01' "  +
					"  		then (STU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '01' "  +
					"  		then (LIVING_AMT) else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '02' "  +
					"  		then (EDU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '02' "  +
					"  		then (STU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '02' "  +
					"  		then (LIVING_AMT) else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '02' "  +
					"  		then (EDU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '02' "  +
					"  		then (STU_AMT1 ) else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '02' "  +
					"  		then (LIVING_AMT) else 0 end),'PCCOPER1', current timeStamp "  +
					"  from icl55.CEILING_SELECT C"  +
					"  	inner join slf_master.v_university U on c.univ_id = u.univ_id"  +
					"  	inner join icl55.request_status r on c.pin = r.pin "  +
					"  		and c.academic_year = r.academic_year and r.semester ='"+semester+"' "  +
					//"  	inner join slf.confirm_form f on c.academic_year = f.academic_year  "  +
					//"  		and c.semester = f.semester  and c.pin = f.pin "  +
					"  where c.academic_year ='"+academic_year+"' "  +
					"  AND r.seq_no in(2,3,4,6,8)"  +
					"  group by r.academic_year, r.semester, r.seq_no "  +				
					
					"  union"  +
					"  Select r.academic_year, r.semester, r.seq_no,'2','', "  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '01' then EDU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '01' then STU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '01' then LIVING_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '01' then EDU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '01' then STU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '01' then LIVING_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '02' then EDU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '02' then STU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '02' then LIVING_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '02' then EDU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '02' then STU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '02' then LIVING_AMT else 0 end),'PCCOPER1', current timeStamp"  +
					"  from slf.register C"  +
					"  	inner join slf_master.v_university U on c.univ_id = u.univ_id"  +
					"  	inner join slf.request_status r on c.academic_year = r.academic_year"  +					
					"  		and c.semester=r.semester  "  +
					"  		and  c.pin = r.pin  and r.semester = '"+semester+"' "  +
					//"  	inner join slf.confirm_form f on c.academic_year = f.academic_year  "  +
					//"  		and c.semester = f.semester  and c.pin = f.pin "  +
					"  where c.ACADEMIC_YEAR ='"+academic_year+"' "  +
					"  	AND (c.cancel_status != 'Y' OR (c.cancel_status   = 'Y' AND c.cancel_user = 'PENDING')) and r.seq_no in(10, 11, 12)"  +
					"  group by r.academic_year, r.semester, r.seq_no " +
					
					"  union"  +
					"  Select r.academic_year, r.semester, r.seq_no,'5','', "  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '01' then EDU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '01' then STU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '01' then LIVING_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '01' then EDU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '01' then STU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '01' then LIVING_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '02' then EDU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '02' then STU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'O' and u.univ_office_id = '02' then LIVING_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '02' then EDU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '02' then STU_AMT else 0 end),"  +
					"  	sum(case when c.stu_no = 'N' and u.univ_office_id = '02' then LIVING_AMT else 0 end),'PCCOPER1', current timeStamp"  +
					"  from icl55.register C"  +
					"  	inner join slf_master.v_university U on c.univ_id = u.univ_id"  +
					"  	inner join icl55.request_status r on c.academic_year = r.academic_year"  +					
					"  		and c.semester=r.semester  "  +
					"  		and  c.pin = r.pin  and r.semester = '"+semester+"' "  +
					//"  	inner join slf.confirm_form f on c.academic_year = f.academic_year  "  +
					//"  		and c.semester = f.semester  and c.pin = f.pin "  +
					"  where c.ACADEMIC_YEAR ='"+academic_year+"' "  +
					"  AND	 (c.cancel_status != 'Y' OR (c.cancel_status   = 'Y' AND c.cancel_user = 'PENDING')) and r.seq_no in(10, 11, 12)"  +
					"  group by r.academic_year, r.semester, r.seq_no with ur" ;
System.out.println("Step 4.1 Insert Into SLF.SUM_AMOUNT= Start ="+sql);				
System.out.println("Step 4.2 Insert Into SLF.SUM_AMOUNT= Start ="+getTime());
				   stmt1.executeUpdate(sql);	
System.out.println("Step 4.3 Insert Into SLF.SUM_AMOUNT= End ="+getTime());
				
				//เพิ่มเติม seq เพื่อใช้ select เื่พื่อแสดง ข้อมูล
				sql="  Insert into SLF.SUM_AMOUNT (ACADEMIC_YEAR, SEMESTER, SEQ_NO,fund_id,isalam,    "  +
					"  EDU_OLD_01, STU_OLD_01, LIV_OLD_01, EDU_NEW_01, STU_NEW_01, LIV_NEW_01,    "  +
					"  EDU_OLD_02, STU_OLD_02, LIV_OLD_02, EDU_NEW_02, STU_NEW_02, LIV_NEW_02,    "  +
					"  UPD_USER, UPD_DATE)    "  +
					"  VALUES('"+academic_year+"', '"+semester+"', 1,'2','',    "  +
					"  0, 0, 0, 0, 0, 0,    "  +
					"  0, 0, 0, 0, 0, 0,   "  +
					"   'PCCOPER1', current timeStamp)   "  ;
					
					stmt1.executeUpdate(sql);
				
				sql="  Insert into SLF.SUM_AMOUNT (ACADEMIC_YEAR, SEMESTER, SEQ_NO,fund_id,isalam,    "  +
					"  EDU_OLD_01, STU_OLD_01, LIV_OLD_01, EDU_NEW_01, STU_NEW_01, LIV_NEW_01,    "  +
					"  EDU_OLD_02, STU_OLD_02, LIV_OLD_02, EDU_NEW_02, STU_NEW_02, LIV_NEW_02,    "  +
					"  UPD_USER, UPD_DATE)    "  +
					"  VALUES('"+academic_year+"', '"+semester+"', 1,'5','',    "  +
					"  0, 0, 0, 0, 0, 0,    "  +
					"  0, 0, 0, 0, 0, 0,   "  +
					"   'PCCOPER1', current timeStamp)   "  ;
				
				    stmt1.executeUpdate(sql);
System.out.println("Step 5. Insert Into SLF.SUM_AMOUNT"+getTime());
				// เพิ่มเติม seq เพื่อใช้ select เื่พื่อแสดง ข้อมูล
					sql="  Insert into SLF.SUM_AMOUNT (ACADEMIC_YEAR, SEMESTER, SEQ_NO,fund_id,isalam,    "  +
					"  EDU_OLD_01, STU_OLD_01, LIV_OLD_01, EDU_NEW_01, STU_NEW_01, LIV_NEW_01,    "  +
					"  EDU_OLD_02, STU_OLD_02, LIV_OLD_02, EDU_NEW_02, STU_NEW_02, LIV_NEW_02,    "  +
					"  UPD_USER, UPD_DATE)    "  +
					"  VALUES('"+academic_year+"', '"+semester+"', 9,'2','',    "  +
					"  0, 0, 0, 0, 0, 0,    "  +
					"  0, 0, 0, 0, 0, 0,   "  +
					"   'PCCOPER1', current timeStamp)   "  ;
					stmt1.executeUpdate(sql);
					
					sql="  Insert into SLF.SUM_AMOUNT (ACADEMIC_YEAR, SEMESTER, SEQ_NO,fund_id,isalam,    "  +
					"  EDU_OLD_01, STU_OLD_01, LIV_OLD_01, EDU_NEW_01, STU_NEW_01, LIV_NEW_01,    "  +
					"  EDU_OLD_02, STU_OLD_02, LIV_OLD_02, EDU_NEW_02, STU_NEW_02, LIV_NEW_02,    "  +
					"  UPD_USER, UPD_DATE)    "  +
					"  VALUES('"+academic_year+"', '"+semester+"', 9,'5','',    "  +
					"  0, 0, 0, 0, 0, 0,    "  +
					"  0, 0, 0, 0, 0, 0,   "  +
					"   'PCCOPER1', current timeStamp)   "  ;
					stmt1.executeUpdate(sql);
System.out.println("Step 6. Insert Into SLF.SUM_AMOUNT"+getTime());
			}rs.close();
System.out.println("==RUN SUCCESSFULLY=="+getTime());		
		}catch(SQLException sqle)
			{
				sqle.printStackTrace();
				try {
						con.rollback();
					} catch (Exception e) 
						{
						e.printStackTrace();
						}	
	}catch(Exception e)
	  {		e.printStackTrace();
			try{
					con.rollback();
			}catch(Exception ee)
				{
					ee.printStackTrace();
				}	
	}finally
	{
		try {
			
			if(rs!=null)rs.close();
			if(stmt!=null)stmt.close();
			if(stmt1!=null)stmt1.close();
			
			} catch (Exception e) 
				{
					e.printStackTrace();
				}
			rs=null;stmt=null;stmt1=null;sql=null;
	}		
	}
	
	private static void ProcessStepTwo(Connection con) 
	{
		String sql="";
		Statement stmt=null, stmt1=null;
		ResultSet rs=null;
		try{
			sql=" select ACADEMIC_YEAR from SLF_MASTER.CONTROL_STATUS with ur";
			//sql=" select ACADEMIC_YEAR from SLF_MASTER.CONTROL_STATUS where academic_year='2555' with ur";
			stmt=con.createStatement();
			rs=stmt.executeQuery(sql);
			String academic_year="",semester="";
			while(rs.next())
			{
				academic_year=chkNull(rs.getString("ACADEMIC_YEAR"));
				
				stmt1=con.createStatement();
				sql="Delete From SLF.SUM_INST_CEI  Where ACADEMIC_YEAR ='"+academic_year+"'  ";
				stmt1.executeUpdate(sql);
//System.out.println("Step 1.ProcessStepTwo Delete From SLF.SUM_INST_CEI=="+getTime()+":"+sql);					
				sql=" Insert Into SLF.SUM_INST_CEI  " +
					"        (ACADEMIC_YEAR, UNIV_OFFICE_ID, STU_NO,FUND_ID, STD_QTY_INST,  " +
					"        EDU_AMT_INST, LIVING_AMT_INST, STD_QTY_CEI, EDU_AMT_CEI,  " +
					"        LIVING_AMT_CEI, UPD_USER, UPD_DATE) " +
					" SELECT SLF.INSTITUTE_LIMIT.ACADEMIC_YEAR, SLF_MASTER.V_UNIVERSITY.UNIV_OFFICE_ID, SLF.INSTITUTE_LIMIT.STU_TYPE, '2', " +
					" Sum(SLF.INSTITUTE_LIMIT.STD_QTY) AS SumOfSTD_QTY, Sum(SLF.INSTITUTE_LIMIT.EDU_AMT) AS SumOfEDU_AMT,  " +
					" Sum(SLF.INSTITUTE_LIMIT.LIVING_AMT) AS SumOfLIVING_AMT, Sum(SLF.INSTITUTE_LIMIT.STD_QTY_PAY) AS SumOfSTD_QTY_PAY,  " +
					" Sum(SLF.INSTITUTE_LIMIT.EDU_AMT_PAY) AS SumOfEDU_AMT_PAY, Sum(SLF.INSTITUTE_LIMIT.LIVING_AMT_PAY) AS SumOfLIVING_AMT_PAY, " +
					" '000000', current timestamp " +
					" FROM SLF.INSTITUTE_LIMIT INNER JOIN SLF_MASTER.V_UNIVERSITY  " +
					" ON SLF.INSTITUTE_LIMIT.UNIV_ID = SLF_MASTER.V_UNIVERSITY.UNIV_ID " +
					" WHERE SLF.INSTITUTE_LIMIT.ACADEMIC_YEAR ='"+academic_year+"'  " +
					" GROUP BY SLF.INSTITUTE_LIMIT.ACADEMIC_YEAR, SLF_MASTER.V_UNIVERSITY.UNIV_OFFICE_ID, SLF.INSTITUTE_LIMIT.STU_TYPE " +
					" With UR; " ;
					
System.out.println("Step 2.1 Insert Into SLF.SUM_INST_CEI= Start ="+sql);		
				stmt1.executeUpdate(sql);	
System.out.println("Step 2.2 Insert Into SLF.SUM_INST_CEI= End ="+getTime());				
			
			}rs.close();
		
		}catch(SQLException sqle)
			{
				sqle.printStackTrace();
				try {
						con.rollback();
					} catch (Exception e) 
						{
						e.printStackTrace();
						}	
	}catch(Exception e)
	  {		e.printStackTrace();
			try{
					con.rollback();
			}catch(Exception ee)
				{
					ee.printStackTrace();
				}	
	}finally
	{
		try {
			
			if(rs!=null)rs.close();
			if(stmt!=null)stmt.close();
			if(stmt1!=null)stmt1.close();
			
			} catch (Exception e) 
				{
					e.printStackTrace();
				}
			rs=null;stmt=null;stmt1=null;sql=null;
	}		
	}
	
	
	
	
	
	public static String chkNull(String value) 
	{
        return (value == null ? "" : value.trim());
    }
	
	 //private static String getTime(){
        //java.util.Day nowDay = new Day();
       // return nowDay.toString();
   // }
	
	public static String getTime() throws SQLException, Exception{
    	GregorianCalendar cal = new GregorianCalendar(Locale.ENGLISH);
		int i_Year = cal.get(Calendar.YEAR);
		int i_Month = cal.get(Calendar.MONTH) + 1;
		int i_Date = cal.get(Calendar.DATE);								
		int i_Hour = cal.get(Calendar.HOUR_OF_DAY);
		int i_Minute = cal.get(Calendar.MINUTE);
		int i_Second = cal.get(Calendar.SECOND);
		String s_Date="";
		String s_Month="";
		String s_Hour=""; 
		String s_Minute=""; 
		String s_Second="";
		if(i_Hour<10){
			s_Hour="0";
		}
		if(i_Minute<10){
			s_Minute="0";
		}
		if(i_Second<10){
			s_Second="0";
		}
		s_Hour+=""+i_Hour;
		s_Minute+=""+i_Minute;
		s_Second+=""+i_Second;
		if(i_Date<10){
			s_Date="0";
		}
		if(i_Month<10){
			s_Month="0";
		}
		s_Date+=""+i_Date;
		s_Month+=""+i_Month;
		String dateReturn="";
		dateReturn=i_Year+"-"+s_Month+"-"+s_Date+"-"+s_Hour+"."+s_Minute+"."+s_Second;
        return dateReturn;
    }

}

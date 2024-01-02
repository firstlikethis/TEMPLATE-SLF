/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package SLF_TOOL;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.Vector;

import com.pccth.utils.DBUtil;
/**
 *
 * @author TRISORN123
 */
public class User_loginBean {
    private Vector vectorList = new Vector();
    private String userid = "",  userid_seq = "",  password = "",  fname = "", begin_date = "", end_date = "", 
			create_by = "",  create_date = "",  update_by = "",  last_update = "", user_type="", 
			title_code="", title_name="", question="", answer="", cat_id="", office_id="", zone_code="", 
			birth_date=null, hr_name="", hr_surname="";
    public User_loginBean(){} 
    /**
	 * Method selectByPrimaryKey สำหรับทำการดึงข้อมูลตาม PrimaryKey ของ Table Sso.user_login 
	 * Example : 
	 * 		user_login.setUserid("01");
	 * 		user_login.setUserid_seq("01");
	 * 		user_login.selectByPrimaryKey();
	 * @return void
	 */	
	public void selectByPrimaryKey() throws Exception {
		Connection con = null;
		try{
			con = DBUtil.getConnection(false);
			selectByPrimaryKey(con);
		}catch(SQLException sqlE){
			System.out.println("User_loginBean SelectByPrimaryKey Select SQLException Error : " + sqlE);
		}catch(Exception e){
			System.out.println("User_loginBean SelectByPrimaryKey Select Exception Error : " + e);
		}finally{
			try{
				if (con != null){
					con.commit();
					con.close();
				}
			}catch(Exception e){
				System.out.println("User_loginBean SelectByPrimaryKey Close connection Exception Error : " + e);
			}
		}
	}
        /**
	 * Method selectByPrimaryKey สำหรับทำการดึงข้อมูลตาม PrimaryKey ของ Table Sso.user_login 
	 * Example : 
	 * 		user_login.setUserid("01");
	 * 		user_login.setUserid_seq("01");
	 * 		user_login.selectByPrimaryKey(con);
	 * @param Connection
	 * @return void
	 */	
	public void selectByPrimaryKey(Connection con) throws Exception {
		Statement stmt = null;
		ResultSet rs = null;
		String sql="";
		try{
			vectorList.removeAllElements();
			
			sql = "select * from " + DBUtil.schemaSlfSso + ".user_login where userid = '" + userid + "' and userid_seq = " + userid_seq;
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				addToVectorList(rs, con);
			}
		}catch(SQLException sqlE){
			System.out.println("User_loginBean SelectByPrimaryKey Select SQLException Error : " + sqlE);
			System.out.println("User_login SelectByPrimaryKey SQL Command : " + sql);
		}catch(Exception e){
			System.out.println("User_loginBean SelectByPrimaryKey Select Exception Error : " + e);
			System.out.println("User_login SelectByPrimaryKey SQL Command : " + sql);
		}finally{
			try{
				if (rs != null){
					rs.close();
				}
				if (stmt != null){
					stmt.close();
				}
			}catch(Exception e){
				System.out.println("User_loginBean SelectByPrimaryKey Close Statment Exception Error : " + e);
				System.out.println("User_login SelectByPrimaryKey SQL Command : " + sql);
			}
		}
	}

	/**
	 * Method selectAll สำหรับทำการดึงข้อมูล Table Sso.user_login ทั้งหมด
	 * Example : 
	 * 		user_login.selectAll();
	 * @return void
	 */	
	public void selectAll() throws Exception {
		Connection con = null;
		try{
			con = DBUtil.getConnection(false);
			selectAll(con);
		}catch(SQLException sqlE){
			System.out.println("User_loginBean SelectAll Select SQLException Error : " + sqlE);
		}catch(Exception e){
			System.out.println("User_loginBean SelectAll Select Exception Error : " + e);
		}finally{
			try{
				if (con != null){
					con.commit();
					con.close();
				}
			}catch(Exception e){
				System.out.println("User_loginBean SelectAll Close connection Exception Error : " + e);
			}
		}
	}

	/**
	 * Method selectAll สำหรับทำการดึงข้อมูล Table Sso.user_login  ทั้งหมด
	* Example : 
	* 		user_login.selectAll(con);
	 * @param Connection
	 * @return void
	 */	
	public void selectAll(Connection con) throws Exception {
		Statement stmt = null;
		ResultSet rs = null;
		String sql="";
		try{
			vectorList.removeAllElements();
			
			sql = "select * from " + DBUtil.schemaSlfSso + ".user_login order by userid ";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				addToVectorList(rs, con);
			}
		}catch(SQLException sqlE){
			System.out.println("User_loginBean SelectAll Select SQLException Error : " + sqlE);
			System.out.println("User_login SelectAll SQL Command : " + sql);
		}catch(Exception e){
			System.out.println("User_loginBean SelectAll Select Exception Error : " + e);
			System.out.println("User_login SelectAll SQL Command : " + sql);
		}finally{
			try{
				if (rs != null)	{
					rs.close();
				}
				if (stmt != null){
					stmt.close();
				}
			}catch(Exception e){
				System.out.println("User_loginBean SelectAll Close Statment Exception Error : " + e);
				System.out.println("User_login SelectAll SQL Command : " + sql);
			}
		}
	}

	/**
	 * Method selectWhere สำหรับทำการดึงข้อมูล Table Sso.user_login ตามเงื่อนไข
	* Example : 
	* 		user_login.selectWhere("where userid = '01'");
	 * @param String
	 * @return void
	 */	
	public void selectWhere(String sqlWhere) throws Exception {
		Connection con = null;
		try{
			con = DBUtil.getConnection(false);
			selectWhere(con, sqlWhere);
		}catch(SQLException sqlE){
			System.out.println("User_loginBean SelectWhere Select SQLException Error : " + sqlE);
		}catch(Exception e){
			System.out.println("User_loginBean selectWhere Select Exception Error : " + e);
		}finally{
			try{
				if (con != null){
					con.commit();
					con.close();
				}
			}catch(Exception e){
				System.out.println("User_loginBean selectWhere Close connection Exception Error : " + e);
			}
		}
	}

	/**
	 * Method selectWhere สำหรับทำการดึงข้อมูล Table Sso.user_login  ตามเงื่อนไข
	* Example : 
	* 		user_login.selectWhere(con, "where userid = '01'");
	 * @param Connection
	 * @param String
	 * @return void
	 */	
	public void selectWhere(Connection con, String sqlWhere) throws Exception {
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "";
		try{
			vectorList.removeAllElements();
			
			sql = "select * from " + DBUtil.schemaSlfSso + ".user_login " + sqlWhere;
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				addToVectorList(rs, con);
			}
		}catch(SQLException sqlE){
			System.out.println("User_loginBean selectWhere Select SQLException Error : " + sqlE);
			System.out.println("User_login selectWhere SQL Command : " + sql);
		}catch(Exception e){
			System.out.println("User_loginBean selectWhere Select Exception Error : " + e);
			System.out.println("User_login selectWhere SQL Command : " + sql);
		}finally{
			try{
				if (rs != null){
					rs.close();
				}
				if (stmt != null){
					stmt.close();
				}
			}catch(Exception e){
				System.out.println("User_loginBean selectWhere Close Statment Exception Error : " + e);
				System.out.println("User_login selectWhere SQL Command : " + sql);
			}
		}
	}

	/**
	* Insert ข้อมูลในตาราง sso.user_login
	* Example : 
	* 		user_login.setUserid('01');
	* 		user_login.insert(con);
    * @param con Connection
    * @return void
    */
	public int insert( Connection con ) throws SQLException, Exception{
		Statement st = null;
		String sql = "";
		int rowUpdates=0;
		try{
			st = con.createStatement();
	
			sql = "insert into " + DBUtil.schemaSlfSso + ".user_login " +
				  "(userid, userid_seq, password, fname, "+
				  "begin_date, end_date, create_by, create_date, " +
				  "user_type, title_code, title_name, " +
				  "question, answer, "+
				  "update_by, last_update, cat_id, office_id, zone_code, birth_date, hr_name, hr_surname) " +
				  "values( '" + userid + "', " + userid_seq + ", '" + password + "', '" +  fname + "', " +   
				  begin_date + ", " + end_date + ", '" + create_by + "', " + create_date + ", '" +
				  user_type + "', '" + title_code + "', '" + title_name + "', '" +  
				  question + "', '" + answer + "', '"+
				  update_by + "', " + last_update + ", '" + cat_id + "', '" + 
				  office_id + "', '" + zone_code + "', " + birth_date + ", '" + hr_name + "', '" + hr_surname + "'  )";
			rowUpdates = st.executeUpdate( sql );
		}catch(SQLException e){
			System.out.println("User_login insert SQLException Error : " + e);
			System.out.println("User_login insert SQL Command : " + sql);
		}catch(Exception e){
			System.out.println("User_login insert Exception Error : " + e);
			System.out.println("User_login insert SQL Command : " + sql);
		}finally{
			try{
				if (st != null)
					st.close();
			}catch(Exception e){
				System.out.println("User_login insert Close Exception Error : " + e);
				System.out.println("User_login insert SQL Command : " + sql);
			}
		}
		return rowUpdates;
	}

	/**
	* Update ข้อมูลในตาราง sso.user_login
	* Example : 
	* 		user_login.setUserid("01");
	* 		user_login.setUserid_seq("01");
	* 		user_login.update(con);
    * @param con Connection
    * @return void
    */
	public int update( Connection con ) throws SQLException, Exception{
		Statement st = null;
		String sql = "";
		int rowUpdates=0;
		try{
			st = con.createStatement();
	
			sql = "update " + DBUtil.schemaSlfSso + ".user_login  " +
					"set password = '" + 	password + "', " + 
					"fname = '" + 			fname + "', " + 
					"begin_date = " + 		begin_date + ", " + 
					"end_date = " + 		end_date + ", " + 
					"create_by = '" + 		create_by + "', " + 
					"create_date = " + 		create_date + ", " +
					"user_type = '" + 		user_type + "', " + 
					"title_code = '" + 		title_code + "', " + 
					"title_name = '" + 		title_name + "', " + 
					"question = '" + 		question + "', " +
					"answer = '" + 			answer + "', " +
					"update_by = '" + 		update_by + "', " + 
					"last_update = " + 	last_update + ", " +
					"cat_id = '" + cat_id + "', " + 
					"office_id = '" + office_id + "', " + 
					"zone_code = '" + zone_code + "', " +
					"birth_date = " + birth_date + ", " +
					"hr_name = '" + hr_name + "', " + 
					"hr_surname = '" + hr_surname + "' " + 
					"where userid = '" + userid + "' and userid_seq = " + userid_seq;
			rowUpdates = st.executeUpdate( sql );
		}catch(SQLException e){
			System.out.println("User_login update SQLException Error : " + e);
			System.out.println("User_login update SQL Command : " + sql);
		}catch(Exception e){
			System.out.println("User_login update Exception Error : " + e);
			System.out.println("User_login update SQL Command : " + sql);
		}finally{
			try{
				if (st != null)
					st.close();
			}catch(Exception e){
				System.out.println("User_login update Close Exception Error : " + e);
				System.out.println("User_login update SQL Command : " + sql);
			}
		}
		return rowUpdates;
	}

	/**
	* Update ข้อมูลในตาราง sso.user_login ตาม Statement SQL
	* Example : 
	* 		user_login.updateSQL(con, "update sso.user_login set title = '001'");
    * @param con Connection
    * @param sql String
    * @return void
    */
	public int updateSQL( Connection con, String sql ) throws SQLException, Exception{
		Statement st = null;
		int rowUpdates=0;
		try{
			st = con.createStatement();
			rowUpdates = st.executeUpdate( sql );
		}catch(SQLException e){
			System.out.println("User_login updateSQL SQLException Error : " + e);
			System.out.println("User_login updateSQL SQL Command : " + sql);
		}catch(Exception e){
			System.out.println("User_login updateSQL Exception Error : " + e);
			System.out.println("User_login updateSQL SQL Command : " + sql);
		}finally{
			try{
				if (st != null)
					st.close();
			}catch(Exception e){
				System.out.println("User_login updateSQL Close Exception Error : " + e);
				System.out.println("User_login updateSQL SQL Command : " + sql);
			}
		}
		return rowUpdates;
	}
	/**
	* delete ข้อมูลในตาราง sso.user_login ตาม PrimaryKey
	* Example : 
	* 		user_login.setUserid("01");
	* 		user_login.setUserid_seq("01");
	* 		user_login.deleteByPrimaryKey(con);
    * @param con Connection
    * @return void
    */
	public int deleteByPrimaryKey( Connection con ) throws SQLException, Exception{
		Statement st = null;
		String sql = "";
		int rowUpdates=0;
		try{
			st = con.createStatement();
	
			sql = "delete from " + DBUtil.schemaSlfSso + ".user_login where userid = '" + userid + "' and userid_seq = " + userid_seq;
			rowUpdates = st.executeUpdate( sql );
		}catch(SQLException e){
			System.out.println("User_login deleteByPrimaryKey SQLException Error : " + e);
			System.out.println("User_login deleteByPrimaryKey SQL Command : " + sql);
		}catch(Exception e){
			System.out.println("User_login deleteByPrimaryKey Exception Error : " + e);
			System.out.println("User_login deleteByPrimaryKey SQL Command : " + sql);
		}finally{
			try{
				if (st != null)
					st.close();
			}catch(Exception e){
				System.out.println("User_login deleteByPrimaryKey Close Exception Error : " + e);
				System.out.println("User_login deleteByPrimaryKey SQL Command : " + sql);
			}
		}
		return rowUpdates;
	}
	/**
	* delete ข้อมูลในตาราง sso.user_login ตาม เงือนไขที่กำหนด
	* Example : 
	* 		user_login.deleteWhere(con, "where userid = 1");
	* @param con Connection
	* @return void
	*/
	public int deleteWhere( Connection con, String where ) throws SQLException, Exception{
		Statement st = null;
		String sql = "";
		int rowUpdates=0;
		try{
			st = con.createStatement();
	
			sql = "delete from " + DBUtil.schemaSlfSso + ".user_login  " + where;
			rowUpdates = st.executeUpdate( sql );
		}catch(SQLException e){
			System.out.println("User_login deleteWhere SQLException Error : " + e);
		}catch(Exception e){
			System.out.println("User_login deleteWhere Exception Error : " + e);
		}finally{
			try{
				if (st != null)
					st.close();
			}catch(Exception e){
				System.out.println("User_login deleteWhere Close Exception Error : " + e);
			}
		}
		return rowUpdates;
	}
	/**
	 * Method addToVectorList สำหรับทำการ Add ค่าจาก Table ลง Vector 
	 * @param ResultSet
	 * @return void
	 */
	private void addToVectorList(ResultSet rs, Connection con) throws Exception {
		String row[] = new String[21];
		row[0] = chkNull(rs.getString("userid"));
		row[1] = chkNull(rs.getString("userid_seq"));
		row[2] = chkNull(rs.getString("password"));
		row[3] = chkNull(rs.getString("fname"));
		row[4] = chkNull(rs.getString("begin_date"));
		row[5] = chkNull(rs.getString("end_date"));
		row[6] = chkNull(rs.getString("create_by"));
		row[7] = chkNull(rs.getString("create_date"));
		row[8] = chkNull(rs.getString("user_type"));
		row[9] = chkNull(rs.getString("title_code"));
		row[10] = chkNull(rs.getString("title_name"));
		row[11] = chkNull(rs.getString("update_by"));
		row[12] = chkNull(rs.getString("last_update"));
		row[13] = chkNull(rs.getString("question"));
		row[14] = chkNull(rs.getString("answer"));
		row[15] = chkNull(rs.getString("cat_id"));
		row[16] = chkNull(rs.getString("office_id"));
		row[17] = chkNull(rs.getString("zone_code"));
		row[18] = chkNull(rs.getString("birth_date"));
		row[19] = chkNull(rs.getString("hr_name"));
		row[20] = chkNull(rs.getString("hr_surname"));
		vectorList.addElement(row);
	}	
	
	/**
	 * Method chkNull สำหรับตรวจสอบค่า null แล้วทำการแปลงค่า Null ให้เป็นค่า Blank 
	 * แล้วทำการ Trim ค่าที่ไม่ใช่ null ส่งกลับไป
	 * Returns the String.
	 * @param String
	 * @return Tring
	 */
	private String chkNull(String value){
		return value==null?"":value.trim();
	}
	
	/**
	 * Returns the vectorList.
	 * @return Vector
	 */
	public Vector getVectorList() {
		return vectorList;
	}

	/**
	 * Sets the vectorList.
	 * @param vectorList The vectorList to set
	 */
	public void setVectorList(Vector vectorList) {
		this.vectorList = vectorList;
	}

	/**
	 * Gets the size()
	 * @return Returns a int
	 */	
	public int size() {
		return vectorList.size();
	}
	/**
	 * Gets the getSize()
	 * @return Returns a int
	 */	
	public int getSize() {
		return vectorList.size();
	}
	
	/**
	 * Gets the userid
	 * @return Returns a String
	 */
	public String[] getUserid() { 
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[0];
		}
		return col;
	}

	/**
	 * Gets the userid_seq
	 * @return Returns a String
	 */
	public String[] getUserid_seq() { 
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[1];
		}
		return col;
	}

	/**
	 * Gets the password
	 * @return Returns a String
	 */
	public String[] getPassword() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[2];
		}
		return col;
	}

	/**
	 * Gets the fname
	 * @return Returns a String
	 */
	public String[] getFname() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[3];
		}
		return col;
	}

	/**
	 * Gets the begin_date
	 * @return Returns a String
	 */
	public String[] getBegin_date() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[4];
		}
		return col;
	}

	/**
	 * Gets the end_date
	 * @return Returns a String
	 */
	public String[] getEnd_date() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[5];
		}
		return col;
	}

	/**
	 * Gets the create_by
	 * @return Returns a String
	 */
	public String[] getCreate_by() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[6];
		}
		return col;
	}

	/**
	 * Gets the create_date
	 * @return Returns a String
	 */
	public String[] getCreate_date() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[7];
		}
		return col;
	}

	/**
	 * Gets the user_type
	 * @return Returns a String
	 */
	public String[] getUser_type() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[8];
		}
		return col;
	}

	/**
	 * Gets the title_code
	 * @return Returns a String
	 */
	public String[] getTitle_code() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[9];
		}
		return col;
	}

	/**
	 * Gets the title_name
	 * @return Returns a String
	 */
	public String[] getTitle_name() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[10];
		}
		return col;
	}


	/**
	 * Gets the update_by
	 * @return Returns a String
	 */
	public String[] getUpdate_by() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[11];
		}
		return col;
	}

	/**
	 * Gets the last_update
	 * @return Returns a String
	 */
	public String[] getLast_update() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[12];
		}
		return col;
	}

	/**
	 * Gets the question
	 * @return Returns a String
	 */
	public String[] getQuestion() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[13];
		}
		return col;
	}
	/**
	 * Gets the answer
	 * @return Returns a String
	 */
	public String[] getAnswer() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[14];
		}
		return col;
	}
	/**
	 * Gets the cat_id
	 * @return Returns a String
	 */
	public String[] getCat_id() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[15];
		}
		return col;
	}
	/**
	 * Gets the office_id
	 * @return Returns a String
	 */
	public String[] getOffice_id() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[16];
		}
		return col;
	}
	/**
	 * Gets the zone_code
	 * @return Returns a String
	 */
	public String[] getZone_code() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[17];
		}
		return col;
	}
	/**
	 * Gets the birth_date
	 * @return Returns a String
	 */
	public String[] getBirth_date() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[18];
		}
		return col;
	}
	/**
	 * Gets the hr_name
	 * @return Returns a String
	 */
	public String[] getHr_name() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[19];
		}
		return col;
	}
	/**
	 * Gets the hr_surname
	 * @return Returns a String
	 */
	public String[] getHr_surname() {
		String row[];
		int records = size();
		String col[] = new String[records];
		for (int at=0; at<records; at++) {
			row = (String[])vectorList.elementAt(at);
			col[at] = row[20];
		}
		return col;
	}
	/**
	 * Gets the userid At
	 * @return Returns a String
	 */
	public String getUseridAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[0];
	}
	/**
	 * Gets the userid_seq At
	 * @return Returns a String
	 */
	public String getUserid_seqAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[1];
	}
	/**
	 * Gets the password At
	 * @return Returns a String
	 */
	public String getPasswordAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[2];
	}
	/**
	 * Gets the fname At
	 * @return Returns a String
	 */
	public String getFnameAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[3];
	}

	/**
	 * Gets the begin_date At
	 * @return Returns a String
	 */
	public String getBegin_dateAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[4];
	}
	/**
	 * Gets the end_date At
	 * @return Returns a String
	 */
	public String getEnd_dateAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[5];
	}
	/**
	 * Gets the create_by At
	 * @return Returns a String
	 */
	public String getCreate_byAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[6];
	}


	/**
	 * Gets the create_date At
	 * @return Returns a String
	 */
	public String getCreate_dateAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[7];
	}

	/**
	 * Gets the user_type At
	 * @return Returns a String
	 */
	public String getUser_typeAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[8];
	}
	/**
	 * Gets the title_code At
	 * @return Returns a String
	 */
	public String getTitle_codeAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[9];
	}
	/**
	 * Gets the title_name At
	 * @return Returns a String
	 */
	public String getTitle_nameAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[10];
	}
	
	/**
	 * Gets the update_by At
	 * @return Returns a String
	 */
	public String getUpdate_byAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[11];
	}
	/**
	 * Gets thelast_update At
	 * @return Returns a String
	 */
	public String getLast_updateAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[12];
	}
	/**
	 * Gets the question At
	 * @return Returns a String
	 */
	public String getQuestionAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[13];
	}
	/**
	 * Gets the answer At
	 * @return Returns a String
	 */
	public String getAnswerAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[14];
	}
	/**
	 * Gets the cat_id At
	 * @return Returns a String
	 */
	public String getCat_idAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[15];
	}
	/**
	 * Gets the office_id At
	 * @return Returns a String
	 */
	public String getOffice_idAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[16];
	}
	/**
	 * Gets the zone_code At
	 * @return Returns a String
	 */
	public String getZone_codeAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[17];
	}
	/**
	 * Gets the birth_date At
	 * @return Returns a String
	 */
	public String getBirth_dateAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[18];
	}
	/**
	 * Gets the hr_name At
	 * @return Returns a String
	 */
	public String getHr_nameAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[19];
	}
	/**
	 * Gets the Hr_surname At
	 * @return Returns a String
	 */
	public String getHr_surnameAt(int at) {
		String row[];
		if ( (at >= getSize() ) || (getSize() == 0 ) )
			return "";
		row = (String[])vectorList.elementAt(at);
		return row[20];
	}
	/**
	 * Sets the userid.
	 * @param userid The userid to set
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}

	/**
	 * Sets the userid_seq.
	 * @param userid_seq The userid_seq to set
	 */
	public void setUserid_seq(String userid_seq) {
		if (userid_seq == null || userid_seq.compareTo("")==0)
			this.userid_seq = "0";
		else
			this.userid_seq = userid_seq;
	}

	/**
	 * Sets the update_by.
	 * @param update_by The update_by to set
	 */
	public void setUpdate_by(String update_by) {
		this.update_by = update_by;
	}

	/**
	 * Sets the last_update.
	 * @param last_update The last_update to set
	 */
	public void setLast_update(String last_update) {
		if (last_update == null || last_update.compareTo("")==0)
			this.last_update = null;
		else
			this.last_update = "'" + last_update + "'";
	}
	/**
	 * Sets the begin_date.
	 * @param begin_date The begin_date to set
	 */
	public void setBegin_date(String begin_date) {
		if (begin_date == null || begin_date.compareTo("")==0)
			this.begin_date = null;
		else
			this.begin_date = "'" + begin_date + "'";
	}

	/**
	 * Sets the create_by.
	 * @param create_by The create_by to set
	 */
	public void setCreate_by(String create_by) {
		this.create_by = create_by;
	}

	/**
	 * Sets the create_date.
	 * @param create_date The create_date to set
	 */
	public void setCreate_date(String create_date) {
		if (create_date == null || create_date.compareTo("")==0)
			this.create_date = null;
		else
			this.create_date = "'" + create_date + "'";
	}

	/**
	 * Sets the end_date.
	 * @param end_date The end_date to set
	 */
	public void setEnd_date(String end_date) {
		if (end_date == null || end_date.compareTo("")==0)
			this.end_date = null;
		else
			this.end_date = "'" + end_date + "'";
	}

	/**
	 * Sets the fname.
	 * @param fname The fname to set
	 */
	public void setFname(String fname) {
		this.fname = fname;
	}

	/**
	 * Sets the password.
	 * @param password The password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * @param string
	 */
	public void setTitle_code(String string) {
		title_code = string;
	}

	/**
	 * @param string
	 */
	public void setTitle_name(String string) {
		title_name = string;
	}

	/**
	 * @param string
	 */
	public void setUser_type(String string) {
		user_type = string;
	}
	/**
	 * @param string
	 */
	public void setQuestion(String string) {
		question = string;
	}
	/**
	 * @param string
	 */
	public void setAnswer(String string) {
		answer = string;
	}
	/**
	 * @param cat_id The cat_id to set.
	 */
	public void setCat_id(String cat_id) {
		this.cat_id = cat_id;
	}
	/**
	 * @param office_id The office_id to set.
	 */
	public void setOffice_id(String office_id) {
		this.office_id = office_id;
	}
	/**
	 * @param zone_code The zone_code to set.
	 */
	public void setZone_code(String zone_code) {
		this.zone_code = zone_code;
	}
	/**
	 * @param birth_date The birth_date to set.
	 */
	public void setBirth_date(String birth_date) {
		if (birth_date == null || birth_date.compareTo("")==0)
			this.birth_date = null;
		else
			this.birth_date = "'" + birth_date + "'";
	}
	/**
	 * @param hr_name The hr_name to set.
	 */
	public void setHr_name(String hr_name) {
		this.hr_name = hr_name;
	}
	/**
	 * @param hr_surname The hr_surname to set.
	 */
	public void setHr_surname(String hr_surname) {
		this.hr_surname = hr_surname;
	}

}

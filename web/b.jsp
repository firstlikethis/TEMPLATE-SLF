<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*"%>
<%@page import="SLF_TOOL.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.pccth.utils.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="java.io.FileReader"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%String contextPath = request.getContextPath();%><!--  #importtant -->
<%
	String userid = new String();
    String isLoggedin = new String();
    String appID1 = new String();
	if (session.getAttribute("isLoggedin") != null) {
        isLoggedin = (String) session.getAttribute("isLoggedin"); //เก็บ sesseion ชื่อ isLoggedin ไว้ในตัวแปรชื่อ isLoggedin
        userid = (String) session.getAttribute("userid");
        appID1 = (String) session.getAttribute("AppId1");
    }
    request.setCharacterEncoding("utf-8"); 
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
	
	request.setCharacterEncoding("windows-874");
	String PageFile="/jsp/pro_fund/SLFPRO006_r.jsp";  //#importtant
	
	String pid=request.getParameter("pid");
	
	Connection con = null;
	ResultSet rs=null;
	Statement stmt=null;

	String sql="";

   try {
        	con = getOra_DB.getConnection(false);		

			
			sql="select * from slf_deb3.promotion where active_flag='Y' and pid='"+pid+"' ";
			stmt=con.createStatement();
			rs=stmt.executeQuery(sql);
			if(rs.next()){
				out.print(rs.getString("remark"));
			}rs.close(); stmt.close();

   	}catch (Exception e) {
        	out.print("Err SLFPRO006_r.jsp=" + e.toString());
        if(con!=null){
        	con.rollback();
        	con.close();
        }
    } finally {
        if(rs!=null){rs.close();}
        if(stmt!=null){stmt.close();}
        if(con!=null){
        	con.commit();
        	con.close();
        }   
    }
%>
<%-- 
    Document   : mainmenu
    Created on : Mar 3, 2018, 8:04:04 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="SLF_TOOL.*"%>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String appID = request.getParameter("AppID");
    
    request.setCharacterEncoding("windows-874"); 
	String contextPath = request.getContextPath();
    
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    String sql = "";
	//out.print("session.getAttribute(isLoggedin)="+session.getAttribute("isLoggedin"));
    try {

        con = getOra_DB.getConnection(false);
        //stmtm = conm.createStatement();
        //Check username and password
		/*
        sql="select userid, userpass from slf_tst.userlogin where userid='"+username+"' and userpass='"+password+"' and active_flag='Y'";
        stmt = con.createStatement();
        rs = stmt.executeQuery(sql);
        if(rs.next()){
            session.setAttribute("isLoggedin", "yes"); //สร้าง session ชื่อ isLoggedin มี value="yes"
            session.setAttribute("userid", username);
            session.setAttribute("AppId1", appID);
            //out.print("<script>alert('Login successful');</script>");
            //out.print("Login successful");
        }else{
            session.setAttribute("isLoggedin", null); 
            session.setAttribute("userid", null);
            
            out.print("<script>alert('User name or Password Fail!');</script>");
        }
        rs.close();stmt.close();
		*/
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      
        <title></title>
    </head>
    <body>
        <%@ include file="menubar.jsp" %>
        <%//=getMenu.setMainMenu(request,"")%>
       
    </body>
</html>
<%

        }  catch (Exception e) {
        out.print("Err Menu=" + e.toString());

        //rsm.close();
        //stmtm.close();
        //if(conm!=null){
        //conm.rollback();
        con.close();
        //}

    } finally {

        //rsm.close();
        //stmtm.close();
        //if(conm!=null){
        //conm.commit();
        con.close();
        //}   
    }
%>
<%-- 
    Document   : mainmenu
    Created on : Octuber, 2023, 20:04:04 PM
    Author     : Chakkri
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
        
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      
        <title></title>
    </head>
    <body>
        <%@ include file="menubar.jsp" %> 
       
    </body>
</html>
<%

        }  catch (Exception e) {
        out.print("Err Menu=" + e.toString());
 
        con.close();
        //}

    } finally {
 
        con.close();
        //}   
    }
%>
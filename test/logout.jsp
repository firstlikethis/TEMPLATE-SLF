<%-- 
    Document   : Logout
    Created on : Octuber, 2023, 9:07:57 AM
    Author     : Chakkri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    session.setAttribute("isLoggedin", null); 
    session.setAttribute("userid", null);
    
    out.print("<script>window.location.replace('Login.jsp');</script>");
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>

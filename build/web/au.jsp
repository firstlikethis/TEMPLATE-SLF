<%-- 
    Document   : au
    Created on : 27 มี.ค. 2561, 10:52:44
    Author     : T
--%>

<%@page contentType="text/html" pageEncoding="x-windows-874"%>
<%@page import="SLF_TOOL.Au"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=x-windows-874">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
        Au aa=new Au();
        
        String b=aa.getAD("user01", "P@ssw0rd");
        out.print("AD="+b);       
        %>
    </body>
</html>

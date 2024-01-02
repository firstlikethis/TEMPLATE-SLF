<%-- 
    Document   : l2
    Created on : Mar 23, 2022, 1:56:58 PM
    Author     : Trisorn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.NamingEnumeration"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.directory.Attribute"%>
<%@page import="javax.naming.directory.DirContext"%>
<%@page import="javax.naming.directory.InitialDirContext"%>
<%@page import="javax.naming.directory.SearchControls"%>
<%@page import="javax.naming.directory.SearchResult"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            String ou = "";
            String tmpChk = "";
            try {
                Hashtable props = new Hashtable();
                props.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
                //props.put(Context.PROVIDER_URL, "ldap://10.1.10.1:389");
                props.put(Context.PROVIDER_URL, "ldap://192.168.40.2:389");
                props.put(Context.SECURITY_PRINCIPAL, "trisornv" + "@studentloan.or.th");
            //props.put(Context.SECURITY_PRINCIPAL, "OU=SLF_USER");
                //props.put(Context.SECURITY_PRINCIPAL, uid + "@studentloan.or.th,OU=SLF_USER,DC=studentloan,DC=or,DC=th");
                //props.put(Context.SECURITY_AUTHENTICATION, uid);
                props.put(Context.SECURITY_CREDENTIALS, "montab");

                InitialDirContext context = new InitialDirContext(props);
                ou = context.toString();

                tmpChk = "Y";
            } catch (NamingException ex) {
                //Logger.getLogger(Au.class.getName()).log(Level.SEVERE, null, ex);
                ou = "Err=" + ex.toString();
                tmpChk = "N";
            }
            
            
            out.print("<br>tmpChk="+tmpChk+"<br>");
        %>
    </body>
</html>

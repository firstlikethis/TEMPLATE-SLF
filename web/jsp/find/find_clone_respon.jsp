<%@ page contentType="text/html; charset=windows-874" language="java" import="java.sql.*" %>
<%@ page import="com.pccth.utils.*"%>
<%@page import="SLF_TOOL.*"%>
<% 
	request.setCharacterEncoding("windows-874");   //------แก้ปัญหาใช้ภาษาไทยไม่ได้
	String contextPath = request.getContextPath();
%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=windows-874"/>
<meta name="viewport" content="width=device-width, initial-scale=1">  		
<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap.css">
<script src="<%=contextPath%>/jquery-3.1.1.min.js"></script>
<script src="<%=contextPath%>/js/bootstrap.min.js"></script>

<script>
	//var formCurrent1=window.opener.document.form1;
	//document.form1.hh.value=formCurrent1.hminitry.value;

	function onClone(){
		var formCurrent=window.opener.document.form1;
		if(document.getElementById("tUserID").value!=""){
				formCurrent.userClone.value=document.getElementById("tUserID").value;
				
				window.opener.onClone();
				
				window.close();
		}
	}
	
</script>

<style type="text/css">
<!--
body {
	background-color: #006699;
}
.style1 {color: #FFFFFF}
-->
</style></head>
<body><br>
<form name="form1" method="post" class="form-inline">
<table width="87%" border="0" align="center" bgcolor="#FFFFFF">
  <tr>
    <td height="26">
			<label><span class="style1">User ID for clone responsibility</span></label>
	  		<input class="form-control" type="text" id="tUserID" name="tUserID" placeholder="Input User ID" ><input type="button" class="form-control"  value="OK" onClick="onClone();"></td>
    </tr>
</table>
</form>
</body>
</html>

<%//@ page contentType="text/html" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="SLF_TOOL.*"%>

<%  //For check Authen
    String userid = new String();
    String isLoggedin = new String();
    String appID1 = new String();
    
    if (session.getAttribute("isLoggedin") != null) {
        isLoggedin = (String) session.getAttribute("isLoggedin"); //เก็บ sesseion ชื่อ isLoggedin ไว้ในตัวแปรชื่อ isLoggedin
        userid = (String) session.getAttribute("userid");
        appID1 = (String) session.getAttribute("AppId1");
    }
     
    if (isLoggedin.equals("yes")) {
                //out.print("Welcome. You are authorized to view this page.");
    } else {
        //out.print("<script>Alert('Verify Fail...Please Login.');</script>");
        out.print("<script>window.location.replace('Login.jsp');</script>");
    }

    //request.setCharacterEncoding("windows-874"); 
	//String contextPath = request.getContextPath();
    
    Connection conm = null;
    Statement stmtm = null, stmts = null;
    ResultSet rsm = null, rss = null;
    String sqlm = "", sqls = "";
	
	String mainmenu="/mainmenu.jsp";

    try {

        conm = getOra_DB.getConnection(false);
        //stmtm = conm.createStatement();
        //out.print(conm);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">  
		<!--      
        <link rel="stylesheet" href="styles/asom/css/font-awesome.min.css">
        <link rel="stylesheet" href="styles/responsive.css">
		-->
		<link rel="stylesheet" href="<%=contextPath%>/css/bootstrap.css">
		<script src="<%=contextPath%>/jquery-3.1.1.min.js"></script>
		<script src="<%=contextPath%>/js/bootstrap.min.js"></script>
        
        <!--<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>-->
		<style>
			.navbar-inverse {
				 background-color: #006699;
				 border-color: #006699;
			}
 		</style>
	<script>
	
	var newWin=null;
	
	function onLoading(pageURL, title, w, h) {
       var left = (screen.width - w) / 2;
       var top = (screen.height - h) / 4;  // for 25% - devide by 4  |  for 33% - devide by 3
	   
       newWin=window.open(pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
	  
		newWin.focus();
	
	} 
	
	function onCloseLoading(){
		newWin.focus();
		
		setTimeout(function(){		
			newWin.close();
		},1000);
		
	}
		
	function clkExit() {
		var txt;
		var r = confirm("Do you want to Exit Program!");
		if (r == true) {
			window.location.replace('<%=contextPath%>/Logout.jsp');
		} else {
			
		}    
	}
	
	function onExit(){
		var txt;
		var r = confirm("Do you want to Exit Program!");
		if (r == true) {
			//window.location.replace('<%//=contextPath%>/mainmenu.jsp');
			var f1=document.subform1;
			f1.url.value="<%=mainmenu%>";         
			f1.action="<%=contextPath%>/Page.php";
			f1.submit();
		} else {
			
		}  
	}
	
	function clkScreen(urlP){
		//window.location.replace(pageURL);
		var f1=document.subform1;
		f1.url.value=urlP;         
		f1.action="<%=contextPath%>/Page.php";
		f1.submit();
	}
	
	function OpenPopup(pageURL, title, w, h) {
       var left = (screen.width - w) / 2;
       var top = (screen.height - h) / 4;  // for 25% - devide by 4  |  for 33% - devide by 3
       var ww=window.open("<%=contextPath%>"+pageURL, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
	   if (window.focus) {
			ww.focus();
		}
	} 
	
	function NumericValue(evt) {
	  var theEvent = evt || window.event;
	  var key = theEvent.keyCode || theEvent.which;
	  key = String.fromCharCode( key );
	  var regex = /[0-9]|\./;
	  if( !regex.test(key) ) {
		theEvent.returnValue = false;
		if(theEvent.preventDefault) theEvent.preventDefault();
	  }
	}
	
	function goPage(urlP){
			var f1=document.subform1;
			f1.url.value=urlP;         
			f1.action="<%=contextPath%>/Page.php";
			f1.submit();
	}
	
	</script>
    
    <body>
<form name="subform1" id="subform1" method="post">
	<input type="hidden" name="url" id="url">

        <div>
            <br><img src="<%=contextPath%>/img/slflogo.png" width="10%" height="5%"><br><br>
        </div>
		<nav class="navbar navbar-inverse">
		<div class="navbar-header">
		  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>                        
		  </button>
		  <a class="navbar-brand" href="#"><%=userid%></a>
		</div>
		
        <div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav">
                          
            <%
                //For Main menu            
                sqlm = "select distinct(a.MenuID), b.MenuName, b.seq_no "
                        + "from slf_sso.usermenu a "
                        + "inner join slf_sso.munusys b on a.MenuID=b.MenuID and b.Active_flag='Y' "
                        + "where a.USERID='"+userid+"' and a.AppID='"+appID1+"' and a.Active_flag='Y' order by b.seq_no";
                
                stmtm = conm.createStatement();
                rsm = stmtm.executeQuery(sqlm);			
                while (rsm.next()) {
					//fom main menu
                    out.print("<li class='dropdown'>");    				
     							
								out.print("<a class='dropdown-toggle' data-toggle='dropdown' href='#'>");         
								out.print("<img src='"+contextPath+"/img/list.png' width='20' height='20'>&nbsp;"+rsm.getString("MenuName")); 
								out.print("</a>");
								//out.print("<img src='img/list.png' width='20' height='20' >&nbsp;"+rsm.getString("MenuName")+"<span class='caret'></span></a>");                   
                                //for sub menu
                                out.print("<ul class='dropdown-menu'>");  
									sqls = "select b.ProName, b.filename "
                                            + "from slf_sso.usermenu a "
                                            + "inner join slf_sso.programsys b on a.ProID=b.ProID and b.Active_flag='Y' "
                                            + "where a.USERID='"+userid+"' and a.MenuID='"+rsm.getString(1)+"' and a.AppID='"+appID1+"' and a.Active_flag='Y' order by b.seq_no";
                                    stmts = conm.createStatement();
                                    rss = stmts.executeQuery(sqls);
									
                                    while (rss.next()) {
										out.print("<li><a onClick=\"goPage('"+rss.getString("filename")+"');\">"+rss.getString("ProName")+"</a></li>");	
										//out.print("<li><a href='"+ contextPath + rss.getString("filename")+"'>"+rss.getString("ProName")+"</a></li>");
									}rss.close();stmts.close();

								out.print("</ul>");
								
					out.print("</li>");
								
										
				
                    
                }          
            
                rsm.close();
                stmtm.close();
            %>        
			</ul>
			
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#" onClick="clkExit();">
				<!--<li><a href="#" data-toggle="modal" data-target="#login-modal">-->
				  <span id="loginBtn2" required autofocus><img src='<%=contextPath%>/img/close.png' width='20' height='20'> Logout</span>
				  <!-- <span class="glyphicon glyphicon-log-in" id="loginBtn2" required autofocus><img src='img/close.png' width='20' height='20'> Logout</span> -->
				  <span class="glyphicon glyphicon-log-out" style="display:none;" id="logOutBtn" required> Logout</span></a></li>
			</ul>
        </div>
		</nav>
		
        <div style="padding-left:16px">   
            
            <!--
            <h2>Responsive Topnav with Dropdown</h2>
            <p>Resize the browser window to see how it works.</p>
            <p>Hover over the dropdown button to open the dropdown menu.</p>
            -->
        </div>

        
</form>

    </body>
</html>
<%

        }  catch (Exception e) {
        out.print("Err Menu=" + e.toString());

        //rsm.close();
        //stmtm.close();
        //if(conm!=null){
        //conm.rollback();
        conm.close();
        //}

    } finally {

        //rsm.close();
        //stmtm.close();
        //if(conm!=null){
        //conm.commit();
        conm.close();
        //}   
    }
%>

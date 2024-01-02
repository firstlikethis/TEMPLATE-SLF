<%-- 
    Document   : menubar
    Created on : Octuber, 2023, 20:04:04 PM
    Author     : Chakkri
--%>

<%@ page pageEncoding="windows-874" contentType="text/html; charset=windows-874" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="SLF_TOOL.*"%>

<%  
	
	String contextPath = request.getContextPath();
	//For check Authen
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
        out.print("<script>window.location.replace('" + contextPath + "/Login.jsp');</script>");
    }

    Connection conm = null;
    Statement stmtm = null, stmts = null,stmta=null,sstmt=null;
    ResultSet rsm = null, rss = null,rsa=null,rrs=null;
    String sqlm = "", sqls = "",sqla="",ssql="";
	
	  String mainmenu="/mainmenu.jsp";

    try {

        conm = getOra_DB.getConnection(false);
        //stmtm = conm.createStatement();
        //out.print(conm);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="windows-874">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/css/all.min.css";>
	<link rel="stylesheet" href="<%=contextPath%>/css/adminlte.min.css";>
    <link rel="stylesheet" href="<%=contextPath%>/css/tempusdominus-bootstrap-4.min.css";>
    <link rel="stylesheet" href="<%=contextPath%>/css/icheck-bootstrap.min.css";>
    <link rel="stylesheet" href="<%=contextPath%>/css/jqvmap.min.css";>
    <link rel="stylesheet" href="<%=contextPath%>/css/OverlayScrollbars.min.css";>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>

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

        function tmout(){
            
        }
		
	</script>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
        <!-- Navbar -->
        <nav class="main-header navbar navbar-expand navbar-white navbar-light">
            <!-- Left navbar links -->
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                </li>
                <li class="nav-item d-none d-sm-inline-block">
                    <%
                        String directPage = ""; 
                        ssql = "SELECT * FROM slf_sso.programsys WHERE appid = '" + appID1 + "' AND promain = 'Y'";
                        
                        //out.print(ssql);
                        sstmt = conm.createStatement();
                        rrs = sstmt.executeQuery(ssql);
                        if (rrs.next()) {
                            directPage = Tools.chkNull(rrs.getString("filename"));
                            if (appID1.equals("00001")) {
                    %>
                                <a href="<%= contextPath + directPage %>" class="nav-link">หน้าหลัก</a>
                    <%
                            } else {
                    %>
                                <a href="<%= contextPath + directPage %>" class="nav-link">หน้าหลัก</a>
                    <%
                            }
                        }
                        sstmt.close();
                        rrs.close();
                    %>
                </li>
                <li class="nav-item d-none d-sm-inline-block">
                    <a href="#" class="nav-link">ติดต่อเรา</a>
                </li>
            </ul>

            <!-- Right navbar links -->
            <ul class="navbar-nav ml-auto">
            <!-- Navbar Search -->
            <li class="nav-item">
                <a class="nav-link" data-widget="navbar-search" href="#" role="button">
                <i class="fas fa-search"></i>
                </a>
                <div class="navbar-search-block">
                <form class="form-inline">
                    <div class="input-group input-group-sm">
                    <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
                    <div class="input-group-append">
                        <button class="btn btn-navbar" type="submit">
                        <i class="fas fa-search"></i>
                        </button>
                        <button class="btn btn-navbar" type="button" data-widget="navbar-search">
                        <i class="fas fa-times"></i>
                        </button>
                    </div>
                    </div>
                </form>
                </div>
            </li>

            <li class="nav-item">
                <a class="nav-link" data-widget="fullscreen" href="#" role="button">
                    <i class="fas fa-expand-arrows-alt"></i>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-widget="control-sidebar" data-controlsidebar-slide="true" href="#" role="button">
                <i class="fas fa-th-large"></i>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%=contextPath%>/Logout.jsp" role="button">
                <i class="fas fa-sign-out-alt"></i>
                </a>
            </li>
            </ul>
        </nav>
        <!-- /.navbar -->

      <!-- Main Sidebar Container -->
      <aside class="main-sidebar sidebar-dark-primary elevation-4">
        <!-- Brand Logo -->
         <%
            String directPage1 = ""; 
            ssql = "SELECT * FROM slf_sso.programsys WHERE appid = '" + appID1 + "' AND promain = 'Y'";
            
            //out.print(ssql);
            sstmt = conm.createStatement();
            rrs = sstmt.executeQuery(ssql);
            if (rrs.next()) {
                directPage1 = Tools.chkNull(rrs.getString("filename"));
                if (appID1.equals("00001")) {
        %>
                <a href="<%= contextPath + directPage1 %>" class="brand-link">
                    <img src="<%=contextPath%>/img/AdminLTELogo.png" alt="SLF Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
                    <span class="brand-text font-weight-light"><b>SLF</b> Template</span>
                </a>
        <%
                } else {
        %>
                <a href="<%= contextPath + directPage1 %>" class="brand-link">
                    <img src="<%=contextPath%>/img/AdminLTELogo.png" alt="SLF Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
                    <span class="brand-text font-weight-light"><b>SLF</b> Template</span>
                </a>
        <%
                }
            }
            sstmt.close();
            rrs.close();
        %>

        </a>

        <!-- Sidebar -->
        <div class="sidebar">
          <!-- Sidebar user panel (optional) -->
          <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <div class="image">
                <img src="<%=contextPath%>/img/avata.jpg" class="img-circle elevation-2" alt="User Image">
            </div>
            <div class="info">
                <%
                    String directPage2 = ""; 
                    ssql = "SELECT * FROM slf_sso.programsys WHERE appid = '" + appID1 + "' AND promain = 'Y'";
                    
                    //out.print(ssql);
                    sstmt = conm.createStatement();
                    rrs = sstmt.executeQuery(ssql);
                    if (rrs.next()) {
                        directPage2 = Tools.chkNull(rrs.getString("filename"));
                        if (appID1.equals("00001")) {
                %>
                            <a href="<%= contextPath + directPage2 %>" class="d-block"> สวัสดีคุณ ผู้ดูแลระบบ</a>
                <%
                        } else {
                %>
                            <a href="<%= contextPath + directPage2 %>" class="d-block"> สวัสดีคุณ <% out.print(""+userid+""); %></a>
                <%
                        }
                    }
                    sstmt.close();
                    rrs.close();
                %>
                
            </div>
          </div>

          <!-- SidebarSearch Form -->
          <div class="form-inline">
            <div class="input-group" data-widget="sidebar-search">
              <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
              <div class="input-group-append">
                <button class="btn btn-sidebar">
                  <i class="fas fa-search fa-fw"></i>
                </button>
              </div>
            </div>
          </div>

          <!-- Sidebar Menu -->
          <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                <li class="nav-item menu-open">

                    <%
                        String directPage3 = ""; 
                        ssql = "SELECT * FROM slf_sso.programsys WHERE appid = '" + appID1 + "' AND promain = 'Y'";
                        
                        //out.print(ssql);
                        sstmt = conm.createStatement();
                        rrs = sstmt.executeQuery(ssql);
                        if (rrs.next()) {
                            directPage3 = Tools.chkNull(rrs.getString("filename"));
                            if (appID1.equals("00001")) {
                    %>
                                <a href="<%= contextPath + directPage3 %>" class="nav-link active"><i class="nav-icon fas fa-tachometer-alt"></i>
                                    <p>
                                        Dashboard
                                        <i class="right fas fa-angle-left"></i>
                                    </p>
                                </a>
                    <%
                            } else {
                    %>
                                <a href="<%= contextPath + directPage3 %>" class="nav-link active"><i class="nav-icon fas fa-tachometer-alt"></i>
                                    <p>
                                        Dashboard
                                        <i class="right fas fa-angle-left"></i>
                                    </p>
                                </a>
                    <%
                            }
                        }
                        sstmt.close();
                        rrs.close();
                    %>
              </li>

              <%
                // For Main menu            
                sqlm = "select distinct(a.MenuID), b.MenuName, b.seq_no, nvl(b.logo_menu, ' ') as logo_menu "
                    + "from slf_sso.usermenu a "
                    + "inner join slf_sso.munusys b on a.MenuID=b.MenuID and b.Active_flag='Y' "
                    + "where a.USERID='" + userid + "' and a.AppID='" + appID1 + "' and a.Active_flag='Y' order by b.seq_no";

                stmtm = conm.createStatement();
                rsm = stmtm.executeQuery(sqlm);

                while (rsm.next()) {
                    // For main menu
                    String logo_menu = Tools.chkNull(rsm.getString("logo_menu"));
                %>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="nav-icon <%out.print(logo_menu);%>"></i>
                            <p>
                                <%= rsm.getString("MenuName") %>
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <%
                            // For sub menu
                            sqls = "select b.ProName, b.filename "
                                + "from slf_sso.usermenu a "
                                + "inner join slf_sso.programsys b on a.ProID=b.ProID and b.Active_flag='Y' "
                                + "where a.USERID='" + userid + "' and a.MenuID='" + rsm.getString(1) + "' and a.AppID='" + appID1 + "' and a.Active_flag='Y' order by b.seq_no";

                            stmts = conm.createStatement();
                            rss = stmts.executeQuery(sqls);

                            while (rss.next()) {
                            %>
                                <li class="nav-item">
                                    <a href="<%= contextPath + rss.getString("filename") %>" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p><%= rss.getString("ProName") %></p>
                                    </a>
                                </li>
                            <%
                            }
                            rss.close();
                            stmts.close();
                            %>
                        </ul>
                    </li>
                <%
                }
                rsm.close();
                stmtm.close();
                %>


            </ul>
          </nav>
          <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
      </aside>



    <script src="<%=contextPath%>/js/jquery.min.js"></script>
	<script src="<%=contextPath%>/js/jquery-ui.min.js"></script>
	<script src="<%=contextPath%>/js/bootstrap.bundle.min.js"></script>
	<script src="<%=contextPath%>/js/sparkline.js"></script>
	<script src="<%=contextPath%>/js/jquery.vmap.min.js"></script>
	<script src="<%=contextPath%>/js/jquery.vmap.usa.js"></script>
	<script src="<%=contextPath%>/js/jquery.knob.min.js"></script>
	<script src="<%=contextPath%>/js/moment.min.js"></script>
	<script src="<%=contextPath%>/js/tempusdominus-bootstrap-4.min.js"></script>
	<script src="<%=contextPath%>/js/jquery.overlayScrollbars.min.js"></script>
	<script src="<%=contextPath%>/js/dashboard.js"></script>
	<script src="<%=contextPath%>/js/bootstrap.min.js"></script>
	<script src="<%=contextPath%>/js/adminlte.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.full.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.8/clipboard.min.js"></script>

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


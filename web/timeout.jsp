<%-- 
    Document   : time out
    Created on : Octuber, 2023, 8:04:04 PM
    Author     : Chakkri
--%>


<%@ page pageEncoding="windows-874" contentType="text/html; charset=windows-874" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="SLF_TOOL.*"%>
<%@ page import="com.pccth.utils.*"%>
<!DOCTYPE html>
<%
    request.setCharacterEncoding("windows-874"); 
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

    out.print("<br>userid="+userid);
    out.print("<br>appID1="+appID1);
     
    String username = Tools.chkNull(request.getParameter("username"));
    //out.print("<br>us="+username);
    String password = Tools.chkNull(request.getParameter("password"));
    //out.print("<br>p="+password);
    String appID = Tools.chkNull(request.getParameter("AppID"));
    //out.print("<br>appID="+appID);

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    String sql = "";

    try {
      con = getOra_DB.getConnection(false);	
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="windows-874">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
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

</head>
<body class="hold-transition lockscreen">
        <!-- Automatic element centering -->
        <div class="lockscreen-wrapper">
            <div class="lockscreen-logo">
                <a href="../../index2.html"><b>Admin</b>LTE</a>
            </div>
            <!-- User name -->
            <div class="lockscreen-name">John Doe</div>

            <!-- START LOCK SCREEN ITEM -->
            <div class="lockscreen-item">
            <!-- lockscreen image -->
            <div class="lockscreen-image">
                <img src="../../dist/img/user1-128x128.jpg" alt="User Image">
            </div>
            <!-- /.lockscreen-image -->

            <!-- lockscreen credentials (contains the form) -->
            <form class="lockscreen-credentials">
            <div class="input-group">
                <input type="password" class="form-control" placeholder="password">

                <div class="input-group-append">
                <button type="button" class="btn">
                    <i class="fas fa-arrow-right text-muted"></i>
                </button>
                </div>
            </div>
            </form>
            <!-- /.lockscreen credentials -->

        </div>
        <!-- /.lockscreen-item -->
        <div class="help-block text-center">
            Enter your password to retrieve your session
        </div>
        <div class="text-center">
            <a href="login.html">Or sign in as a different user</a>
        </div>
        <div class="lockscreen-footer text-center">
            Copyright &copy; 2014-2021 <b><a href="https://adminlte.io" class="text-black">AdminLTE.io</a></b><br>
            All rights reserved
        </div>
        </div>
        <!-- /.center -->


 
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

</body>
</html>
<%
    } catch (Exception e) {
      out.print("Err Menu=" + e.toString());
    if(con!=null){
      //con.rollback();
      con.close();
    }

  } finally {
    if(rs!=null){rs.close();}
    if(stmt!=null){stmt.close();}
    if(con!=null){
      //con.commit();
      con.close();
    }   
  }
%>
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

    String username = Tools.chkNull(request.getParameter("username"));
    //out.print("<br>us="+username);
    String password = Tools.chkNull(request.getParameter("password"));
    //out.print("<br>p="+password);
    String appID = Tools.chkNull(request.getParameter("AppID"));
    //out.print("<br>appID="+appID);
    //Flag
    String lgFlag = Tools.chkNull(request.getParameter("lgFlag"));
    
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

    

    <style>
      body {
        background-image: url('<%=contextPath%>/img/bg.jpg');
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        background-repeat: no-repeat;
        margin: 0;
      }
    </style>
    <script>
      function onSubmit(){
        const f1 = document.getElementById("formLogin");
        if(f1.username.value == ""){
          alert("กรุณากรอกชื่อผู้ใช้");
          f1.username.focus();
        }else if(f1.password.value == ""){
          alert("กรุณากรอกรหัสผ่าน");
          f1.password.focus();
        }else{
          f1.lgFlag.value="Y";
          //alert(f1.lgFlag.value);
          f1.submit();
        }
      }

      function redirected() {
        window.location = "<%=contextPath%>/jsp/dashboard.jsp";
      }

      function redirected2(){        
        window.location = "<%=contextPath%>/jsp/sys/SLFSYS000.jsp";
      }

    </script> 

</head>
<body class="hold-transition login-page">
    <div class="login-box">
        <div class="card">
            <div class="card-body login-card-body">
                <form action="" method="post" id="formLogin">
                    <input type="hidden" name="lgFlag" value="<%=lgFlag%>">
                    
                    <div class="login-logo">
                        <a href="<%=contextPath%>/Login.jsp"><b>SLF</b>TEMPLATE</a>
                    </div>
                    
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" name="username" id="username" placeholder="Username">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-user"></span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="input-group mb-3">
                        <input type="password" class="form-control" name="password" id="password" placeholder="Password">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <select name="AppID" id="AppID" class="form-control">
                            <%
                            sql = "select appid, appname from slf_sso.appsys where active_flag='Y' " +
                                  " and seq_no IN ('100', '15') order by seq_no";
                            stmt = con.createStatement();
                            rs = stmt.executeQuery(sql);
                            while (rs.next()) {
                            %>
                            <option value="<%=rs.getString("appid")%>"><%=rs.getString("appname")%></option>
                            <%
                            }
                            rs.close();
                            stmt.close();
                            %>
                        </select>
                    </div>
                    
                    <div class="row">
                        <div class="col-8">
                            <div class="icheck-primary">
                                <input type="checkbox" id="remember">
                                <label for="remember">Remember Me</label>
                            </div>
                        </div>
                        
                        <div class="col-4">
                            <button type="button" onClick="onSubmit();" class="btn btn-primary btn-block">Sign In</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
  <%
    if (lgFlag.equals("Y")) {
      //out.print(12);
      try {
        if (username.equals("admin")) {
            if (appID.equals("00001")) {
                sql = "select userid, userpass from slf_sso.userlogin where userid='" + username + "' and userpass='" + password + "' and active_flag='Y'";
                stmt = con.createStatement();
                rs = stmt.executeQuery(sql);
                if (rs.isBeforeFirst()) {
                    if (rs.next()) {
                        session.setAttribute("isLoggedin", "yes");
                        session.setAttribute("userid", username);
                        session.setAttribute("AppId1", appID);
                        out.print("<script>alert('เข้าสู่ระบบสำเร็จ');</script>");
                        out.print("<script>redirected2();</script>");
                    } else {
                        session.setAttribute("isLoggedin", null);
                        session.setAttribute("userid", null);
                        session.setAttribute("AppId1", null);
                        out.print("<script>alert('ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง!');</script>");
                    }
                } else {
                    out.print("<script>alert('ไม่สามารถเข้าสู่ระบบได้เนื่องจากไม่มีสิทธิ์');</script>");
                }
                rs.close();
                stmt.close();
            }else{
              out.print("<script>alert('กรุณาเลือกโปรแกรมสำหรับผู้ดูแลระบบ');</script>");
            }
        } else {
            if (appID.equals("00003")) {
              if (!username.equals("admin")) {
                Au au_key = new Au();
                String authen = au_key.getAD("" + username + "", "" + password + "");

                if (authen.equals("Y")) {
                    session.setAttribute("isLoggedin", "yes");
                    session.setAttribute("userid", username);
                    session.setAttribute("AppId1", appID);
                    out.print("<script>alert('เข้าสู่ระบบสำเร็จ');</script>");
                    out.print("<script>redirected();</script>");
                } else {
                    session.setAttribute("isLoggedin", null);
                    session.setAttribute("userid", null);
                    session.setAttribute("AppId1", null);
                    out.print("<script>alert('ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง!');</script>");
                }
              } else {
                out.print("<script>alert('กรุณาเลือกโปรแกรมสำหรับผู้ดูแลระบบ');</script>");
              }
            } else {
              out.print("<script>alert('ไม่สามารถเข้าสู่ระบบได้เนื่องจากไม่มีสิทธิ์');</script>");
            }
        }

    } catch (Exception ee) {
        out.print("Error Login=" + ee.toString());
    }

    }
  %>

  
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
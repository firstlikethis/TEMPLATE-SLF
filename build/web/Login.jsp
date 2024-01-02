<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    String password = Tools.chkNull(request.getParameter("password"));
    String appID = Tools.chkNull(request.getParameter("AppID"));
	String action = Tools.chkNull(request.getParameter("action"));
    
    String me="Login.jsp";
    
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    String sql = "";

    try {

        con = getOra_DB.getConnection(false);	
        
        //out.print("Connection="+con.toString()+"<BR>");
		
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="styles/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
        <script src="styles/jquery-1.11.3.min.js"></script>
        <script src="styles/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
        <title></title>
        
<style type="text/css">

  .ui-page { background: #0099CC;} /*สีพื้นหลัง*/


</style>
    </head>
    <script>
        function goLogin(){
            var f1=document.form1;
            //alert(f1.AppID.value);
            if(f1.username.value==""){
                alert('Please input username.');                
            }else if(f1.password.value==""){
                alert('Please input Password.');
            }else if(f1.AppID.value=="00000"){
                alert('Please select your Application.');  
                window.location.replace('Login.jsp');
                //location.reload();
            }else{         
				f1.action.value="Login";         
                f1.action="<%=me%>";
                f1.submit();
            }
        }
		
		function goMain(){
			var f1=document.form1;
			
			f1.url.value="mainmenu.jsp";         
            f1.action="<%=contextPath%>/Page.php";
            f1.submit();
		}
    </script>
    <body><br><br><br><br>        
        <form method="post" name="form1">
		<input type="hidden" name="url" id="url">
		<%
		if(action.equals("Login")){
			if(username.equals("admin")){ //กรณีใช้ user admin
					sql="select userid, userpass from slf_sso.userlogin where userid='"+username+"' and userpass='"+password+"' and active_flag='Y'";
					stmt = con.createStatement();
					rs = stmt.executeQuery(sql);
					if(rs.next()){
						session.setAttribute("isLoggedin", "yes"); //สร้าง session ชื่อ isLoggedin มี value="yes"
						session.setAttribute("userid", username);
						session.setAttribute("AppId1", appID);
						//out.print("<script>alert('Login successful');</script>");
						//out.print("Login successful");
						//out.print("<script>window.location.replace('mainmenu.jsp');</script>");
						out.print("<script>goMain();</script>");
						
					}else{
					
						session.setAttribute("isLoggedin", null); 
						session.setAttribute("userid", null);
						session.setAttribute("AppId1", null);
						
						out.print("<script>alert('User name or Password Fail!');</script>");
						
					}
					rs.close();stmt.close();	
			}else{ //กรณี Authen AD
			
					Au au_key=new Au();
        
					String authen=au_key.getAD(""+username+"", ""+password+"");
					
					if(authen.equals("Y")){ //Authen ผ่าน
						session.setAttribute("isLoggedin", "yes"); //สร้าง session ชื่อ isLoggedin มี value="yes"
						session.setAttribute("userid", username);
						session.setAttribute("AppId1", appID);
						//out.print("<script>alert('Login successful');</script>");
						//out.print("Login successful");
						//out.print("<script>window.location.replace('mainmenu.jsp');</script>");
						out.print("<script>goMain();</script>");
					}else{
						session.setAttribute("isLoggedin", null); 
						session.setAttribute("userid", null);
						session.setAttribute("AppId1", null);
						
						out.print("<script>alert('User name or Password Fail!');</script>");
					}
					 
			}
		}
		%>
	  <center><img src="img/slflogo.png" width="180" height="106">
	  </center>
          <table width="430" border="1" align="center" cellspacing="0" bordercolor="#00CCFF" bgcolor="#FFFFFF">
            <tr>
              <td align="center">
		<table width="98%" align="center">                
                <tr><td>Username :</td>
                </tr>
                <tr><td><input type="text" name="username" placeholder="Username"></td></tr>
                <tr><td>Password :</td></tr>
                <tr><td><input type="password" name="password" placeholder="Password"></td></tr>
                <tr>
                    <td>Application :                        
                        <select name="AppID" id="AppID" data-mini="true" data-icon="bullets">
                                <option value="00000">Select your Application</option>
                            <%
                                sql="select appid, appname from slf_sso.appsys where active_flag='Y' order by seq_no";
                                stmt = con.createStatement();
                                rs = stmt.executeQuery(sql);
                                while(rs.next()){
                            %>
                            <option value="<%=rs.getString("appid")%>"><%=rs.getString("appname")%></option>
                            <%
                                }rs.close(); stmt.close();
                            %>                           
                          </select>                        
                    </td>
                </tr>                
                <tr>
                  <td><button onClick="goLogin();">::Login::</button></td>
                </tr>
              </table>
              </td>
            </tr>
          </table>
		  <input type="hidden" name="action" id="action">
        </form>
		
    </body>
</html>
<%

        }  catch (Exception e) {
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
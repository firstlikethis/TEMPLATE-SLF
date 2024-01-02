/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SLF_TOOL;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.Calendar;
import java.util.Date;

import SLF_TOOL.*;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;

/**
 *
 * @author admin
 */
public class getMenu {

    public static String setMainMenu(HttpServletRequest request, String ProCode) throws SQLException, UnsupportedEncodingException {
        return setMainMenu(request, ProCode, "");
    }

    public static String setMainMenu(HttpServletRequest request, String ProCode, String tmp) throws SQLException, UnsupportedEncodingException {

        HttpSession session = request.getSession(true);
        String contextPath = request.getContextPath();
        StringBuffer html = new StringBuffer("");

        Connection conm = null;
        Statement stmtm = null, stmts = null;
        ResultSet rsm = null, rss = null;
        String sqlm = "", sqls = "";
        
        request.setCharacterEncoding("windows-874");
        
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
            html.append("<script>window.location.replace('Login.jsp');</script>");
        }

        

        //session.setAttribute("PROG_ID", prog_id);
        //AppSession appsession = (AppSession)session.getAttribute("APPSESSION");
        try {

            conm = getOra_DB.getConnection(false);
            
            html.append("<meta name='viewport' content='width=device-width, initial-scale=1'>");           

            html.append("<link rel='stylesheet' href='"+contextPath+"/styles/asom/css/font-awesome.min.css'>");
            html.append("<link rel='stylesheet' href='"+contextPath+"/styles/responsive.css'>");
            
            html.append("<script>");
                html.append("function clkExit() {");
                    html.append("var txt;");
                    html.append("var r = confirm('Do you want to Exit Program!');");
                    html.append("if (r == true) {");
                        html.append("window.location.replace('"+contextPath+"/Logout.jsp');");
                    html.append("} else {");
                        
                    html.append("}"); 
                html.append("}");
            html.append("</script>");
            
            html.append("<div><br><img src='"+contextPath+"/img/slflogo.jpg' width='10%' height='5%'><br></div>"); //Logo SLF
            
            html.append("<div class='topnav' id='myTopnav'>");
            html.append("<a href='#' class='active'><i class='fa fa-user'></i></a> ");//Icon user
                //Start gen Menu
                sqlm = "select distinct(a.MenuID), b.MenuName "
                        + "from usermenu a "
                        + "inner join munusys b on a.MenuID=b.MenuID and b.Active_flag='Y' "
                        + "where a.USERID='"+userid+"' and a.AppID='"+appID1+"' and a.Active_flag='Y'";
                stmtm = conm.createStatement();
                rsm = stmtm.executeQuery(sqlm);
                
                while (rsm.next()) {
                    html.append("<div class='dropdown'>");
                        html.append("<button class='dropbtn'>");
                                html.append(rsm.getString("MenuName")+"&nbsp;");  //MenuName                                
                                html.append("<i class='fa fa-th-list'></i>");
                          
                        html.append("</button>");//out.print("<button class='dropbtn'>");                        
                                html.append("<div class='dropdown-content'>");                
                                 
                                    //For get Sub menu                                    
                                    sqls = "select b.ProName, b.filename "
                                            + "from usermenu a "
                                            + "inner join programsys b on a.ProID=b.ProID and b.Active_flag='Y' "
                                            + "where a.USERID='"+userid+"' and a.MenuID='"+rsm.getString(1)+"' and a.AppID='"+appID1+"' and a.Active_flag='Y'";
                                    stmts = conm.createStatement();
                                    rss = stmts.executeQuery(sqls);
                                    while (rss.next()) {
                                        html.append("<a href='"+ contextPath + rss.getString("filename")+"'>"+rss.getString("ProName")+"</a>");
                                    }rss.close();stmts.close();
                                    
                                html.append("</div>");//out.print("<div class='dropdown-content'>"); 
                    html.append("</div>");//out.print("<div class='dropdown'>");
                    
                }rsm.close();stmtm.close();
                
                html.append("<a href='#' onclick='clkExit();'><i class='fa fa-power-off'></i></a>");
                html.append("<a href='javascript:void(0);' style='font-size:15px;' class='icon' onClick='myFunction()'>&#9776;</a>");
            
                html.append("<script>");
                    html.append("function myFunction() {");
                        html.append("var x = document.getElementById('myTopnav');");
                        html.append("if (x.className === 'topnav') {");
                            html.append("x.className += ' responsive';");
                        html.append("} else{");
                            html.append("x.className = 'topnav';");
                        html.append("}");
                    html.append("}");
                html.append("</script>");

        } catch (Exception e) {
            html.append("Err Menu Bean=" + e.toString());

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

       

        return html.toString();
    }
    
    public static void main(String[] args) throws SQLException {
        System.out.print("Build OK");
    }
}

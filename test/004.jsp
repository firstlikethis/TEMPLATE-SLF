<%-- 
    Document   : SLFSYS004
    Created on : Octuber, 2023, 3:23:45 PM
    Author     : Chakkri
--%>
<%@ page contentType="text/html; charset=windows-874" language="java" %>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="SLF_TOOL.*"%>
<%@ page import="com.pccth.utils.*"%>
<%@ include file="../../menubar.jsp"%> <!--  #importtant -->
<%
	request.setCharacterEncoding("windows-874"); 
    String PageMain="/jsp/sys/SLFSYS000.jsp";  //#importtant
	String PageFile="/jsp/sys/SLFSYS004.jsp";  //#importtant

    //Variable
	String tuser = Tools.chkNull(request.getParameter("tuser"));
    String appid = Tools.chkNull(request.getParameter("appid"));
    String menuid = Tools.chkNull(request.getParameter("menuid"));
    String proid = Tools.chkNull(request.getParameter("proid"));
    //out.print(tuser);


    //Flag
    String searchFlag = Tools.chkNull(request.getParameter("searchFlag"));
    String inFlag = Tools.chkNull(request.getParameter("inFlag"));
    String deFlag = Tools.chkNull(request.getParameter("deFlag"));
    String clFlag = Tools.chkNull(request.getParameter("clFlag"));
    String openModal = Tools.chkNull(request.getParameter("openModal"));
    String aID = Tools.chkNull(request.getParameter("aID"));

    //DELETE FLAG
    String aID2 = Tools.chkNull(request.getParameter("aID2"));
    String uID = Tools.chkNull(request.getParameter("uID"));
    String uAPP = Tools.chkNull(request.getParameter("uAPP"));
    String uMENU = Tools.chkNull(request.getParameter("uMENU"));
    String uPRO = Tools.chkNull(request.getParameter("uPRO"));


    //variable clone
    String cuser1 = Tools.chkNull(request.getParameter("cuser1"));
    String cuser2 = Tools.chkNull(request.getParameter("cuser2"));
    String cappid = Tools.chkNull(request.getParameter("cappid"));
    


	Connection con = null;
    Statement stmt = null,stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;
    ResultSet rs = null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
    String sql = "",sql1="",sql2="",sql3="",sql4="",sql5="";

    try {

        con = getOra_DB.getConnection(false);
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="windows-874">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Repository</title>

    <style>
        .icon-button {
            background: none;
            border: none;
            padding: 0;
            cursor: pointer;
        }


       .modal {
            animation: slideInAndFade 0.8s forwards;
            transition: opacity 0.9s;
        }

        .modal-dialog {
            animation: fadeIn 1s forwards;
        }

        @keyframes slideInAndFade {
            from {
                top: -100%;
            }
            to {
                top: 0;
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0.5;
            }
            to {
                opacity: 1;
            }
        }
    </style>

    <script> 

        //datatable search
        $(document).ready(function() {
            $('#example').DataTable();
        });

        //datatable program
        $(document).ready(function() {
            $('#example1').DataTable();
        });

        //datatable menu
        $(document).ready(function() {
            $('#example2').DataTable();
        });

        //datatable path file
        $(document).ready(function() {
            $('#example3').DataTable();
        });

        //modal
        $(document).ready(function () {
            $('#myModal').modal('show');
        });

        $(function () {
            $('#custom-tabs').on('click', 'a', function (e) {
                e.preventDefault();
                $(this).tab('show');
            });
        });

        $(function () {
            $('#custom-tabs2').on('click', 'a', function (e) {
                e.preventDefault();
                $(this).tab('show');
            });
        });

        
        //blockf12
        document.onkeydown = function (e) {
            if (e.key === "F12" || (e.key === "F12" && e.ctrlKey && e.shiftKey && e.altKey)) {
                e.preventDefault();
                return false;
            }
        };

        //block right click
        document.oncontextmenu = function (e) {
            e.preventDefault();
            return false;
        };

        function openMD(aID) {
            const f1 = document.getElementById("FormSearch");
            const aIDInput = document.getElementById("aIDInput");
            aIDInput.value = aID;
            //alert(aID);
            f1.openModal.value = "open";
            //alert(f1.openModal.value);
            f1.submit();
        }

    
        //จำกัดจำนวนปุ่ม
        function lockInput(txt, values) {
            var value = txt.value;
            if (value.length > values) {
                txt.value = value.slice(0, values);
            }
        }
         
        function search(){
            const f1 = document.getElementById("FormSearch");

            if(f1.tuser.value==""){
                alert("กรุณากรอกชื่อผู้ใช้งาน");
                f1.tuser.focus();
            }else{
                f1.searchFlag.value="Y";
                //alert(f1.searchFlag.value);
                f1.submit();
            }
        }

        function insert(aID2) {
            const f1 = document.getElementById("formUPmodal");
            const sendAID2 = document.getElementById("sendAID2");
            if(f1.appid.value==""){
                alert("กรุณาเลือกโปรแกรม");
                f1.appid.focus();
            }else if(f1.menuid.value==""){
                alert("กรุณาเลือกเมนู");
                f1.menuid.focus();
            }else if(f1.proid.value==""){
                alert("กรุณาเลือกที่อยู่โปรแกรม");
                f1.proid.focus();
            }else{
                sendAID2.value = aID2;
                f1.inFlag.value = "INSERT";
                //alert(f1.inFlag.value);
                f1.submit();
            }
        }

        //แก้ไขสิทธิ์
        function delUUID(uID,uAPP,uMENU,uPRO){
            const f1 = document.getElementById("editForm");
            //alert("1");
            const sendAID3 = document.getElementById("sendAID3");
            const sendAID4 = document.getElementById("sendAID4");
            const sendAID5 = document.getElementById("sendAID5");
            const sendAID6 = document.getElementById("sendAID6");
            sendAID3.value = uID;
            sendAID4.value = uAPP;
            sendAID5.value = uMENU;
            sendAID6.value = uPRO;
            f1.deFlag.value = "DELETE";
            //alert(uAPP);
            f1.submit();
        }

        //แก้ไขสิทธิ์
        function cloneMenu(){
            const f1 = document.getElementById("cloneForm");
            if(f1.cappid.value==""){
                alert("กรุณาเลือกโปรแกรม");
                f1.cappid.focus();
            }else if(f1.cuser2.value==""){
                alert("กรุณาเลือกผู้ให้โคลน");
                f1.cuser2.focus();
            }else{
                f1.clFlag.value = "CLONE";
                //alert(f1.clFlag.value);
                f1.submit();
            }

            
        }


        function success(txt) {
            if(txt === 'Y'){
                alert("เพิ่มเมนูสำเร็จ");
                window.location.href = "<%=contextPath%>/jsp/sys/SLFSYS004.jsp";
            }else if(txt === 'D'){
                alert("ลบเมนูสำเร็จ");
                window.location.href = "<%=contextPath%>/jsp/sys/SLFSYS004.jsp";
            }else if(txt === 'X'){
                alert("โคลนโปรแกรมสำเร็จ");
                window.location.href = "<%=contextPath%>/jsp/sys/SLFSYS004.jsp";
            }else{
                alert("อัปเดตเมนูสำเร็จ");
                window.location.href = "<%=contextPath%>/jsp/sys/SLFSYS004.jsp";
            }
        }
    </script>
</head>
<body class="hold-transition sidebar-mini layout-fixed">



    <%

       //อัพเดตโปรแกรม
        if(openModal.equals("open")){
            try{
    %>
            <!-- The Modal -->
            <div class="modal" id="myModal">
                <div class="modal-dialog modal-xl">
                    <div class="card">
                        <div class="modal-content">
                            <div class="card-header p-0">
                                <ul class="nav nav-tabs" id="custom-tabs2">
                                    <li class="nav-item">
                                        <a class="nav-link active" href="#addRole" data-toggle="tab">
                                            <i class="fas fa-user-plus"></i> เพิ่มสิทธิ์
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="#editRole" data-toggle="tab">
                                            <i class="fas fa-users-cog"></i> แก้ไขสิทธิ์
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="#cloneRole" data-toggle="tab">
                                            <i class="fas fa-user-friends"></i> โคลนเมนู
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="tab-content">
                                <div class="tab-pane active" id="addRole">
                                    <form method="post" id="formUPmodal">
                                        <input type="hidden" name="inFlag" id="inFlag">
                                            <!-- Modal Header -->
                                            <div class="modal-header">
                                                <h4 class="modal-title"><i class="fas fa-sync fa-spin"></i> เพิ่มสิทธิ์โปรแกรมคุณ <%=aID%> </h4>
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                            </div>

                                            <!-- Modal body -->
                                            <div class="modal-body">
                                                <%
                                                    try{
                                                %>
                                                <div class="row">

                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label for="appid">โปรแกรม:</label>
                                                            <select id="appid" name="appid" class="form-control">
                                                                <option value="">เลือกโปรแกรม</option>
                                                            <%  
                                                                try{
                                                                    String sqProgram = " SELECT * FROM SLF_SSO.APPSYS WHERE ACTIVE_FLAG = 'Y' ORDER BY appid ";
                                                                    Statement stProgram = con.createStatement();
                                                                    ResultSet rsProgram = stProgram.executeQuery(sqProgram);
                                                                    while(rsProgram.next()){
                                                            %>
                                                                    <option value="<%=Tools.chkNull(rsProgram.getString("appid"))%>"> <%=Tools.chkNull(rsProgram.getString("appname"))%></option>
                                                            <%      
                                                                    }stProgram.close();
                                                                    rsProgram.close();
                                                                }catch(Exception qm){
                                                                    out.print("Error on menu="+qm.toString());
                                                                }
                                                            %>
                                                            </select>
                                                        </div>
                                                    </div>

                                                </div>


                                                <div class="row">

                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label for="menuid">เลือกเมนู:</label>
                                                            <select id="menuid" name="menuid" class="form-control">
                                                                <option value="">เลือกเมนู</option>
                                                            <%
                                                                try{
                                                                    //String sqMenu = " SELECT * FROM SLF_SSO.MUNUSYS WHERE ACTIVE_FLAG = 'Y' ORDER BY menuid ";
                                                                    String sqMenu = " SELECT a.appid,a.menuid, a.menuname, b.appname "+
                                                                                    " FROM SLF_SSO.MUNUSYS a "+
                                                                                    " LEFT JOIN SLF_SSO.APPSYS b on a.appid = b.appid "+
                                                                                    " WHERE A.ACTIVE_FLAG = 'Y' "+
                                                                                    " ORDER BY A.MENUID ";
                                                                    Statement stMenu = con.createStatement();
                                                                    ResultSet rsMenu = stMenu.executeQuery(sqMenu);
                                                                    while(rsMenu.next()){
                                                            %>
                                                                    <option value="<%= Tools.chkNull(rsMenu.getString("menuid")) %>">
                                                                        <%
                                                                            if (Tools.chkNull(rsMenu.getString("appid")).equals("")) {
                                                                                out.print(" เมนู : " + Tools.chkNull(rsMenu.getString("menuname")));
                                                                            } else {
                                                                                out.print(" โปรแกรม : " + Tools.chkNull(rsMenu.getString("appname")) + " | เมนู : " + Tools.chkNull(rsMenu.getString("menuname")));
                                                                            }
                                                                        %>

                                                                    </option>
                                                            <%
                                                                    }stMenu.close();
                                                                    rsMenu.close();
                                                                }catch(Exception qm){
                                                                    out.print("Error on menu="+qm.toString());
                                                                }
                                                            %>

                                                            </select>
                                                        </div>
                                                    </div>
                                                    
                                                </div>

                                                <div class="row">

                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label for="proid">ที่อยู่โปรแกรม:</label>
                                                            <select id="proid" name="proid" class="form-control">
                                                                <option value="">เลือกที่อยู่โปรแกรม</option>
                                                            <%
                                                                try{
                                                                    
                                                                    //String sqFile = " SELECT * FROM SLF_SSO.PROGRAMSYS WHERE ACTIVE_FLAG = 'Y' ORDER BY proid ";
                                                                    String sqFile = " SELECT PS.proid, SS.APPNAME, ms.menuname, PS.proname, PS.filename, PS.appid "+
                                                                                    " FROM SLF_SSO.PROGRAMSYS PS "+
                                                                                    " LEFT JOIN SLF_SSO.MUNUSYS MS ON PS.menuid = MS.menuid "+
                                                                                    " LEFT JOIN SLF_SSO.APPSYS SS ON PS.appid = SS.appid "+
                                                                                    " WHERE PS.ACTIVE_FLAG = 'Y' "+
                                                                                    " ORDER BY PS.proid ";
                                                                    Statement stFile = con.createStatement();
                                                                    ResultSet rsFile = stFile.executeQuery(sqFile);

                                                                    while(rsFile.next()){
                                                            %>
                                                                    <option value="<%= Tools.chkNull(rsFile.getString("proid")) %>">
                                                                    <%
                                                                        if (Tools.chkNull(rsFile.getString("appid")).equals("")) {
                                                                            out.print(" ชื่อเมนูย่อย : " + Tools.chkNull(rsFile.getString("proname")) + " | พาธ : " + Tools.chkNull(rsFile.getString("filename")));
                                                                        } else {
                                                                            out.print(" โปรแกรม : " + Tools.chkNull(rsFile.getString("APPNAME")) + " | เมนู : " + Tools.chkNull(rsFile.getString("menuname")) + " | ชื่อเมนูย่อย : " + Tools.chkNull(rsFile.getString("proname")) + " | พาธ : " + Tools.chkNull(rsFile.getString("filename")));
                                                                        }
                                                                    %>
                                                                    </option>
                                                            <%
                                                                    }stFile.close();
                                                                    rsFile.close();
                                                                }catch(Exception qf){
                                                                    out.print("Error on File="+qf.toString());
                                                                }
                                                            %>



                                                            </select>
                                                        </div>
                                                    </div>

                                                </div>
                                                <%
                                                    }catch(Exception md){
                                                        out.print("Error on Modal="+md.toString());
                                                    }
                                                %>
                                            </div>

                                            <!-- Modal footer -->
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">ปิดหน้าต่าง</button>
                                                <button type="button" onClick="insert('<%=aID%>');" class="btn btn-primary">บันทึก</button>
                                                <input type="hidden" name="aID2" id="sendAID2">
                                            </div>
                                    </form>
                                </div>

                                <div class="tab-pane" id="editRole">
                                    <!-- Content for the second tab -->
                                    <form method="post" id="editForm">
                                        <input type="hidden" name="uID" id="sendAID3">
                                        <input type="hidden" name="uAPP" id="sendAID4">
                                        <input type="hidden" name="uMENU" id="sendAID5">
                                        <input type="hidden" name="uPRO" id="sendAID6">
                                        <input type="hidden" name="deFlag" id="deFlag">
                                        <!-- Modal Header -->
                                        <div class="modal-header">
                                            <h4 class="modal-title"><i class="fas fa-sync fa-spin"></i> แก้ไขสิทธิ์โปรแกรมคุณ <%=aID%> </h4>
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        </div>


                                        <!-- Modal body -->
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    
                                                    <% 
                                                        try {
                                                            String result = "";
                                                            sql5 = "SELECT COUNT(*) AS count FROM slf_sso.usermenu WHERE userid = '"+aID+"'";
                                                            stmt5 = con.createStatement();
                                                            rs5 = stmt5.executeQuery(sql5);

                                                            if (rs5.next() && rs5.getInt("count") > 0) {
                                                                result = "WHERE b.userid = '"+aID+"'";
                                                            } else {
                                                                result = "WHERE 1 = 1 and a.proid is not null ";
                                                            }

                                                            sql5 = " select distinct a.proid, a.proname, a.filename, a.active_flag, a.seq_no, a.procode " +
                                                                        ", b.MenuID, c.MenuName, d.AppID, d.AppName " +
                                                                    "from slf_sso.usermenu b "+
                                                                        "RIGHT join slf_sso.programsys a on b.proid=a.proid "+
                                                                        "RIGHT join slf_sso.munusys c on c.MenuID=b.MenuID "+
                                                                        "RIGHT join slf_sso.appsys d on d.AppID=b.AppID "+
                                                                result + " " +
                                                                "ORDER BY a.proid";

                                                            stmt5 = con.createStatement();
                                                            rs5 = stmt5.executeQuery(sql5);

                                                            int i = 1;
                                                    %>
                                                            <table class="table table-bordered" id="example3">
                                                                <thead>
                                                                    <tr>
                                                                        <th><center>No<center></th>
                                                                        <th><center>Program<center></th>
                                                                        <th><center>Menu<center></th>
                                                                        <th><center>File Name<center></th>
                                                                        <th><center>Path File<center></th>
                                                                        <th><center>Status<center></th>
                                                                        <th><center>Manage<center></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                    <%
                                                            while (rs5.next()) {
                                                                String af = "";
                                                                if (rs5.getString("active_flag").equals("Y")) {
                                                                    af = "<i class='fas fa-circle' style='color: #00ff33;'></i> กำลังใช้งานอยู่";
                                                                } else {
                                                                    af = "<i class='fas fa-circle' style='color: #e90707;'></i> ไม่ได้ใช้งาน";
                                                                }
                                                    %>
                                                                <tr>
                                                                    <td align="center"><%= i %></td>
                                                                    <td><%= Tools.chkNull(rs5.getString("appname")) %></td>
                                                                    <td><%= Tools.chkNull(rs5.getString("menuname")) %></td>
                                                                    <td><%= Tools.chkNull(rs5.getString("proname")) %></td>
                                                                    <td><%= Tools.chkNull(rs5.getString("filename")) %></td>
                                                                    <td><%= af %></td>
                                                                    <td align="center">
                                                                        <button type="button" onClick="delUUID('<%=aID%>','<%=Tools.chkNull(rs5.getString("appid"))%>','<%=Tools.chkNull(rs5.getString("menuid"))%>','<%=Tools.chkNull(rs5.getString("proid"))%>');" class="icon-button">
                                                                            <i class="fas fa-trash-alt" style="color: #122222;"></i>
                                                                        </button>
                                                                    </td>
                                                                </tr>
                                                    <%
                                                                i++;
                                                            }
                                                            stmt5.close();
                                                            rs5.close();
                                                        } catch (Exception tr) {
                                                            out.print("Error in program=" + tr.toString());
                                                        }
                                                    %>
                                                        </tbody>
                                                    </table>



                                                </div>
                                            </div>
                                        </div>

                                        <!-- Modal footer -->
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">ปิดหน้าต่าง</button>
                                        </div>

                                    </form>
                                </div>


                                <div class="tab-pane" id="cloneRole">
                                    <!-- Content for the second tab -->
                                    <form method="post" id="cloneForm">
                                        <!-- Modal Header -->
                                        <div class="modal-header">
                                            <h4 class="modal-title"><i class="fas fa-sync fa-spin"></i> โคลนเมนูของคุณ <%=aID%> </h4>
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        </div>

                                        <!-- Modal Body -->
                                        <div class="modal-body">
                                            <div class="d-flex justify-content-center align-items-center">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label for="cuser1">ผู้รับสิทธิ์</label>
                                                        <input type="text" class="form-control" placeholder="<%=aID%>" readonly value="<%=aID%>" id="cuser1" name="cuser1">
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="cappid">เลือกโปรแกรมที่ต้องการโคลน:</label>
                                                        <select id="cappid" name="cappid" class="form-control">
                                                            <option value="">เลือกโปรแกรม</option>
                                                            <%  
                                                                try {
                                                                    String sqProgram = "SELECT * FROM SLF_SSO.APPSYS WHERE ACTIVE_FLAG = 'Y' ORDER BY appid";
                                                                    Statement stProgram = con.createStatement();
                                                                    ResultSet rsProgram = stProgram.executeQuery(sqProgram);
                                                                    while(rsProgram.next()) {
                                                            %>      
                                                                    <option value="<%=Tools.chkNull(rsProgram.getString("appid"))%>"> <%=Tools.chkNull(rsProgram.getString("appname"))%></option>
                                                            <%      
                                                                    }
                                                                    stProgram.close();
                                                                    rsProgram.close();
                                                                } catch (Exception qm) {
                                                                    out.print("Error on menu=" + qm.toString());
                                                                }
                                                            %>
                                                        </select>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="cuser2">ผู้ให้โคลนสิทธิ์</label>
                                                        <input type="text" class="form-control" name="cuser2" id="cuser2">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>



                                        <!-- Modal footer -->
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">ปิดหน้าต่าง</button>
                                            <button type="button" onClick="cloneMenu();" class="btn btn-primary">บันทึก</button>
                                            <input type="hidden" name="clFlag" id="clFlag">
                                        </div>

                                    </form>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>
            </div>


    <%      
            }catch(Exception ee2){
                out.print("Error on insert="+ee2.toString());
            }
        }
    %>


    <%
        if(inFlag.equals("INSERT")){
            try{
                //out.print("<script>alert('1');</script>");
                String sqInsert = " INSERT INTO slf_sso.usermenu(userid, appid, menuid, proid, active_flag) values('"+aID2+"', '"+appid+"', '"+menuid+"', '"+proid+"', 'Y') ";
                //out.print(sqInsert);
                Statement stInsert=con.createStatement();
                int rowsUpdate = stInsert.executeUpdate(sqInsert);						
                if(rowsUpdate>0){					
                    out.print("<script>success('Y');</script>");
                    con.commit();					
                }else{							
                    out.print("<script>alert('เกิดข้อผิดพลาดในการเพิ่มข้อมูล');</script>");		
                }stInsert.close();

            }catch(Exception in){
                out.print("Error on insert="+in.toString());
            }
        }


        if(deFlag.equals("DELETE")){

            try{
                String sqDel = " delete from slf_sso.usermenu where userid='"+uID+"' and appid='"+uAPP+"' and menuid='"+uMENU+"' and proid='"+uPRO+"' ";
                //out.print(sqDel);
                //out.print("<script>alert('12');</script>");
                Statement stDel=con.createStatement();
                int rowsUpdate = stDel.executeUpdate(sqDel);						
                if(rowsUpdate > 0){					
                    out.print("<script>success('D');</script>");
                    con.commit();					
                }else{							
                    out.print("<script>alert('เกิดข้อผิดพลาดในการลบสิทธิ์');</script>");		
                } stDel.close();
            }catch(Exception de){
                out.print("Error on delete="+de.toString());
            }
        }

        if(clFlag.equals("CLONE")){
            try{
                String sqDel2 = " DELETE FROM slf_sso.usermenu "+
						        " WHERE USERID='"+cuser1+"' and AppID='"+cappid+"' "; 
				//out.print(sqDel2);
				Statement stDel2 = con.createStatement();
				int rowDel2  = stDel2.executeUpdate(sqDel2);
				if (rowDel2 > 0) {
					con.commit();
				} else {

				} stDel2.close();


                //out.print("<script> alert('cl'); </script>");
                String sqCl=" insert into slf_sso.usermenu(USERID, AppID, MenuID, ProID, Active_flag) SELECT '"+cuser1+"',  AppID, MenuID, ProID, Active_flag FROM slf_sso.usermenu where USERID='"+cuser2+"' and AppID='"+cappid+"' ";
                Statement stCl = con.createStatement();
                int rowCl = stCl.executeUpdate(sqCl);
                if (rowCl > 0) {
                    out.print("<script>success('X');</script>");
                    con.commit();
                } else {
                    out.print("<script>alert('เกิดข้อผิดพลาดในการโคลนโปรแกรม');</script>");		
                } stCl.close();

            }catch(Exception de){
                out.print("Error on delete="+de.toString());
            }
        }
    %>


    

    <div class="wrapper">

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <div class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1 class="m-0"><b>SLF</b>REPOSITORY</h1>
                        </div><!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="<%=contextPath + PageMain%>">หน้าแรก</a></li>
                            <li class="breadcrumb-item active">เพิ่มสิทธิ์</li>
                            </ol>
                        </div><!-- /.col -->
                    </div><!-- /.row -->
                </div><!-- /.container-fluid -->
            </div>
            <!-- /.content-header -->


            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <!-- Small boxes (Stat box) -->
                    <div class="row">
                        <!-- Blank content -->
                    </div>
                    <!-- /.row -->


                    <!-- Main row -->
                    <div class="row">

                        
                        <!-- top col -->
                        <section class="col-lg-12 connectedSortable">
                            <!-- Custom tabs (Crts with tabs)-->
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">
                                        <i class="fas fa-search" style="color: #202956;"></i>                                
                                        ค้นหาผู้ใช้งาน เพื่อเพิ่มหรือแก้ไขสิทธิ์การเข้าถึงโปรแกรม
                                    </h3>
                                </div><!-- /.card-header -->
                                <div class="card-body text-center">
                                    <form action="" method="post" id="FormSearch">
                                    <input type="hidden" name="aID" id="aIDInput" value="">
                                    <input type="hidden" name="openModal" id="openModal">
                                       
                                        <!-- First Row -->
                                        <div class="row">
                                            <div class="col-md-3 mx-auto">
                                                <div class="form-group">
                                                    <label for="tuser">กรอกชื่อผู้เข้าใช้งาน เพื่อค้นหา</label>
                                                    <input type="text" id="tuser" name="tuser" placeholder="ชื่อผู้ใช้" class="form-control" oninput="lockInput(this, 30);">
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Submit button -->
                                        <button type="button" onClick="search();" class="btn-sm btn-info">ค้นหา</button>
                                        <input type="hidden" name="searchFlag" id="searchFlag">

                                        <%
                                            if(searchFlag.equals("Y")){
                                        
                                        %>
                                            <table class="table table-bordered" id="example">
                                                <thead>
                                                    <tr>
                                                        <th><center>ลำดับที่</center></th>
                                                        <th><center>ชื่อผู้ใช้</center></th>
                                                        <th><center>วันที่ปรับแก้ล่าสุด</center></th>
                                                        <th><center>สถานะ</center></th>
                                                        <th><center>จัดการ</center></th>
                                                    </tr>
                                                </thead>
                                            <tbody>
                                       <%
                                            try {
                                                sql = " SELECT * FROM slf_sso.userlogin WHERE username = '" + tuser + "' "+
                                                    " AND active_flag = 'Y' ORDER BY userid ";
                                                stmt = con.createStatement();
                                                rs = stmt.executeQuery(sql);
                                                int i = 1;
                                                while (rs.next()) {
                                                    String af = "";
                                                    if (rs.getString("active_flag").equals("Y")) {
                                                        af = "<i class='fas fa-circle' style='color: #00ff33;'></i> กำลังใช้งานอยู่";
                                                    } else {
                                                        af = "<i class='fas fa-circle' style='color: #e90707;'></i> ไม่ได้ใช้งาน";
                                                    }

                                                    String updDate = rs.getString("upd_date").split(" ")[0];
                                                    String[] dd = updDate.split("-");
                                                    int d_day = Integer.parseInt(dd[2]);
                                                    int d_m = Integer.parseInt(dd[1]);
                                                    int d_y = Integer.parseInt(dd[0]);

                                                    d_y = d_y + 543;

                                                    String result = d_day + "/" + d_m + "/" + d_y;
                                        %>

                                                <tr>
                                                    <td align="center"><%=i%></td> 
                                                    <td><%=rs.getString("userid")%></td>                                           
                                                    <td align="center"><%=result%></td>
                                                    <td align="center"><%=af%></td>       
                                                    <td align="center" style="display: flex;justify-content: space-around;">
                                                        <button type="button" onClick="openMD('<%=rs.getString("userid")%>');" class="icon-button"><i class="fas fa-user-edit" style="color: #122222;"></i></button>
                                                    </td>
                                                </tr>
                                        <%          
                                                i++;
                                                    }stmt.close();
                                                    rs.close();

                                                }catch(Exception ee){
                                                    out.print("Error on search="+ee.toString());
                                                }
                                            }
                                        %> 
                                        
                                            </tbody>
                                        </table>



                                    </form>
                                </div><!-- /.card-body -->


                            </div>
                            <!-- /.card -->
                        </section>

                    <!-- bottom col -->
                    <section class="col-lg-12 connectedSortable">
                        <!--( Multi path )-->   
                        <div class="row">
                            <div class="col-lg-12">
                                <!-- Custom tabs (Tabs with dropdown menu)-->
                                <div class="card">
                                    <div class="card-header p-0">
                                        <ul class="nav nav-tabs" id="custom-tabs">
                                            <li class="nav-item">
                                                <a class="nav-link active" href="#tab-programs" data-toggle="tab">
                                                    <i class="fas fa-sitemap"></i> โปรแกรม
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="#tab-menus" data-toggle="tab">
                                                    <i class="fas fa-stream"></i> เมนู
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="#tab-file" data-toggle="tab">
                                                    <i class="fas fa-folder-open"></i> พาธไฟล์
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="card-body">
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="tab-programs">
                                                <div class="card">
                                                        <div class="card-body">
                                                            <% 
                                                                try {
                                                                    String result = "";
                                                                    sql1 = "SELECT COUNT(*) AS count FROM slf_sso.usermenu WHERE userid = '"+tuser+"'";
                                                                    stmt1 = con.createStatement();
                                                                    rs1 = stmt1.executeQuery(sql1);

                                                                    if (rs1.next() && rs1.getInt("count") > 0) {
                                                                        result = "WHERE b.userid = '"+tuser+"'";
                                                                    } else {
                                                                        result = "WHERE 1 = 1";
                                                                    }

                                                                    sql1 = "SELECT DISTINCT a.appid, a.appname, a.seq_no, a.active_flag " +
                                                                        "FROM slf_sso.appsys a " +
                                                                        "LEFT JOIN slf_sso.usermenu b ON a.appid = b.appid " +
                                                                        result + " " +
                                                                        "ORDER BY a.appid";

                                                                    stmt1 = con.createStatement();
                                                                    rs1 = stmt1.executeQuery(sql1);

                                                                    int i = 1;
                                                            %>
                                                                    <table class="table table-bordered" id="example1">
                                                                        <thead>
                                                                            <tr>
                                                                                <th><center>No<center></th>
                                                                                <th><center>Program Id<center></th>
                                                                                <th><center>Program Name<center></th>
                                                                                <th><center>Seq<center></th>
                                                                                <th><center>Status<center></th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                            <%
                                                                    while (rs1.next()) {
                                                                        String af = "";
                                                                        if (rs1.getString("active_flag").equals("Y")) {
                                                                            af = "<i class='fas fa-circle' style='color: #00ff33;'></i> กำลังใช้งานอยู่";
                                                                        } else {
                                                                            af = "<i class='fas fa-circle' style='color: #e90707;'></i> ไม่ได้ใช้งาน";
                                                                        }
                                                            %>
                                                                        <tr>
                                                                            <td align="center"><%= i %></td>
                                                                            <td align="center"><%= Tools.chkNull(rs1.getString("appid")) %></td>
                                                                            <td><%= Tools.chkNull(rs1.getString("appname")) %></td>
                                                                            <td align="center"><%= Tools.chkNull(rs1.getString("seq_no")) %></td>
                                                                            <td><%= af %></td>
                                                                        </tr>
                                                            <%
                                                                        i++;
                                                                    }
                                                                    stmt1.close();
                                                                    rs1.close();
                                                                } catch (Exception ee1) {
                                                                    out.print("Error in program=" + ee1.toString());
                                                                }
                                                            %>
                                                        
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <!-- /.card-body -->
                                                </div>
                                                <!-- /.card -->
                                            </div>
                                            <div class="tab-pane" id="tab-menus">
                                                <!-- Custom tabs (Charts with tabs)-->
                                                <div class="card">
                                                    <div class="card-body">
                                                            
                                                        <% 
                                                                try {
                                                                    String result = "";
                                                                    sql2 = "SELECT COUNT(*) AS count FROM slf_sso.usermenu WHERE userid = '"+tuser+"'";
                                                                    stmt2 = con.createStatement();
                                                                    rs2 = stmt2.executeQuery(sql2);

                                                                    if (rs2.next() && rs2.getInt("count") > 0) {
                                                                        result = "WHERE b.userid = '"+tuser+"'";
                                                                    } else {
                                                                        result = "WHERE 1 = 1";
                                                                    }

                                                                    sql2 = "select distinct a.menuid, a.menuname, a.seq_no, a.active_flag, nvl(c.appname, '-') as appname " +
                                                                        "FROM slf_sso.munusys a " +
                                                                        "left join slf_sso.usermenu b on a.menuid=b.menuid " +
                                                                        "left join slf_sso.appsys c on a.appid = c.appid "+ 
                                                                        result + " " +
                                                                        "ORDER BY a.menuid";

                                                                    stmt2 = con.createStatement();
                                                                    rs2 = stmt2.executeQuery(sql2);

                                                                    int i = 1;
                                                            %>
                                                                    <table class="table table-bordered" id="example2">
                                                                        <thead>
                                                                            <tr>
                                                                                <th><center>No<center></th>
                                                                                <th><center>Menu Id<center></th>
                                                                                <th><center>Menu Name<center></th>
                                                                                <th><center>Program Name<center></th>
                                                                                <th><center>Seq<center></th>
                                                                                <th><center>Status<center></th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                            <%
                                                                    while (rs2.next()) {
                                                                        String af = "";
                                                                        if (rs2.getString("active_flag").equals("Y")) {
                                                                            af = "<i class='fas fa-circle' style='color: #00ff33;'></i> กำลังใช้งานอยู่";
                                                                        } else {
                                                                            af = "<i class='fas fa-circle' style='color: #e90707;'></i> ไม่ได้ใช้งาน";
                                                                        }
                                                            %>
                                                                        <tr>
                                                                            <td align="center"><%= i %></td>
                                                                            <td align="center"><%= Tools.chkNull(rs2.getString("menuid")) %></td>
                                                                            <td><%= Tools.chkNull(rs2.getString("menuname")) %></td>
                                                                            <td align="center"><%= Tools.chkNull(rs2.getString("appname")) %></td>
                                                                            <td align="center"><%= Tools.chkNull(rs2.getString("seq_no")) %></td>
                                                                            <td><%= af %></td>
                                                                        </tr>
                                                            <%
                                                                        i++;
                                                                    }
                                                                    stmt2.close();
                                                                    rs2.close();
                                                                } catch (Exception ee2) {
                                                                    out.print("Error in menu=" + ee2.toString());
                                                                }
                                                            %>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <!-- /.card-body -->
                                                </div>
                                                <!-- /.card -->
                                            </div>
                                            <div class="tab-pane" id="tab-file">
                                                <!-- Custom tabs (Charts with tabs)-->
                                                <div class="card">
                                                    <div class="card-body">
                                                    <% 
                                                                try {
                                                                    String result = "";
                                                                    sql3 = "SELECT COUNT(*) AS count FROM slf_sso.usermenu WHERE userid = '"+tuser+"'";
                                                                    stmt3 = con.createStatement();
                                                                    rs3 = stmt3.executeQuery(sql3);

                                                                    if (rs3.next() && rs3.getInt("count") > 0) {
                                                                        result = "WHERE b.userid = '"+tuser+"'";
                                                                    } else {
                                                                        result = "WHERE 1 = 1 and a.proid is not null ";
                                                                    }

                                                                    sql3 = " select distinct a.proid, a.proname, a.filename, a.active_flag, a.seq_no, a.procode " +
                                                                                ", b.MenuID, c.MenuName, d.AppID, d.AppName " +
                                                                            "from slf_sso.usermenu b "+
                                                                                "RIGHT join slf_sso.programsys a on b.proid=a.proid "+
                                                                                "RIGHT join slf_sso.munusys c on c.MenuID=b.MenuID "+
                                                                                "RIGHT join slf_sso.appsys d on d.AppID=b.AppID "+
                                                                        result + " " +
                                                                        "ORDER BY a.proid";

                                                                    stmt3 = con.createStatement();
                                                                    rs3 = stmt3.executeQuery(sql3);

                                                                    int i = 1;
                                                            %>
                                                                    <table class="table table-bordered" id="example3">
                                                                        <thead>
                                                                            <tr>
                                                                                <th><center>No<center></th>
                                                                                <th><center>File Id<center></th>
                                                                                <th><center>Program<center></th>
                                                                                <th><center>Menu<center></th>
                                                                                <th><center>File Name<center></th>
                                                                                <th><center>Path File<center></th>
                                                                                <th><center>Status<center></th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                            <%
                                                                    while (rs3.next()) {
                                                                        String af = "";
                                                                        if (rs3.getString("active_flag").equals("Y")) {
                                                                            af = "<i class='fas fa-circle' style='color: #00ff33;'></i> กำลังใช้งานอยู่";
                                                                        } else {
                                                                            af = "<i class='fas fa-circle' style='color: #e90707;'></i> ไม่ได้ใช้งาน";
                                                                        }
                                                            %>
                                                                        <tr>
                                                                            <td align="center"><%= i %></td>
                                                                            <td align="center"><%= Tools.chkNull(rs3.getString("proid")) %></td>
                                                                            <td><%= Tools.chkNull(rs3.getString("appname")) %></td>
                                                                            <td><%= Tools.chkNull(rs3.getString("menuname")) %></td>
                                                                            <td><%= Tools.chkNull(rs3.getString("proname")) %></td>
                                                                            <td align="center"><%= Tools.chkNull(rs3.getString("filename")) %></td>
                                                                            <td><%= af %></td>
                                                                        </tr>
                                                            <%
                                                                        i++;
                                                                    }
                                                                    stmt3.close();
                                                                    rs3.close();
                                                                } catch (Exception ee3) {
                                                                    out.print("Error in program=" + ee3.toString());
                                                                }
                                                            %>
                                                            
                                                    
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <!-- /.card-body -->
                                                </div>
                                                <!-- /.card -->
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.card-body -->
                                </div>
                                <!-- /.card -->
                            </div>
                        </div>
                        <!--(/.Multi path )-->
                    </section>




                    </div>
                    <!-- /.row (main row) -->
                </div><!-- /.container-fluid -->
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
        
      <!-- /.content-wrapper -->
      <footer class="main-footer">
          <strong>Copyright &copy; 2566 - Now <a href="https://www.studentloan.or.th/th/home">กองทุนเงินให้กู้ยืมเพื่อการศึกษา</a>.</strong>
          All rights reserved.
          <div class="float-right d-none d-sm-inline-block">
          <b>Version</b> 0.0.1
          </div>
      </footer>

    </div>
    <!-- ./wrapper -->
    
    <script>  
        $.widget.bridge('uibutton', $.ui.button)    
    </script>
</body>
</html>
<%
    }  catch (Exception e) {
        out.print("Err Menu=" + e.toString());
        if(con!=null){
            con.close();
        }
    } finally {

        if(rs!=null){rs.close();}
        if(stmt!=null){stmt.close();}
        if(con!=null){
        	con.close();
        }   
    }
%>
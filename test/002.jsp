<%-- 
    Document   : SLFSYS002
    Created on : Octuber, 2023, 11:04:04 AM
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
	String PageFile="/jsp/sys/SLFSYS002.jsp";  //#importtant


    //variable
    String menuid = Tools.chkNull(request.getParameter("menuid"));
    String menuname = Tools.chkNull(request.getParameter("menuname"));
    String appname = Tools.chkNull(request.getParameter("appname"));
    String logo_menu = Tools.chkNull(request.getParameter("logo_menu"));
    String seq_no = Tools.chkNull(request.getParameter("seq_no"));
    String active_flag = Tools.chkNull(request.getParameter("active_flag"));

    //flag
    String inFlag = Tools.chkNull(request.getParameter("inFlag"));
    String upFlag = Tools.chkNull(request.getParameter("upFlag"));
    String openModal = Tools.chkNull(request.getParameter("openModal"));
    String aID = Tools.chkNull(request.getParameter("aID"));
    String aID2 = Tools.chkNull(request.getParameter("aID2"));

	
	Connection con = null;
    Statement stmt = null,stmt2=null,stmt3=null,stmt4=null;
    ResultSet rs = null,rs2=null,rs3=null,rs4=null;
    String sql = "",sql2="",sql3="",sql4="";

    try {

        con = getOra_DB.getConnection(false);
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="windows-874">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu</title>

    <style>
       /* Hide the default scrollbar */
        #icons {
            display: flex;
            justify-content: space-between;
            overflow-x: scroll;            
            background-color:#F0F0F0;

        }

        .icon-item {
            margin: 10px; /* Adjust this value to control the space around each item */
            text-align: center;
        }

        /* Ensure that there are 8 items in a row */
        .row {
            display: flex;
            flex-wrap: wrap;
        }

        /* To make sure each item takes equal space within the row */
        .icon-item {
            flex: 3;
            width: calc(10.5% - 20px); 
            max-width: calc(10.5% - 20px);
        }

        /* Style the button inside the icon item */
        .copy-icon-class {
            border: none;
            background: transparent;
            cursor: pointer;
            padding: 0;
            width:135px;
            height:90px;
            background-color:#ffffff;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            border-radius: 10px;        
        }

        .copy-icon-class:hover {
            background:#EFF166;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            border-radius: 10px;
        }


        .icon-button {
            background: none;
            border: none;
            padding: 0;
            cursor: pointer;
        }


       .modal {
            animation: slideInAndFade 0.8s forwards; /* Use both animations */
            transition: opacity 0.9s; /* To smoothly transition opacity */
        }

        .modal-dialog {
            animation: fadeIn 1s forwards; /* Apply fade-in animation */
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
        //icons copie
        document.addEventListener('DOMContentLoaded', function() {
            var clipboard = new ClipboardJS('.copy-icon-class');

            clipboard.on('success', function(e) {
                e.clearSelection();
                alert('ก๊อบปี้สำเร็จแล้ว: ' + e.text);
            });

            clipboard.on('error', function(e) {
                alert('เกิดข้อผิดพลาด');
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

        //datatable
        $(document).ready(function() {
            $('#example').DataTable();
        });

        //modal
        $(document).ready(function () {
            $('#myModal').modal('show');
        });

        //จำกัดจำนวนปุ่ม
        function lockInput(txt, values) {
            var value = txt.value;
            if (value.length > values) {
                txt.value = value.slice(0, values);
            }
        }

        function insert(){
            const f1 = document.getElementById("formInsert");
            if(f1.menuid.value==""){
                alert("กรุณากรอกรหัสเมนู");
                f1.menuid.focus();
            }else if(f1.menuname.value==""){
                alert("กรุณากรอกชื่อเมนู");
                f1.menuname.focus();
            }else if(f1.appname.value==""){
                alert("กรุณากรอกชื่อโปรแกรม");
                f1.appname.focus();
            }else if(f1.logo_menu.value==""){
                alert("กรุณากรอกโลโก้");
                f1.logo_menu.focus();
            }else if(f1.seq_no.value==""){
                alert("กรุณากรอกลำดับโปรแกรม");
                f1.seq_no.focus();
            }else if(f1.active_flag.value==""){
                alert("กรุณากรอกสถานะโปรแกรม");
                f1.active_flag.focus();
            }else{
                f1.inFlag.value="INSERT";
                //alert(f1.inFlag.value);
                f1.submit();
            }
        }

        function openMD(aID) {
            const f1 = document.getElementById("formUpdate");
            const aIDInput = document.getElementById("aIDInput");
            aIDInput.value = aID;
            //alert(aID);
            f1.openModal.value = "open";
            //alert(f1.openModal.value);
            f1.submit();
        }

        function update(aID2) {
            const f1 = document.getElementById("formUPmodal");
            const sendAID2 = document.getElementById("sendAID2");
            sendAID2.value = aID2;
            f1.upFlag.value = "UPDATE";
            //alert(f1.openModal.value);
            f1.submit();
        }

        function success(txt) {
            if(txt === 'Y'){
                alert("เพิ่มเมนูสำเร็จ");
                window.location.href = "<%=contextPath%>/jsp/sys/SLFSYS002.jsp";
            }else{
                alert("อัปเดตเมนูสำเร็จ");
                window.location.href = "<%=contextPath%>/jsp/sys/SLFSYS002.jsp";
            }
        }

        function fawesome() {
            window.open("https://fontawesome.com/v5/search?o=r&m=free", "_blank");
        }
    </script>
</head>
<body class="hold-transition sidebar-mini layout-fixed">

    <%
        //เพิ่มโปรแกรม
        if(inFlag.equals("INSERT")){
            try{
                
				sql=" insert into slf_sso.munusys(menuid,menuname,appid,logo_menu,active_flag,seq_no) values('"+menuid+"','"+menuname+"' ,'"+appname+"', '"+logo_menu+"', '"+active_flag+"', "+seq_no+") ";
                //out.print(sql);
                stmt = con.createStatement();
                int insert = stmt.executeUpdate(sql);
                if(insert > 0){
                    out.print("<script>success('Y');</script>");
                    con.commit();
                }else{
                    out.print("เกิดข้อผิดพลาดในการเพิ่มโปรแกรม");
                }stmt.close();

            }catch(Exception ee){
                out.print("Error on insert="+ee.toString());
            }
        }
        
        
        
        
        //อัพเดตโปรแกรม
        if(openModal.equals("open")){
            try{
    %>
            <!-- The Modal -->
            <div class="modal" id="myModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form method="post" id="formUPmodal">
                            <input type="hidden" name="upFlag" id="upFlag">
                            <%
                                //sql4 = " SELECT * FROM slf_sso.munusys where menuid = '"+aID+"' ";
                                sql4 = " select a.menuname, a.logo_menu, a.appid, a.seq_no, a.active_flag, b.appname "+
                                       " FROM slf_sso.munusys a "+
                                       " left join slf_sso.appsys b on a.appid = b.appid "+
                                       " where a.menuid = '"+aID+"' ";
                                //out.print(sql4);
                                stmt4 = con.createStatement();
                                rs4 = stmt4.executeQuery(sql4);
                                if(rs4.next()){
                                    String an = Tools.chkNull(rs4.getString("menuname"));
                                    String apid = Tools.chkNull(rs4.getString("appid"));
                            %>
                                <!-- Modal Header -->
                                <div class="modal-header">
                                    <h4 class="modal-title"><i class="fas fa-sync fa-spin"></i> แก้ไข <%=an%></h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>

                                <!-- Modal body -->
                                <div class="modal-body">
                                    <div class="row">

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="menuname">Menu Name:</label>
                                                <input type="text" id="menuname" name="menuname" value="<%=an%>" class="form-control" oninput="lockInput(this, 50);">
                                            </div>
                                        </div>
                                    
                                    </div>


                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="logo_menu">Logo:</label>
                                                <input type="text" id="logo_menu" name="logo_menu" value="<%=Tools.chkNull(rs4.getString("logo_menu"))%>" class="form-control" oninput="lockInput(this, 50);">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="appname">App Name:</label>
                                                <select id="appname" name="appname" class="form-control">
                                                    <option value="">เลือกโปรแกรม</option>
                                                    <%  
                                                        String tempSQL = "";
                                                        //out.print(apid);
                                                        if(!apid.equals("")) {
                                                            tempSQL = "1=1 OR appid = '"+apid+"'";
                                                        } else {
                                                            tempSQL = "1=1"; 
                                                        }
                                                        String sqlApp = "SELECT DISTINCT appid, appname FROM SLF_SSO.APPSYS WHERE " + tempSQL;

                                                        Statement stmApp = con.createStatement();
                                                        ResultSet rsApp = stmApp.executeQuery(sqlApp);
                                                        while(rsApp.next()) {
                                                            String currentAppId = Tools.chkNull(rsApp.getString("appid"));
                                                            %>
                                                            <option value="<%= currentAppId %>" <%= (apid.equals(currentAppId) ? "selected" : "") %>>
                                                                <%= Tools.chkNull(rsApp.getString("appname")) %>
                                                            </option>
                                                            <%
                                                        }
                                                        stmApp.close();
                                                        rsApp.close();
                                                    %>
                                                </select>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="seq_no">Seq:</label>
                                                <input type="number" id="seq_no" name="seq_no" value="<%=rs4.getString("seq_no")%>" class="form-control" oninput="lockInput(this, 3);">
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="active_flag">Status:</label>
                                                <select id="active_flag" name="active_flag" class="form-control">
                                                    <option value="">เลือกสถานะเมนู</option>
                                                    <option value="Y" <% if (rs4.getString("active_flag").equals("Y")) { %>selected<% } %>>ใช้งาน</option>
                                                    <option value="N" <% if (rs4.getString("active_flag").equals("N")) { %>selected<% } %>>ไม่ใช้งาน</option>
                                                </select>
                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <!-- Modal footer -->
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">ปิดหน้าต่าง</button>
                                    <button type="button" onClick="update('<%=aID%>');" class="btn btn-primary">บันทึก</button>
                                    <input type="hidden" name="aID2" id="sendAID2">
                                </div>
                            <%
                                }stmt4.close();
                                rs4.close();
                            %>
                        </form>
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
        if(upFlag.equals("UPDATE")){
            try{
                sql3=" update slf_sso.munusys set menuname='"+menuname+"', logo_menu='"+logo_menu+"' ,seq_no="+seq_no+" , active_flag='"+active_flag+"',appid='"+appname+"' where menuid='"+aID2+"' ";
                //out.print(sql3);
                stmt3=con.createStatement();
                int rowsUpdate = stmt3.executeUpdate(sql3);						
                if(rowsUpdate>0){					
                    out.print("<script>success('U');</script>");
                    con.commit();					
                }else{							
                    out.print("<script>alert('Save Error!');</script>");		
                }stmt3.close();
            }catch(Exception ee3){
                out.print("Error on update="+ee3.toString());
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
                            <h1 class="m-0"><b>SLF</b>MENU</h1>
                        </div><!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="<%=contextPath + PageMain%>">หน้าแรก</a></li>
                            <li class="breadcrumb-item active">เพิ่มเมนู</li>
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
                        
                        <!-- right col -->
                        <section class="col-lg-7 connectedSortable">
                            <!-- Custom tabs (Charts with tabs)-->
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">
                                        <i class="fas fa-database"></i>
                                        เมนูทั้งหมดที่มีในระบบ
                                    </h3>
                                </div><!-- /.card-header -->
                                <div class="card-body">
                                    <form action="" method="post" id="formUpdate">
                                    <input type="hidden" name="aID" id="aIDInput" value="">
                                    <input type="hidden" name="openModal" id="openModal">
                                        <table class="table table-bordered" id="example">
                                            <thead>
                                                <tr>
                                                    <th align="center">No</th>
                                                    <th align="center">MId</th>
                                                    <th align="center">L</th>
                                                    <th align="center">Menu Name</th>
                                                    <th align="center">PName</th>
                                                    <th align="center">Seq</th>
                                                    <th align="center">Status</th>
                                                    <th align="center">Magn</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                        <%
                                            //sql2 = " select MENUID, MENUNAME, nvl(APPID, '-') as APPNAME, LOGO_MENU, SEQ_NO, ACTIVE_FLAG from slf_sso.munusys order by menuid ";
                                            sql2= " select a.menuid , a.menuname, nvl(b.appname, '-') as appname, a.logo_menu, a.seq_no, a.active_flag "+
                                                  " from slf_sso.munusys a "+
                                                  " left join slf_sso.appsys b on a.appid = b.appid "+
                                                  " where 1=1 "+
                                                  " order by a.menuid ";
                                                  //out.print(sql2);
                                            stmt2 = con.createStatement();
                                            rs2 = stmt2.executeQuery(sql2);
                                            int i=1;
                                            while(rs2.next()){
                                                String af = "";
                                                String lm = Tools.chkNull(rs2.getString("LOGO_MENU"));
                                                if(rs2.getString("active_flag").equals("Y")){
                                                    af = "<i class='fas fa-circle' style='color: #00ff33;'></i> กำลังใช้งานอยู่";
                                                }else{
                                                    af = "<i class='fas fa-circle' style='color: #e90707;'></i> ไม่ได้ใช้งาน";
                                                }
                                                
                                        %>
                                                <tr>
                                                    <td align="center"><%=i%></td> 
                                                    <td align="center"><%=rs2.getString("menuid")%></td>
                                                    <%if(lm.equals("")){%>
                                                        <td align="center">-</td>
                                                    <%}else{%>
                                                    <td align="center">
                                                        <i class='<%=lm%>'></i>
                                                    </td>
                                                    <%}%>                                                 
                                                    <td><%=rs2.getString("menuname")%></td>
                                                    <td align="center"><%=rs2.getString("appname")%></td>
                                                    <td align="center"><%=rs2.getString("seq_no")%></td>
                                                    <td><%=af%></td>
                                                    <td align="center">
                                                        <button type="button" onClick="openMD('<%=rs2.getString("menuid")%>');" class="icon-button"><i class="fas fa-edit fa-lg" style="color: #122222;"></i></button>
                                                    </td>
                                                </tr>

                                        <%
                                            i++;
                                        }
                                        stmt2.close();
                                        rs2.close();
                                        %>
                                            </tbody>
                                        </table>
                                    </form>
                                </div><!-- /.card-body -->
                            </div>
                            <!-- /.card -->
                        </section>

                        <!-- Left col -->
                        <section class="col-lg-5 connectedSortable">
                            <!-- Custom tabs (Charts with tabs)-->
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">
                                        <i class="fas fa-edit"></i>                                  
                                        เพิ่มเมนูของโปรแกรม
                                    </h3>
                                </div><!-- /.card-header -->
                                <div class="card-body">
                                    <form action="" method="post" id="formInsert">
                                        <input type="hidden" name="inFlag" id="inFlag">
                                        <!-- First Row -->
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="menuid">Menu ID:</label>
                                                    <input type="number" id="menuid" name="menuid" placeholder="รหัสเมนู" class="form-control" oninput="lockInput(this, 5);">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="menuname">Menu Name:</label>
                                                    <input type="text" id="menuname" name="menuname" placeholder="ชื่อเมนู" class="form-control" oninput="lockInput(this, 50);">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                <label for="appname">App Name:</label>
                                                    <select id="appname" name="appname" class="form-control">
                                                        <option value="">เลือกโปรแกรม</option>
                                                    <%
                                                        String sqApp = " SELECT * FROM SLF_SSO.APPSYS WHERE ACTIVE_FLAG = 'Y' ";
                                                        Statement stApp = con.createStatement();
                                                        ResultSet rsApp = stApp.executeQuery(sqApp);
                                                        while(rsApp.next()){
                                                    %>
                                                        <option value="<%=Tools.chkNull(rsApp.getString("appid"))%>"><%=Tools.chkNull(rsApp.getString("appname"))%></option>
                                                    <%
                                                        }stApp.close();
                                                        rsApp.close();
                                                    %>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="logo_menu">Logo:</label>
                                                    <input type="text" id="logo_menu" name="logo_menu" placeholder="โลโก้เมนู" class="form-control" oninput="lockInput(this, 50);">
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Second Row -->
                                        <div class="row">
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label for="seq_no">Seq:</label>
                                                    <input type="number" id="seq_no" name="seq_no" placeholder="ลำดับของโปรแกรม" class="form-control" oninput="lockInput(this, 3);">
                                                </div>
                                            </div>
                                            <div class="col-md-7">
                                                <div class="form-group">
                                                    <label for="active_flag">Status:</label>
                                                    <select id="active_flag" name="active_flag" class="form-control">
                                                        <option value="">เลือกสถานะโปรแกรม</option>
                                                        <option value="Y">ใช้งาน</option>
                                                        <option value="N">ไม่ใช้งาน</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Submit button -->
                                        <button type="button" onClick="insert();" class="btn btn-primary">บันทึก</button>
                                    </form>
                                </div><!-- /.card-body -->
                            </div>
                            <!-- /.card -->

                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">
                                        <i class="fas fa-icons"></i>
                                        เลือกโลโก้เมนูเลย!! <button type="button" onClick="fawesome();" class="icon-button"><p style="color:red;">ดูมากกว่านี้คลิกเลย! <i style="color: #122222;" class="fas fa-location-arrow"></i></p></button>
                                    </h3>
                                </div>
                                <div class="card-body" id="icons">
                                    <div class="row">
                                        <ul id="icon-list" class="list-unstyled">
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-unlock"><i class="fas fa-unlock"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-envelope"><i class="fas fa-envelope"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-user-friends"><i class="fas fa-user-friends"></i></button></li>

                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-wifi"><i class="fas fa-wifi"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-wrench"><i class="fas fa-wrench"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-undo-alt"><i class="fas fa-undo-alt"></i></button></li>
                                            <!-- Add more icons and buttons here -->
                                        </ul>
                                    </div>
                                    <div class="row">
                                        <ul id="icon-list" class="list-unstyled">
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-user-plus"><i class="fas fa-user-plus"></i> </button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-upload"><i class="fas fa-upload"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-th-list"><i class="fas fa-th-list"></i></button></li>

                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-table"><i class="fas fa-table"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-user-circle"><i class="fas fa-user-circle"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-circle"><i class="fas fa-circle"></i></button></li>
                                            <!-- Add more icons and buttons here -->
                                        </ul>
                                    </div>
                                    <div class="row">
                                        <ul id="icon-list" class="list-unstyled">
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-folder"><i class="fas fa-folder"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-edit"><i class="fas fa-edit"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-th-large"><i class="fas fa-th-large"></i></button></li>

                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-home"><i class="fas fa-home"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-database"><i class="fas fa-database"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-cogs"><i class="fas fa-cogs"></i></button></li>
                                            <!-- Add more icons and buttons here -->
                                        </ul>
                                    </div>
                                    <div class="row">
                                        <ul id="icon-list" class="list-unstyled">
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-chart-pie"><i class="fas fa-chart-pie"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-bookmark"><i class="fas fa-bookmark"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-book"><i class="fas fa-book"></i></button></li>

                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-address-book"><i class="fas fa-address-book"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-tasks"><i class="fas fa-tasks"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-sticky-note"><i class="fas fa-sticky-note"></i></button></li>
                                            <!-- Add more icons and buttons here -->
                                        </ul>
                                    </div>

                                    <div class="row">
                                        <ul id="icon-list" class="list-unstyled">
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-tools"><i class="fas fa-tools"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-user-check"><i class="fas fa-user-check"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-code-branch"><i class="fas fa-code-branch"></i></button></li>
                                            
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-layer-group"><i class="fas fa-layer-group"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-project-diagram"><i class="fas fa-project-diagram"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-thumbtack"><i class="fas fa-thumbtack"></i></button></li>
                                        </ul>
                                    </div>

                                    <div class="row">
                                        <ul id="icon-list" class="list-unstyled">
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fa-stream"><i class="fas fa-stream"></i></button></li>
                                            <li class="col-3 icon-item"> <button class="copy-icon-class" data-clipboard-text="fas fas fa-users-cog"><i class="fas fas fa-users-cog"></i></button></li>
                                        </ul>
                                    </div>




                                </div>
                            </div>

                        </section><!-- /.section -->
                    </div>
                    <!-- /.row (main row) -->



                </div><!-- /.container-fluid -->
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
        
      <!-- /.content-wrapper -->
      <footer class="main-footer">
          <strong>Copy right &copy; 2566 - Now <a href="https://www.studentloan.or.th/th/home">กองทุนเงินให้กู้ยืมเพื่อการศึกษา</a>.</strong>
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
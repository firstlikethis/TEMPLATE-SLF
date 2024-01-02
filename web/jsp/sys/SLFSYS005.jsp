<%-- 
    Document   : SLFSYS002
    Created on : Octuber, 2023, 4:51:23 PM
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
	String PageFile="/jsp/sys/SLFSYS005.jsp";  //#importtant

    String tuser = Tools.chkNull(request.getParameter("tuser"));
    String tpass = Tools.chkNull(request.getParameter("tpass"));
    String active_flag = Tools.chkNull(request.getParameter("active_flag"));
    String fullname = Tools.chkNull(request.getParameter("fullname"));





    
    String searchFlag = Tools.chkNull(request.getParameter("searchFlag"));
    String upFlag = Tools.chkNull(request.getParameter("upFlag"));
    String inFlag = Tools.chkNull(request.getParameter("inFlag"));
    String aID = Tools.chkNull(request.getParameter("aID"));
    String aID2 = Tools.chkNull(request.getParameter("aID2"));
    String openModal = Tools.chkNull(request.getParameter("openModal"));


	
	Connection con = null;
    Statement stmt = null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;
    ResultSet rs = null,rs2=null,rs3=null,rs4=null,rs5=null;
    String sql = "",sql2="",sql3="",sql4="",sql5="";

    try {

        con = getOra_DB.getConnection(false);
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="windows-874">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Login</title>

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
        //modal
        $(document).ready(function () {
            $('#myModal').modal('show');
        });

        //datatable search
        $(document).ready(function() {
            $('#example').DataTable();
        });
        
        //datatable query
        $(document).ready(function() {
            $('#example2').DataTable();
        });

        function search(){
            const f1 = document.getElementById("FormSearch");
            
            if(f1.tuser.value==""){
                alert("กรุณากรอกชื่อผู้ใช้");
                f1.tuser.focus();
            }else{
                f1.searchFlag.value="Y";
                f1.submit();
            }
        }


        function openMD(aID){
            const f1 = document.getElementById("FormSearch");
            const aIDInput = document.getElementById("aIDInput");
            
            aIDInput.value = aID;
            f1.openModal.value="open";
            //alert(aIDInput.value);
            f1.submit();
        }

        function updated2(aID2){
            const f1 = document.getElementById("formUPmodal");
            const sendAID2 = document.getElementById("sendAID2");

            sendAID2.value = aID2;
            f1.upFlag.value="update";
            //alert(aIDInput.value);
            f1.submit();
        }

        function insert(){
            const f1 = document.getElementById("FormInsert");
            
            if(f1.tuser.value==""){
                alert("กรุณากรอกชื่อผู้ใช้");
                f1.tuser.focus();
            }else if(f1.tpass.value==""){
                alert("กรุณากรอกรหัสผ่าน");
                f1.tpass.focus();
            }else if(f1.fullname.value==""){
                alert("กรุณากรอกชื่อและนามสกุล");
                f1.fullname.focus();
            }else if(f1.active_flag.value==""){
                alert("กรุณาเลือกสถานะ");
                f1.active_flag.focus();
            }else{
                f1.inFlag.value="insert";
                //alert(f1.inFlag.value);
                f1.submit();
            }
        }

        
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

        function success(txt) {
            if(txt === 'Y'){
                alert("เพิ่มผู้ใช้งานสำเร็จ");
                window.location.href = "<%=contextPath%>/jsp/sys/SLFSYS005.jsp";
            }else if(txt === 'D'){
                alert("ลบผู้ใช้งานสำเร็จ");
                window.location.href = "<%=contextPath%>/jsp/sys/SLFSYS005.jsp";
            }else{
                alert("อัปเดตเมนูสำเร็จ");
                window.location.href = "<%=contextPath%>/jsp/sys/SLFSYS005.jsp";
            }
        }
        
    </script>
</head>
<body class="hold-transition sidebar-mini layout-fixed">



    <%

       //แก้ไขผู้ใช้งาน
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
                                sql4 = " SELECT * FROM slf_sso.userlogin where userid = '"+aID+"' ";
                                //out.print(sql4);
                                stmt4 = con.createStatement();
                                rs4 = stmt4.executeQuery(sql4);
                                if(rs4.next()){
                                    String an = Tools.chkNull(rs4.getString("userid"));
                            %>
                                <!-- Modal Header -->
                                <div class="modal-header">
                                    <h4 class="modal-title"><i class="fas fa-sync fa-spin"></i> แก้ไขข้อมูลคุณ <%=an%></h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>

                                <!-- Modal body -->
                                <div class="modal-body">
                                    <div class="row">

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="euser">ชื่อผู้ใช้:</label>
                                                <input type="text" id="euser" name="euser" value="<%=an%>" readonly class="form-control" oninput="lockInput(this, 50);">
                                            </div>
                                        </div>
                                    
                                    </div>


                                    <div class="row">

                                        <div class="col-md-12">
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
                                    <button type="button" onClick="updated2('<%=an%>');" class="btn btn-primary">บันทึก</button>
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
        if(upFlag.equals("update")){
            try{
                String sqUp = " UPDATE SLF_SSO.USERLOGIN SET active_flag = '"+active_flag+"' WHERE userid = '"+aID2+"' "; 
                //out.print(sqUp);
                Statement stUp = con.createStatement();
                int rowsUpdate = stUp.executeUpdate(sqUp);

                if(rowsUpdate > 0){
                    con.commit();
                    out.print("<script>success('X');</script>");
                }else{
                    out.print("<script>เกิดข้อผิดพลาดในการแก้ไขข้อมูล</script>");
                }stUp.close();

            }catch(Exception ee1){
                out.print("Error on update="+ee1.toString());
            }
        }

        if(inFlag.equals("insert")){
            //out.print("<script>alert('test');</script>");
             try{
                String sqIn = " INSERT INTO slf_sso.userlogin (USERID, userpass, TYPE_ID, start_date, end_date, active_flag, upd_date, upd_user, username)  "+
                              " VALUES ('"+tuser+"', '"+tpass+"', '0', TIMESTAMP '4713-01-01 00:00:00.000000', TIMESTAMP '9999-01-01 00:00:00.000000', '"+active_flag+"', CURRENT_TIMESTAMP, '"+userid+"', '"+fullname+"')";
                //out.print(sqIn);
                Statement stIn = con.createStatement();
                int rowsInsert = stIn.executeUpdate(sqIn);

                if(rowsInsert > 0){
                    con.commit();
                    out.print("<script>success('Y');</script>");
                }else{
                    out.print("<script>เกิดข้อผิดพลาดในการแก้ไขข้อมูล</script>");
                }stIn.close();
            
            }catch(Exception ee1){
                out.print("Error on update="+ee1.toString());
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
                            <li class="breadcrumb-item active">เพิ่มผู้ใช้งาน</li>
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
                        <section class="col-lg-7 connectedSortable">
                            <!-- Custom tabs (Crts with tabs)-->
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">
                                        <i class="fas fa-search" style="color: #202956;"></i>                                
                                        ค้นหาผู้ใช้งาน เพื่อเพิ่มหรือแก้ไขข้อมูล
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
                                                    <label for="tuser">กรอกชื่อผู้เข้าใช้งาน</label>
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
                                                        <th><center>สถานะ</center></th>
                                                        <th><center>จัดการ</center></th>
                                                    </tr>
                                                </thead>
                                            <tbody>
                                       <%
                                            try {
                                                sql = " select USERID, userpass, active_flag, username from slf_sso.userlogin where userid LIKE '%"+tuser+"%' ";
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
                                        %>

                                                <tr>
                                                    <td align="center"><%=i%></td> 
                                                    <td><%=rs.getString("userid")%></td>                                            
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


                        <!-- top col -->
                        <section class="col-lg-5 connectedSortable">
                            <!-- Custom tabs (Crts with tabs)-->
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">
                                        <i class="fas fa-user-plus" style="color: #202956;"></i>                                
                                        เพื่อผู้เข้าใช้งาน
                                    </h3>
                                </div><!-- /.card-header -->
                                <div class="card-body text-center">
                                    <form action="" method="post" id="FormInsert">
                                       
                                        <!-- First Row -->
                                        <div class="row">
                                            <div class="col-md-6 mx-auto">
                                                <div class="form-group">
                                                    <label for="tuser">ชื่อผู้เข้าใช้งาน</label>
                                                    <input type="text" id="tuser" name="tuser" placeholder="ชื่อผู้ใช้" class="form-control" oninput="lockInput(this, 30);">
                                                </div>
                                            </div>

                                            <div class="col-md-6 mx-auto">
                                                <div class="form-group">
                                                    <label for="tpass">รหัสผ่าน</label>
                                                    <input type="text" id="tpass" name="tpass" placeholder="รหัสผ่าน" class="form-control" oninput="lockInput(this, 10);">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6 mx-auto">
                                                <div class="form-group">
                                                    <label for="fullname">ชื่อ-นามสกุล</label>
                                                    <input type="text" id="fullname" name="fullname" placeholder="ชื่อและนามสกุล" class="form-control" oninput="lockInput(this, 10);">
                                                </div>
                                            </div>
                                            <div class="col-md-6 mx-auto">
                                                <div class="form-group">
                                                    <label for="active_flag">สถานะ:</label>
                                                    <select id="active_flag" name="active_flag" class="form-control">
                                                        <option value="">เลือกสถานะโปรแกรม</option>
                                                        <option value="Y">ใช้งาน</option>
                                                        <option value="N">ไม่ใช้งาน</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Submit button -->
                                        <button type="button" onClick="insert();" class="btn-sm btn-primary">บันทึก</button>
                                        <input type="hidden" name="inFlag" id="inFlag">

                                    </form>
                                </div><!-- /.card-body -->


                            </div>
                            <!-- /.card -->
                        </section>

                    </div>
                    <!-- /.row (main row) -->




                    <!-- Main row -->
                    <div class="row">
                        <section class="col-lg-12 connectedSortable">
                            <!-- Custom tabs (Crts with tabs)-->
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">
                                        <i class="fas fa-search" style="color: #202956;"></i>                                
                                        ค้นหาผู้ใช้งาน เพื่อเพิ่มหรือแก้ไขข้อมูล
                                    </h3>
                                </div><!-- /.card-header -->
                                <div class="card-body text-center">
                                    <form action="" method="post" id="formtest">
                                    <input type="hidden" name="aID" id="aIDInput" value="">
                                    <input type="hidden" name="openModal" id="openModal">
                                        <table class="table table-bordered" id="example2">
                                            <thead>
                                                <tr>
                                                    <th><center>No</center></th>
                                                    <th><center>User Id</center></th>
                                                    <th><center>Full Name</center></th>
                                                    <th><center>Start Date</center></th>
                                                    <th><center>Status</center></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                        <%
                                            sql5 = " select userid, username,  upd_date, active_flag from slf_sso.userlogin order by userid ";
                                            stmt5 = con.createStatement();
                                            rs5 = stmt5.executeQuery(sql5);
                                            int i=1;
                                            while(rs5.next()){
                                                String af = "";
                                                if(rs5.getString("active_flag").equals("Y")){
                                                    af = "<i class='fas fa-circle' style='color: #00ff33;'></i> กำลังใช้งานอยู่";
                                                }else{
                                                    af = "<i class='fas fa-circle' style='color: #e90707;'></i> ไม่ได้ใช้งาน";
                                                }

                                                String updDate = rs5.getString("upd_date").split(" ")[0];
                                                String[] dd = updDate.split("-");
                                                int d_day = Integer.parseInt(dd[2]);
                                                int d_m = Integer.parseInt(dd[1]);
                                                int d_y = Integer.parseInt(dd[0]);

                                                d_y = d_y + 543;

                                                String result = d_day + "/" + d_m + "/" + d_y;
                                                
                                        %>
                                                <tr>
                                                    <td align="center"><%=i%></td> 
                                                    <td align="center"><%=rs5.getString("userid")%></td>
                                                    <td><%=rs5.getString("username")%></td>
                                                    <td align="center"><%=result%></td>
                                                    <td><%=af%></td>
                                                </tr>

                                        <%
                                            i++;
                                        }
                                        stmt5.close();
                                        rs5.close();
                                        %>
                                            </tbody>
                                        </table>
                                    </form>
                                </div>
                            </div>
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
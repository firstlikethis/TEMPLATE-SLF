<%-- 
    Document   : SLFSYS001
    Created on : Octuber, 2023, 20:04:04 PM
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
	String PageFile="/jsp/sys/SLFSYS001.jsp";  //#importtant
    

    //Variable
    String appid = Tools.chkNull(request.getParameter("appid"));
    String appname = Tools.chkNull(request.getParameter("appname"));
    String seq_no = Tools.chkNull(request.getParameter("seq_no"));
    String active_flag = Tools.chkNull(request.getParameter("active_flag"));

    //Flag
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
    <title>Admin</title>

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
        $(document).ready(function() {
            $('#example').DataTable();
        });

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



        function insert(){
            const f1 = document.getElementById("formInsert");
            if(f1.appid.value==""){
                alert("กรุณากรอกรหัสโปรแกรม");
                f1.appid.focus();
            }else if(f1.appname.value==""){
                alert("กรุณากรอกชื่อโปรแกรม");
                f1.appname.focus();
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
                alert("เพิ่มโปรแกรมสำเร็จ");
                window.location.href = "<%=contextPath%>/jsp/sys/SLFSYS001.jsp";
            }else{
                alert("อัปเดตโปรแกรมสำเร็จ");
                window.location.href = "<%=contextPath%>/jsp/sys/SLFSYS001.jsp";
            }
        }
    </script>
</head>
<body class="hold-transition sidebar-mini layout-fixed">

    
    <%
        //เพิ่มโปรแกรม
        if(inFlag.equals("INSERT")){
            try{
                
				sql="insert into slf_sso.appsys values('"+appid+"', '"+appname+"', '"+active_flag+"', "+seq_no+")";
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
                                sql4 = " SELECT * FROM slf_sso.appsys where appid = '"+aID+"' ";
                                //out.print(sql4);
                                stmt4 = con.createStatement();
                                rs4 = stmt4.executeQuery(sql4);
                                if(rs4.next()){
                                    String an = Tools.chkNull(rs4.getString("appname"));
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
                                                <label for="appname">App Name:</label>
                                                <input type="text" id="appname" name="appname" value="<%=an%>" class="form-control" oninput="lockInput(this, 50);">
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
                                                    <option value="">เลือกสถานะโปรแกรม</option>
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
                sql3=" update slf_sso.appsys set appname='"+appname+"', seq_no="+seq_no+" , active_flag='"+active_flag+"' where appid='"+aID2+"' ";
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
                            <h1 class="m-0"><b>SLF</b>PROGRAM</h1>
                        </div><!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="<%=contextPath + PageMain%>">หน้าแรก</a></li>
                            <li class="breadcrumb-item active">เพิ่มโปรแกรม</li>
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
                                        โปรแกรมทั้งหมดที่มีในระบบ
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
                                                    <th align="center">Program Id</th>
                                                    <th align="center">Program Name</th>
                                                    <th align="center">Seq</th>
                                                    <th align="center">Status</th>
                                                    <th align="center">Magn</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                        <%
                                            sql2 = " select appid, appname, seq_no, active_flag from slf_sso.appsys order by appid ";
                                            stmt2 = con.createStatement();
                                            rs2 = stmt2.executeQuery(sql2);
                                            int i=1;
                                            while(rs2.next()){
                                                String af = "";
                                                if(rs2.getString("active_flag").equals("Y")){
                                                    af = "<i class='fas fa-circle' style='color: #00ff33;'></i> กำลังใช้งานอยู่";
                                                }else{
                                                    af = "<i class='fas fa-circle' style='color: #e90707;'></i> ไม่ได้ใช้งาน";
                                                }
                                                
                                        %>
                                                <tr>
                                                    <td align="center"><%=i%></td> 
                                                    <td align="center"><%=rs2.getString("appid")%></td>
                                                    <td><%=rs2.getString("appname")%></td>
                                                    <td align="center"><%=rs2.getString("seq_no")%></td>
                                                    <td><%=af%></td>
                                                    <td align="center">
                                                        <button type="button" onClick="openMD('<%=rs2.getString("appid")%>');" class="icon-button"><i class="fas fa-edit fa-lg" style="color: #122222;"></i></button>
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
                                        เพิ่มโปรแกรม
                                    </h3>
                                </div><!-- /.card-header -->
                                <div class="card-body">
                                    <form action="" method="post" id="formInsert">
                                        <!-- First Row -->
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="appid">App ID:</label>
                                                    <input type="number" id="appid" name="appid" placeholder="รหัสโปรแกรม" class="form-control" oninput="lockInput(this, 5);">
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="appname">App Name:</label>
                                                    <input type="text" id="appname" name="appname" placeholder="ชื่อโปรแกรม" class="form-control" oninput="lockInput(this, 50);">
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
                                        <input type="hidden" name="inFlag" id="inFlag">
                                    </form>
                                </div><!-- /.card-body -->
                            </div>
                            <!-- /.card -->
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
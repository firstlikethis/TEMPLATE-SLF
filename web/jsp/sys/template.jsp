<%-- 
    Document   : SLFSYS002
    Created on : Octuber, 2023, 22:04:04 PM
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
        
    </style>

    <script>  
        
    </script>
</head>
<body class="hold-transition sidebar-mini layout-fixed">

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
                                    <h1>content here</h1>
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
                                                    <input type="text" id="appname" name="appname" placeholder="ชื่อโปรแกรม" class="form-control" oninput="lockInput(this, 50);">
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="logo_menu">App Name:</label>
                                                    <input type="text" id="logo_menu" name="logo_menu" placeholder="ชื่อโปรแกรม" class="form-control" oninput="lockInput(this, 50);">
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
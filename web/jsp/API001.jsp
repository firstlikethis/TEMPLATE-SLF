<%-- 
    Document   : API001
    Created on : Octuber, 2023, 22:04:04 PM
    Author     : Chakkri
--%>
<%@ page contentType="text/html; charset=windows-874" language="java" %>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="SLF_TOOL.*"%>
<%@ page import="com.pccth.utils.*"%>
<%@ page import="javax.crypto.Cipher" %>
<%@ page import="javax.crypto.spec.SecretKeySpec" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Random" %>

<%@ include file="../../menubar.jsp"%> <!--  #importtant -->
<%  
	request.setCharacterEncoding("windows-874"); 
    String PageMain="/jsp/API000.jsp";  //#importtant
	String PageFile="/jsp/API001.jsp";  //#importtant

    //Detail API
    String client_id = "eGJ1SVpZdk9adEtkVk9HdUJYYk0zc2FDMWhKWGVYajI";
    String redirect_uri = "https://slfmoigw-dev.studentloan.or.th/api/callback";
    String scope = Tools.chkNull(request.getParameter("scope"));
    //out.print(scope);
    String aa = "";
    String dates = "";

    //variable
    String firstId = Tools.chkNull(request.getParameter("firstId"));

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
    <title>Encrypt</title>

    <style>
    </style>
    <script>  

        //จำกัดจำนวนปุ่ม
        function lockInput(txt, values) {
            var value = txt.value;
            if (value.length > values) {
                txt.value = value.slice(0, values);
            }
        }


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
                                <li class="breadcrumb-item active">ทดสอบ API (encrypt)</li>
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
                        <!-- Left col -->
                        <section class="col-lg-12 connectedSortable">
                            <!-- Custom tabs (Charts with tabs)-->
                            <div class="card" style="display:none;">
                                <div class="card-header">
                                    <h3 class="card-title">
                                        <i class="fas fa-edit"></i>                                  
                                        เพิ่มเมนูของโปรแกรม
                                    </h3>
                                </div><!-- /.card-header -->
                                <div class="card-body">
                                    <form action="" method="post" id="formEnc">
                                        <!-- First Row -->
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="firstId">ID:</label>
                                                    <input type="number" id="firstId" name="firstId" placeholder="" class="form-control" oninput="lockInput(this, 13);">
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Submit button -->
                                        <button type="button" onClick="encrypt();" class="btn btn-primary">เข้ารหัส</button>
                                        <input type="hidden" name="encFlag">
                                    </form>
                                </div><!-- /.card-body -->
                            </div>
                            <!-- /.card -->




                            <!-- Custom tabs (Charts with tabs)-->
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">
                                        <i class="fas fa-edit"></i>                                  
                                        เพิ่มเมนูของโปรแกรม
                                    </h3>
                                </div><!-- /.card-header -->
                                <div class="card-body">
                                
                                   <%
                                        sql2 = " SELECT app_date, COUNT(*) AS count " +
                                                " FROM slf_deb3.reg_debt " +
                                                " GROUP BY app_date " +
                                                " HAVING COUNT(*) > 2 " +
                                                " ORDER BY count DESC ";

                                        stmt2 = con.createStatement();
                                        rs2 = stmt2.executeQuery(sql2);
                                        //out.print(sql2);
                                        

                                        while(rs2.next()){
                                            aa = Tools.chkNull(rs2.getString("app_date"));
                                            out.print(" "+aa);
                                            //out.print(" "+aa);
                                            dates += aa + " ";

                                        }stmt2.close();
                                        rs2.close();
                                   %>


                                   <input type="text" name="flag_hidden" id="flag_hidden" value="<%=dates.trim()%>">
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


        
        const keepValues = document.getElementById("flag_hidden").value;
        const dateArray = keepValues.split(' ');

        const arrayDate = [...dateArray];

        const lastValue = JSON.stringify(arrayDate);
        console.log(lastValue);


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
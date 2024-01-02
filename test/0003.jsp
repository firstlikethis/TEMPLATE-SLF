<%-- 
    Document   : SLFSYS003
    Created on : Octuber, 2023, 11:55:09 AM
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
    String proid = Tools.chkNull(request.getParameter("proid"));
    String proname = Tools.chkNull(request.getParameter("proname"));
    String filename = Tools.chkNull(request.getParameter("filename"));
    String procode = Tools.chkNull(request.getParameter("procode"));
    String menuname = Tools.chkNull(request.getParameter("menuname"));
    String appname = Tools.chkNull(request.getParameter("appname"));
    String seq_no = Tools.chkNull(request.getParameter("seq_no"));
    String active_flag = Tools.chkNull(request.getParameter("active_flag"));
    String promain = Tools.chkNull(request.getParameter("promain"));

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
        //icons copie
        document.addEventListener('DOMContentLoaded', function() {
            var clipboard = new ClipboardJS('.copy-icon-class');

            clipboard.on('success', function(e) {
                e.clearSelection();
                alert('��ͺ������������: ' + e.text);
            });

            clipboard.on('error', function(e) {
                alert('�Դ��ͼԴ��Ҵ');
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

        //�ӡѴ�ӹǹ����
        function lockInput(txt, values) {
            var value = txt.value;
            if (value.length > values) {
                txt.value = value.slice(0, values);
            }
        }

        function insert(){
            const f1 = document.getElementById("formInsert");
            if(f1.proid.value==""){
                alert("��سҡ�͡�������");
                f1.proid.focus();
            }else if(f1.proname.value==""){
                alert("��سҡ�͡�������");
                f1.proname.focus();
            }else if(f1.filename.value==""){
                alert("��س���鹷ҧ�ͧ���");
                f1.filename.focus();
            }else if(f1.appname.value==""){
                alert("��سҡ�͡���������");
                f1.appname.focus();
            }else if(f1.menuname.value==""){
                alert("��سҡ�͡��������");
                f1.menuname.focus();
            }else if(f1.procode.value==""){
                alert("��سҡ�͡�����");
                f1.procode.focus();
            }else if(f1.seq_no.value==""){
                alert("��سҡ�͡�ӴѺ�����");
                f1.seq_no.focus();
            }else if(f1.active_flag.value==""){
                alert("��سҡ�͡ʶҹ������");
                f1.active_flag.focus();
            }else if(f1.promain.value==""){
                alert("��س����͡˹��");
                f1.promain.focus();
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
                alert("������������");
                window.location.href = "<%=contextPath%>/jsp/sys/SLFSYS003.jsp";
            }else{
                alert("�ѻവ��������");
                window.location.href = "<%=contextPath%>/jsp/sys/SLFSYS003.jsp";
            }
        }

        function fawesome() {
            window.open("https://fontawesome.com/v5/search?o=r&m=free", "_blank");
        }
    </script>
</head>
<body class="hold-transition sidebar-mini layout-fixed">



    <%
        //���������
        if(inFlag.equals("INSERT")){
            try{
                
				sql=" insert into slf_sso.programsys(proid,proname,filename,appname,menuname,procode,active_flag,seq_no,promain) values('"+proid+"','"+proname+"', '"+filename+"' ,'"+appname+"', '"+menuname+"', '"+procode+"', '"+active_flag+"', "+seq_no+",'"+promain+"') ";
                //out.print(sql);
                stmt = con.createStatement();
                int insert = stmt.executeUpdate(sql);
                if(insert > 0){
                    out.print("<script>success('Y');</script>");
                    con.commit();
                }else{
                    out.print("�Դ��ͼԴ��Ҵ㹡�����������");
                }stmt.close();

            }catch(Exception ee){
                out.print("Error on insert="+ee.toString());
            }
        }

        //�Ѿവ�����
        if(openModal.equals("open")){
            try{
    %>
            <!-- The Modal -->
            <div class="modal" id="myModal">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <form method="post" id="formUPmodal">
                            <input type="hidden" name="upFlag" id="upFlag">
                            <%
                                sql4 = " SELECT * FROM slf_sso.programsys where proid = '"+aID+"' ";
                                //out.print(sql4);
                                stmt4 = con.createStatement();
                                rs4 = stmt4.executeQuery(sql4);
                                if(rs4.next()){
                                    String an = Tools.chkNull(rs4.getString("proname"));
                                    String pm = Tools.chkNull(rs4.getString("promain"));
                            %>
                                <!-- Modal Header -->
                                <div class="modal-header">
                                    <h4 class="modal-title"><i class="fas fa-sync fa-spin"></i> ��� <%=an%></h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>

                                <!-- Modal body -->
                                <div class="modal-body">
                                    <div class="row">

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="proname">File Menu Name:</label>
                                                <input type="text" id="proname" name="proname" value="<%=an%>" class="form-control" oninput="lockInput(this, 50);">
                                            </div>
                                        </div>

                                        <div class="col-md-5">
                                            <div class="form-group">
                                                <label for="filename">Path:</label>
                                                <input type="text" id="filename" name="filename" value="<%=Tools.chkNull(rs4.getString("filename"))%>" class="form-control" oninput="lockInput(this, 50);">
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label for="procode">File Code:</label>
                                                <input type="text" id="procode" name="procode" value="<%=Tools.chkNull(rs4.getString("procode"))%>" class="form-control" oninput="lockInput(this, 10);">
                                            </div>
                                        </div>
                                    
                                    </div>


                                    <div class="row">

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="appname">Program Name:</label>
                                                <input type="text" id="appname" name="appname" value="<%=Tools.chkNull(rs4.getString("appname"))%>" class="form-control" oninput="lockInput(this, 50);">
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="menuname">Menu Name:</label>
                                                <input type="text" id="menuname" name="menuname" value="<%=Tools.chkNull(rs4.getString("menuname"))%>" class="form-control" oninput="lockInput(this, 50);">
                                            </div>
                                        </div>
                                        
                                    </div>

                                    <div class="row">

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="seq_no">Seq:</label>
                                                <input type="number" id="seq_no" name="seq_no" value="<%=rs4.getString("seq_no")%>" class="form-control" oninput="lockInput(this, 3);">
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="active_flag">Status:</label>
                                                <select id="active_flag" name="active_flag" class="form-control">
                                                    <option value="">���͡ʶҹ�����</option>
                                                    <option value="Y" <% if (rs4.getString("active_flag").equals("Y")) { %>selected<% } %>>��ҹ</option>
                                                    <option value="N" <% if (rs4.getString("active_flag").equals("N")) { %>selected<% } %>>�����ҹ</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="promain">Page:</label>
                                                <select id="promain" name="promain" class="form-control">
                                                    <option value="">���͡˹��</option>
                                                    <option value="Y" <% if (pm.equals("Y")) { %>selected<% } %>>˹���á</option>
                                                    <option value="N" <% if (pm.equals("N")) { %>selected<% } %>>˹���ͧ</option>
                                                </select>
                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <!-- Modal footer -->
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">�Դ˹�ҵ�ҧ</button>
                                    <button type="button" onClick="update('<%=aID%>');" class="btn btn-primary">�ѹ�֡</button>
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
                sql3=" update slf_sso.programsys set proname='"+proname+"', filename='"+filename+"' ,procode='"+procode+"' , appname='"+appname+"', menuname='"+menuname+"', seq_no = '"+seq_no+"' , active_flag='"+active_flag+"', promain='"+promain+"' where proid='"+aID2+"' ";
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
                            <h1 class="m-0"><b>SLF</b>Program Menu Path</h1>
                        </div><!-- /.col -->
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="<%=contextPath + PageMain%>">˹���á</a></li>
                            <li class="breadcrumb-item active">������������</li>
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


                    <!-- Top col -->
                        <section class="col-lg-12 connectedSortable">
                            <!-- Custom tabs (Charts with tabs)-->
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">
                                        <i class="fas fa-edit"></i>                                  
                                        �������٢ͧ�����
                                    </h3>
                                </div><!-- /.card-header -->
                                <div class="card-body">
                                    <form action="" method="post" id="formInsert">
                                        <input type="hidden" name="inFlag" id="inFlag">
                                        <!-- First Row -->
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="proid">File ID:</label>
                                                    <input type="number" id="proid" name="proid" placeholder="�������" class="form-control" oninput="lockInput(this, 5);">
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="proname">File Menu Name:</label>
                                                    <input type="text" id="proname" name="proname" placeholder="�����������" class="form-control" oninput="lockInput(this, 50);">
                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="filename">Path:</label>
                                                    <input type="text" id="filename" name="filename" placeholder="��鹷ҧ�ͧ���" class="form-control" oninput="lockInput(this, 50);">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="appname">Program Name:</label>
                                                    <input type="text" id="appname" name="appname" placeholder="���������" class="form-control" oninput="lockInput(this, 50);">
                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="menuname">Menu Name:</label>
                                                    <input type="text" id="menuname" name="menuname" placeholder="��������" class="form-control" oninput="lockInput(this, 50);">
                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="procode">File Code:</label>
                                                    <input type="text" id="procode" name="procode" placeholder="�����" class="form-control" oninput="lockInput(this, 10);">
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Second Row -->
                                        <div class="row">
                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <label for="seq_no">Seq:</label>
                                                    <input type="number" id="seq_no" name="seq_no" placeholder="�ӴѺ�ͧ�����" class="form-control" oninput="lockInput(this, 3);">
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="active_flag">Status:</label>
                                                    <select id="active_flag" name="active_flag" class="form-control">
                                                        <option value="">���͡ʶҹ������</option>
                                                        <option value="Y">��ҹ</option>
                                                        <option value="N">�����ҹ</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="promain">Page:</label>
                                                    <select id="promain" name="promain" class="form-control">
                                                        <option value="">���͡˹��</option>
                                                        <option value="Y">˹���á</option>
                                                        <option value="N">˹���ͧ</option>
                                                    </select>
                                                </div>
                                            </div>
                                                                                                               
                                        </div>

                                        <!-- Submit button -->
                                        <button type="button" onClick="insert();" class="btn btn-primary">�ѹ�֡</button>
                                    </form>
                                </div><!-- /.card-body -->
                            </div>
                            <!-- /.card -->
                        </section>

















                        
                        <!-- bottom col -->
                        <section class="col-lg-12 connectedSortable">
                            <!-- Custom tabs (Charts with tabs)-->
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">
                                        <i class="fas fa-database"></i>
                                        ���ٷ������������к�
                                    </h3>
                                </div><!-- /.card-header -->
                                <div class="card-body">
                                    <form action="" method="post" id="formUpdate">
                                        <input type="hidden" name="aID" id="aIDInput" value="">
                                        <input type="hidden" name="openModal" id="openModal">
                                        <table class="table table-bordered" id="example">
                                            <thead>
                                                <tr>
                                                    <th><center>No</center></th>
                                                    <th><center>File ID</center></th>
                                                    <th><center>File Menu Name</center></th>
                                                    <th><center>Path</center></th>
                                                    <th><center>Page</center></th>
                                                    <th><center>Program Name</center></th>
                                                    <th><center>Menu Name</center></th>
                                                    <th><center>File Code</center></th>
                                                    <th><center>Seq</center></th>
                                                    <th><center>Status</center></th>
                                                    <th><center>Magn</center></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                        <%
                                            sql2 = " select proid, proname,nvl(promain,'-') as promain, filename, nvl(appname,'-') as appname, nvl(menuname,'-') as menuname, procode, SEQ_NO, ACTIVE_FLAG from slf_sso.programsys order by proid ";
                                            stmt2 = con.createStatement();
                                            rs2 = stmt2.executeQuery(sql2);
                                            int i=1;
                                            while(rs2.next()){
                                                String af = "";
                                                if(rs2.getString("active_flag").equals("Y")){
                                                    af = "<i class='fas fa-circle' style='color: #00ff33;'></i> ���ѧ��ҹ����";
                                                }else{
                                                    af = "<i class='fas fa-circle' style='color: #e90707;'></i> �������ҹ";
                                                }

                                                String pm = "";
                                                if(rs2.getString("promain").equals("Y")){
                                                    pm = "˹����ѡ";
                                                }else if(rs2.getString("promain").equals("N")){
                                                    pm = "˹���ͧ";
                                                }
                                                
                                        %>
                                                <tr>
                                                    <td align="center"><%=i%></td> 
                                                    <td align="center"><%=rs2.getString("proid")%></td>                                           
                                                    <td><%=rs2.getString("proname")%></td>
                                                    <td align="center"><%=rs2.getString("filename")%></td>   
                                                    <td><%=pm%></td>
                                                    <td align="center"><%=rs2.getString("appname")%></td>
                                                    <td align="center"><%=rs2.getString("menuname")%></td>
                                                    <td align="center"><%=rs2.getString("procode")%></td>
                                                    <td align="center"><%=rs2.getString("seq_no")%></td>
                                                    <td><%=af%></td>
                                                    <td align="center">
                                                        <button type="button" onClick="openMD('<%=rs2.getString("proid")%>');" class="icon-button"><i class="fas fa-edit fa-lg" style="color: #122222;"></i></button>
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

                        




                    </div>
                    <!-- /.row (main row) -->
                </div><!-- /.container-fluid -->
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
        
      <!-- /.content-wrapper -->
      <footer class="main-footer">
          <strong>Copyright &copy; 2566 - Now <a href="https://www.studentloan.or.th/th/home">�ͧ�ع�Թ�����������͡���֡��</a>.</strong>
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
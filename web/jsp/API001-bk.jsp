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
    int length = 10;
    String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    Random random = new Random();
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < length; i++) {
        int index = random.nextInt(characters.length());
        char randomChar = characters.charAt(index);
        sb.append(randomChar);
    }
    String randomString = sb.toString();

	request.setCharacterEncoding("windows-874"); 
    String PageMain="/jsp/API000.jsp";  //#importtant
	String PageFile="/jsp/API001.jsp";  //#importtant

    //Detail API
    String client_id = "eGJ1SVpZdk9adEtkVk9HdUJYYk0zc2FDMWhKWGVYajI";
    String redirect_uri = "https://slfmoigw-dev.studentloan.or.th/api/callback";
    String scope = Tools.chkNull(request.getParameter("scope"));
    //out.print(scope);
    
    

    //variable
    String firstId = Tools.chkNull(request.getParameter("firstId"));

    //Flag
    String encFlag = Tools.chkNull(request.getParameter("encFlag"));



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
        function encrypt(){
            const f1 = document.getElementById("formEnc");

            if(f1.firstId.value==""){
                alert("ใส่ข้อความก่อนดิ");
                f1.firstId.focus();
            }else{
                f1.encFlag.value="enc";
                f1.submit();
            }
        }

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

        function auRequest() {
            const f1 = document.getElementById("AuthenRequest");
            f1.setAttribute("method", "get");
            f1.setAttribute("enctype", "application/x-www-form-urlencoded");
            f1.setAttribute("target", "_blank");
            f1.setAttribute("action", "https://imauth.bora.dopa.go.th/api/v2/oauth2/auth/");
            f1.submit();
        }



    </script>
</head>
<body class="hold-transition sidebar-mini layout-fixed">

<%
    class AESBase64 {
        private final String secretKey = "YjRxZDhsRVplMXc5VGQ5bHNNcEt4ZVNsZm1HR1ZFcmpUZFMyY3RPZA";

        private SecretKeySpec generateKey() throws Exception {
            byte[] keyBytes = secretKey.getBytes("UTF-8");
            MessageDigest sha = MessageDigest.getInstance("SHA-256");
            keyBytes = sha.digest(keyBytes);
            keyBytes = Arrays.copyOf(keyBytes, 16);
            return new SecretKeySpec(keyBytes, "AES");
        }

        public String encrypt(String message) throws Exception {
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.ENCRYPT_MODE, generateKey());
            byte[] encryptedBytes = cipher.doFinal(message.getBytes());
            return Base64.getEncoder().encodeToString(encryptedBytes);
        }

        public String decrypt(String textEncrypt) throws Exception {
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, generateKey());
            byte[] decryptedBytes = cipher.doFinal(Base64.getDecoder().decode(textEncrypt));
            return new String(decryptedBytes);
        }
    }

    AESBase64 aesBase64 = new AESBase64();
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
                            <div class="card">
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

                                    <%
                                        if(encFlag.equals("enc")){
                                            /**
                                            String pin = aesBase64.encrypt(firstId);
                                            String dpin = aesBase64.decrypt(pin);

                                            out.print("<br>enc="+pin);
                                            out.print("<br>dnc="+dpin);
                                            **/

                                    %>  
                                                <!-- The Modal -->
                                                <div class="modal" id="myModal">
                                                    <div class="modal-dialog modal-xl">
                                                        <div class="modal-content">
                                                            <form action="" method="" id="AuthenRequest"> 
                                                                <!-- Modal Header -->
                                                                <div class="modal-header">
                                                                    <h4 class="modal-title"><i class="fas fa-sync fa-spin"></i> Authentication Request</h4>
                                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                </div>  
                                                                <!-- Modal body -->
                                                                <div class="modal-body">
                                                                    <!-- First Row -->
                                                                    <div class="row">
                                                                        <div class="col-md-12">
                                                                            <div class="form-group">

                                                                            
                                                                                <input type="hidden" class="form-control" name="response_type" value="code" placeholder="Response Type">
                                                                                <input type="hidden" class="form-control" name="client_id" value="<%=client_id%>" placeholder="Client ID">
                                                                                <input type="hidden" class="form-control" name="redirect_uri" value="<%=redirect_uri%>" placeholder="Redirect_uri">
                                                                        
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="pid" value="pid">
                                                                                    <label class="form-check-label" for="pid">pid (หมายเลขประจำตัวประชาชน 13 หลัก)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="name" value="name">
                                                                                    <label class="form-check-label" for="name">name (ชื่อ นามสกุล ภาษาไทย)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="name_en" value="name_en">
                                                                                    <label class="form-check-label" for="name_en">name_en (ชื่อ นามสกุล ภาษาอังกฤษ)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="birthdate" value="birthdate">
                                                                                    <label class="form-check-label" for="birthdate">birthdate (วัน เดือน ปี ค.ศ.เกิด)</label>
                                                                                </div>

                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="address" value="address">
                                                                                    <label class="form-check-label" for="address">address (ที่อยู่ตามหน้าบัตรประจำตัวประชาชน)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="given_name" value="given_name">
                                                                                    <label class="form-check-label" for="given_name">given_name (ชื่อ ภาษาไทย)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="middle_name" value="middle_name">
                                                                                    <label class="form-check-label" for="middle_name">middle_name (ชื่อกลาง ภาษาไทย)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="family_name" value="family_name">
                                                                                    <label class="form-check-label" for="family_name">family_name (นามสกุล ภาษาไทย)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="given_name_en" value="given_name_en">
                                                                                    <label class="form-check-label" for="given_name_en">given_name_en (ชื่อ ภาษาอังกฤษ)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="middle_name_en" value="middle_name_en">
                                                                                    <label class="form-check-label" for="middle_name_en">middle_name_en (ชื่อกลาง ภาษาอังกฤษ)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="family_name_en" value="family_name_en">
                                                                                    <label class="form-check-label" for="family_name_en">family_name_en (นามสกุล ภาษาอังกฤษ)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="gender" value="gender">
                                                                                    <label class="form-check-label" for="gender">gender (เพศ)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="smartcard_code" value="smartcard_code">
                                                                                    <label class="form-check-label" for="smartcard_code">smartcard_code (เลขใต้รูป)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="title" value="title">
                                                                                    <label class="form-check-label" for="title">title (คำนำหน้านามภาษาไทย)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="title_en" value="title_en">
                                                                                    <label class="form-check-label" for="title_en">title_en (คำนำหน้านามภาษาอังกฤษ)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="ial" value="ial">
                                                                                    <label class="form-check-label" for="ial">ial (ระดับความเข้มข้นในการพิสูจน์ตัวตน)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="date_of_issuance" value="date_of_issuance">
                                                                                    <label class="form-check-label" for="date_of_issuance">date_of_issuance (วันที่ออกบัตร)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="date_of_expiry" value="date_of_expiry">
                                                                                    <label class="form-check-label" for="date_of_expiry">date_of_expiry (วันที่บัตรหมดอายุ)</label>
                                                                                </div>
                                                                                <div class="form-check">
                                                                                    <input class="form-check-input" type="checkbox" name="scope" id="openid" value="openid">
                                                                                    <label class="form-check-label" for="openid">openid (id_token ที่มีข้อมูลผู้ใช้บริการที่ RP ร้องขอ)</label>
                                                                                </div>

                                                                                <input type="hidden" name="state" value="<%=randomString%>">



                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                
                                                                <!-- Modal footer -->
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">ปิดหน้าต่าง</button>
                                                                    <button type="button" onClick="auRequest();" class="btn btn-primary">ยืนยัน</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                                    

                                    <%
                                        }

                                    %>




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
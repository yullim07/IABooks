<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
   String ctxPath = request.getContextPath();
   
%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_header_footer.css" />

<style type="text/css">

div#top {
      text-align : center;
      margin-top: 3%;
      padding: 20px;
   }
   
   div#IdPasswd {
      text-align : center;
      
   }
   
   div#loginbutton {
      text-align: center;
      margin-top:20px;
      margin-bottom:20px;
   }
   
   div#loginbutton:hover img {
      filter: brightness(70%);
   }
   
   
   div#small{
      text-align : center;
   }
    
   }
   div#link > a {
      text-decoration-line: none; 
      color:gray;
      font-weight : bold;
   }
   
   .LOGIN {
      height: 50px;
      width:400px;
      
   }


</style>
<title>로그인</title>
<jsp:include page="/WEB-INF/header.jsp"/>
<script type="text/javascript">
 
    $(document).ready(function(){
       /* var 변수명 = '1234';
       선택자.attr('value',변수명); */
       if(localStorage.getItem("keep") != null){
          var gab   = localStorage.getItem("keep");
          $('#loginUserid').attr('value', gab );
          $('#keep').attr('checked', "checked");
       }
       
       
      $("button#btnSubmit").click(function(){
         goLogin(); // 로그인 시도한다.
      });
      
      $("input#loginPwd").bind("keydown", function(event){
         if(event.keyCode == 13) { // 암호입력란에 엔터를 했을 경우
            goLogin(); // 로그인 시도한다.
         }
      });
      
   }); // end of $(document).ready(function(){})--------------------

// Function Declration
// == 로그인 처리 함수 = //
function goLogin() {
   
   const loginUserid = $("input#loginUserid").val().trim();
   const loginPwd = $("input#loginPwd").val().trim();
   
   if(loginUserid == ""){
      alert("아이디를 입력하세요!!");
      $("input#loginUserid").val("");
      $("input#loginUserid").focus();
      return; // goLogin() 함수 종료
   }
   
   if(loginPwd == ""){
      alert("암호를 입력하세요!!");
      $("input#loginPwd").val("");
      $("input#loginPwd").focus();
      return; // goLogin() 함수 종료
   }
   
   
   /* function show() { */
   
      if( $("input:checkbox[id='keep']").prop("checked") ) {
         localStorage.setItem('keep',$("input#loginUserid").val());
      }
      else {
         localStorage.removeItem('keep');
      }
   
   
   const frm = document.loginFrm;
   frm.action = "<%=request.getContextPath()%>/login/login.book"
   frm.method = "post"; 
   frm.submit();
    
} // end of function goLogin()------------------------


</script>

<div class="container">
   
   <div id = "top">
    <h1 style = "font-size: 40pt;">LOGIN</h1>
    <h6>WELCOME BACK</h6>
    </div>
       <form name="loginFrm">
         <div id = "IdPasswd">
            <input type="text" id="loginUserid" class="LOGIN" name="userid" size="30" placeholder="ID" ><br><br>
         
            <input type="password" id="loginPwd" class="LOGIN" name="pwd" size="30" placeholder="Password"><br><br>
         </div>
         <div id = "loginbutton">
            <img src="<%=ctxPath%>/images/member/btn_login.gif" style= "cursor:pointer;" onclick="goLogin()">
         </div>
         <div id = "small">
            <input type="checkbox" id="keep" class="input_keep" value="off">아이디 저장&nbsp;&nbsp;<img src="<%=ctxPath%>/images/member/dot_notice.gif"/>&nbsp;<span>보안접속</span>
         <hr style = "width:275px;">
         <div id = "link">
            <a href="<%= ctxPath %>/login/idFind.book" >아이디 찾기</a>&nbsp;
            <a href="<%= ctxPath %>/login/pwdFind.book">비밀번호 찾기</a>&nbsp;
            <a href="<%= ctxPath %>/member/memberRegister.book">회원가입</a><br>
         </div>
         <hr style = "width:275px;"><br>
         </div>
      </form>
      
</div>
   
<jsp:include page="/WEB-INF/footer.jsp"/>
 
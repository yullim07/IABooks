<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    
%>



<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/style_member.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<style type="text/css">

	#div_pwd {
      width: 70%;
      height: 15%;
      margin-bottom: 5%;
      margin-left: 10%;
      position: relative;
   }
   
   	#div_pwd2 {
      width: 70%;
      height: 15%;
      margin-bottom: 5%;
      margin-left: 10%;
      position: relative;
   }
   
   	#div_updateResult {
      width: 90%;
      height: 15%;
      margin-bottom: 5%;
      text-align: center;
	  font-weight: bold;
	  color: firebrick;
	  font-size: 14pt;
      position: relative;
   }
   
   	#div_btnUpdate {
      width: 70%;
      height: 15%;
      margin-bottom: 5%;
      margin-left: 10%;
      position: relative;
   }
   
   .text{
   	height: 40px;
   }
   
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("button#btnUpdate").click(function(){
			
			const pwd = $("input#pwd").val();
			const pwd2 = $("input#pwd2").val();
			
				// const regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
			   	// 또는
				
			   	const regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
			   	// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
				
			   	
				const bool = regExp.test(pwd);   
				  
				  if(!bool) {
					  // 암호가 정규표현식에 위배된 경우 
					  alert("암호는 8글자 이상 15글자 이하에 영문자,숫자,특수기호가 혼합되어야만 합니다.")
					  $("input#pwd").val("");
					  $("input#pwd2").val("");
					  return; // 종료
				  }
				  else if(bool && pwd != pwd2){
					  alert("암호가 일치하지 않습니다.")
					  $("input#pwd").val("");
					  $("input#pwd2").val("");
					  return; // 종료
				  }
				  else {
					  const frm = document.pwdUpdateEndFrm;
					  frm.action = "<%= ctxPath%>/login/pwdUpdateEnd.book";
					  frm.method = "post";
					  frm.submit();
				  }
					  
		});
		
	});// end of $(document).ready(function()-----------

</script>
<title>비밀번호 변경</title>
<jsp:include page="/WEB-INF/header.jsp"/>
<div class="container">
	<div class="titleArea">
		<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;비밀번호 변경</strong>
    </div>
	<hr style="border: solid 2px #e8e8e8; margin-bottom:8rem;">
<form name="pwdUpdateEndFrm">

	<div id="div_pwd" align="center">
      	<span style="color: gray; font-size: 16pt;"><strong>새암호</strong></span><br/> 
      	<input type="password" class="text" name="pwd" id="pwd" size="30" placeholder="PASSWORD" required />
   	</div>
   
   	<div id="div_pwd2" align="center">
        <span style="color: gray; font-size: 16pt;"><strong>새암호확인</strong></span><br/>
      	<input type="password" class="text" id="pwd2" size="30" placeholder="PASSWORD" required />
   	</div>

	<c:if test="${requestScope.method == 'GET'}">
		<div id="div_btnUpdate" align="center">
	        <button type="button" style= "font-weight: bold;" class="btn btn-success" id="btnUpdate">암호변경하기</button>
	    </div>
	</c:if>
	
	<c:if test="${requestScope.method == 'POST' && requestScope.n == 1}">
		<div id="div_updateResult" align="center">
			사용자 ID ${requestScope.userid} 님의 암호가 새로이 변경되었습니다.<br/>
	    </div>
	</c:if>
</form>
</div>
<jsp:include page="/WEB-INF/footer.jsp"/>
	
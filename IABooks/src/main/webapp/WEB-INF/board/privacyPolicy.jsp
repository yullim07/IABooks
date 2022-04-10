<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">

</style>

	  
<meta charset="UTF-8">
<title>개인정보처리방침</title>



<jsp:include page="/WEB-INF/header.jsp"/>


<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/jeong_css/semi_style.css" />

<style type="text/css">

	/* #PP_outer {
		width: 100%;
		border: solid 1px #d7d5d5;
		background-color: #fbfafa;
		min-height: 1000px;
	}
	
	
	#PP_inner {
		padding: 20px;
	    border: 1px solid #e8e8e8;
	    color: #404040;
	    min-height: 980px;
	}
	
	#PP_content {
		padding: 20px;
	    border: 1px solid #d7d5d5;
	    background-color: #fff;
	    min-height: 960px;
	    font-size: 14px;
	} */
	
	/* privacy_policy.jsp 서식 끝  */

</style>

<script type="text/javascript">
		
		$(document).ready(function(){
			
		});
	
	</script>

 <div class="container">
  	<div class="title" >
	  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_heading.gif" /></div>
	  	<h2>개인정보처리방침</h2>
   
  	</div>
  	
  	<div id="PP_outer">
  		
  		<div id="PP_inner">
  			
  			<div id="PP_content">
  				<p>
  					(주)연지출판사은 (이하 "회사"는) 고객님의 개인정보를 중요시하며, "정보통신망 이용촉진 및 정보보호"에 관한 법률을 준수하고 있습니다.

					회사는 개인정보처리방침을 통하여 고객님께서 제공하시는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.
					
					■ 수집하는 개인정보 항목 및 수집방법
					가. 수집하는 개인정보의 항목
					o 회사는 회원가입, 상담, 서비스 신청 등을 위해 아래와 같은 개인정보를 수집하고 있습니다.
					- 회원가입시 : 이름 , 생년월일 , 성별 , 로그인ID , 비밀번호 , 자택 전화번호 , 휴대전화번호 , 이메일 , 14세미만 가입자의 경우 법정대리인의 정보
					- 서비스 신청시 : 주소, 결제 정보
					
					o 서비스 이용 과정이나 사업 처리 과정에서 서비스이용기록, 접속로그, 쿠키, 접속 IP, 결제 기록, 불량이용 기록이 생성되어 수집될 수 있습니다.
  				</p>
  				
  			</div>
  			
  		</div>
  		
  	</div>




</div> <!-- container 끝 -->


<jsp:include page="/WEB-INF/footer.jsp"/>
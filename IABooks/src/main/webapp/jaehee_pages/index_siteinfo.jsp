<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">

</style>

	  
<meta charset="UTF-8">
<title>인디펍 :: 독립출판 온라인 서점</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jaehee_pages/semicss/semi_style.css" />


<script type="text/javascript">
	
	$(document).ready(function(){
		
	
	});

</script>


<jsp:include page="../header.jsp"/>

	
<div class="container">

<div class="contents">
  <div class="title" >
  	<div class="title_icon" ><img src="<%= ctxPath%>/jaehee_pages/semi_images/ico_heading.gif" /></div>
  	<h2 >이용안내</h2>
  	
    
  </div>
  <p class="mb-3"></p>
  
  <div class="info_list">
  	<div id="member" >
  		<ul class="menu" style="display: inline-block;">
  			<li class="selected">
  				<a href="#member">회원가입 안내</a>
  			</li>
  			<li>
  				<a href="#order">주문 안내</a>
  			</li>
  			<li>
  				<a href="#payment">결제 안내</a>
  			</li>
  			<li>
  				<a href="#delivery">배송 안내</a>
  			</li>
  			<li>
  				<a href="#chage">교환/반품 안내</a>
  			</li>
  			<li>
  				<a href="#refund">환불 안내</a>
  			</li>
  			<li>
  				<a href="#etc">기타 안내</a>
  			</li>
  			
  		</ul>
  		<div>
  			<h3>회원가입 안내</h3>
  			<div>
  				[회원가입] 메뉴를 통해 이용약관, 개인정보보호정책 동의 및 일정 양식의 가입항목을 기입함으로써 회원에
				가입되며, 가입 즉시 서비스를 무료로 이용하실 수 있습니다.
				<br>
				주문하실 때에 입력해야하는 각종 정보들을 일일이 입력하지 않으셔도 됩니다. 인디펍에서 제공하는 다양한 혜택 및 각종 이벤트에 참여하실 수 있습니다.
				
  			</div>
  		</div>
  	
  	</div>
  </div>
		
  
</div>
</div>


	
<jsp:include page="../footer.jsp"/>
 
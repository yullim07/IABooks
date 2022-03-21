<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">

</style>

	  
<meta charset="UTF-8">
<title>타인의 책장</title>

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
  	<h2 >타인의 책장</h2>
  	<div class="bar_icon" ><img src="<%= ctxPath%>/jaehee_pages/semi_images/bar_eee.gif" /></div>
  	<span >후기를 작성하는 공간입니다.</span>
    
  </div>
  <p class="mb-3"></p>
  
  <div class="pdt_img_info">
  	<p><img src="//indiepub.kr/web/product/tiny/202112/f449e3d8f488e8ca32e413dade853e84.jpg"/></p>
  	<div class="pdt_info">
  		<h3><a href="#">직업이 술꾼입니다!</a></h3>
  		<p>16,000원</p>
  		<button class="button" type="button"><a>상품 상세보기</a></button>
  	</div>
  </div>
 	
    
  
</div>
</div>


	
<jsp:include page="../footer.jsp"/>
 
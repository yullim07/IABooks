<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>

<%
    String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>

<head>

	<title>header</title>
	
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
	
	<!-- Bootstrap Icons -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
	
	<!-- Font Awesome 5 Icons -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	
	<!-- 직접 만든 CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style_header_footer.css" />
	
	<!-- Optional JavaScript -->
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>
	 
	<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
	<script type="text/javascript">
		
		$(document).ready(function(){
			
			
		});
	</script>
</head>

<body>


<!-- ======= Header ======= -->
<header>

	<div class="container">
		<nav id="navbar" class="navbar">
			<ul class="justify-content-end ml-auto">     		
				<!-- <li><a class="nav-link scrollto" href="#">즐겨찾기</a></li> -->
          		<li class="bar"><a class="nav-link scrollto" href="#">로그인</a></li>
          		<li class="bar bulkhead"><a class="nav-link scrollto" href="#">회원가입</a></li>
				<li class="bar bulkhead"><a class="" href="#">장바구니</a></li>
          		<li class="bar bulkhead"><a href="#">마이페이지</a>
           		<li class="dropdown bulkhead"><a href="#">마이페이지<i class="bi bi-chevron-down dropdown-indicator"></i></a>
					<ul>
						<li><a href="#">주문조회</a></li>
						<li><a href="#">배송조회</a></li>
						<li><a href="#">관심상품</a></li>
						<li><a href="#">내게시물</a></li>
            		</ul>
          		</li>
          
				<li class="dropdown bulkhead"><a href="#">고객센터<i class="bi bi-chevron-down dropdown-indicator"></i></a>
            		<ul>
              			<li><a href="#">자주 묻는 질문</a></li>
						<li><a href="#">1:1문의</a></li>
					</ul>
				</li>
				
			</ul>
        	<i class="bi bi-list mobile-nav-toggle d-none"></i>
		</nav>
	</div>
</header>



<div class="divClear"></div>

<div class="container">    
	<div class="d-none d-lg-block">
		<a href="#" style="display: inline-block;">
			<img src="<%= ctxPath%>/images/logo.png" alt="로고"/>
    	</a>
       
		<div class="search_section">
			<form class="searchBarForm" name="" action="/product/search.html" method="get" target="_self" enctype="multipart/form-data" >
				<fieldset>
		      		<input type="text"  class="inputTypeText" name="keyword" onmousedown="" >
		      		<input type="image" class="inputTypeImage" onclick="" src="<%= ctxPath%>/images/search_btn.png" alt="검색" >
				</fieldset>
			</form>    
		</div>
		
	</div>	
</div>	

<div class="container">
	<div id="categorie">
		<nav id="navbar2" class="navbar">
			<ul class="justify-content-start">     
				<li class="dropdown"><a class="" href="#">카테고리 전체보기<i class="bi bi-chevron-down dropdown-indicator"></i></a>
					<ul>
						<li><a href="#">종합</a></li>
						<li><a href="#">인문</a></li>
						<li><a href="#">사회</a></li>
						<li><a href="#">과학</a></li>
            		</ul>
          		</li>		
				
          		<li class=""><a class="" href="#">Best 30</a></li>
				<li class="bulkhead"><a class="" href="#">신간</a></li>
				<li class="bulkhead"><a class="" href="#">구간의 재발견</a></li>
          		<li class="bulkhead"><a class="" href="#">구간의 재발견</a></li>	
			</ul>
		</nav>
	</div>
</div>
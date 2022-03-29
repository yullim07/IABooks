<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="<%=ctxPath %>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">

	<!-- Optional JavaScript -->
    <script src="<%=ctxPath %>/js/jquery-3.6.0.min.js" type="text/javascript"></script>
    <script src="<%=ctxPath %>/bootstrap-4.6.0-dist/js/bootstrap.bundle.js" type="text/javascript"></script>
    
</head>
<body>
<div class="container">

		<!-- 상세보기 메인이미지(detail_img_display) 시작 -->
		<div class="detail_img_display carousel slide carousel-fade" data-ride="carousel">
			<ol class="carousel-indicators">
			</ol>
			
			<a href="" onClick="window.open('pop_images.jsp', '미리보기', 'width=500, height=800, toolbar=no, location=no, status=no, scrollbars=no, resizeable=no, left=200, top=200')">
				<img class="big" src="<%=ctxPath%>/images/product/book.jpg">
			</a>
		</div>
		<!-- 상세보기 메인이미지(detail_img_display) 끝 -->
				

		
		<div id="img_display" class="carousel slide carousel-fade" data-ride="carousel">
		  <ol class="carousel-indicators">
		    <li data-target="#img_display" data-slide-to="0" class="active"></li>
		    <li data-target="#img_display" data-slide-to="1"></li>
		    <li data-target="#img_display" data-slide-to="2"></li>
		  </ol>
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="<%=ctxPath %>/images/product/book.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="<%=ctxPath %>/images/product/book2.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="<%=ctxPath %>/images/product/book3.jpg" class="d-block w-100" alt="...">
		    </div>
		  </div>
		  <a class="carousel-control-prev" href="#img_display" role="button" data-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="sr-only">Previous</span>
		  </a>
		  <a class="carousel-control-next" href="#img_display" role="button" data-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="sr-only">Next</span>
		  </a>
		</div>

</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
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
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product_style.css" />
	
	<!-- Optional JavaScript -->
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>
	 
	<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
	<title>Insert title here</title>
</head>
<body>

	<!-- 그림 영역(img_area) 시작 -->
	<div class="img_area" class="col-lg-6">
		<!-- 메인이미지 영역(img_display) 시작 -->
		<div class="img_display">
			<a href="" onClick="window.open('pop_images.jsp', '미리보기', 'width=500, height=800, toolbar=no, location=no, status=yes, scrollbars=yes, resizeable=no, left=200, top=200')">
				<img class="big" src="<%=ctxPath%>/images/book.jpg" style="width: 400px;">
			</a>
		</div>
		<!-- 메인이미지 영역(img_display) 끝 -->

		<!-- 썸네일이미지 영역(img_thumbnail) 시작 -->
		<div class="img_thumbnails">
			<img class="small" src="<%=ctxPath%>/images/book.jpg">
			<img class="small" src="<%=ctxPath%>/images/book2.jpg">
			<img class="small" src="<%=ctxPath%>/images/book3.jpg">
		</div>
		<!-- 썸네일이미지 영역(img_thumbnail) 끝 -->
	</div>
	<!-- 그림 영역(img_area) 끝 -->
	
	<button type="button" onclick="window.close()">닫기</button>
	


<script type="text/javascript">
	
	$(document).ready(function(){
		
		// *** 썸네일 이미지 클릭 시 메인 이미지 바꾸기 시작 *** //
		var bigPic = document.querySelector(".big");
		var smallPics = document.querySelectorAll(".small");
	
		for(var i=0; i < smallPics.length; i++) {
			smallPics[i].addEventListener("click", changepic);
		} 		
	
		function changepic() {
			var smallPicAttr = this.getAttribute("src");
			bigPic.setAttribute("src", smallPicAttr);
		}
		// *** 썸네일 이미지 클릭 시 메인 이미지 바꾸기 끝 *** //
		
	});

</script>

</body>
</html>
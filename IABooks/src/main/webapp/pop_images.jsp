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
	 
	<title>상품 미리보기</title>
</head>
<body>

	<!-- 상세보기 상단 그림영역(detail_top_img) 시작 -->
	<div class="detail_top_img col-lg-6">
	
		<!-- 상세보기 메인이미지(detail_img_display) 시작 -->
		<div class="detail_img_display">
			<!-- <a href="" onClick="window.open('pop_images.jsp', '미리보기', 'width=500, height=800, toolbar=no, location=no, status=no, scrollbars=no, resizeable=no, left=200, top=200')"> -->
				<img class="big" src="<%=ctxPath%>/images/book.jpg">
			<!-- </a> -->
		</div>
		<!-- 상세보기 메인이미지(detail_img_display) 끝 -->

		<!-- 상세보기 썸네일이미지(detail_img_thumbnail) 시작 -->
		<div class="detail_img_thumbnails">
			<img class="small" src="<%=ctxPath%>/images/book.jpg">
			<img class="small" src="<%=ctxPath%>/images/book2.jpg">
			<img class="small" src="<%=ctxPath%>/images/book3.jpg">
			<img class="small" src="<%=ctxPath%>/images/book.jpg">
		</div>
		<!-- 상세보기 썸네일이미지(detail_img_thumbnail) 끝 -->
	</div>
	<!-- 상세보기 상단 그림영역(detail_top_img) 끝 -->
	
	<!-- 닫기 버튼 시작 -->
	<div class="popupArea">
		<button type="button" id="btn_closePop"onclick="window.close()" style="border: solid 1px ;">닫기</button>
	</div>
	<!-- 닫기 버튼 끝 -->


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
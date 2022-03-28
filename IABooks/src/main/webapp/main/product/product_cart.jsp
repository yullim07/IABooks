<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String ctxPath = request.getContextPath();
%>


<meta charset="UTF-8">
<title>도서 상세보기 페이지</title>

<!-- css -->
<link rel="stylesheet" href="<%=ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/css/product/product_cart.css" />


<title>장바구니 페이지</title>
<jsp:include page="/header.jsp" />

<button class="tablink" onclick="openPage('deliveryBook', this, 'red')">국내배송상품</button>
<button class="tablink" onclick="openPage('News', this, 'green')" id="defaultOpen">해외배송상품</button>
<button class="tablink-none" id="defaultOpen">&nbsp;</button>
<button class="tablink-none" id="defaultOpen">&nbsp;</button>

<div id="deliveryBook" class="tabcontent">
	<h3>Home</h3>
	<p>여기에 테이블</p>
</div>

<div id="News" class="tabcontent">
	<h3>News</h3>
	<p>Some news this fine day!</p>
</div>

<div id="Contact" class="tabcontent">
	<h3>Contact</h3>
	<p>Get in touch, or swing by for a cup of coffee.</p>
</div>

<div id="About" class="tabcontent">
	<h3>About</h3>
	<p>Who we are and what we do.</p>
</div>

<script>
	/* 탭메뉴 클릭 시 펼쳐주기 */
	function openPage(pageName, elmnt, color) {
		var i, tabcontent, tablinks;
		tabcontent = document.getElementsByClassName("tabcontent");
		for (i = 0; i < tabcontent.length; i++) {
			tabcontent[i].style.display = "none";
		}
		tablinks = document.getElementsByClassName("tablink");
		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].style.backgroundColor = "";
		}
		document.getElementById(pageName).style.display = "block";
		elmnt.style.backgroundColor = color;
	}

	// Get the element with id="defaultOpen" and click on it
	document.getElementById("defaultOpen").click();
</script>

<jsp:include page="/footer.jsp" />

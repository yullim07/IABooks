<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();	
%>

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_category_search.css" />

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

 	function showBookDetail(pronum) {
 		//console.log(pronum);
 		location.href="<%= ctxPath%>/product/showBookDetail.book?pronum="+pronum;
	}

</script>

<style type="text/css">

</style>

<title>in사과 : oldbook</title>

<jsp:include page="/WEB-INF/header.jsp"/>
<%-- main --%>		
<div class="container d-none d-lg-block">

<%-- oldbook foreach 사용 출간일역순 --%>	
<h2 class="listtile">구간의 재발견</h2>
<h3 class="listtile2"><a style="visibility: hidden;">구간의 재발견</a></h3>
<br>
<br>

	<div class="row">
		<c:forEach var="pvo" items="${requestScope.productList}">
			<div class="col-3">
				<ul class="booklist">
					<li>
					<div class="card">
				  		<img src="<%= ctxPath%>/images/product/${pvo.category.cate_name}/${pvo.pro_imgfile_name}" class="card-img-top">
						<a href="javascript:showBookDetail(${pvo.pk_pro_num})" class="stretched-link"></a>
					</div>	
					</li>
					<li>
						<a href="javascript:showBookDetail(${pvo.pk_pro_num})"><span class="name">${pvo.pro_name}</span></a>
					</li>
					<li>
						<div class="line"></div> 
					</li>
				    <li>
						<span class="price"><fmt:formatNumber value="${pvo.pro_saleprice}" pattern="###,###" />원</span>
					</li>  
				</ul>
			</div>	
		</c:forEach>		
	</div>	

</div>

<br>
<br>
<%-- footer --%>
<jsp:include page="/WEB-INF/footer.jsp"/>
 
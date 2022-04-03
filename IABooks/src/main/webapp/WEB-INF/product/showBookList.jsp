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
	
	$(document).ready(function() { 	
	 	$("div.itemslist a#${requestScope.sort}").addClass("active"); 
	 	 
	 	$("li.nav-item > a").click(function() {
			const $target = $(event.target);
		 	$target.addClass("active"); 
	 		
			const sort = $(this).attr("id");
 			location.href="<%= ctxPath%>/product/showBookList.book?category=${requestScope.category}&sort="+sort;

	 	});//end of $("li.nav-item > a").click(function()
	 			
	 	$("li.pagenum > a").click(function() {//pagination active 설정
			const $target = $(event.target);
			/* $("li.pagenum > a.active").removeClass("active");  */
		 	$(this).parent().siblings().children() .removeClass("active"); 
		 	$target.addClass("active"); 

		});//end of $("li.pagenum > a").click(function()
				
	});//end of $(document).ready(function()

 	function showBookDetail(pronum) {
 		//console.log(pronum);
 		location.href="<%= ctxPath%>/product/showBookDetail.book?pronum="+pronum;
	}//end of function showBookDetail(pronum)
	
</script>

<style type="text/css">

</style>

<title>in사과 : total</title>

<jsp:include page="/WEB-INF/header.jsp"/>
<%-- main --%>		
<div class="container d-none d-lg-block">

<%-- 종합 foreach 사용 출간일순 이름순 판매순 --%>	

	<div class="title ">
		<br>
		<h2>
			<c:choose>
				<c:when test="${requestScope.category eq 'total'}">
					종합
				</c:when>
				<c:when test="${requestScope.category eq 'humanities'}">
					인문
				</c:when>
				<c:when test="${requestScope.category eq 'society'}">
					사회
				</c:when>
				<c:when test="${requestScope.category eq 'science'}">
					과학
				</c:when>
				<c:when test="${requestScope.category eq 'other'}">
					기타
				</c:when>
			</c:choose>
		</h2>
	</div>

	<div class="divClear"></div>

	<div class="itemslist">
	
		<span class="itemscount"><strong>${requestScope.totalPro}</strong> ITEMS</span>
		<ul class="nav nav-tabs Justify-content-end">
			<li class="nav-item">
		    	<a class="nav-link rounded-0" data-toggle="tab" id="new" href="#">신상품</a>
			</li>
			<li class="nav-item">
				<a class="nav-link rounded-0" data-toggle="tab"  id="name" href="#">상품명</a>
			</li>
			<li class="nav-item">
				<a class="nav-link rounded-0" data-toggle="tab" id="popularity" href="#">인기상품</a>
			</li>
		</ul>
		
		<br/>
	
		<div class="tab-content"><%-- foreach 사용해서 불러옴 --%>	
			<div class="tab-pane fade show active">
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
			
		</div>	
	</div><%--<div class="itemslist"> end --%>

	

	<%--페이지 네비게이션 --%>
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center ">
		<%--ShowBookListAction 작성 --%>
			${requestScope.pageBar}
	  	</ul>
	</nav>

</div><%-- <div class="container d-none d-lg-block"> end --%>

<br>
<br>
<%-- footer --%>
<jsp:include page="/WEB-INF/footer.jsp"/>
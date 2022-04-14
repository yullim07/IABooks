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
			location.href="<%= ctxPath%>/product/search.book?searchWord=${requestScope.searchWord}&sort="+sort;
	
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

<title>in사과::search</title>

<jsp:include page="/WEB-INF/header.jsp"/>
<%-- main --%>		
<div class="container d-none d-lg-block">

<%-- 상품검색 foreach 사용 출간일순 이름순 판매순 --%>	

	<div class="title">
		<br>
		<h2>상품검색</h2>
	</div>

	<div class="divClear"></div>

		<%-- 상품검색 상세조건 --%>	<%-- 상품검색 나중에 차후 --%>	
		<!-- 
 		<div class="detailserch">
	    	<table class="searchtbl">	
	 			<tr>
				 	<th>
				 		<strong class="searchtitle">상품분류</strong> 
				    </th>
			    	<td>
				    	<select id="product_type" name="product_type" class="p_search">
							<option selected="selected">상품분류 선택</option>
							<option value="total">종합</option>
							<option value="humanities">종합 > 인문</option>
							<option value="society">종합 > 사회</option>
							<option value="science">종합 > 과학</option>
							<option value="other">종합 > 기타</option>
				    	</select>
				    </td>
				</tr>
				
				<tr>
				 	<th>
				 		<strong class="searchtitle">검색조건</strong> 
				 	</th>
			    	<td>
					    <select id="search_condition" name="search_condition" class="p_search">
							<option selected="selected">조건선택</option>
							<option value="pnun">도서명</option>
							<option value="private_pnum">도서표준번호</option>
							<option value="model">작가명</option>
							<option value="brand">출판사명</option>
					    </select>
					    <input type="text" class="product_name p_search" placeholder="도서명" />
					</td>
				</tr>
			
				<tr>
				 	<th>
						<strong class="searchtitle">제외검색어</strong>
					</th>
					<td>
						<input type="text" id="search_exception" class="search_exception p_search"/> 
					</td>
				</tr>
				
				<tr>
				 	<th>
						<strong class="searchtitle">판매가격대</strong> 
				    </th>
				    <td>
					   	<input class="price p_search" type="text" />
					     ~
						<input class="price2 p_search" type="text"/>
					</td>
				</tr>
				
				<tr>
				 	<th>
				   		<strong class="searchtitle">검색정렬기준</strong> 
				    </th>
				    <td>
						<select id="order_by" name="order_by" class="p_search">
							<option selected="selected">::: 기준선택 :::</option>
							<option value="new">신상품 순</option>
							<option value="name">상품명 순</option>
							<option value="popularity">인기상품 순</option>
					   	</select>
					</td>
				</tr>
				
			</table> 
				
			<div>
			   <button class="searchbtn">검색하기</button>
			</div>  	
	    	 		     
	    </div>
	     -->
	    <%-- 상품검색 상세조건 끝 --%>	
 		
 		<!-- 
		<br/>
		<br/>
		<br/>
		 -->
		 
		<%-- 검색한 리스트 --%>	
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
			${requestScope.pageBar}
	  	</ul>
	</nav>

</div><%-- <div class="container d-none d-lg-block">끝 --%>

<br>
<br>
<%-- footer --%>
<jsp:include page="/WEB-INF/footer.jsp"/>
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
%>

	<!-- 내가만든 CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/style_member.css" />

<script type="text/javascript">

</script>

<style type="text/css">
 
</style>

<title>관심상품</title>

<jsp:include page="<%= ctxPath %>/WEB-INF/header.jsp"/>

	
<div class="container">

<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;관심상품</strong>
<hr style="border: solid 2px #e8e8e8;">
	
	<!-- 나중에 숨김처리 해야함  -->
	<div class="interestde_empty">
	<table class="interested_none">
		<tr>
			<td>관심상품 내역이 없습니다.</td>
		</tr>
	</table>
	</div>
	
	<div class="interestde_not_empty">
		<table class="interested">
			<thead>
				<tr>
					<td><input type="checkbox" name="interested_allcheck" /></td>
					<td>이미지</td>
					<td>상품정보</td>
					<td>판매가</td>
					<td>적립금</td>
					<td>배송구분</td>
					<td>배송비</td>
					<td>합계</td>
					<td>선택</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="checkbox" id="interested_check" /></td>
					<td><img src="<%= ctxPath %>/images/e78bdc919df426ed106c57e265db6395.jpg" style="height: 80px; width: 80px;"/></td>
					<td>30대 백수 남편이지만 잘 살고 있습니다.</td>
					<td>15,000원</td>
					<td>-</td>
					<td>기본배송</td>
					<td>3,000원<br>조건</td>
					<td>18,000원</td>
					<td>
						<ul>
							<li><img src="<%= ctxPath %>/images/btn_order.gif" style="cursor: pointer;"/></li>
							<li><img src="<%= ctxPath %>/images/btn_basket.gif" style="cursor: pointer;"/></li>
							<li><img src="<%= ctxPath %>/images/btn_delete.gif" style="cursor: pointer;"/></li>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
		
		<span class="interested_choice">
			<strong>선택상품을</strong><img src="<%= ctxPath %>/images/btn_delete2.gif" style="cursor: pointer;" /><img src="<%= ctxPath %>/images/btn_basket2.gif"  style="cursor: pointer;"/>
		</span>
		<span class="interested_order"><img src="<%= ctxPath %>/images/btn_order_empty.gif" style="cursor: pointer;" />&nbsp;&nbsp;<img src="<%= ctxPath %>/images/btn_order_all.gif" style="cursor: pointer;" /></span>
		
		<div class="pagination pagination-sm justify-content-center">
		  <a href="#"><img src="<%= ctxPath %>/images/btn_page_first.gif" /></a>
		  <a href="#"><img src="<%= ctxPath %>/images/btn_page_prev.gif" /></a>
		  <a class="active" href="#">1</a>
		  <a href="#"><img src="<%= ctxPath %>/images/btn_page_next.gif" /></a>
		  <a href="#"><img src="<%= ctxPath %>/images/btn_page_last.gif" /></a>
		</div>
	</div>

</div>

<jsp:include page="<%= ctxPath %>/WEB-INF/footer.jsp"/>
 
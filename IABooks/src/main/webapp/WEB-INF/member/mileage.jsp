<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%
	String ctxPath = request.getContextPath();
%>
<title>in사과::적립금</title>

<jsp:include page="/WEB-INF/header.jsp"/>


	<!-- 내가만든 CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/style_member.css" />

	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css">
	
	<!-- Optional JavaScript-->
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>

<script type="text/javascript">

$(document).ready(function() {

	$("div#menu2").hide();
	$("div#menu3").hide();
	
	$("select").bind().change(function () {
		
		if($("select").val() == 1) {
			$("div#menu2").hide();
			$("div#menu3").hide();
			$("div#menu1").show();
		}
		if($("select").val() == 2) {
			$("div#menu1").hide();
			$("div#menu3").hide();
			$("div#menu2").show();
		}
		if($("select").val() == 3) {
			$("div#menu1").hide();
			$("div#menu2").hide();
			$("div#menu3").show();
		}
		
		
	})
	
});

		      
</script>

<style type="text/css">

td.pointTable {
	padding: 50px;
}

table.pointTable tbody > tr > td:first-child {
	text-align: right;
}

span.pointTable {
	font-size: 16pt;
	font-weight: bold;
	text-align: left;
	color: #00bbcc;
}

</style>


<div class="container">
<%-- 	<br>
	&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"  /> 적립금 </strong> &nbsp;
	<img src="<%= ctxPath%>/images/bar_eee.gif" style="width: 2px; height: 20px;" /> &nbsp; 고객님의 사용가능한 적립금 입니다.
	<hr style="border: solid 2px #e8e8e8;"> --%>
			<div class="title">
		<br>
		<h2 style="display: inline-block;">적립금&nbsp;</h2><span style="font-size: 14px; color: #939393;">&nbsp;고객님의 사용가능한 적립금 입니다.</span>
		</div>
	
	<table class="pointTable">
			<tr >
				<td class="pointTable" width="50%;">
					<strong><img src="<%= ctxPath%>/images/member/arrow_menu.gif" /> 보유 적립금</strong>
				</td>
				<td class="pointTable" >
					<span class="pointTable"><fmt:formatNumber type="number" pattern="###,###">${requestScope.mileage}</fmt:formatNumber>원</span>
				</td>
			</tr>
	</table>
		
		<select name="mgct">
			<option value="1" selected="selected">전체</option>
			<option value="2">적립</option>
			<option value="3">사용</option>
		</select>
		
		  <!-- 적립내역보기 -->
		  <div id="menu1">
		    <table class="point_menu">
		    	<thead>
		    		<tr align="center">
						<td>번호</td>
						<td>유형</td>
						<td>적립금</td>
						<td>관련주문</td>
						<td>내용</td>
						<td>주문날짜</td>
		    		</tr>
		    	</thead>
		    	<tbody>
		    		 <c:if test="${not empty requestScope.mileageList}">
				   	  	  <c:forEach var="map" items="${requestScope.mileageList}" varStatus="i">
				   	  	  	  <tr align="center">
					   	  	  	 <td>${i.index+1}</td>
				   	  	  	  	 <td>	
					   	  	  	  	<c:choose>
					   	  	  	  	  <c:when test="${map.MILEAGEINFO > 0}">
					   	  	  	  			<span style="color:blue;">적립</span>
					   	  	  	  	  </c:when>
					   	  	  	  	  <c:otherwise>
					   	  	  	  			<span style="color:red;">사용</span>
					   	  	  	  	  </c:otherwise>
					   	  	  	  	</c:choose> 
				   	  	  	  	  </td>
				   	  	  	  	  <td>
				   	  	  	  	  <c:choose>
					   	  	  	  	  <c:when test="${map.MILEAGEINFO > 0}">
					   	  	  	  			<span style="color:blue;">${map.MILEAGEINFO}</span>
					   	  	  	  	  </c:when>
					   	  	  	  	  <c:otherwise>
					   	  	  	  			<span style="color:red;">${map.MILEAGEINFO}</span>
					   	  	  	  	  </c:otherwise>
					   	  	  	  </c:choose> 
				   	  	  	  	  </td>
				   	  	  	  	  <td>${map.ODRCODE}</td>
				   	  	  	  	  <td>${map.PRO_NAME}</td>
				   	  	  	  	  <td>${map.ODR_DATE}</td>
				   	  	  	  </tr>
				   	  	  </c:forEach>
			   	  	  </c:if>
			   	  	  <c:if test="${empty requestScope.mileageList}">
			    		<tr>
			    			<td colspan="6" align="center"><span>적립금내역이없습니다.</span></td>
			    			<!-- 나중에 데이터값에 따라 태그 수정 -->
			    		</tr>
		    		  </c:if>
		    	</tbody>
		    </table>
			    <nav class="my-5">
				   	<div style="display: flex; width: 100%;">
			    		<ul class="pagination" style='margin:auto;'>
			    			${requestScope.pageBar}
			    		</ul>
			    	</div>
			    </nav>    
		  </div>
		
		  <!-- 적립 -->
		  <div id="menu2">
		     <table class="point_menu">
		    	<thead >
		    		<tr align="center">
						<td>번호</td>
						<td>유형</td>
						<td>적립금</td>
						<td>관련주문</td>
						<td>내용</td>
						<td>주문날짜</td>
		    		</tr>
		    	</thead>
		    	<tbody class="menu">
		    		<c:if test="${not empty requestScope.mileageList2}">
				   	  	  <c:forEach var="map" items="${requestScope.mileageList2}" varStatus="i">
				   	  	  	  <tr align="center">
				   	  	  	  	<td>${i.index+1}</td>
				   	  	  	  	 <td>	
					   	  	  	  	<c:choose>
					   	  	  	  	  <c:when test="${map.MILEAGEINFO > 0}">
					   	  	  	  			<span style="color:blue;">적립</span>
					   	  	  	  	  </c:when>
					   	  	  	  	  <c:otherwise>
					   	  	  	  			<span style="color:red;">사용</span>
					   	  	  	  	  </c:otherwise>
					   	  	  	  	</c:choose> 
				   	  	  	  	  </td>
				   	  	  	  	  <td>
				   	  	  	  	  <c:choose>
					   	  	  	  	  <c:when test="${map.MILEAGEINFO > 0}">
					   	  	  	  			<span style="color:blue;">${map.MILEAGEINFO}</span>
					   	  	  	  	  </c:when>
					   	  	  	  	  <c:otherwise>
					   	  	  	  			<span style="color:red;">${map.MILEAGEINFO}</span>
					   	  	  	  	  </c:otherwise>
					   	  	  	  </c:choose> 
				   	  	  	  	  </td>
				   	  	  	  	  <td>${map.ODRCODE}</td>
				   	  	  	  	  <td>${map.PRO_NAME}</td>
				   	  	  	  	  <td>${map.ODR_DATE}</td>
				   	  	  	  </tr>
				   	  	  </c:forEach>
			   	  	  </c:if>
			   	  	  <c:if test="${empty requestScope.mileageList2}">
			    		<tr>
			    			<td colspan="6" align="center"><span>적립금내역이없습니다.</span></td>
			    			<!-- 나중에 데이터값에 따라 태그 수정 -->
			    		</tr>
		    		  </c:if>
		    	</tbody>	
		    </table>
		    <nav class="my-5">
				<div style="display: flex; width: 100%;">
			 		<ul class="pagination" style='margin:auto;'>
			   			${requestScope.pageBar2}
			   		</ul>
			   	</div>
			 </nav> 
		   </div>
		  
		  <!-- 사용 -->
		  <div id="menu3">
		     <table class="point_menu">
		    	<thead >
		    		<tr align="center">
						<td>번호</td>
						<td>유형</td>
						<td>적립금</td>
						<td>관련주문</td>
						<td>내용</td>
						<td>주문날짜</td>
		    		</tr>
		    	</thead>
		    	<tbody class="menu">
		    		<c:if test="${not empty requestScope.mileageList3}">
				   	  	  <c:forEach var="map" items="${requestScope.mileageList3}" varStatus="i">
				   	  	  	  <tr align="center">
				   	  	  	  	 <td>${i.index+1}</td>
				   	  	  	  	 <td>	
					   	  	  	  	<c:choose>
					   	  	  	  	  <c:when test="${map.MILEAGEINFO > 0}">
					   	  	  	  			<span style="color:blue;">적립</span>
					   	  	  	  	  </c:when>
					   	  	  	  	  <c:otherwise>
					   	  	  	  			<span style="color:red;">사용</span>
					   	  	  	  	  </c:otherwise>
					   	  	  	  	</c:choose> 
				   	  	  	  	  </td>
				   	  	  	  	  <td>
				   	  	  	  	  <c:choose>
					   	  	  	  	  <c:when test="${map.MILEAGEINFO > 0}">
					   	  	  	  			<span style="color:blue;">${map.MILEAGEINFO}</span>
					   	  	  	  	  </c:when>
					   	  	  	  	  <c:otherwise>
					   	  	  	  			<span style="color:red;">${map.MILEAGEINFO}</span>
					   	  	  	  	  </c:otherwise>
					   	  	  	  </c:choose> 
				   	  	  	  	  </td>
				   	  	  	  	  <td>${map.ODRCODE}</td>
				   	  	  	  	  <td>${map.PRO_NAME}</td>
				   	  	  	  	  <td>${map.ODR_DATE}</td>
				   	  	  	  </tr>
				   	  	  </c:forEach>
			   	  	  </c:if>
			   	  	  <c:if test="${empty requestScope.mileageList3}">
			    		<tr>
			    			<td colspan="6" align="center"><span>적립금내역이없습니다.</span></td>
			    			<!-- 나중에 데이터값에 따라 태그 수정 -->
			    		</tr>
		    		  </c:if>
		    	</tbody>
		    </table>
    			<nav class="my-5">
			    	<div style="display: flex; width: 100%;">
			    		<ul class="pagination" style='margin:auto;'>
			    			${requestScope.pageBar3}
			    		</ul>
			    	</div>
			    </nav>    
		  </div>
		
		  
</div>
	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
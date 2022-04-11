<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
    String ctxPath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- 내가만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/style_member.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>     

<script type="text/javascript">

function cancel() {
	
	window.close();  
	
}

</script>

<style type="text/css">

div#container {
	text-align: center;
}

button#btn_cancel { 
	margin: 40px auto;
	text-align: center;
	background-color: #212529;
	color: white;
}

table.coupon {
	width: 80%;
	margin:50px auto;
}


</style>

<div id="container">
	
	<h2 style="text-align: center; margin-top: 50px;"><i class="fas fa-ticket-alt"></i>쿠폰목록보기</h2>
	
	<table class="coupon">
		<thead>
			<tr>
				<td>번호</td>
				<td>쿠폰명</td>
				<td>쿠폰혜택</td>
				<td>최소주문금액</td>
				<td>사용가능기간</td>
				<td>쿠폰사용여부</td>
			</tr>
		</thead>
		<tbody>		
			<c:if test="${not empty (requestScope.couponListP)}">
				<c:forEach var="cvo" items="${requestScope.couponListP}" >
					<tr>
						<td align="center" class="numAsc">${cvo.rno}</td>
						<td align="center">${cvo.cname }</td>
						<td align="center"><fmt:formatNumber type="number" pattern="###,###" >${cvo.cprice }</fmt:formatNumber>원</td>
						<td align="center"><fmt:formatNumber type="number" pattern="###,###" >${cvo.cminprice }</fmt:formatNumber>원</td>
						<td align="center">${cvo.cstartdate }~${cvo.cenddate }</td>
						<td align="center">
						<c:choose>
	   	  	  	  	  		<c:when test="${cvo.ucvo.user_cp_status eq '1' or cvo.cenddate > sysdate}"><!-- 조건변경 -->
	   	  	  	  	  			<span style="color: blue;">사용가능</span>
	   	  	  	  	  		</c:when>
	   	  	  	  	  		<c:otherwise>
	   	  	  	  	  			<span style="color: red;">사용불가</span>
	   	  	  	  	  		</c:otherwise>
	   	  	  	  	  	</c:choose>
					
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty (requestScope.couponListP)}">
				<tr>
					<td colspan="7" align="center">
						보유하고 계신 쿠폰내역이 없습니다.
					</td>
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
    
    <button id="btn_cancel" onclick="cancel();">확인</button>
</div>       

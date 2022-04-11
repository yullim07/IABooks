<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
%>

<title>주문서작성</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css">
<!-- 내가만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_order.css" /> 
<!-- Optional JavaScript-->
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>	
<script type="text/javascript">

</script>

<style type="text/css">

</style>

<jsp:include page="/WEB-INF/header.jsp"/>

<div class="container">
<div> 결제가 완료되었습니다. </div>

<div>아이디 : ${requestScope.userid}</div>
<div>이메일 : ${requestScope.email}</div>
<div>이름 : ${requestScope.name}</div>
<div>핸드폰 : ${requestScope.phone}</div>
<div>우편번호 : ${requestScope.postcode}</div>
<div>주소 : ${requestScope.address}</div>
<div>총액 : ${requestScope.finalPrice}</div>

</div>





<jsp:include page="/WEB-INF/footer.jsp"/>
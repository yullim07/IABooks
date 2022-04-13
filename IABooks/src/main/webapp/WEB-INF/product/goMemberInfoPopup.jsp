<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
%>

<title>in사과::회원정보</title>

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
.shipping_info tr {
	height: 80px;
}

#paymentExpected tr td {
    width: 20%;
    text-align: center;
}



table.shipping_info td.button {
	padding-top: 20px;
	padding-bottom: 20px;
	padding-left: 5px;
}

table.shipping_info td.button .btn1 {
	background-color: #444444;
	background-image: linear-gradient(to bottom,#444444,#111111);
	color: white;
	width: 30%;
	border: none;
	height: 50px;
}

table.shipping_info td.button .btn2 {
	background-color: #f2f2f2;
	background-image: linear-gradient(to bottom,#f2f2f2,#e5e5e5);
	width: 100%;
	border: none;
	height: 50px;
}

table.shipping_info td.button .btn2:hover{
	background-image: linear-gradient(to bottom,#e5e5e5,#f2f2f2);
}
table.shipping_info td.button .btn1:hover{
	background-image: linear-gradient(to bottom,#111111,#444444);
}


</style>


<strong style="font-size: 12pt; padding-left: 20px;">회원상세정보</strong>
<table class="shipping_info">
	<tr>
		<th>아이디</th>
	    <td>${requestScope.orderMemberInfo.pk_userid}</td>
	</tr>
	<tr>
		<th>이름</th>
	    <td>${requestScope.orderMemberInfo.mname}</td>
	</tr>
	<tr>
		<th>우편번호</th>
      	<td>${requestScope.orderMemberInfo.postcode}</td>
	</tr>
	<tr>
		<th id="register">주소</th>
		<td>${requestScope.orderMemberInfo.address}&nbsp;${requestScope.orderMemberInfo.detailaddress}&nbsp;${requestScope.orderMemberInfo.extraaddress}</td>
	</tr>
	<tr>
		<th>휴대전화</th>
        <td>${requestScope.orderMemberInfo.uq_phone}</td>
	</tr>
	<tr>
		<th>이메일</th>
		<td>${requestScope.orderMemberInfo.uq_email}</td>
	</tr>
	<tr>					
		<td colspan='2' class="button" style="text-align:center;">
			<button type="button" id="btn_buy" class="btn1" onclick="window.close()" >
				닫기
			</button>
		</td>
	 </tr>
</table>

</body>
</html>
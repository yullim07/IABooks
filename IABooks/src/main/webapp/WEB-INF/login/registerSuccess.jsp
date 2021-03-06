<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
%>

<title>회원가입 완료</title>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/style_member.css" />

<script type="text/javascript">

</script>

<style type="text/css">
	
	
</style>

<jsp:include page="/WEB-INF/header.jsp"/>

	
<div class="container">

 	<br>
	&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"  /> 회원가입 완료 </strong> &nbsp;
	<hr style="border: solid 2px #e8e8e8;">
	
	<table class="register_success">
		<thead>
			<tr>
				<td>회원가입</td>
			</tr>	
			<tr>
				<td style="color: #66d9ff; ">회원가입이 완료되었습니다.</td>
			</tr>
		</thead>
		<tbody class="content">
			<tr>
				<td>저희쇼핑몰을 이용해주셔서 감사합니다. </td>
			</tr>
			<tr>
				<td>
					<ul>
						<li><img src="<%= ctxPath%>/images/member/arrow_menu.gif" />&nbsp;아이디</li>
						<li><img src="<%= ctxPath%>/images/member/arrow_menu.gif" />&nbsp;이름</li>
					</ul>
					<ul style="margin-left: 60px;">
						<li><span>${loginuser.userid}</span></li>
						<li><span>${loginuser.name}</span></li>
					</ul>
				</td>
			</tr>
		</tbody>	
	</table>
	
	<div class="memberInfo"><span id="name">${loginuser.name }</span>님은 [<span id="admin">일반</span>] 회원이십니다. </div>
	<div class="memberInfo"><button type="button" onclick="location.href='<%= ctxPath %>/index.book'" id="main">메인으로 이동</button></div>
	

	
	
</div>	
	
	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath();  %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
	
	window.onload = function() {
		
		const frm = document.loginRegisterFrm;
		frm.action = "<%= ctxPath%>/login/login.book";
		frm.method = "POST";
		frm.submit();
		
	} // end of window.onload = function()
	

</script>

</head>
<body>
	
	<form name="loginRegisterFrm">
	   <input type="hidden" name="registerflag" value="true"/>
	   <input type="hidden" name="userid" value="${requestScope.userid}"/>
	   <input type="hidden" name="pwd" value="${requestScope.pwd}"/>
	   <input type="hidden" name="name" value="${requestScope.name }" />
	</form>

</body>
</html>
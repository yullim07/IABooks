<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<script type="text/javascript">

	//alert("${requestScope.message}"); // 메시지 출력해주기

	// 페이지 이동
	//location.href = "${requestScope.loc}"; 	// 자바스크립트에서 페이지이동
	
	//self.close(); // 팝업창 닫기
	//opener.location.reload(true); // 부모창 새로 고침
	
	if("${requestScope.message}".match("로그인")){
		if(!alert("${requestScope.message}")) document.location = "<%= ctxPath%>/login/join.book";
	}else if("${requestScope.message}".match("관리자")){
		if(!alert("${requestScope.message}")) document.location = "<%= ctxPath%>/index.book";
	}else{
		alert("${requestScope.message}");
		location.href = "${requestScope.loc}"
	}
	
	
</script>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<script type="text/javascript">

	alert("${requestScope.message}"); // 메시지 출력해주기

	// 페이지 이동
	location.href = "${requestScope.loc}"; 	// 자바스크립트에서 페이지이동
	
</script>

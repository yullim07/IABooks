<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
%>

<!-- 내가만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/style_member.css" />

<title>in사과::게시물 관리</title>


<script type="text/javascript">

</script>

<style type="text/css" >

</style>

<jsp:include page="<%= ctxPath %>/WEB-INF/header.jsp"/>

<div class="container">
	<br>
	&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"  /> 게시물 관리 </strong> &nbsp;
	<hr style="border: solid 1px #e8e8e8;">
	
	<div class="boardMg_title">
		<span>분류선택</span>
		<select>
			<option value="date_array">작성일자별</option>
			<option value="category_array">분류별</option>
		</select>
	</div>
	
	<table class="boardInfo">
		<thead>
			<tr>
				<td width="8%">번호</td>
				<td width="12%">분류</td>
				<td width="52%">제목</td>
				<td width="10%">작성자</td>
				<td width="10%">작성일</td>
				<td width="8%">조회</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="6">게시물이 없습니다.</td>
			</tr>
		</tbody>
	</table>
	
	
	<div class="boardMg_foot">
		<select>
			<option value="boardTitle">제목</option>
			<option value="boardContents">내용</option>
			<option value="boardName">글쓴이</option>
			<option value="boardId">아이디</option>
		</select>
		<input type="text" />
		<button type="button" onclick="#">찾기</button>
	</div>
	
	
	
</div>
	
<jsp:include page="<%= ctxPath %>/WEB-INF/footer.jsp"/>
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


		<div class="container">
			<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<tbody>
					<tr>
						<td align="left" bgcolor="beige">댓글</td>
					</tr>
					<tr>
						<%-- <%
							BoardDAO bdao = new BoardDAO();
							ArrayList<Comment> list = BoardDAO.getList(fk_userid,cmtContent, cmtPasswd
									,cmtWriter,pk_qna_num);
							for(int i=0; i<list.size(); i++){
						%> --%>
<%-- 댓글달기 --%>
	
	<div>
	
		<!-- 댓글 목록 -->
		<!-- 댓글이 등록이 되면 listComment에 댓글이 쌓이게 된다 -->
		<div id="listComment"></div>
		
		<div class="comment" style=" font-size: 14px; padding:auto 20px; background-color:#fbfafa; border: 1px solid #e9e9e9; margin-top: 70px;">
			<c:set var="qnaVO" value="${qnaVO}" />
			<c:if test="${ not empty sessionScope.loginuser }">
			<%-- <form class="comment" method="post"> --%>
				<div class="mb-1"><strong>댓글달기</strong></div>
				<div class="mb-3">
					<a>이름 : </a><input id="cmtWriter" name="cmtWriter" type="text" value="${(requestScope.qnaVO).member.name}"/> 
					
					<a>비밀번호 : </a><input id="comment_pwd" name="comment_pwd" type="password" value="${(requestScope.qnaVO).member.pwd}"/>
				</div>
				<div style="vertical-align: middle;">
					<textarea style="float:left; width:90%; height: 50px;"  id="commnet_content" name="commnet_content" ></textarea>
					<button onclick="" id ="submitCmt" class=" submit" type="button" style="color: white; float:right; font-size: 14px; border: none; background-color: #999; width:9%; height: 50px; border-radius: 10%;">확인</button>
				</div>
				
				<input type="hidden" class="fk_userid" name="fk_userid" id="fk_userid" value="${(requestScope.qnaVO).fk_userid}"/>
				<input type="hidden" name="pk_qna_num" id="pk_qna_num" value="${(requestScope.qnaVO).pk_qna_num}">
			<%--</form>--%>
			</c:if>
			<c:if test="${empty sessionScope.loginuser }">
			
			<p style="font-size: 14px; margin:0;">회원에게만 댓글 작성 권한이 있습니다.</p>
			</c:if>
		</div>
	</div>

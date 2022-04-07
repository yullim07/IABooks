<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<script type="text/javascript">
	
	$(function(){
		var chkObj = document.getElementsByName("checkbox");
		var rowCnt = chkObj.length;
	
		$("input[name='selectall']").click(function(){
			var chk_listArr = $("input[name='checkbox']");
			for (var i=0; i<chk_listArr.length; i++) {
				chk_listArr[i].checked = this.checked;
			}
		});
	
		$("input[name='checkbox']").click(function () {
			if($("input[name='checkbox']:checked").length == rowCnt) {
				$("input[name='selectall']")[0].checked = true;
			}
			else{
				$("input[name='selectall']")[0].checked = false;
			}
		});
	});

	function deleteValue() {
		var url="delete"; // Controller로 보내고자 하는 URL
		var valueArr = new Array();
		var list = $("input[name='checkbox']");
		
		for(var i=0; i<list.length; i++) {
			if(list[i].checked){ // 선택되어있으면 배열에 값을 저장함
				valueArr.push(list[i].value);	
			}
		}

		if(valueArr.length == 0) {
			alert("선택된 글이 없습니다.");
		}
		else{
			var chk confirm("");
			$.ajax({
				url: url,				// 전송 URL
				type: 'POST',			// POST 방식	
				traditional true,
				data : {
					valueArr : valueArr // 보내고자 하는 data 변수 설정
				},
				success: function(jdata) {
					if(jdata = 1) {
						alert("삭제 성공");
						location.replace("list") //list 로 페이지 새로고침
					}
					else {
						alert("삭제 실패");
					}
				}
			}); // end of ajax
		}
	} // end of function deleteValue()
	
</script>

</head>
<body>
	
<h1>List page</h1>
	<table>
		<thead>
			<tr>
			<th scope="col"><input id="selectall" type="checkbox" name="selectall"/></th>
			<th scope="col">번호</th>
			<th scope="col">ID</th>
			<th scope="col">성함</th>
			<th scope="col">목표</th>
			<th scope="col">작성일자</th>
			<th scope="col">작성시간</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list)" var="list">
				<tr>
					<td class="text_ct"><input name="checkbox" type="checkbox" value="${list.no}"/></td>
					<td class="text_ct">${list.no}&nbsp;</td>
					<td class="text_ct">${list.id}&nbsp;</td>
					<td class="text_ct"><a href="${path}/board/detail?no=${list.no}">${list.name}&nbsp;</a></td>
					<td class="text_ct">${list.goal}&nbsp;</td>
					<td class="text_ct"><fmt:formatDate value="${list.date}" pattern="yyyy/MM/dd" /></td>
					<td class="text_ct"><fmt:formatDate value="${list.time}" pattern="HH:mm:ss" /></td>
				</tr>		
			</c:forEach>
		</tbody>
	</table>
	<a href="<c:url value='/board/create' />" role="button" class="btn btn-outline-info">글쓰기</a>
	<input type="button" value="4" class="btn btn-outline-info" onclick="deleteValue();">

	
</body>
</html>
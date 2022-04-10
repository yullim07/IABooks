<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>
    
<script type="text/javascript">

</script>

<style type="text/css" >

</style>

<jsp:include page="<%= ctxPath %>/WEB-INF/header.jsp"/>


<style type="text/css">

tr.memberInfo:hover {
	background-color: #e6ffe6;
	cursor: pointer;
}

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		
		
		// **** select 태그에 대한 이벤트를 click이 아니라 change 이다 ****
		$("select#sizePerPage").bind("change",function(){
			
			const frm = document.memberFrm;
			frm.action = "memberList.book";
		//	frm.method = "get";
			frm.submit();
			
		});
		
		$("select#sizePerPage").val("${requestScope.sizePerPage}");
		
		
		$("form[name='memberFrm']").submit(function() {
			if($("select#searchType").val() == "" ) {
				alert("검색대상을 선택해주세요");
				return false; // 서브밋을 하지 않게해주는 것 
			}
			
			if($("input#searchWord").val().trim() == "" ) {
				alert("검색어를 입력해주세요");
				return false; // 서브밋을 하지 않게해주는 것 
			}
			
		});
		
		$("input#searchWord").bind("keyup", function(event) {
			if(event.keyCode == 13) {
				// 검색어에서 엔터를 치면 검색하러 가도록 한다.
				goSearch()
			}
		});
		
//		alert("확인용 : ${requestScope.searchType}");
		
		if("${requestScope.searchType}" != "" ){
			$("select#searchType").val("${requestScope.searchType}");  
			$("input#searchWord").val("${requestScope.searchWord}"); 
		}
		
		// 특정 회원을 클릭하면 그 회원의 상세정보를 보여주도록 한다.
		$("tr.memberInfo").click( () => {
			
			const $target = $(event.target);
			
		//	alert("확인용 => " + $target.parent().html() );
				
			const userid = $target.parent().children(".userid").text();
		//	alert(userid);
			
			location.href="<%= ctxPath%>/member/memberOneDetail.up?userid="+userid+"&goBackURL=${requestScope.goBackURL}";
			// 																		&goBackURL=/member/memberList.up?currentShowPageNo=5&sizePerPage=10&searchType=name&searchWord=%EC%9C%A0	
			
		}); 
		
		
	}); // end of $(document).ready(function()
	
	// function Declaration
	function goSearch() {
		
		if($("select#searchType").val() == "" ) {
			alert("검색대상을 선택해주세요");
			return; // 함수종료하라는 뜻
		}
		
		if($("input#searchWord").val().trim() == "" ) {
			alert("검색어를 입력해주세요");
			return; // 함수종료하라는 뜻 
		}
		
		const frm = document.memberFrm;
		frm.action = "memberList.up";
	//	frm.method = "get";
		frm.submit();
		
	}
	

</script>

<h2 style="margin: 20px;">::: 회원전체 목록 :::</h2>

<%--<form name="memberFrm">--%>
	<form name="memberFrm" action="memberList.up" method="GET">
		
		<select id="searchType" name="searchType">
			<option value="">검색대상</option>
			<option value="name">회원명</option>
			<option value="userid">아이디</option>
			<option value="email">이메일</option>
		</select>
		<input type="text" id="searchWord" name="searchWord"  />
		
		<%-- form 태그내에서 전송해야할 input 태그가 만약에 1개 밖에 없을 경우에는 유효성검사가 있더라도 
               유효성 검사를 거치지 않고 막바로 submit()을 하는 경우가 발생한다.
               이것을 막아주는 방법은 input 태그를 하나 더 만들어 주면 된다. 
               그래서 아래와 같이 style="display: none;" 해서 1개 더 만든 것이다. 
       --%>
     	<input type="text" style="display: none;" /> <%-- 조심할 것은 type="hidden" 이 아니다. --%>
		
		
		
	<%--<button type="button" onclick="goSearch();" style="margin-right: 30px;">검색</button>--%>
		<input type="submit" value="검색" style="margin-right: 30px;" />			
		<span style="color: red; font-weight: bold; font-size: 12pt;">페이지당 회원명수-</span>
	      <select id="sizePerPage" name="sizePerPage">
	         <option value="10">10</option>
	         <option value="5">5</option>
	         <option value="3">3</option>
	      </select>
		
	</form>
	
	
	<table id="memberTbl" class="table table-bordered" style="width: 90%; margin-top: 20px;">
       <thead>
          <tr>
             <th>아이디</th>
             <th>회원명</th>
             <th>이메일</th>
             <th>성별</th>
          </tr>
       </thead>
      
       <tbody>
   	  	  <c:if test="${not empty requestScope.memberList}">
	   	  	  <c:forEach var="mvo" items="${requestScope.memberList}">
	   	  	  	  <tr class="memberInfo">
	   	  	  	  	  <td class="userid">${mvo.userid}</td>
	   	  	  	  	  <td>${mvo.name}</td>
	   	  	  	  	  <td>${mvo.email}</td>
	   	  	  	  	  <td>
	   	  	  	  	  	<c:choose>
	   	  	  	  	  		<c:when test="${mvo.gender eq '1'}">
	   	  	  	  	  			남
	   	  	  	  	  		</c:when>
	   	  	  	  	  		<c:otherwise>
	   	  	  	  	  			여
	   	  	  	  	  		</c:otherwise>
	   	  	  	  	  	</c:choose>
	   	  	  	  	  </td>
	   	  	  	  </tr>
	   	  	  </c:forEach>
   	  	  </c:if>
   	  	  <c:if test="${empty requestScope.memberList}">
   	  	  	  <tr class="memberInfo">
   	  	  	  	<td colspan="4" style="text-align: center; ">검색되어진 데이터가 없습니다!</td>
   	  	  	  </tr>	  
   	  	  </c:if>
   	  	  
       </tbody>
    </table>
    
    <nav class="my-5">
    	<div style="display: flex; width: 80%;">
    		<ul class="pagination" style='margin:auto;'>
    			${requestScope.pageBar}
    		</ul>
    	</div>
    </nav>    


<jsp:include page="<%= ctxPath %>/WEB-INF/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%@ page import="board.model.BoardDAO" %>
<%@ page import="board.model.QnABoardVO" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%
	String ctxPath = request.getContextPath();
	
%>

<style type="text/css">
	 #navbar2 {
   display: inline-block !important;
} 
</style>

  
<meta charset="UTF-8">
<title>상품 Q&A</title>

<jsp:include page="/WEB-INF/header.jsp"/>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/lee_css/semi_style.css" />




<!-- 서머노트를 위해 추가해야할 부분 시작 -->
  <script src="<%= ctxPath%>/summernote/summernote-lite.js"></script>
  <script src="<%= ctxPath%>/summernote//summernote-ko-KR.js"></script>
  <link rel="stylesheet" href="<%= ctxPath%>/summernote/summernote-lite.css">
  <!--  -->
  
 <!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> 

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<!-- 썸머노트 추가 끝 -->

 


<script type="text/javascript">
	
	$(document).ready(function(){
		
		
		
	});
	
	function goEdit() {
		  
		  // *** 필수입력 사항에 모두 입력이 되었는지 검사한다. *** //
		  let b_FlagRequiredInfo = false;
		  
		  $("input#qnaSubject").each(function(index, item){
			  const data = $(item).val().trim();
			  if(data == "") {
				  alert("제목 항목은 필수 입력값입니다.");
				  b_FlagRequiredInfo = true;
				  return false;  // for 문에서 break; 와 같은 기능이다.
			  }
		  });
		  
		  if(b_FlagRequiredInfo) {
			  return; // 종료 
		  } 
		 
		  
		  $("textarea#editordata").each(function(index, item){
			  const data = $(item).val().trim();
			  if(data == "") {
				  alert("내용(을/를) 입력하세요.");
				  b_FlagRequiredInfo = true;
				  return false;  // for 문에서 break; 와 같은 기능이다.
			  }
		  });
		  
		  if(b_FlagRequiredInfo) {
			  return; // 종료 
		  } 
		  
		  $("input#qnaPasswd").each(function(index, item){
			  const data = $(item).val().trim();
			  if(data == "") {
				  alert("비밀번호 항목은 필수 입력값입니다.");
				  b_FlagRequiredInfo = true;
				  return false;  // for 문에서 break; 와 같은 기능이다.
			  }
		  });
		  
		  if(b_FlagRequiredInfo) {
			  return; // 종료 
		  } 
		  
		  
	/* 	  // *** 비밀글설정이 선택 되었는지 검사한다. *** //
		  const qnaIssecretCheckedLength = $("input:radio[name='qnaIssecret']:checked").length;
		  
		  if(qnaIssecretCheckedLength == 0) {
			  alert("비밀글 유무를 선택하셔야 합니다.");
			  return; // 종료
		  }
		   */
		  
		  
		  
		  const frm = document.qnaEditFrm;
		  frm.action = "<%= ctxPath%>/board/qnaUpdateEnd.book";
		  frm.method = "post"; 
		  frm.submit();
		  
		  
	}// end of function goQnaWrite() {}------------------------------------
	
	function cancelUpdate(){
		if( confirm("수정을 취소하시겠습니까?") == true ) {
			window.history.back();	
		}
		else{
			
		}
	}
	

</script>




	
<div class="container">

<div class="contents">
  <div class="title" >
  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/ico_heading.gif" /></div>
  	<h2>상품 Q&A</h2>
  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/bar_eee.gif" /></div>
  	<span >상품 Q&A입니다. 상품에 관해서 궁금하신 점을 질문해주세요.</span>
    
  </div>
  <p class="mb-3"></p>
  
  <c:set var="qnaVO" value="${requestScope.qnaVO}" />
  	
  		
  	
  	<form name="qnaEditFrm" method="post"  >
		<div class="table table-responsive">
		<table class=" write_review">
		  	<tbody>
		    <tr>
		      <th class="col-2" >제목</th>
		      <td class="col-10" ><input type="text" id="qnaSubject" name="qnaSubject" value="${qnaVO.qna_title}" /></td>
		    </tr>
		  	
		  	 <%--
		    <tr class="notMember hidden">
		      <th>작성자</th>
		      <td> <input type="text" id="writer" name="writer" /></td> 
		      	<input type="hidden" id="qnaUserid" name="qnaUserid" />
               <input type="text" name="qnaWriter" id="name" class="requiredInfo" required /> 
		    </tr>
		    --%>
		    
		    <%--
		    <tr class="hidden" >
		      <th>이메일</th>
		      <td>
		      	<input type="text" id="email1" name="email1" />
		      	@
		      	<input type="text" id="email2" name="email2" />
		      	<select id="email3">
		      		<option selected="selected">-이메일선택-</option>
		      		<option>naver.com</option>
		      		<option>daum.net</option>
		      		<option>nate.com</option>
		      		<option>hotmail.com</option>
		      		<option>yahoo.com</option>
		      		<option>empas.com</option>
		      		<option>korea.com</option>
		      		<option>dreamwiz.com</option>
		      		<option>gmail.com</option>
		      		<option>직접입력</option>
		      	</select>
		      </td>
		    </tr>
		    --%>
		    
		    
		    
		    <tr>
		      
		      <td colspan="2">
		      	
		      		<textarea class="summernote" id="editordata" name="qnaContent">${qnaVO.qna_contents}</textarea>
                        <script>
                        $('.summernote').summernote({
                        	height: 300,                 // 에디터 높이
                            minHeight: 600,             // 최소 높이
                            maxHeight: null,             // 최대 높이
                            focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
                            lang: "ko-KR",               // 한글 설정
                            placeholder: '최대 2048자까지 쓸 수 있습니다'   //placeholder 설정
                           });
                        </script>
		      	
		      	
		      </td>
		    
		    
		    </tr>
		    
		    <%--
		     <tr class="hidden">
		      <th>UCC URL</th>
		      <td class="uccurl_input">
		      	<input type="text" id="ucc_url" name="ucc_url"/>
		      </td>
		    </tr> 
		    --%>
		     <%--
		    <tr>
		      <th>비밀번호</th>
		      <td>
		      	<input type="text" id="qnaPasswd" name="qnaPasswd" type="password"/>
		      </td>
		    </tr>
		    --%>
		    <tr>
				<th scope="row">비밀글설정</th>
				<td>
						<c:if test="${qnaVO.qna_issecret eq '0'}">
						<input checked="checked" type="radio" name="qnaIssecret" id="qnaPublic" value="0"/>공개글
						&nbsp;
						<input  type="radio" name="qnaIssecret" id="qnaSecret" value="1" />비밀글
						</c:if> 
						
						<c:if test="${qnaVO.qna_issecret eq '1'}">
						<input type="radio" name="qnaIssecret" id="qnaPublic" value="0"/>공개글
						&nbsp;
						<input checked="checked" type="radio" name="qnaIssecret" id="qnaSecret" value="1" />비밀글
						</c:if>
						<input type="hidden" class="qna_issecret" name="qna_issecret" id="qna_issecret" value="${(requestScope.qnaVO).qna_issecret}"/>
				</td>
				
			</tr>
		   
					
		    
		    
		    
		    </tbody>
		  
		</table>
		
		<input type="hidden" name="pk_qna_num" id="pk_qna_num" value="${qnaVO.pk_qna_num}">
		<span style="display:none;">${qnaVO.pk_qna_num}</span>	
		
	</div>
	</form>

	<div class="buttons">
		
		<button class="btn btn_update" type="button" onclick="goEdit()">수정</button>
		<button class="btn btn_delete" type="button" onclick="cancelUpdate()">취소</button>		
		
	</div>
  
</div>
</div>


	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
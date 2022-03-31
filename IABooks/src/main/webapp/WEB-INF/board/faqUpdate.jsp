<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>

<style type="text/css">
	#navbar2 {
   display: inline-block !important;
}
</style>

  
<meta charset="UTF-8">
<title>FAQ 글 수정하기</title>

<jsp:include page="/WEB-INF/header.jsp"/>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/lee_css/semi_style.css" />


 


<script type="text/javascript">
	

	function goEdit() {
		  
		  // *** 필수입력 사항에 모두 입력이 되었는지 검사한다. *** //
		  
		const frm = document.editFrm;
	      frm.method = "POST";
	      frm.action = "<%= ctxPath%>/board/faqUpdateEnd.book";
	      frm.submit();
		  
	  }// end of function goEdit()-----------------------------
	
	function cancelUpdate() {
		  
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
  	<h2 >FAQ</h2>
  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/bar_eee.gif" /></div>
  	<span >이용안내 FAQ입니다.</span>
    
  </div>
  <p class="mb-3"></p>
  
  <c:set var="faqVO" value="${faqVO}" />
  <form name="editFrm">
	<div class="table table-responsive">
		<table class=" write_review">
		  	<tbody>
		    <tr>
		      <th class="col-2" >제목</th>
		      <td class="col-10" ><input type="text" id="faqBoardTitle" name="faqBoardTitle" value="${(requestScope.faqVO).faq_title}"/></td>
		    </tr>
		  	</tr>
		    <tr class="notMember">
		      <th>작성자</th>
		      <td><input type="text" id="faqBoardWriter" name="faqBoardWriter" value="${(requestScope.faqVO).faq_writer}" /></td>
		    </tr>
		    
		    <tr class="notMember">
		      <th>분류</th>
		      	<td>
		      	   <select id="faqBoardCate" class="cateDropdown" name="faqBoardCate">
				       <option value="1">전체</option>
		               <option value="2">회원</option>
		               <option value="3">상품</option>
		               <option value="4">반품/교환</option>
		               <option value="5">주문/배송</option>
		               <option value="6">제휴</option>
			       </select>
		      	</td>
		    </tr>
		    
		    <tr>
		      
		      <td colspan="2">
		      	
		      		<textarea class="form-control" maxlength="3000" style="height:350px;" id="faqBoardContent" name="faqBoardContent">${(requestScope.faqVO).faq_contents}</textarea>
		      		
		      		<!-- <textarea class="summernote" id="faqBoardContent" name="faqBoardContent"></textarea>
                        <script>
                        $('.summernote').summernote({
                        	height: 300,                 // 에디터 높이
                            minHeight: 600,             // 최소 높이
                            maxHeight: null,             // 최대 높이
                            focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
                            lang: "ko-KR",               // 한글 설정
                            placeholder: '최대 2048자까지 쓸 수 있습니다'   //placeholder 설정
                           });
                        </script> -->
		  
		      </td>
		    </tr>
		    <tr>
		      <th>첨부파일1</th>
		      <td class="" >
		      	<button  name="file_attach" id="file_attach" type="button">파일 선택</button> <%--  button으로 할지 input으로 할지 고민고민 --%>
		      	<span>선택된 파일 없음</span>
		      </td>
		    </tr>
		    
		    
		    
		    </tbody>
		  
		</table>
		<input type="hidden" name="pk_faq_board_num" id="pk_faq_board_num" value="${(requestScope.faqVO).pk_faq_board_num}">
		<span style="display:none;">${(requestScope.faqVO).pk_faq_board_num}</span>	
	  </div>
	</form>
	
	<div class="buttons">
		<button class="btn btn_update" type="button" onclick="goEdit();">수정하기</button>
		<button class="btn btn_delete" type="button" onclick="cancelUpdate();">취소</button>	
		
	</div>
  
</div>
</div>


	
<jsp:include page="/WEB-INF/footer.jsp"/>


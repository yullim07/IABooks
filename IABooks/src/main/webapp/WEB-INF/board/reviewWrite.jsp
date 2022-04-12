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
<title>타인의 책장</title>

<jsp:include page="/WEB-INF/header.jsp"/>

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
	
	function goReviewSubmit() {
		  
			// *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
			/*
			let b_FlagRequiredInfo = false;
			
			$("input#reviewBoardPasswd").each(function(index, item) {
				const data = $(item).val().trim();
				if(data == ""){
					alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
					b_FlagRequiredInfo = true;
					return false; // each문에서 for문에서 break; 와 같은 기능이다.
				}
			});
			
			if(b_FlagRequiredInfo) {
				return;
			}
		  	*/
		  const frm = document.reviewSubmitFrm;
		  frm.action = "reviewSubmit.book";
		  frm.method = "post";
		  frm.submit();
		  
	  }// end of function goReviewSubmit() {}------------------------------------

</script>




	
<div class="container">

<div class="contents">
  <div class="title" >
  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/ico_heading.gif" /></div>
  	<h2 >타인의 책장</h2>
  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/bar_eee.gif" /></div>
  	<span >후기를 작성하는 공간입니다.</span>
    
  </div>
  <p class="mb-3"></p>
  
  
	<div class="table table-responsive">
		<form name="reviewSubmitFrm" enctype="multipart/form-data">
		<c:set var="revVO" value="${requestScope.revVO}" />
		<c:set var="pk_pro_num" value="${requestScope.pk_pro_num}" />
		<input type="hidden" class="pk_pro_num" name="pk_pro_num" id="pk_pro_num" value="${pk_pro_num}">
		<input type="hidden" class="fk_pnum" name="fk_pnum" id="fk_pnum" value="${revVO.fk_pnum}">
		<table class=" write_review">
		  	<%-- <tbody> --%>
		    <tr>
		      <th class="col-2" >제목</th>
		      <td class="col-10" ><input type="text" id="reviewBoardTitle" name="reviewBoardTitle" /></td>
		    </tr>
		  	
		    <tr class="notMember">
		      <th>작성자</th>
		      <td><input type="text" id="reviewBoardWriter" name="reviewBoardWriter" /></td>
		    </tr>
		    
		    <!-- <tr>
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
		    </tr> -->
		    
		    
		    <tr >
		      <th>평점</th>
		      <td class="star_grade" style="vertical-align: middle;">
				  <input type="radio" id="grade" name="grade" value="5">
				  <label for="grade5"><span class="point" style="color:red;"><em>★★★★★</em></span></label>
				  <input type="radio" id="grade" name="grade" value="4">
				  <label for="grade4"><span class="point" style="color:red;"><em>★★★★</em></span></label>
				  <input type="radio" id="grade" name="grade" value="3">
				  <label for="grade3"><span class="point" style="color:red;"><em>★★★</em></span></label>
				  <input type="radio" id="grade" name="grade" value="2">
				  <label for="grade2"><span class="point" style="color:red;"><em>★★</em></span></label>
				  <input type="radio" id="grade" name="grade" value="1">
				  <label for="grade1"><span class="point" style="color:red;"><em>★</em></span></label>
		      </td>
		    </tr>
		    
		    <tr>
			<%-- ${revVO.fk_pnum} ${pk_pro_num} --%>
		      <td colspan="2">
		      	
		      		<textarea class="summernote" name="reviewBoardContent" id="reviewBoardContent"></textarea>
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
		    <tr>
		      <th>첨부파일</th>
		      <td class="" >
		      		<input type="file"  name="rev_file" class="rev_file"/>  <%--  button으로 할지 input으로 할지 고민고민 --%>
		      	
		      </td>
		    </tr>
		    <tr>
		      <th>비밀번호</th>
		      <td>
		      	<input type="password" id="reviewBoardPasswd" name="reviewBoardPasswd" size="20" maxlength="20" required />
		      </td>
		    </tr>
		    <%-- </tbody> --%>
		  
		</table>
		
				
		</form>
	</div>
	
	<div class="buttons">
		
		<button class="btn btn_list" type="button" onclick="location.href='<%= ctxPath%>/board/reviewBoard.book'">목록</button>
		<button class="btn btn_cancel" type="button">취소</button>
		<button class="btn btn_submit" type="button" onclick="goReviewSubmit()">등록</button>	
		
	</div>
  
</div>
</div>


	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">

</style>

	  
<meta charset="UTF-8">
<title>타인의 책장</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jaehee_pages/semicss/semi_style.css" />

<jsp:include page="../header.jsp"/>


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

</script>




	
<div class="container">

<div class="contents">
  <div class="title" >
  	<div class="title_icon" ><img src="<%= ctxPath%>/jaehee_pages/semi_images/ico_heading.gif" /></div>
  	<h2 >타인의 책장</h2>
  	<div class="bar_icon" ><img src="<%= ctxPath%>/jaehee_pages/semi_images/bar_eee.gif" /></div>
  	<span >후기를 작성하는 공간입니다.</span>
    
  </div>
  <p class="mb-3"></p>
  
  
	<div class="table table-responsive">
		<table class=" write_review">
		  	<tbody>
		    <tr>
		      <th class="col-2" >제목</th>
		      <td class="col-10" ><input type="text" id="subject" name="subject" /></td>
		    </tr>
		  	
		    <tr class="notMember">
		      <th>작성자</th>
		      <td><input type="text" id="writer" name="writer" /></td>
		    </tr>
		    
		    <tr>
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
		    
		    
		    <tr>
		      <th>평점</th>
		      <td>
				  <input type="radio" id="point0" name="point" value="5">
				  <label for="point0"><span class="point" style="color:red;"><em>★★★★★</em></span></label>
				  <input type="radio" id="point1" name="point" value="5">
				  <label for="point1"><span class="point" style="color:red;"><em>★★★★</em></span></label>
				  <input type="radio" id="point2" name="point" value="5">
				  <label for="point2"><span class="point" style="color:red;"><em>★★★</em></span></label>
				  <input type="radio" id="point3" name="point" value="5">
				  <label for="point3"><span class="point" style="color:red;"><em>★★</em></span></label>
				  <input type="radio" id="point4" name="point" value="5">
				  <label for="point4"><span class="point" style="color:red;"><em>★</em></span></label>
		      </td>
		    </tr>
		    
		    <tr>
		      
		      <td colspan="2">
		      	
		      		<textarea class="summernote" name="editordata"></textarea>
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
		      <td>
		      	<a href="#">
			      	<img id="file_attach_2" name="file_attach" src="semi_images/ico_attach2.gif" onmouseover="showImg(this)" onmouseout="hideImg(this)"/>
			      	<a class="file_attach" href="#">review-attachment-0515b276-bd69-4c97-84ae-76781fcfc993.jpeg</a>
			    </a>
		      </td>
		    </tr>
		    <tr>
		      <th>UCC URL</th>
		      <td class="uccurl_input">
		      	<input type="text" id="ucc_url" name="ucc_url"/>
		      </td>
		    </tr>
		    <tr>
		      <th>첨부파일1</th>
		      <td class="" >
		      	<button name="file_attach" type="file">파일 선택</button> <%--  button으로 할지 input으로 할지 고민고민 --%>
		      	<span>선택된 파일 없음</span>
		      </td>
		    </tr>
		    <tr>
		      <th>첨부파일2</th>
		      <td class="" >
		      	<button name="file_attach" type="file">파일 선택</button>
		      	<span>선택된 파일 없음</span>
		      </td>
		    </tr>
		    <tr>
		      <th>첨부파일3</th>
		      <td class="" >
		      	<button name="file_attach" type="file">파일 선택</button>
		      	<span>선택된 파일 없음</span>
		      </td>
		    </tr>
		    <tr>
		      <th>첨부파일4</th>
		      <td class="" >
		      	<button name="file_attach" type="file">파일 선택</button>
		      	<span>선택된 파일 없음</span>
		      </td>
		    </tr>
		    <tr>
		      <th>첨부파일5</th>
		      <td class="" >
		      	<button name="file_attach" type="file">파일 선택</button>
		      	<span>선택된 파일 없음</span>
		      </td>
		    </tr>
		    <tr>
		      <th>비밀번호</th>
		      <td>
		      	<input type="text" id="password" name="password" type="password"/>
		      </td>
		    </tr>
		    
		    <tr class="notMember">
		      <th>자동등록방지<br>보안문자</th>
		      <td>
		      	<img id="captcha" /> <%-- captcha 오픈소스를 가져와야겠다 --%>
		      	<img src="<%= ctxPath%>/jaehee_pages/semi_images/btn_captcha_refresh.png"/>
		      	
		      	<p class="gBlank5"> 
		      		<input type="text"  id="captcha" name="captcha" placeholder="보안문자를 입력해 주세요." type="text"/>
		      		<%-- 느낌표 이미지를 span::before로 가져와보기 --%>
		      		<img src="<%= ctxPath%>/jaehee_pages/semi_images/ico_info.gif"/>
		      		<span class="ec-base-help txtInfo">영문, 숫자 조합을 공백없이 입력하세요(대소문자구분)</span> 
		      	</p>
		      </td>
		    </tr>
		    <tr>
		    	<th>
		    		개인정보 수집 및<br>이용 동의
		    	</th>
		    	<td>
		    		<textarea id="terms" class="agree" name="terms" style="width: 60%; height: 140px; margin: 0 0 10px 0; ">
		    			■ 개인정보의 수집·이용 목적
						서비스 제공 및 계약의 이행, 구매 및 대금결제, 물품배송 또는 청구지 발송, 회원관리 등을 위한 목적
						
						■ 수집하려는 개인정보의 항목
						이름, 주소, 연락처, 이메일 등
						
						■ 개인정보의 보유 및 이용 기간
						회사는 개인정보 수집 및 이용목적이 달성된 후에는 예외없이 해당정보를 파기합니다.
					</textarea>
					<div>
						개인정보 수집 및 이용에 동의하십니까?  
						<input type="radio" id="privacy_agreement0" name="privacy_agreement" value="T">
				    	<label for="privacy_agreement0">동의함</label>
				    	<input type="radio" id="privacy_agreement1" name="privacy_agreement" value="F">
				    	<label for="privacy_agreement1">동의안함</label>
					</div>
					
		    	</td>
		    </tr>
		    
		    
		    
		    </tbody>
		  
		</table>
	</div>
	
	<div class="buttons">
		
		<button class="btn btn_list" type="button">목록</button>
		<button class="btn btn_cancel" type="button">취소</button>
		<button class="btn btn_submit" type="button">등록</button>	
		
	</div>
  
</div>
</div>


	
<jsp:include page="../footer.jsp"/>
 
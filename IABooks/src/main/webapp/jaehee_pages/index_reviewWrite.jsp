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


<script type="text/javascript">
	
	$(document).ready(function(){
		
	
	});

</script>


<jsp:include page="../header.jsp"/>

	
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
		      <td class="col-10" ><input id="subject" name="subject" /></td>
		    </tr>
		  	
		    <tr class="notMember">
		      <th>작성자</th>
		      <td><input id="writer" name="writer" /></td>
		    </tr>
		    
		    <tr>
		      <th>이메일</th>
		      <td>
		      	<input id="email1" name="email1" />
		      	@
		      	<input id="email2" name="email2" />
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
				  <label for="point0"><span class="point5"><p>★★★★★</p></span></label>
				  <input type="radio" id="point1" name="point" value="5">
				  <label for="point1"><span class="point5"><p>★★★★</p></span></label>
				  <input type="radio" id="point2" name="point" value="5">
				  <label for="point2"><span class="point5"><p>★★★</p></span></label>
				  <input type="radio" id="point3" name="point" value="5">
				  <label for="point3"><span class="point5"><p>★★</p></span></label>
				  <input type="radio" id="point4" name="point" value="5">
				  <label for="point4"><span class="point5"><p>★</p></span></label>
		      </td>
		    </tr>
		    
		    <tr>
		      
		      <td colspan="2">
		      	
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
		      	<input id="ucc_url" name="ucc_url"/>
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
		      	<input id="password" name="password" type="password"/>
		      </td>
		    </tr>
		    
		    <tr class="notMember">
		      <th>자동등록방지<br>보안문자</th>
		      <td>
		      	<img id="captcha" /> <%-- captcha 오픈소스를 가져와야겠다 --%>
		      	<img src="<%= ctxPath%>/jaehee_pages/semi_images/btn_captcha_refresh.png"/>
		      	
		      	<p class="gBlank5"> 
		      		<input id="captcha" name="captcha" placeholder="보안문자를 입력해 주세요." type="text"/>
		      		<%-- 느낌표 이미지를 span::before로 가져와보기 --%>
		      		<span class="ec-base-help txtInfo">영문, 숫자 조합을 공백없이 입력하세요(대소문자구분)</span> 
		      	</p>
		      </td>
		    </tr>
		    <tr>
		    	<th>
		    		
		    	</th>
		    	<td>
		    		
		    	</td>
		    </tr>
		    
		    
		    
		    </tbody>
		  
		</table>
	</div>
	
	<div class="buttons">
		
		<button class="btn btn_list" type="button">목록</button>
		<button class="btn btn_update" type="button">수정</button>
		<button class="btn btn_delete" type="button">삭제</button>	
		
	</div>
	
	<div class="prev_next table table-responsive">
		<table class="prev_next">
			<tbody>
				<tr>
					<th><img src="<%=ctxPath%>/jaehee_pages/semi_images/ico_move_prev.gif"/><a>이전글</a></th>
					<td><a href="">만족</a></td>
				</tr>
				<tr>
					<th><img src="<%=ctxPath%>/jaehee_pages/semi_images/ico_move_next.gif"/><a>다음글</a></th>
					<td><a href="">고민하며 성장하는 모습은 감동적이고 아름답다.</a></td>
				</tr>
			</tbody>
			
		</table>
	</div>
	
	
 	<div class="related">
 		<h3>관련 글 보기</h3>
 
  		<div class="table">
	  		<table class="table tbl_related table-hover">
			    <thead>
			      <tr class="tblHeader">
			        <th width="9.2%">번호</th>
			        <th width="18.5%">상품명</th>
			        <th width="40%">제목</th>
			        <th width="11%">작성자</th>
			        <th width="10.5%">작성일</th>
			       <!--  <th width="10.5%">조회</th> -->
			      </tr>
			    </thead>
			    <tbody>
			      <tr>
			        <td class="tbl_number mycenter">218</td>
			        <td class="tbl_bookname">
						<span >직업이 술꾼입니다!</span>
			        </td>
			        <td class="tbl_subject"><a href="">만족</a></td>
			        <td class="tbl_writer mycenter">네****</td>
			        <td class="tbl_date mycenter">2022-03-10</td>
			      </tr>
			      
			      <tr>
			        <td class="tbl_number mycenter">214</td>
			        <td class="tbl_bookname">
						<span >직업이 술꾼입니다!</span>
			        </td>
			        <td class="tbl_subject"><a href="">보통</a></td>
			        <td class="tbl_writer mycenter">네****</td>
			        <td class="tbl_date mycenter">2022-02-13</td>
			      </tr>
			      
			      <tr>
			        <td class="tbl_number mycenter">204</td>
			        <td class="tbl_bookname">
						<span >직업이 술꾼입니다!</span>
			        </td>
			        <td class="tbl_subject"><a href="">만족</a></td>
			        <td class="tbl_writer mycenter">네****</td>
			        <td class="tbl_date mycenter">2022-01-25</td>
			      </tr>
			      
			      <tr>
			        <td class="tbl_number mycenter">203</td>
			        <td class="tbl_bookname">
						<span >직업이 술꾼입니다!</span>
			        </td>
			        <td class="tbl_subject"><a href="">직업이 술꾼이라니 너무 재밌는 책이라 구입했습니다. 먼저 일러스트로 알게 되었고, 그 다음<img id="file_attach" name="file_attach" src="semi_images/ico_attach2.gif" onmouseover="showImg(this)" onmouseout="hideImg(this)"/></a></td>
			        <td class="tbl_writer mycenter">네****</td>
			        <td class="tbl_date mycenter">2022-01-24</td>
			      </tr>
			      
			      <tr>
			        <td class="tbl_number mycenter">194</td>
			        <td class="tbl_bookname">
						<span >직업이 술꾼입니다!</span>
			        </td>
			        <td class="tbl_subject"><a href="">배송이 빨라 좋았어요!<img id="file_attach" name="file_attach" src="semi_images/ico_attach2.gif" onmouseover="showImg(this)" onmouseout="hideImg(this)"/></a></td>
			        <td class="tbl_writer mycenter">네****</td>
			        <td class="tbl_date mycenter">2022-01-04</td>
			      </tr>
			    </tbody>
			</table>
			
		</div>
		
	</div>
  
</div>
</div>


	
<jsp:include page="../footer.jsp"/>
 
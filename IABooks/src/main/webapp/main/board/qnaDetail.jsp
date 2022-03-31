<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">
/* 	container img {
  max-width: 100%;
  height: auto;
  display: block; */
}
</style>

	  
<meta charset="UTF-8">
<title>배송도 빠르도 책도 잘 포장돼서 왔어요! 타인의 책장</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/lee_css/semi_style.css" />

<jsp:include page="/WEB-INF/header.jsp"/>

<script type="text/javascript">
	
	$(document).ready(function(){
		
	
	});

</script>




	
<div class="container">

<div class="contents">
  <div class="title" >
  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/ico_heading.gif" /></div>
  	<h2 >상품 Q&A</h2>
  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/bar_eee.gif" /></div>
  	<span >상품 Q&A입니다. 상품에 관해서 궁금하신 점을 질문해주세요.</span>
    
  </div>
  <p class="mb-3"></p>
  
  <div class="pdt_img_info" >
  	<p><img  onclick="#" src="//indiepub.kr/web/product/tiny/202112/f449e3d8f488e8ca32e413dade853e84.jpg"/></p>
  	<div class="pdt_info" >
  		<h3><a href="#">직업이 술꾼입니다!</a></h3>
  		<p class="p_price">16,000원</p>
  		<p class="button"><button class="btn btn_detail" type="button"><a href="#">상품 상세보기 ></a></button></p>
  	</div>
  </div>
	
	
	<div class="table ">
		<table class=" review_table ">
		  	<tbody>
		    <tr>
		      <th class="col-2" >제목</th>
		      <td class="col-10" >배송도 빠르도 책도 잘 포장돼서 왔어요!</td>
		    </tr>
		  	
		    <tr>
		      <th>작성자</th>
		      <td>네****</td>
		    </tr>
		    <tr>
		      
		      <td colspan="2">
		      	<ul>
		      		
		      		<li class="li_header">
		      			<strong>작성일</strong>
		      			<span style="font-size: 11px; color: gray; ">2022-03-10 04:06:33</span>
		      		</li>
		      		<li class="li_header">
		      			<strong>조회수</strong>
		      			<span style="font-size: 11px; color: gray; ">33</span>
		      		</li>
		      	
		      	</ul>
		      	<div class="detail " >
		      		
		      		<div>
		      		<p>배송도 빠르도 책도 잘 포장돼서 왔어요!</p>
		      		</div>
		      	</div>
		      
		      </td>
		    
		    
		    </tr>
		    
		    <tr>
		      <th>비밀번호</th>
		      <td class="password">
		      	<input type="text" id="password" name="password"/>
		      	<div class="exclam_mark"><p id="wow">!</p></div>
		      	<span>삭제하려면 비밀번호를 입력하세요.</span>
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
	
	<div class="jumbotron" style="background-color:#fbfafa; border: 1px solid #e9e9e9; margin-top: 70px;">
		<form class="comment">
			<div class="mb-1"><strong>댓글달기</strong></div>
			<div class="mb-3"><a>이름 : </a><input type="text"/> <a>비밀번호 : </a><input id="comment_pwd" name="comment_pwd" type="password"/></div>
			<div style="vertical-align: middle;"><textarea style="float:left; width:90%;" id="comment" name="commnet" type="text"></textarea>
			<button onclick="#" class="submit btn-dark" type="button" style="float:right; width:9%; height: 50px; border-radius: 10%;">확인</button></div>
		</form>
	</div>
	
	
	<div class="prev_next table table-responsive" >
		<table class="prev_next line_table">
			<tbody>
				<tr>
					<th><img style="max-width:100%; height:auto;" src="<%= ctxPath%>/images/board/leejh_images/ico_move_prev.gif" id="img_prev" /><a>이전글</a></th>
					<td><a href="">만족</a></td>
				</tr>
				<tr>
					<th><img src="<%= ctxPath%>/images/board/leejh_images/ico_move_next.gif" id="img_next" /><a>다음글</a></th>
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
			        <td class="tbl_subject"><a href="">직업이 술꾼이라니 너무 재밌는 책이라 구입했습니다. 먼저 일러스트로 알게 되었고, 그 다음<img id="file_attach" name="file_attach" src="<%= ctxPath%>/images/board/leejh_images/ico_attach2.gif" onmouseover="showImg(this)" onmouseout="hideImg(this)"/></a></td>
			        <td class="tbl_writer mycenter">네****</td>
			        <td class="tbl_date mycenter">2022-01-24</td>
			      </tr>
			      
			      <tr>
			        <td class="tbl_number mycenter">194</td>
			        <td class="tbl_bookname">
						<span >직업이 술꾼입니다!</span>
			        </td>
			        <td class="tbl_subject"><a href="">배송이 빨라 좋았어요!<img id="file_attach" name="file_attach" src="<%= ctxPath%>/images/board/leejh_images/ico_attach2.gif" onmouseover="showImg(this)" onmouseout="hideImg(this)"/></a></td>
			        <td class="tbl_writer mycenter">네****</td>
			        <td class="tbl_date mycenter">2022-01-04</td>
			      </tr>
			    </tbody>
			</table>
			
		</div>
		
	</div>
  
</div>
</div>


	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
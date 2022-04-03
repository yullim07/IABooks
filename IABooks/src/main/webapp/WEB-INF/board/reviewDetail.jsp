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
		
		$(document).ready(function(){
			
			$("button.btn_delete").click( ()=> {
				
				if( confirm("글을 삭제하시겠습니까?") == true ) {
					location.href="<%= ctxPath%>/board/reviewDelete.book?pk_rnum="+${revVO.pk_rnum};
				}
			});
		
		});
	
	});

</script>




	
<div class="container">
<c:set var="revVO" value="${requestScope.revVO}" />
<div class="contents">
  <div class="title" >
  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/ico_heading.gif" /></div>
  	<h2 >타인의 책장</h2>
  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/bar_eee.gif" /></div>
  	<span >후기를 작성하는 공간입니다.</span>
    
  </div>
  <p class="mb-3"></p>
  
  <div class="pdt_img_info" >
  	<p><img src="<%= ctxPath%>/images/product/${revVO.category.cate_name}/${revVO.product.pro_imgfile_name}" id="thumbimg"/></p>
  	<div class="pdt_info" >
  		<h3><a href="#">${revVO.product.pro_name}</a></h3>
  		<p class="p_price">${revVO.product.pro_price} 원</p>
  		<p class="button"><button class="btn btn_detail" type="button"><a href="#">상품 상세보기 ></a></button></p>
  	</div>
  </div>
	
	
	<div class="table ">
		<table class=" review_table ">
		  	<tbody>
		    <tr>
		      <th class="col-2" >제목</th>
		      <td class="col-10" >${revVO.re_title}</td>
		    </tr>
		  	
		    <tr>
		      <th>작성자</th>
		      <td>${revVO.re_writer}</td>
		    </tr>
		    <tr>
		      
		      <td colspan="2">
		      	<ul>
		      		<li class="li_header">
		      			<strong>평점</strong>
		      			<c:if test="${revVO.re_grade eq 1 }">
					   <img src="<%= ctxPath%>/images/board/jeonghm_images/ico_point1.gif" />
					   </c:if>
					   <c:if test="${revVO.re_grade eq 2 }">
					   <img src="<%= ctxPath%>/images/board/jeonghm_images/ico_point2.gif" />
					   </c:if>
					   <c:if test="${revVO.re_grade eq 3 }">
					   <img src="<%= ctxPath%>/images/board/jeonghm_images/ico_point3.gif" />
					   </c:if>
					   <c:if test="${revVO.re_grade eq 4 }">
					   <img src="<%= ctxPath%>/images/board/jeonghm_images/ico_point4.gif" />
					   </c:if>
					   <c:if test="${revVO.re_grade eq 5 }">
					   <img src="<%= ctxPath%>/images/board/jeonghm_images/ico_point5.gif" />
					   </c:if>
		      		</li>
		      		<li class="li_header">
		      			<strong>작성일</strong>
		      			<span style="font-size: 11px; color: gray; ">${revVO.re_date}</span>
		      		</li>
		      	
		      	</ul>
		      	<div class="detail " >
		      		<%-- <img style="max-width:100%; height:auto;"  src="<%= ctxPath%>/images/board/leejh_images/review-attachment-0515b276-bd69-4c97-84ae-76781fcfc993.jpeg"/> --%>
		      		<div>
		      		<p>${revVO.re_contents}</p>
		      		<br/>
		      		<br/>
		      		
		      		</div>
		      	</div>
		      
		      </td>
		    
		    
		    </tr>
		    <tr>
		      <th>첨부파일</th>
		      <td>
			      	<img id="file_attach_2" name="file_attach" src="<%= ctxPath%>/images/board/leejh_images/ico_attach2.gif" onmouseover="showImg(this)" onmouseout="hideImg(this)"/>
			      	<a class="file_attach" href="#">review-attachment-0515b276-bd69-4c97-84ae-76781fcfc993.jpeg</a>
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
		<button class="btn btn_list" type="button" onclick="location.href='<%= ctxPath%>/board/reviewBoard.book'">목록</button>
		<button class="btn btn_update" type="button" onclick="location.href='<%= ctxPath%>/board/reviewUpdate.book?pk_rnum=${revVO.pk_rnum}'">수정</button>
		<button class="btn btn_delete" type="button">삭제</button>	
		
	</div>
	
	<div class="prev_next table table-responsive">
				<table class="prev_next">
					<tbody>
						<tr>
							<th>
								<img src="<%=ctxPath%>/images/board/leejh_images/ico_move_prev.gif" id="img_prev" />
								<a href="<%= ctxPath%>/board/reviewDetail.book?pk_rnum=${revVO.next_num}">다음글</a>
							</th>
							
							<td id="td_left" class="board_prev">
								<c:if test="${revVO.next_num ne 0 }">	
									<a href="<%= ctxPath%>/board/reviewDetail.book?pk_rnum=${revVO.next_num}">${revVO.next_title}</a>
								</c:if>
								<c:if test="${revVO.next_num eq 0 }">	
									<p>다음글이 없습니다.</p>
								</c:if>
							</td>
						</tr>
						<tr>
							<th><img src="<%=ctxPath%>/images/board/leejh_images/ico_move_next.gif" id="img_next" />
								<a href="<%= ctxPath%>/board/reviewDetail.book?pk_rnum=${revVO.prev_num}">이전글</a>
							</th>
							<td id="td_left" class="board_next">
								<c:if test="${revVO.prev_num ne 0 }">
									<a href="<%= ctxPath%>/board/reviewDetail.book?pk_rnum=${revVO.prev_num}">${revVO.prev_title}</a>
								</c:if>
								<c:if test="${revVO.prev_num eq 0 }">	
									<p>이전글이 없습니다.</p>
								</c:if>
							</td>
						</tr>
					</tbody>
					
				</table>
			</div>
	
	
 	<%-- <div class="related">
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
		
	</div> --%>
  	<input type="hidden" class="pk_rnum" name="pk_rnum" id="pk_rnum" value="${revVO.pk_rnum}"/>
</div>
</div>


	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
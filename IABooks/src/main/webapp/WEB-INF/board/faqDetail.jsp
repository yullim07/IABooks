<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">

</style>

	  
<meta charset="UTF-8">
<title>FAQ 상세보기</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/jeong_css/semi_style.css" />

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<jsp:include page="/WEB-INF/header.jsp"/>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$("button.btn_delete").click( ()=> {
			
			if( confirm("글을 삭제하시겠습니까?") == true ) {
				location.href="<%= ctxPath%>/board/faqDelete.book?pk_faq_board_num="+${faqVO.pk_faq_board_num};
			}
		});
	
	});

	//////////////////////////////////////
	
	// 함수 선언
	
	
	
	
</script>



    


	
 <div class="container">
	<c:set var="faqVO" value="${requestScope.faqVO}" />
	<div class="content">
	    
	<div class="title" >
		  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_heading.gif" /></div>
		  	<h2>FAQ</h2>
		  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/jeonghm_images/bar_eee.gif" /></div>
		  	<span >이용안내 FAQ입니다.</span>
	    
	   </div>
	   			
				<table class=" review_table table_content">
				  	<tbody>
				    <tr>
				      <th class="col-2" >제목</th>
				      <td class="col-10 subject" id="td_left" >${faqVO.faq_title}</td>
				    </tr>
				  	
				    <tr>
				      <th>작성자</th>
				      <td class="writer" id="td_left" >${faqVO.faq_writer}</td>
				    </tr>
				    <tr>
				      
				      <td colspan="2" class="td_content">
				      	<div class="detail detail_contents">
				      		<div class="fr-view fr-view-article">
								${faqVO.faq_contents}	
							</div>
				      	</div>
				      
				      </td>
				    
				    
				    </tr>
				    </tbody>
				  
				</table>
			
			<div class="buttons">
				
				<button class="btn btn_list" type="button" onclick="location.href='<%= ctxPath%>/board/faqBoard.book'">목록</button>
				<button class="btn btn_update" type="button" onclick="location.href='<%= ctxPath%>/board/faqUpdate.book?pk_faq_board_num=${faqVO.pk_faq_board_num}'">수정</button>
				<button class="btn btn_delete" type="button" >삭제</button>
				<%-- <button class="btn btn_delete" type="button" onclick="location.href='<%= ctxPath%>/board/faqDelete.book?pk_faq_board_num=${faqVO.pk_faq_board_num}'">삭제</button> --%>	
				
			</div>
			
			<div class="prev_next table table-responsive">
				<table class="prev_next">
					<tbody>
						<tr>
							<th>
								<img src="<%=ctxPath%>/images/board/leejh_images/ico_move_prev.gif" id="img_prev" />
								<a href="<%= ctxPath%>/board/faqDetail.book?pk_faq_board_num=${faqVO.next_num}">다음글</a>
							</th>
							
							<td id="td_left" class="board_prev">
								<c:if test="${faqVO.next_num ne 0 }">	
									<a href="<%= ctxPath%>/board/faqDetail.book?pk_faq_board_num=${faqVO.next_num}">${faqVO.next_title}</a>
								</c:if>
								<c:if test="${faqVO.next_num eq 0 }">	
									<p>다음글이 없습니다.</p>
								</c:if>
							</td>
						</tr>
						<tr>
							<th><img src="<%=ctxPath%>/images/board/leejh_images/ico_move_next.gif" id="img_next" />
								<a href="<%= ctxPath%>/board/faqDetail.book?pk_faq_board_num=${faqVO.prev_num}">이전글</a>
							</th>
							<td id="td_left" class="board_next">
								<c:if test="${faqVO.prev_num ne 0 }">
									<a href="<%= ctxPath%>/board/faqDetail.book?pk_faq_board_num=${faqVO.prev_num}">${faqVO.prev_title}</a>
								</c:if>
								<c:if test="${faqVO.prev_num eq 0 }">	
									<p>이전글이 없습니다.</p>
								</c:if>
							</td>
						</tr>
					</tbody>
					
				</table>
			</div>
		<input type="hidden" class="pk_faq_board_num" name="pk_faq_board_num" id="pk_faq_board_num" value="${faqVO.pk_faq_board_num}"/>
	</div>	
			
</div> <!-- container 끝 -->
		
		
		

<jsp:include page="/WEB-INF/footer.jsp"/>


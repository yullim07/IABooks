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
		$("button.btn_delete").click(function(){
			
			if( confirm("글을 삭제하시겠습니까?") == true ) {
				location.href="<%= ctxPath%>/board/qnaDelete.book?pk_qna_num="+"${qnaVO.pk_qna_num}";
			}
		});
		
		//댓글쓰기
		
		$("button#submitCmt").click( () =>{
			console.log("돼요?");
			 var commnettext=$("#commnet_content").val(); //댓글 내용
		        var pk_qna_num="${qnaVO.pk_qna_num}"; //게시물 번호
		        	console.log("나오는거니????"+${qnaVO.pk_qna_num});
		        var param= { "commnettext": commnettext, "pk_qna_num": pk_qna_num
		        		   , "comment_pwd" : $("input#comment_pwd").val()};
		        
		        //var param="replytext="+replytext+"&bno="+bno;
		        $.ajax({
		            type: "post", //데이터를 보낼 방식
		            url: "<%= ctxPath%>/board/commentSubmit.book", //데이터를 보낼 url
		            data: param, //보낼 데이터
		            dataType:"json",
		            success: function(json){ //데이터를 보내는것이 성공했을시 출력되는 메시지
		                alert("댓글이 등록되었습니다.");
		                listComment(); //댓글 목록 출력
		            },
		            error:function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            }
		        });
			
		});
		
		
	});//end of $(document).ready(function(){})--------------
	
	
	//댓글 목록 출력 함수
	function listComment(){
		$.ajax({
	        type: "get", //get방식으로 자료를 전달한다
	        url: "<%= ctxPath%>/board/commentList.book?pk_qna_num="+${qnaVO.pk_qna_num}, //컨트롤러에 있는 list.do로 맵핑하고 게시판 번호도 같이 보낸다.
	        success: function(result){ //자료를 보내는것이 성 공했을때 출력되는 메시지
	            //result : responseText 응답텍스트(html)
	            $("#listComment").html(result);
	        }
	    });
		
	}
	
	

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
		<c:set var="qnaVO" value="${requestScope.qnaVO}" />
			<table class=" review_table ">
			  	<tbody>
			    <tr>
			      <th class="col-2" >제목</th>
			      <td class="col-10 subject" >${qnaVO.qna_title}</td>
			    </tr>
			  	
			    <tr>
			      <th>작성자</th>
			      <td class="writer">${qnaVO.member.name}</td>
			    </tr>
			    <tr>
			      
			      <td colspan="2">
			      	<ul>
			      		
			      		<li class="li_header">
			      			<strong>작성일</strong>
			      			<span class="writedate" style="font-size: 11px; color: gray; ">${qnaVO.qna_date}</span>
			      			
			      		</li>
			      		<li class="li_header">
			      			<strong>조회수</strong>
			      			<span class="readcount" style="font-size: 11px; color: gray; ">${qnaVO.qna_readcount}</span>
			      		</li>
			      	
			      	</ul>
			      	<div class="detail " >
			      		
			      		<div class="content">
			      		${qnaVO.qna_contents}
			      		</div>
			      	</div>
			      
			      </td>
			    
			    
			    </tr>
			    
			    <%-- 
			    <tr>
			      <th>비밀번호</th>
			      <td class="password">
			      	<input type="text" id="pasword" name="password"/>
			      	<div class="exclam_mark"><p id="wow">!</p></div>
			      	<span>삭제하려면 비밀번호를 입력하세요.</span>
			      </td>
			    </tr>
			     --%> 
			    </tbody>
			  
			</table>
			<input type="hidden" class="pk_qna_num" name="pk_qna_num" id="pk_qna_num" value="${board.pk_qna_num}"/>
	</div>
	
	
	<div class="buttons">
		
		<button class="btn btn_list" type="button" onclick="location.href='<%= ctxPath%>/board/qnaBoard.book'">목록</button>
		<button class="btn btn_update" type="button" onclick="location.href='<%= ctxPath%>/board/qnaUpdate.book?pk_qna_num=${qnaVO.pk_qna_num}'">수정</button>
		<button class="btn btn_delete" type="button">삭제</button>
		<%-- <button class="btn btn_delete" type="button" onclick="location.href='<%= ctxPath%>/board/qnaDelete.book?pk_qna_num=${qnaVO.pk_qna_num}'">삭제</button> --%>	
		
	</div>
	
	<%-- 댓글달기 --%>
	
	<div>
	
		<!-- 댓글 목록 -->
		<!-- 댓글이 등록이 되면 listReply에 댓글이 쌓이게 된다 -->
		<div id="listComment"></div>
		
		<div class="comment" style=" font-size: 14px; padding:auto 20px; background-color:#fbfafa; border: 1px solid #e9e9e9; margin-top: 70px;">
			<c:set var="qnaVO" value="${qnaVO}" />
			<c:if test="${ not empty sessionScope.loginuser }">
			<form class="comment" method="post">
				<div class="mb-1"><strong>댓글달기</strong></div>
				<div class="mb-3">
					<a>이름 : </a><input id="cmtWriter" name="cmtWriter" type="text" value="${(requestScope.qnaVO).member.name}"/> 
					
					<a>비밀번호 : </a><input id="comment_pwd" name="comment_pwd" type="password" value="${(requestScope.qnaVO).qna_passwd}"/>
				</div>
				<div style="vertical-align: middle;">
					<textarea style="float:left; width:90%; height: 50px;"  id="commnet_content" name="commnet_content" ></textarea>
					<button onclick="" id ="submitCmt" class=" submit" type="button" style="color: white; float:right; font-size: 14px; border: none; background-color: #999; width:9%; height: 50px; border-radius: 10%;">확인</button>
				</div>
				
				<input type="hidden" class="fk_userid" name="fk_userid" id="fk_userid" value="${board.fk_userid}"/>
				<input type="hidden" name="pk_qna_num" id="pk_qna_num" value="${(requestScope.qnaVO).pk_qna_num}">
			</form>
			</c:if>
			<c:if test="${empty sessionScope.loginuser }">
			
			<p style="font-size: 14px; margin:0;">회원에게만 댓글 작성 권한이 있습니다.</p>
			</c:if>
		</div>
	</div>
	
	<div class="prev_next table table-responsive">
				<table class="prev_next">
					<tbody>
						<tr>
							<th><img src="<%=ctxPath%>/images/board/jeonghm_images/ico_move_prev.gif" id="img_prev" />
							<a href="<%= ctxPath%>/board/qnaDetail.book?pk_qna_num=${(board.pk_qna_num)-1}">이전글</a></th>
							<td id="td_left" class="board_prev"><a href=""></a></td>
						</tr>
						<tr>
							<th><img src="<%=ctxPath%>/images/board/jeonghm_images/ico_move_next.gif" id="img_next" />
							<a href="<%= ctxPath%>/board/qnaDetail.book?pk_qna_num=${(board.pk_qna_num)+1}">다음글</a></th>
							<td id="td_left" class="board_next"><a href=""></a></td>
						</tr>
					</tbody>
					
				</table>
			</div>
	</div>


	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
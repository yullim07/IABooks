<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
	
%>

<%-- <meta charset="UTF-8"> --%>
<title>in사과 : ${qnaVO.qna_title} | 상품Q&A</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/lee_css/semi_style.css" />

<jsp:include page="/WEB-INF/header.jsp"/>
<%-- 
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
--%>
<style type="text/css">
  div#listComment { 
  		border-collapse:collapse; 
   		font-size: 14px; 
   		width:100%; 
   		margin-top: 10px; 
   		display:inline-block;
   }
   
   div#cmtlist_header{
   		padding: 10px 0 10px 20px; 
   		background-color: #fbfafa; 
   		border:1px solid  #e9e9e9; 
   		min-height: 40px;
   }
   div#cmtlist_header  span {
    	margin-left: 10px; 
    	font-size: 12px;
   }
   div#cmtlist_header  button.cmtButton{
     	float:right;
     	margin-right: 10px; 
     	border-radius: 5px; 
     	background-color: white; 
     	border: solid 1px gray;
   }
   
   div#cmtlist_content_box{
   		padding: 20px 0 20px 25px; 
   		border: 1px solid  #e9e9e9; 
   		min-height: 60px;
   }
   
  
   
   div.customDisplay {display: inline-block;
                      margin: 1% 3% 0 0;
   }
                   
   div.spacediv {margin-bottom: 5%;}
   
 
</style>


<script type="text/javascript">
	
	$(document).ready(function(){
		$("button.btn_delete").click(function(){
			
			if( confirm("글을 삭제하시겠습니까?") == true ) {
				location.href="<%= ctxPath%>/board/qnaDelete.book?pk_qna_num="+"${qnaVO.pk_qna_num}";
			}
		});
		
		listComment();
		
		//댓글쓰기
		
		$("button#submitCmt").click( () =>{
			
			 	var commenttext=$("#comment_content").val(); //댓글 내용
		        var pk_qna_num="${(requestScope.qnaVO).pk_qna_num}"; //게시물 번호
		        var comment_pwd = $("#comment_pwd").val();
		     /*    var cmtWriter = ${(requestScope.qnaVO).member.name}.val();  "cmtWriter" : cmtWriter , */
		        var fk_userid = "${(requestScope.qnaVO).fk_userid}";
		        
		        //	console.log("나오는거니????"+${qnaVO.pk_qna_num});
		        var param= {  "comment_pwd" : comment_pwd
		        		   , "commenttext": commenttext,"fk_userid" : fk_userid , "pk_qna_num": pk_qna_num
		        		     }; 
		       /*  const queryString = $("form[name=commentFrm]").serialize(); */
		        //var param="replytext="+replytext+"&bno="+bno;
		        $.ajax({
		            type: "post", //데이터를 보낼 방식
		            url: "<%= ctxPath%>/board/commentSubmit.book", 
		            data: param, //보낼 데이터
		            dataType:"json",  
		          /*   traditional : true, */
		            /* contentType: "application/x-www-form-urlencoded; charset=UTF-8", */

		            success: function(json){ //데이터를 보내는것이 성공했을시 출력되는 메시지
		            	console.log("json : ", json);
		            	if(json.n == 1) {
		            		alert("댓글이 등록되었습니다.");
							//getAllReplies(); //댓글 새로고침
					 		listComment();
		                	//listComment(); //댓글 목록 출력
		            	}
		            	  else{
		            		 alert("댓글등록이 실패했습니다.");
		            	 } 
		            	
		            	 $("textarea#comment_content").val("").focus();
		            },
		            error:function(request, status, error){
		               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            }
		        });//end of ajax()
		        
		        let html  = "";
		        
			
		});
		
		
		
		
		
	});//end of $(document).ready(function(){})--------------
	
	
	//댓글 목록 출력 함수
	function listComment(){
	//	 var fk_qna_num="${(requestScope.cmtVO).fk_qna_num}"; //게시물 번호
		
		$.ajax({
	        type: "get", //get방식으로 자료를 전달한다  //컨트롤러에 있는 list.do로 맵핑하고 게시판 번호도 같이 보낸다.
	        url: "<%= ctxPath%>/board/commentList.book",
	        data:{"fk_qna_num":"${requestScope.qnaVO.pk_qna_num}"},
	        dataType:"JSON", 
	        		
	        success: function(json){ //자료를 보내는것이 성 공했을때 출력되는 메시지
	        	
	        	
	        	console.log("json : ", json);
	        	let html = "";
	        	console.log("출력");
	        	
	        	if(json.length > 0) {   
	        		$.each(json, function(index, item){ 
	        			/* html += "<div> "+item.fk_qna_num+"</div>"
	        				+ "<div> "+item.pk_cmt_num+"</div>"
	        			 */
	        			 var loginuserid = "${sessionScope.loginuser.userid}";
	        			 var loginusername = "${sessionScope.loginuser.name}";
	        			 var writeuserid = item.fk_userid;
	        			 html += "<div id='cmtlist_header'>" ;
	        			 if( writeuserid == 'admin'){
	        				 html += "<div> <strong>관리자</strong>";
	        			 }
	        			 else{
	        				  html += "<div> <strong>"+writeuserid.substr(0,2)+"*****</strong>";
	        			 }
	        			  html  += "<span>"+item.cmt_date+"</span>";
	        			  if( loginuserid != "" && writeuserid == loginuserid ) {
	        					html += "<button class='cmtButton' type='button' onclick='delMyComment("+item.pk_cmt_num+")'>삭제</button>"
	        				   		  + "<button class='cmtButton commentUpdate' type='button' onclick='updateMyComment("+index+","+item.pk_cmt_num+")'>수정</button>";
	        			  }
	        			          				   
	        			  html += "</div> </div>"
	        				   + " <div id='cmtlist_content_box'><div id='cmtlist_content"+index+"'>"+item.cmt_contents+"</div></div> </div>";
	        				 
		                 /*  if( loginuserid == "") {
		                     html += "<div class='customDisplay spacediv'>&nbsp;</div>";
		                  }      
		                  else if( loginuserid != "" && writeuserid != loginuserid ) {
		                     html += "<div class='customDisplay spacediv'>&nbsp;</div>";
		                  }    
		                  else if( loginuserid != "" && writeuserid == loginuserid ) {
		                     html += "<div class='customDisplay spacediv commentDel' onclick='delMyReview("+item.pk_cmt_num+")'>댓글삭제</div>";
		                  }  */
	        		});
	        	 }//end of if -----
	        	 else {
	                 html += "<div>등록된 댓글이 없습니다.</div>";
	              }// end of else ---------------------
	              
	              $("div#listComment").html(html);
	        	
	        	
	        },
	        error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	         }
	        	
	        	//result : responseText 응답텍스트(html)
	        	
	           // $("#listComment").html(result);
	        });//end of ajax()
	    }//end of fucntion listComment
		
	    
	 // 특정 제품의 제품후기를 수정하는 함수
	    function updateMyComment(index, pk_cmt_num){
	 	   
	 	    const origin_elmt = $("div#cmtlist_content"+index).html(); // 원래의 제품후기 엘리먼트
	 	   // alert(origin_elmt);   
	 	      
	 	      const cmt_contents = $("div#cmtlist_content"+index).text(); // 원래의 제품후기 내용 
	 	   // alert(review_contents);
	 	   
	 	      $("button.commentUpdate").hide(); // "후기수정" 글자 감추기
	 	      
	 	      // "후기수정" 을 위한 엘리먼트 만들기 
	 	      let html = "<textarea id='edit_textarea' style='font-size: 14px; width: 40%; height: 50px;'>"+cmt_contents+"</textarea>";
	 	          html += "<div style='display: inline-block; position: relative; top: -20px; left: 10px; font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnCommentUpdate_OK'><span>수정완료</span></button></div>";
	 	          html += "<div style='display: inline-block; position: relative; top: -20px; left: 20px; font-size: 12px; height: 25px; padding: 0;'><button type='button' class='btn btn-sm btn-outline-secondary' id='btnCommentUpdate_NO'><span>수정취소</span></button></div>";  
	 	      
	 	      // 원래의 제품후기 엘리먼트에 위에서 만든 "후기수정" 을 위한 엘리먼트로 교체하기  
	 	      $("div#cmtlist_content"+index).html(html);
	 	      
	 	      // 수정취소 버튼 클릭시 
	 	      $("button#btnCommentUpdate_NO").click(function(){
	 	         $("div#cmtlist_content"+index).html(origin_elmt); // 원래의 제품후기 엘리먼트로 복원하기  
	 	         $("button.commentUpdate").show(); // "후기수정" 글자 보여주기 
	 	      });
	 	      
	 	      // 수정완료 버튼 클릭시 
	 	      $("button#btnCommentUpdate_OK").click(function(){
	 	      // alert(review_seq); // 수정할 제품후기 번호 
	 	      // alert($("textarea#edit_textarea").val()); // 수정할 제품후기 내용
	 	      
	 	         $.ajax({
	 	            url:"<%= ctxPath%>/board/commentUpdate.book",
	 	            type:"POST",
	 	            data:{"pk_cmt_num":pk_cmt_num
	 	                ,"cmt_contents":$("textarea#edit_textarea").val()},
	 	            dataType:"JSON",
	 	            success:function(json) { // {"n":1} 또는 {"n":0}
	 	               if(json.n == 1) {
	 	            	  listComment();
	 	               }
	 	               else {
	 	                  alert("댓글 수정이 실패되었습니다.");
	 	                 listComment();
	 	               }
	 	            },
	 	            error: function(request, status, error){
	 	               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	 	            }   
	 	         });
	 	         
	 	      });
	 	   
	    }//end of function updateMyReview(index, review_seq){}---------------------- 
	
	    
	 // 특정 글의 댓글을 삭제하는 함수
	    function delMyComment(pk_cmt_num) {
	       
	       const bool = confirm("정말로 댓글을 삭제하시겠습니까?");
	    //  console.log("bool => " + bool); // bool => true , bool => false
	       
	       if(bool) {
	       
	          $.ajax({
	             url:"<%= ctxPath%>/board/commentDelete.book",
	             type:"POST",
	             data:{"pk_cmt_num":pk_cmt_num},
	             dataType:"JSON",
	             success:function(json) { // {"n":1} 또는 {"n":0}
	                if(json.n == 1) {
	                   alert("댓글 삭제가 성공되었습니다.");
	                   
	                   listComment();
	                }
	                else {
	                   alert("댓글 삭제가 실패했습니다.");
	                }
	             },
	             error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	             }
	          });
	       
	       }
	       
	    }// end of function delMyReview(review_seq) {}--------------------------  
	    
	    

</script>


<style type="text/css">
/* 	container img {
  max-width: 100%;
  height: auto;
  display: block; */
}
</style>

	
<div class="container">
<c:set var="qnaVO" value="${requestScope.qnaVO}" />
<div class="contents">
  <div class="title" >
  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/ico_heading.gif" /></div>
  	<h2 >상품 Q&A</h2>
  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/bar_eee.gif" /></div>
  	<span >상품 Q&A입니다. 상품에 관해서 궁금하신 점을 질문해주세요.</span>
    
  </div>
  <p class="mb-3"></p>
  
  	<c:if test="${not empty qnaVO.category.cate_name}">
	 <div class="pdt_img_info" >
	  	<p><img src="<%= ctxPath%>/images/product/${qnaVO.category.cate_name}/${qnaVO.product.pro_imgfile_name}" id="thumbimg"/></p>
	  	<div class="pdt_info" >
	  		<h3><a href="#">${qnaVO.product.pro_name}</a></h3>
	  		<p class="p_price">${qnaVO.product.pro_price} 원</p>
	  		<p class="button"><button class="btn btn_detail" type="button"><a href="<%= ctxPath%>/product/showBookDetail.book?pronum=${qnaVO.fk_pnum}">상품 상세보기 ></a></button></p>
	  	</div>
	  </div>
  	</c:if>
	
	<div class="table ">
		
			<table class="review_table ">
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
			      		<br/>
		      			<br/>
			      		<c:if test="${qnaVO.qna_file_original_name ne '없음'}">
			      		 	<img src="/IABooks/images/${qnaVO.qna_file_system_name}" class="img-fluid" style="width:100%;" />
			      		</c:if>
			      		
			      		
			      		</div>
			      	</div>
			      
			      </td>
			    
			    
			    </tr>
			    <tr>
			      <th>첨부파일</th>
			      <td>
				      	<c:if test="${qnaVO.qna_file_original_name ne '없음'}">
				      		<img id="file_attach_2" name="file_attach" src="<%= ctxPath%>/images/board/leejh_images/ico_attach2.gif" onmouseover="showImg(this)" onmouseout="hideImg(this)"/>
		                    <a class="file_attach" href="<%= ctxPath%>/board/fileDownload.book?pk_qna_num=${qnaVO.pk_qna_num}">${qnaVO.qna_file_original_name}</a>
		                </c:if>
		                <c:if test="${qnaVO.qna_file_original_name eq '없음'}">
		                   첨부파일없음
		                </c:if>
			      </td>
			     
			    </tr>
			    <%-- 
			    <tr>
			      <th>비밀번호</th>
			      <td class="password">
			      	<input type="password" id="pasword" name="password"/>
			      	<div class="exclam_mark"><p id="wow">!</p></div>
			      	<span>삭제하려면 비밀번호를 입력하세요.</span>
			      </td>
			    </tr>
			     --%>
			    </tbody>
			  
			</table>
			<input type="hidden" class="pk_qna_num" name="pk_qna_num" id="pk_qna_num" value="${board.pk_qna_num}"/>
	</div>
	
	
	<div class="buttons" style="margin-bottom: 70px;">
		
		<button class="btn btn_list" type="button" onclick="location.href='<%= ctxPath%>/board/qnaBoard.book'">목록</button>
		<button class="btn btn_update" type="button" onclick="location.href='<%= ctxPath%>/board/qnaUpdate.book?pk_qna_num=${qnaVO.pk_qna_num}'">수정</button>
		<button class="btn btn_delete" type="button">삭제</button>
		<%-- <button class="btn btn_delete" type="button" onclick="location.href='<%= ctxPath%>/board/qnaDelete.book?pk_qna_num=${qnaVO.pk_qna_num}'">삭제</button> --%>	
		
	</div>
	
	
		
	<div>
		<strong style="font-size: 14px; margin-left: 12px;">댓글 목록</strong>
		<!-- 댓글 목록 -->
		<div id="listComment"></div>
		
		<%-- 댓글달기 --%>
		<!-- 댓글이 등록이 되면 listComment에 댓글이 쌓이게 된다 -->
		<div class="comment" style=" font-size: 14px; padding:10px 20px; background-color:#fbfafa; border: 1px solid #e9e9e9; margin-top: 30px; min-height: 140px;">
			<form class="comment" name="comment" method="post">  
			<c:set var="qnaVO" value="${qnaVO}" />
			<c:if test="${ not empty sessionScope.loginuser }">
			 
				<div class="mb-1"><strong>댓글달기</strong></div>
					<div class="mb-3">
						<a>아이디 : </a><input id="cmtWriter" name="cmtWriter" type="text" value="${sessionScope.loginuser.userid}"/> 
						
						<a>비밀번호 : </a><input id="comment_pwd" name="comment_pwd" type="password"  autocomplete="off" value=""/>
					</div>
					<div style="vertical-align: middle;">
						<textarea style="float:left; width:90%; height: 50px;"  id="comment_content" name="comment_content" ></textarea>
						<button  id ="submitCmt" class="submitCmt" type="button" style="color: white; float:right; font-size: 14px; border: none; background-color: #999; width:9%; height: 50px; border-radius: 10%;">확인</button>
					</div>
				
					<input type="hidden" class="fk_userid" name="fk_userid" id="fk_userid" value="${(requestScope.qnaVO).fk_userid}"/>
					<input type="hidden" name="pk_qna_num" id="pk_qna_num" value="${(requestScope.qnaVO).pk_qna_num}">
			
			</c:if>
			</form>
			<c:if test="${empty sessionScope.loginuser }">
			
			<p style="font-size: 14px; margin:0; padding: 40px 10px; vertical-align: middle;">회원에게만 댓글 작성 권한이 있습니다.</p>
			</c:if>
		</div>
	</div>
	
	
	
	
	<div class="prev_next table table-responsive">
		<table class="prev_next">
			<tbody>
				<tr>
					<th>
						<img src="<%=ctxPath%>/images/board/leejh_images/ico_move_prev.gif" id="img_prev" />
						<a >이전글</a>
					</th>
					
					<td id="td_left" class="board_prev">
						<c:if test="${not empty qnaVO.prev_num}">	
							<a href="<%= ctxPath%>/board/qnaDetail.book?pk_qna_num=${qnaVO.prev_num}">${qnaVO.prev_title}</a>
						</c:if>
						<c:if test="${empty qnaVO.prev_num}">	
							<p>이전글이 없습니다.</p>
						</c:if>
					</td>
				</tr>
				<tr>
					<th><img src="<%=ctxPath%>/images/board/leejh_images/ico_move_next.gif" id="img_next" />
						<a >다음글</a>
					</th>
					<td id="td_left" class="board_next">
						<c:if test="${not empty qnaVO.next_num}">
							<a href="<%= ctxPath%>/board/qnaDetail.book?pk_qna_num=${qnaVO.next_num}">${qnaVO.next_title}</a>
						</c:if>
						<c:if test="${empty qnaVO.next_num}">	
							<p>다음글이 없습니다.</p>
						</c:if>
					</td>
				</tr>
			</tbody>
			
		</table>
	</div>
	
	<input type="hidden" class="pk_qna_num" name="pk_qna_num" id="pk_qna_num" value="${qnaVO.pk_qna_num}"/>
</div>
</div>
	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
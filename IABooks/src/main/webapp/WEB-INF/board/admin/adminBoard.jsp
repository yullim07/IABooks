<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%
	String ctxPath = request.getContextPath();
	
%>


<jsp:include page="/WEB-INF/header.jsp"/>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/jeong_css/semi_style.css" />

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">


<style type="text/css">

#faq_thead > tr > th {
	text-align: center;
}

#my_tbody > tr > td:nth-child(1), td:nth-child(2), td:nth-child(3), td:nth-child(5), td:nth-child(6) {
	text-align: center;
}

 #mySearchContent {
		font-size:14px;
}

#my_tbody > tr > td:nth-child(4) {
	padding-left : 20px;
}

tr#tr_go {
	float: left;
}

button#btn_isdelete, button#btn_delete {
	padding-top : 10px;
    width: 100px;
    height: 24px;
    background-color: #999;
    color: white;
    font-size: 12px;
    vertical-align: middle; 
    padding: 0;
    cursor: pointer;
}
</style>



<script type="text/javascript">
	
	$(document).ready(function(){
		
		//전체체크박스설정		
		$("input#selectAll").bind("click",function () {
            if ($("input#selectAll").prop("checked")) {
                $("input#qnaboardCheck").prop("checked", true);
                $("input#revboardCheck").prop("checked", true);
            } else {
                $("input#qnaboardCheck").prop("checked", false);
                $("input#revboardCheck").prop("checked", false);
            }
		});//end of $("input#selectAll").click(function ()
		
		// 체크박스가 전체 선택되었을 때 th 체크박스 활성화
		$("input#qnaboardCheck").bind("click",function() {
            if ( $("input[name='qnaboardCheck']:checked").length == $("input[name='qnaboardCheck']").length & 
            	 $("input[name='revboardCheck']:checked").length == $("input[name='revboardCheck']").length	) {
                $("input#selectAll").prop("checked", true);
            } else {
                $("input#selectAll").prop("checked", false);
            }
        });	//end of $(".test").click(function()	
        		
        $("input#revboardCheck").bind("click",function() {
            if ( $("input[name='qnaboardCheck']:checked").length == $("input[name='qnaboardCheck']").length & 
            	 $("input[name='revboardCheck']:checked").length == $("input[name='revboardCheck']").length	) {
                $("input#selectAll").prop("checked", true);
            } else {
                $("input#selectAll").prop("checked", false);
            }
        });	//end of $(".test").click(function()
		
        		
        // 선택게시글 삭제(delete)	
		$("span#deleteSelect").click(function () {
			var qnaCnt = $("input[name='qnaboardCheck']:checked").length;
	      	var qnaBoardNoArr = new Array();
	        $("input[name='qnaboardCheck']:checked").each(function() {
	        	qnaBoardNoArr.push($(this).val());
	        });
	        
	        var revCnt = $("input[name='revboardCheck']:checked").length;
	      	var revBoardNoArr = new Array();
	        $("input[name='revboardCheck']:checked").each(function() {
	        	revBoardNoArr.push($(this).val());
	        });
	        
	        if(qnaCnt == 0 && revCnt == 0){
	            alert("선택된 제품이 없습니다.");
	            return;
	        }
	        const qnaNoStr = qnaBoardNoArr.join();
	        const revNoStr = revBoardNoArr.join();
	        
	        adminBoardDeleteSelect(qnaCnt, qnaNoStr, revCnt, revNoStr);
		});//end of $("li#btn_delete").click(function ()
        
				
		// 선택게시글 공개/비공개("displaySelect")	
		$("span#displaySelect").click(function () {
			var qnaCnt = $("input[name='qnaboardCheck']:checked").length;
	      	var qnaBoardNoArr = new Array();
	        $("input[name='qnaboardCheck']:checked").each(function() {
	        	qnaBoardNoArr.push($(this).val());
	        });
	        
	        var revCnt = $("input[name='revboardCheck']:checked").length;
	      	var revBoardNoArr = new Array();
	        $("input[name='revboardCheck']:checked").each(function() {
	        	revBoardNoArr.push($(this).val());
	        });
	        
	        if(qnaCnt == 0 && revCnt == 0){
	            alert("선택된 제품이 없습니다.");
	            return;
	        }
	        const qnaNoStr = qnaBoardNoArr.join();
	        const revNoStr = revBoardNoArr.join();
	        
	        adminBoardDisplaySelect(qnaCnt, qnaNoStr, revCnt, revNoStr);
		});//end of $("span#displaySelect").click(function () {
        		
			
		$("button#btn_mySearch").click(function(){
			// console.log(이 form 이 submit 될 때 함수 실행하겠다.);	
			
			if($("select.mySearchType").val() == "" ) {
				alert("검색대상을 올바르게 선택하세요!! ");
				return false; // submit을 하지 않고 종료
			}
			
			if($("input#mySearchWord").val().trim() == "") {
				alert("검색어는 공백만으로 되지 않습니다. 검색어를 올바르게 입력하세요!!");
				return false;
			}
			
			$("input#mySearchWord").bind("keyup", function(){
				
				if(event.keyCode == 13) {
					// 검색어에서 엔터를 치면 검색하러 간다.
					goAdminBoardSearch();
				}
				
			});
			
		}); // end of $("button#btn_search").click(function(){})----------------
		
		// 검색조건을 넣은 후, action단에서 페이지바를 보여주고 다른 페이징 처리를 할 때 검색조건을 넣어준다
		// alert("~~ 확인용 : ${requestScope.searchType} ");
		// "~~ 확인용 : "
		// 회원명 조건하고 했더니 "~~ 확인용 : name" 뜸
		if( "${requestScope.mySearchType}" != "" ) { // 반드시 if에 넣을때 쌍따옴표 꼭 붙여라!!(자바스크립트임)
			$("select#mySearchType").val("${requestScope.mySearchType}");
			$("input#mySearchWord").val("${requestScope.mySearchWord}");
		}
		
		
	});

	// Function Declaration
	function goAdminBoardSearch(){
	
		if($("select.mySearchType").val() == "" ) {
			alert("검색대상을 올바르게 선택하세요!!");
			return; // goAdminBoardSearch() 함수 종료.
		}
		
		if($("input#mySearchWord").val().trim() == "") {
			alert("검색어는 공백만으로 되지 않습니다. 검색어를 올바르게 입력하세요!!");
			return;
		}
		
		const frm = document.myBoardFrm;
		frm.action = "adminBoard.book";
		frm.method = "post";
		frm.submit();
		
	 } // end of function goAdminBoardSearch();
	 
	// 선택 게시글 삭제 함수
	function  adminBoardDeleteSelect(qnaCnt, qnaNoStr, revCnt, revNoStr) {
		$.ajax({
			url:"<%= ctxPath%>/board/adminBoardDeleteSelect.book",
			type:"POST",
			data:{"qnaCnt":qnaCnt,
				  "qnaNoStr":qnaNoStr,
				  "revCnt":revCnt,
				  "revNoStr":revNoStr}, 
			dataType:"JSON",
			success:function(json) {
				if(json.adminBoardDeleteSelect == 1) {
					alert("선택한 게시글이 삭제되었습니다.");
					location.reload();
				}else{
					alert("오류발생"); 
				}

			},
			error: function(request, status, error){
				//alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			
				if(request.responseText.match("로그인")){
					if(!alert(request.responseText)) document.location = "<%= ctxPath%>/login/join.book";
				}else{
					alert(request.responseText);
					location.reload();
				}
				
			}
		});//end of $.ajax
	}//end of function  proDeleteSelect(cnt, cartNoStr) 
	
	// 선택 게시글 공개/비공개 처리 함수
	function  adminBoardDisplaySelect(qnaCnt, qnaNoStr, revCnt, revNoStr) {
		$.ajax({
			url:"<%= ctxPath%>/board/adminBoardDisplaySelect.book",
			type:"POST",
			data:{"qnaCnt":qnaCnt,
				  "qnaNoStr":qnaNoStr,
				  "revCnt":revCnt,
				  "revNoStr":revNoStr}, 
			dataType:"JSON",
			success:function(json) {
				if(json.adminBoardDisplaySelect == 1) {
					alert("선택한 게시글의 게시상태가 변경되었습니다.");
					location.reload();
				}else{
					alert("오류발생"); 
				}

			},
			error: function(request, status, error){
				//alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			
				if(request.responseText.match("로그인")){
					if(!alert(request.responseText)) document.location = "<%= ctxPath%>/login/join.book";
				}else{
					alert(request.responseText);
					location.reload();
				}
				
			}
		});//end of $.ajax
	}//end of function  proDeleteSelect(cnt, cartNoStr) 
	
</script>



</head>
<body>


	    <div class="container">
	    <form name="myBoardFrm" method="get">
			    <div class="title" >
				  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_heading.gif" /></div>
				  	<h2>게시글관리</h2>
				  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/jeonghm_images/bar_eee.gif" /></div>
				  	<span >리뷰및 상품문의 게시판의 글들을 관리할 수 있습니다.</span>
			    
			   </div>
			  <p class="mb-3"></p>
			
			  <table class="table" id="faq_table_all">
			  <thead class="thead-light" id="faq_thead">
			    <tr style="text-align: center;">
			    	<th width="4%"><input type="checkbox" id="selectAll" name="selectAll" /></td>
			      	<th width="8%">고유번호</th>
			        <th width="10%">카테고리</th>
			        <th width="46%">제목</th>
			        <th width="8%">작성아이디</th>
			        <th width="16%">작성일</th>
			        <th width="8%">게시상태</th>
			    </tr>
			  </thead>
			  <tbody id="my_tbody">
			  	<c:if test="${not empty requestScope.myBoardList}">
			    <c:forEach var="board" items="${requestScope.myBoardList}" >
			    	<c:if test="${board.revBoard.pk_rnum ne 0 }">
				    <tr>
				    	<%-- 체크박스 --%>
						<td> 
							<input type="checkbox" name="revboardCheck" id="revboardCheck" value="${board.revBoard.pk_rnum}" />
						</td>
				      	<td><input type="hidden" id="pk_rnum"  value="${board.revBoard.pk_rnum}"/>${board.revBoard.pk_rnum}</td>
				      	<td style="text-align: center;"><a href="<%= ctxPath%>/board/reviewBoard.book">타인의 책장</a></td>
				      	<td><a href="<%= ctxPath%>/board/reviewDetail.book?pk_rnum=${board.revBoard.pk_rnum}">${board.revBoard.re_title}</a></td>
				      	<td>${board.revBoard.fk_userid}</td>
				      	<td>${board.revBoard.re_date}</td>
				      	<c:if test="${board.revBoard.isdelete eq 0 }">
				      		<td style="text-align: center;">공개</td>
				      	</c:if>
				      	<c:if test="${board.revBoard.isdelete eq 1 }">
				      		<td style="text-align: center;">비공개</td>
				      	</c:if>
				    </tr>
				    </c:if>
			    
			    	<c:if test="${board.qnaBoard.pk_qna_num ne 0 }">
				    <tr>
				    	<%-- 체크박스 --%>
						<td> 
							<input type="checkbox" name="qnaboardCheck" id="qnaboardCheck" value="${board.qnaBoard.pk_qna_num}" />
						</td>
				      	<td><input type="hidden" id="pk_qna_num" value="${board.qnaBoard.pk_qna_num}"/>${board.qnaBoard.pk_qna_num}</td>
				      	<td style="text-align: center;"><a href="<%= ctxPath%>/board/qnaBoard.book">상품 Q&A</a></td>
				      	<td><a href="<%= ctxPath%>/board/qnaDetail.book?pk_qna_num=${board.qnaBoard.pk_qna_num}">${board.qnaBoard.qna_title}</a></td>
				      	<td>${board.qnaBoard.fk_userid}</td>
				      	<td>${board.qnaBoard.qna_date}</td>
				      	<c:if test="${board.qnaBoard.isdelete eq 0 }">
				      		<td style="text-align: center;">공개</td>
				      	</c:if>
				      	<c:if test="${board.qnaBoard.isdelete eq 1 }">
				      		<td style="text-align: center;">비공개</td>
				      	</c:if>
				    </tr>
				    </c:if>
			    </c:forEach> 
			    </c:if> 
			     <c:if test="${empty requestScope.myBoardList}">
			     <tr id="notExist">
			      	<td colspan="6">
			      		<div>
			      		<span style="color: #555555; font-weight:bold;">게시물이 없습니다.</span>
			      		</div>
			      	</td>
			     </tr>
			     </c:if>
			  </tbody>
			</table>
			<tfoot>
				<tr style="border-bottom: none;" id="tr_go">
					<td colspan="3" class="text-left">
						<span id="deleteSelect">
							선택상품&nbsp;<button class="btn" name="btn_delete" id="btn_delete" ">삭제</button>
						</span>
						
						<span id="displaySelect">
							<button class="btn btn_isdelete" name="btn_isdelete" id="btn_isdelete" ">비공개/공개</button>
						</span>
				</tr>	
			</tfoot>
			<nav class="my-5">
				<div style="display: flex; width: 100%;">
					<ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
				</div>	
			</nav>
			
			<div class="search_outer" id="tab_center">
		 		<div class="search_inner">
				    <select id="mySearchContent" name="mySearchType">
				    	<option value="">분류</option>
				    	<option value="all">전체</option>
				    	<option value="my_title">제목</option>
				        <option value="my_contents">내용</option>
				    </select>
				    <input type="text" name="mySearchWord" id="mySearchWord"></input>
				    <button class="btn btn_myboard_search" name="btn_mySearch" id="btn_mySearch" onlick="goAdminBoardSearch();">찾기</button>
			    </div>
		    
		  	</div>
		</form>	
		</div> <!-- container 끝 -->
		
		
<jsp:include page="/WEB-INF/footer.jsp"/>

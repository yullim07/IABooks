<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%@ page import="board.model.BoardDAO" %>
<%@ page import="board.model.QnABoardVO" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">

</style>

	  
<meta charset="UTF-8">
<title>상품 Q&A</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/lee_css/semi_style.css" />
<jsp:include page="/WEB-INF/header.jsp"/>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		
		
		/* $("input#searchContent").bind("keyup",function(event){
			if(event.keyCode ==13){
				//검색어에서 엔터를 치면 검색하러 가도록 한다.
				goSearch();
			}
			
		}); */
		
		
	
	});
	
	//Fucntion Declaration
	function goSearch(){
		
		
	/* 
		if( $("input#searchContent").val().trim() == "" ){ //input 값 또한 텅 비었다면, 공백
			alert("검색어는 공백만으로는 되지 않습니다. \n검색어를 올바르게 입력하세요!!");
			return; // return; 는 goSearch() 함수 종료이다.
		}
		
		const frm = document.qnaSearchFrm; 
		frm.action = "qnaBoard.book";
		frm.method ="get"; //안쓰면 생략 가능
		frm.submit(); */
		
	}

</script>



<div class="container">
<div class="contents">
  <p><br></p>
  <div class="title" >
  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/ico_heading.gif" /></div>
  	<h2 >상품 Q&A</h2>
  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/bar_eee.gif" /></div>
  	<span >상품 Q&A입니다. 상품에 관해서 궁금하신 점을 질문해주세요.</span>
    
  </div>
  <p class="mb-3"></p>
  
  <p class="board_top"><img  src="<%= ctxPath%>/images/board/leejh_images/board_top.gif" /></p>
  
  <div class="table_all">
  <div class="table">
	  <table class="table qna_table line_table">
	    <thead>
	      <tr class="tblHeader">
	        <th width="9.5%">번호</th>
	        <th width="18.5%">도서명</th>
	        <th width="40%">제목</th>
	        <th width="11%">작성자</th>
	        <th width="10.5%">작성일</th>
	        <th width="10.5%">조회</th>
	      </tr>
	    </thead>
	    
	    
	    <tbody>
	    	<c:if test="${not empty requestScope.qnaboardList}">
	    		<c:forEach var="board" items="${requestScope.qnaboardList}">
	        		<tr class="qnaboardInfo">
	        			
		        		<td class="tbl_number mycenter">${board.pk_qna_num}</td>
				    	<td class="tbl_bookname">
				    		<a  href="#">
		            			<img src="" border="0" alt=""/>
								<span>${board.product.pro_name}</span>
							</a>  
							
				    	</td>
				    	<td class="tbl_subject">
				    		<a href="<%= ctxPath%>/board/qnaDetail.book?pk_qna_num=${board.pk_qna_num}">
				    		${board.qna_title}
				    		<img class="lock" src="<%= ctxPath%>/images/board/leejh_images/ico_lock.gif"/>
				    		</a>
				    	</td>
				    	<td class="tbl_writer mycenter">${board.member.name}</td>
				    	<td class="tbl_date mycenter">${board.qna_date}</td>
				    	<td class="tbl_viewcount mycenter">${board.qna_readcount}</td>
	        			
	        		</tr>
	        		
	        	</c:forEach>
	        </c:if>
	        
	        <c:if test="${empty requestScope.qnaboardList}">
        		<tr>
        			<td colspan="6" style="text-align: center; ">검색된 데이터가 존재하지 않습니다.</td>
        		</tr>
        	</c:if>
	    		<%-- 
			    <%
			    	BoardDAO bdao = new BoardDAO();
			    	List<QnABoardVO> qnaboardList = bdao.qnaboardList();
			    	for(int i=0; i<qnaboardList.size(); i++) {
			    %>
			    <tr> 
			    	<td class="tbl_number mycenter"><%= qnaboardList.get(i).getPk_qna_num() %></td>
			    	<td class="tbl_bookname">
			    		<a  href="#">
	            			<img  src="//indiepub.kr/web/product/tiny/202202/eb7c31609e59e7436d9445a4c5043207.jpg" border="0" alt=""/>
							<span ><%= qnaboardList.get(i).getFk_pnum() %></span>
						</a>
			    	</td>
			    	<td class="tbl_subject"><a href=""><%= qnaboardList.get(i).getQna_title() %><img class="lock" src="<%= ctxPath%>/images/board/leejh_images/ico_lock.gif"/></a></td>
			    	<td class="tbl_writer mycenter"><%= qnaboardList.get(i).getFk_userid() %></td>
			    	<td class="tbl_date mycenter"><%= qnaboardList.get(i).getQna_date()%></td>
			    	<td class="tbl_viewcount mycenter"><%= qnaboardList.get(i).getQna_readcount()%></td>
			    </tr>
			    <%
			    	}
			    %>
			    --%>
		</tbody>
	 
	  </table>
	  <div class="write_btn_zone">
      	<button type="button" class="btn btn-dark" onclick="location.href='<%= ctxPath %>/board/qnaWrite.book'">글쓰기</button>
  	  </div>
	  
	</div>
  	
  	</div>
  	
  	
  	<div class="pagination2 justify-content-center" style="display:flex; width: 80%;">
	    <ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
	    <%-- 
	    <ul>
		    <li><a href="#"><img src="<%= ctxPath%>/images/board/leejh_images/btn_page_first.gif" /></a></li>
		    <li class="active"><a href="#">1</a></li>
		    <li><a href="#">2</a></li>
		    <li><a href="#">3</a></li>
		    <li><a href="#">4</a></li>
		    <li><a href="#">5</a></li>
		   
		    <li><a href="#"><img src="<%= ctxPath%>/images/board/leejh_images/btn_page_last.gif" /></a></li>
	    </ul>
	    --%>
	</div>
 	
 <%-- 	<form name="qnaSearchFrm" action="qnaBoard.book" method="get" ></form>--%>
	 	<div class="search_outer" >
	 		<div class="search_inner">
	 		<a><img src="<%= ctxPath%>/images/board/leejh_images/ico_triangle3.gif" /></a>
		  	<p class="pSearch" style=" display: inline-block; font-size: 12px;">검색어</p>
		  	
		    <select id="searchDate" name="search">
		    	<option value="week" selected="selected">일주일</option>
		        <option value="month">한달</option>
		        <option value="3months">세달</option>
		        <option value="all">전체</option>
		    </select>
		    
		    <select id="searchContent" name="search">
		    	<option value="subject" selected="selected">제목</option>
		        <option value="content">내용</option>
		        <option value="writername">글쓴이</option>
		        <option value="userid">아이디</option>
		        <option value="nickname">별명</option>
		        <option value="product">상품정보</option>
		
		    </select>
		    
		    <input type="text" id="searchWord" name="search"></input>
		    
		    
		    <button type="submit" onclick="goSearch()" class="btn" name="search" >찾기</button>
		   <%--  <input type="submit" value="검색" style="margin-right: 30px;" /> --%>
		    </div>
	    
	  	</div>
  	
</div>
</div>


	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
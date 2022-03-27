<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">



</style>



	<script type="text/javascript">
		
		$(document).ready(function(){
			
		});
	
	</script>


<jsp:include page="../../header.jsp"/>



<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/jeong_css/semi_style.css" />
    
<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    
</head>
<body>


	    <div class="container">
			    <div class="title" >
				  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_heading.gif" /></div>
				  	<h2>게시물 관리</h2>
			    
			   </div>
			  <!-- <p class="mb-3"></p> -->
			
			  	<div id="sort">
			  		<span> 분류 선택 </span>
				    <select id="searchContent" class="cateDropdown" name="search">
				       <option value="all">전체</option>
		               <option value="sort_date">작성 일자별</option>
		               <option value="sort_category">분류별</option>
				    </select>
		    	</div>
			
			<hr>
			  <table class="table" id="faq_table_all">
			  <thead class="thead-light" id="faq_thead">
			    <tr style="text-align: center;">
			      	<th width="5.6%">번호</th>
			        <th width="8%">카테고리</th>
			        <th width="60%">제목</th>
			        <th width="8%">작성자</th>
			        <th width="12%">작성일</th>
			        <th width="6.4%">조회</th>
			    </tr>
			  </thead>
			  <tbody id="faq_tbody">
			    <tr>
			      	<td class="tbl_number mycenter">1</td>
			        <td class="tbl_category mycenter">배송</td>
			        <td class="tbl_subject" id="td_left">
			        	<a href="">
			        		배송관련 문의드립니다.
			        	</a>
			        	<img class="lock" src="<%= ctxPath%>/images/board/jeonghm_images/ico_lock.gif"/>
			        <td class="tbl_writer mycenter">네****</td>
			        <td class="tbl_date mycenter">2022-03-17</td>
			        <td class="tbl_readcount mycenter"><span >1</span></td>
			    </tr>
			    
			     <tr id="notExist">
			      	<td colspan="6">
			      		<div>
			      		<span style="color: #555555; font-weight:bold;">게시물이 없습니다.</span>
			      		</div>
			      	</td>
			     </tr>
			  </tbody>
			</table>
			
			<div class="search_outer" id="tab_center">
		 		<div class="search_inner">
			    <select id="searchContent" name="search">
			    	<option value="subject">제목</option>
			        <option value="content">내용</option>
			        <option value="writername">글쓴이</option>
			        <option value="userid">아이디</option>
			        <option value="nickname">별명</option>
			    </select>
			    <input type="text" name="search" id="input_myboard_search"></input>
			    <button class="btn btn_myboard_search" name="search" >찾기</button>
			    </div>
		    
		  	</div>
			
		</div> <!-- container 끝 -->
		
		
<jsp:include page="../../footer.jsp"/>

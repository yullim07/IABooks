<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="board.model.BoardDAO" %>
<%@ page import="board.model.ReviewBoardVO" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">

</style>

	  
<meta charset="UTF-8">
<title>타인의 책장</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/lee_css/semi_style.css" />
<jsp:include page="/WEB-INF/header.jsp"/>


<script type="text/javascript">
	
	/* function showImg(){
		console.log("hoi");
	}
	function hideImg(){
		
	} */

	$(document).ready(function(){
		
		/* 
		 $("span.error").hide();
		 $("input#name").focus();
		 */
		 let html = "";
		 $("img#file_attach").mouseover( ()=>{
			  
			  const $target = $(event.target);
			  console.log($target.text()+"에 마우스가 올라갔군요");
			  $("span#mouseover_img").html("<img style='height: 80px; vertical-align:middle; ' src='<%= ctxPath%>/images/board/leejh_images/review-attachment-0515b276-bd69-4c97-84ae-76781fcfc993.jpeg'/>");
		 });
		 
		 $("img#file_attach").mouseout(function(){
			 const $target = $(event.target);   
			 $("span#mouseover_img").html("");
		 });
		<%-- let html = "";
		 $("img#file_attach").mouseover(function(){
			    $("div#mouseover_img").css("background-color", "yellow");
			    
			    const $target = $(event.target);
				console.log($target.text()+"에 마우스가 올라갔군요");
					
				$("div#mouseover_img").html("<img src='<%= ctxPath%>/images/board/leejh_images/review-attachment-0515b276-bd69-4c97-84ae-76781fcfc993.jpeg'/>");
			    
			    
		  });
		  $("img#file_attach").mouseout(function(){
		    $("div#mouseover_img").html("<img src='<%= ctxPath%>/images/board/leejh_images/review-attachment-0515b276-bd69-4c97-84ae-76781fcfc993.jpeg'/>");
		  }); --%>
		
	
	});
	
	
</script>




	
	





<div class="container">
<div class="contents">
  <div class="title" >
  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/ico_heading.gif" /></div>
  	<h2 >타인의 책장</h2>
  	<div class="bar_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/bar_eee.gif" /></div>
  	<span >후기를 작성하는 공간입니다.</span>
    
  </div>
  <p class="mb-3"></p>
  
  <div class="table_all">
  <div class="table">
	  <table class="table line_table">
	    <thead>
	      <tr class="tblHeader">
	        <th width="9.5%">번호</th>
	        <th width="18.5%">도서명</th>
	        <th width="40%">제목</th>
	        <th width="11%">작성자</th>
	        <th width="10.5%">작성일</th>
	        <th width="10.5%">평점</th>
	      </tr>
	    </thead>
	    
	    <tbody>
			    <%
			    	BoardDAO bdao = new BoardDAO();
			    	List<ReviewBoardVO> reviewList = bdao.reviewList();
			    	for(int i=0; i<reviewList.size(); i++) {
			    %>
			    <tr> 
			    	<td class="tbl_number mycenter"><%= reviewList.get(i).getPk_rnum() %></td>
			    	<td class="tbl_bookname">
			    		<a  href="#">
	            			<img  src="//indiepub.kr/web/product/tiny/202202/eb7c31609e59e7436d9445a4c5043207.jpg" border="0" alt=""/>
							<span ><%= reviewList.get(i).getFk_pnum() %></span>
						</a>
			    	</td>
			    	<td class="tbl_subject">
			    		<a href=""><%= reviewList.get(i).getRe_title() %></a>
	        			<span class="new_tag">NEW</span>
	        			</td>
			    	<td class="tbl_writer mycenter"><%= reviewList.get(i).getRe_writer()%></td>
			    	<td class="tbl_date mycenter"><%= reviewList.get(i).getRe_date()%></td>
			    	<td class="tbl_grade mycenter"><%= reviewList.get(i).getRe_grade()%></td>
			    </tr>
			    <%
			    	}
			    %>
		</tbody>
	    
	    
	   <%--  
	    <tbody>
	      <tr>
	        <td class="tbl_number mycenter">98</td>
	        <td class="tbl_bookname">
	        	<a  href="#">
	            	<img  src="//indiepub.kr/web/product/tiny/202202/eb7c31609e59e7436d9445a4c5043207.jpg" border="0" alt=""/>
					<span >지금, 사랑하는 나에게</span>
				</a>
				
	        </td>
	        <td class="tbl_subject">
	        	<a href="">만족</a>
	        	<span class="new_tag">NEW</span>
	        </td>
	        <td class="tbl_writer mycenter">네****</td>
	        <td class="tbl_date mycenter">2022-03-10 04:06:33</td>
	        <td class="tbl_grade mycenter"><img name="star_point" src="<%= ctxPath%>/images/board/leejh_images/ico_point5.gif"/></td>
	      </tr>
	      
	      <tr>
	        <td class="tbl_number mycenter">97</td>
	        <td class="tbl_bookname">
	        	<a  href="#">
	            	<img src="//indiepub.kr/web/product/tiny/202112/f449e3d8f488e8ca32e413dade853e84.jpg" border="0" alt="">
					<span >직업이 술꾼입니다!</span>
				</a>
				
	        </td>
	        <td class="tbl_subject">
	        	<a href="">
	        		배송도 빠르도 책도 잘 포장돼서 왔어요!
	        	</a>
	        	<img id="file_attach" name="file_attach" src="<%= ctxPath%>/images/board/leejh_images/ico_attach2.gif"  <%-- onmouseover="showImg()" onmouseout="hideImg()"--%> 
	       <%--  	
	        	<span id="mouseover_img" style="position:absolute;  "></span>
	        	
	        	<span class="new_tag">NEW</span>
	        </td>
	        <td class="tbl_writer mycenter">네****</td>
	        <td class="tbl_date mycenter">2022-03-17 02:25:14</td>
	        <td class="tbl_grade mycenter"><img name="star_point" src="<%= ctxPath%>/images/board/leejh_images/ico_point5.gif"/></td>
	      </tr>
	      
	      <tr>
	        <td class="tbl_number mycenter">96</td>
	        <td class="tbl_bookname">
	        	<a  href="#">
	            	<img style=" width:46px; float:left;" src="//indiepub.kr/web/product/tiny/202202/eb7c31609e59e7436d9445a4c5043207.jpg" border="0" alt=""/>
					<span >지금, 사랑하는 나에게</span>
				</a>
				
	        </td>
	        <td class="tbl_subject"><a href="">만족</a></td>
	        <td class="tbl_writer mycenter">네****</td>
	        <td class="tbl_date mycenter">2022-03-17 02:25:14</td>
	        <td class="tbl_grade mycenter"><img name="star_point" src="<%= ctxPath%>/images/board/leejh_images/ico_point5.gif"/></td>
	      </tr>
	     </tbody>  
	      --%>
	      
	    
	    
	  </table>
	  <div class="write_btn_zone">
      	 <a href="index_reviewWrite.jsp"  class="btn btn-dark" id="write_btn">글쓰기</a> 
  	  </div>
	  
	</div>
  	
  	</div>
  	
  	
  	<div class="pagination2 justify-content-center" >
	    <ul>
		    <li><a href="#"><img src="<%= ctxPath%>/images/board/leejh_images/btn_page_first.gif" /></a></li>
		    <li class="active"><a href="#">1</a></li>
		    <li><a href="#">2</a></li>
		    <li><a href="#">3</a></li>
		    <li><a href="#">4</a></li>
		    <li><a href="#">5</a></li>
		    <li><a href="#">6</a></li>
		    <li><a href="#">7</a></li>
		    <li><a href="#">8</a></li>
		    <li><a href="#">9</a></li>
		    <li><a href="#">10</a></li>
		    <li><a href="#"><img src="<%= ctxPath%>/images/board/leejh_images/btn_page_last.gif" /></a></li>
	    </ul>
	</div>
 	
 	<div class="search_outer" >
 		<div class="search_inner">
 		<a><img src="<%= ctxPath%>/images/board/leejh_images/ico_triangle3.gif" /></a>
	  	<p class="pSearch" style=" display: inline-block; font-size: 12px;">검색어</p>
	  	
	    <select id="searchDate" name="search">
	    	<option value="week">일주일</option>
	        <option value="month">한달</option>
	        <option value="3months">세달</option>
	        <option value="all">전체</option>
	    </select>
	    <select id="searchContent" name="search">
	    	<option value="subject">제목</option>
	        <option value="content">내용</option>
	        <option value="writername">글쓴이</option>
	        <option value="userid">아이디</option>
	        <option value="nickname">별명</option>
	        <option value="product">상품정보</option>
	
	    </select>
	    <input type="text" name="search"></input>
	    <button class="btn" name="search" >찾기</button>
	    </div>
    
  	</div>
</div>
</div>


	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
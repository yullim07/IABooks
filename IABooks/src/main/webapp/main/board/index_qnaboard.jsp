<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


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
<jsp:include page="/header.jsp"/>

<script type="text/javascript">
	
	$(document).ready(function(){
		
	
	});

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
	      <tr>
	        <td class="tbl_number mycenter">73</td>
	        <td class="tbl_bookname">
	        	<%-- <a  href="#">
	            	<img  src="//indiepub.kr/web/product/tiny/202202/eb7c31609e59e7436d9445a4c5043207.jpg" border="0" alt=""/>
					<span >지금, 사랑하는 나에게</span>
				</a> --%>
				
	        </td>
	        <td class="tbl_subject"><a href="">도매가 구입 방법<img class="lock" src="<%= ctxPath%>/jaehee_pages/semi_images/ico_lock.gif"/></a></td>
	        <td class="tbl_writer mycenter">홍****</td>
	        <td class="tbl_date mycenter">2022-03-18 19:05:42</td>
	        <td class="tbl_viewcount mycenter">1</td>
	      </tr>
	      
	      <tr>
	        <td class="tbl_number mycenter">72</td>
	        <td class="tbl_bookname">
	        	<a  href="#">
	            	<img src="//indiepub.kr/web/product/tiny/202112/f449e3d8f488e8ca32e413dade853e84.jpg" border="0" alt="">
					<span>추천곡</span>
				</a>
				
	        </td>
	        <td class="tbl_subject"><a href="">안녕하세요. 혹시 작가님 메일 주소를 알 수 있을까요?</a></td>
	        <td class="tbl_writer mycenter">이****</td>
	        <td class="tbl_date mycenter">2022-02-02 10:52:10</td>
	        <td class="tbl_viewcount mycenter">23</td>
	      </tr>
	      
	      <tr>
	        <td class="tbl_number mycenter">71</td>
	        <td class="tbl_bookname">
	        	<%-- 
	        	<a  href="#">
	            	<img src="//indiepub.kr/web/product/tiny/202112/f449e3d8f488e8ca32e413dade853e84.jpg" border="0" alt="">
					<span>추천곡</span>
				</a> 
				--%>
				
	        </td>
	        <td class="tbl_subject">
	        	&nbsp;&nbsp;&nbsp;
	        	<img src="<%= ctxPath%>/images/board/leejh_images/ico_re.gif"/>
	        	<a href="">안녕하세요. 혹시 작가님 메일 주소를 알 수 있을까요?</a>
	        	<img class="lock" src="<%= ctxPath%>/images/board/leejh_images/ico_lock.gif"/>
	        </td>
	        <td class="tbl_writer mycenter">인디펍</td>
	        <td class="tbl_date mycenter">2022-02-09 23:15:28</td>
	        <td class="tbl_viewcount mycenter">3</td>
	      </tr>
	      
	      <tr>
	        <td class="tbl_number mycenter">70</td>
	        <td class="tbl_bookname">
	        	<a  href="#">
	            	<img src="//indiepub.kr/web/product/tiny/202112/f449e3d8f488e8ca32e413dade853e84.jpg" border="0" alt="">
					<span>추천곡</span>
				</a>
				
	        </td>
	        <td class="tbl_subject"><a href="">안녕하세요. 혹시 작가님 메일 주소를 알 수 있을까요?</a></td>
	        <td class="tbl_writer mycenter">이****</td>
	        <td class="tbl_date mycenter">2022-02-02 10:52:10</td>
	        <td class="tbl_viewcount mycenter">23</td>
	      </tr>
	      
	      <tr>
	        <td class="tbl_number mycenter">69</td>
	        <td class="tbl_bookname">
	        	<%-- 
	        	<a  href="#">
	            	<img src="//indiepub.kr/web/product/tiny/202112/f449e3d8f488e8ca32e413dade853e84.jpg" border="0" alt="">
					<span>추천곡</span>
				</a> 
				--%>
				
	        </td>
	        <td class="tbl_subject">
	        	&nbsp;&nbsp;&nbsp;
	        	<img src="<%= ctxPath%>/images/board/leejh_images/ico_re.gif"/>
	        	<a href="">안녕하세요. 혹시 작가님 메일 주소를 알 수 있을까요?</a>
	        	<img class="lock" src="<%= ctxPath%>//images/board/leejh_images/ico_lock.gif"/>
	        </td>
	        <td class="tbl_writer mycenter">인디펍</td>
	        <td class="tbl_date mycenter">2022-02-09 23:15:28</td>
	        <td class="tbl_viewcount mycenter">3</td>
	      </tr>
	      
	      <tr>
	        <td class="tbl_number mycenter">68</td>
	        <td class="tbl_bookname">
	        	<a  href="#">
	            	<img src="//indiepub.kr/web/product/tiny/202112/f449e3d8f488e8ca32e413dade853e84.jpg" border="0" alt="">
					<span>추천곡</span>
				</a>
				
	        </td>
	        <td class="tbl_subject"><a href="">안녕하세요. 혹시 작가님 메일 주소를 알 수 있을까요?</a></td>
	        <td class="tbl_writer mycenter">이****</td>
	        <td class="tbl_date mycenter">2022-02-02 10:52:10</td>
	        <td class="tbl_viewcount mycenter">23</td>
	      </tr>
	      
	      <tr>
	        <td class="tbl_number mycenter">67</td>
	        <td class="tbl_bookname">
	        	<%-- 
	        	<a  href="#">
	            	<img src="//indiepub.kr/web/product/tiny/202112/f449e3d8f488e8ca32e413dade853e84.jpg" border="0" alt="">
					<span>추천곡</span>
				</a> 
				--%>
				
	        </td>
	        <td class="tbl_subject">
	        	&nbsp;&nbsp;&nbsp;
	        	<img src="<%= ctxPath%>/images/board/leejh_images/ico_re.gif"/>
	        	<a href="">안녕하세요. 혹시 작가님 메일 주소를 알 수 있을까요?</a>
	        	<img class="lock" src="<%= ctxPath%>/images/board/leejh_images/ico_lock.gif"/>
	        </td>
	        <td class="tbl_writer mycenter">인디펍</td>
	        <td class="tbl_date mycenter">2022-02-09 23:15:28</td>
	        <td class="tbl_viewcount mycenter">3</td>
	      </tr>
	      
	      <tr>
	        <td class="tbl_number mycenter">66</td>
	        <td class="tbl_bookname">
	        	<a  href="#">
	            	<img src="//indiepub.kr/web/product/tiny/202112/f449e3d8f488e8ca32e413dade853e84.jpg" border="0" alt="">
					<span>추천곡</span>
				</a>
				
	        </td>
	        <td class="tbl_subject"><a href="">안녕하세요. 혹시 작가님 메일 주소를 알 수 있을까요?</a></td>
	        <td class="tbl_writer mycenter">이****</td>
	        <td class="tbl_date mycenter">2022-02-02 10:52:10</td>
	        <td class="tbl_viewcount mycenter">23</td>
	      </tr>
	      
	      <tr>
	        <td class="tbl_number mycenter">65</td>
	        <td class="tbl_bookname">
	        	<%-- 
	        	<a  href="#">
	            	<img src="//indiepub.kr/web/product/tiny/202112/f449e3d8f488e8ca32e413dade853e84.jpg" border="0" alt="">
					<span>추천곡</span>
				</a> 
				--%>
				
	        </td>
	        <td class="tbl_subject">
	        	&nbsp;&nbsp;&nbsp;
	        	<img src="<%= ctxPath%>/images/board/leejh_images/ico_re.gif"/>
	        	<a href="">안녕하세요. 혹시 작가님 메일 주소를 알 수 있을까요?</a>
	        	<img class="lock" src="<%= ctxPath%>/images/board/leejh_images/ico_lock.gif"/>
	        </td>
	        <td class="tbl_writer mycenter">인디펍</td>
	        <td class="tbl_date mycenter">2022-02-09 23:15:28</td>
	        <td class="tbl_viewcount mycenter">3</td>
	      </tr>
	      
	      <tr>
	        <td class="tbl_number mycenter">64</td>
	        <td class="tbl_bookname">
	        	<a  href="#">
	            	<img src="//indiepub.kr/web/product/tiny/202112/f449e3d8f488e8ca32e413dade853e84.jpg" border="0" alt="">
					<span>추천곡</span>
				</a>
				
	        </td>
	        <td class="tbl_subject"><a href="">안녕하세요. 혹시 작가님 메일 주소를 알 수 있을까요?</a></td>
	        <td class="tbl_writer mycenter">이****</td>
	        <td class="tbl_date mycenter">2022-02-02 10:52:10</td>
	        <td class="tbl_viewcount mycenter">23</td>
	      </tr>
	      
	      <tr>
	        <td class="tbl_number mycenter">63</td>
	        <td class="tbl_bookname">
	        	<%-- 
	        	<a  href="#">
	            	<img src="//indiepub.kr/web/product/tiny/202112/f449e3d8f488e8ca32e413dade853e84.jpg" border="0" alt="">
					<span>추천곡</span>
				</a> 
				--%>
				
	        </td>
	        <td class="tbl_subject">
	        	&nbsp;&nbsp;&nbsp;
	        	<img src="<%= ctxPath%>/images/board/leejh_images/ico_re.gif"/>
	        	<a href="">안녕하세요. 혹시 작가님 메일 주소를 알 수 있을까요?</a>
	        	<img class="lock" src="<%= ctxPath%>/images/board/leejh_images/ico_lock.gif"/>
	        </td>
	        <td class="tbl_writer mycenter">인디펍</td>
	        <td class="tbl_date mycenter">2022-02-09 23:15:28</td>
	        <td class="tbl_viewcount mycenter">3</td>
	      </tr>
	     
	  
	      
	      
	    </tbody>
	  </table>
	  <div class="write_btn_zone">
      	<button type="button" class="btn btn-dark">글쓰기</button>
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


	
<jsp:include page="/footer.jsp"/>
 
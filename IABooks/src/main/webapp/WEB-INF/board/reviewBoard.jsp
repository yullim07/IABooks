<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
   String ctxPath = request.getContextPath();
   
%>

<style type="text/css">

	select#revSearchType, select#revSearchWord {
		font-size:14px;
	}
	
	img#thumbimg {
		width: 30%;
		float: left;
	}

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
      
	   if( "${sessionScope.loginuser.userid}" == "admin" ) {
			$("div.write_btn_zone").show();
		}
		else {
			$("div.write_btn_zone").hide();
		}
	   
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

   
   });
   
	// Function Declaration
	function goRevSearch(){
		
		if($("select.revSearchType").val() == "" ) {
			alert("검색대상을 올바르게 선택하세요!!");
			return; // goSearch() 함수 종료.
		}
		
		if($("input#revSearchWord").val().trim() == "") {
			alert("검색어는 공백만으로 되지 않습니다. 검색어를 올바르게 입력하세요!!");
			return;
		}
		
		const frm = document.revBoardFrm;
		frm.action = "reviewBoard.book";
		frm.method = "get";
		frm.submit();
		
	}
   
   
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
  
  <form name="revBoardFrm" method="get">
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
          <c:set var="num" value="${requestScope.rvo.totalCnt - ( (requestScope.rvo.currentShowPageNo-1) *10 ) }" />
          	 <c:if test="${not empty requestScope.reviewList}">
			 <c:forEach var="board" items="${requestScope.reviewList}" >
                   <tr>
                   <td class="tbl_number mycenter">${num}</td>
                   <td class="tbl_bookname"> <a href="<%= ctxPath%>/product/showBookDetail.book?pronum=${board.fk_pnum}"><img src="<%= ctxPath%>/images/product/${board.category.cate_name}/${board.product.pro_imgfile_name}" id="thumbimg"/>${board.product.pro_name}</a>
                        
                     
                   </td>
                   <td class="tbl_subject">
                       <a href="<%= ctxPath%>/board/reviewDetail.book?pk_rnum=${board.pk_rnum}">${board.re_title}</a>
                   </td>
                   <%-- <td class="tbl_writer mycenter">${board.re_writer}</td> --%>
                   <td class="tbl_writer mycenter">${board.member.name}</td>
                   <td class="tbl_date mycenter">${board.re_date}</td>
                   <c:if test="${board.re_grade eq 1 }">
				   <td align="center"><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_point1.gif" /></td>
				   </c:if>
				   <c:if test="${board.re_grade eq 2 }">
				   <td align="center"><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_point2.gif" /></td>
				   </c:if>
				   <c:if test="${board.re_grade eq 3 }">
				   <td align="center"><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_point3.gif" /></td>
				   </c:if>
				   <c:if test="${board.re_grade eq 4 }">
				   <td align="center"><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_point4.gif" /></td>
				   </c:if>
				   <c:if test="${board.re_grade eq 5 }">
				   <td align="center"><img src="<%= ctxPath%>/images/board/jeonghm_images/ico_point5.gif" /></td>
				   </c:if>
                </tr>
             	 <c:set var="num" value="${num-1 }"></c:set>
             </c:forEach>   
 			 </c:if>
 			 <c:if test="${empty requestScope.reviewList}">
        		<tr id="notExist">
			      	<td colspan="6">
			      		<div>
			      		<span style="color: #555555; font-weight:bold;">표시할 내용이 없습니다.</span>
			      		</div>
			      	</td>
			    </tr>
       		 </c:if>
         </tbody>
         
        </table>
        <div class="write_btn_zone">
             <a href="<%= ctxPath%>/board/reviewWrite.book"  class="btn btn-dark" id="write_btn">글쓰기</a> 
          </div>
        
      </div>
        
        </div>
   

   <nav class="my-5">
      <div style="display: flex; width: 100%;">
         <ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
      </div>   
   </nav>
     
    
    <div class="search_outer" >
       <div class="search_inner">
       <a><img src="<%= ctxPath%>/images/board/leejh_images/ico_triangle3.gif" /></a>
        <p class="pSearch" style=" display: inline-block; font-size: 12px;">검색어</p>
        
       <select class="revSearchType" id="revSearchType" name="revSearchType">
       	   <option value="">대상</option>
           <option value="re_title">제목</option>
           <option value="re_writer">글쓴이</option>
           <option value="fk_userid">아이디</option>
           <option value="product">상품정보</option>
   
       </select>
       	<input type="text" name="revSearchWord" id="revSearchWord"></input>
	   	<button class="btn btn_rev_search" type="button" id="btn_search" name="btn_search" onclick="goRevSearch();" >찾기</button>
	   </div>
    
     </div>
     
     	
	</form>     
	</div>


</div> <!-- container 끝 -->


   
<jsp:include page="/WEB-INF/footer.jsp"/>
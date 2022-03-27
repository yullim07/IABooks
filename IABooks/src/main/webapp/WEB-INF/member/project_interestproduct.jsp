<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">

	table {
		width: 100%;
		margin: 30px 0 ;
	}
	
	tr.tbl_interest_line {
	border-top: 2px solid #e8e8e8;
	border-bottom: 2px solid #e8e8e8;
	
	}
	
	td.tbl_interest_td {
		padding: 1%;
		width: 7%;
		
	}
	
	div.pagination {
     display: inline-block;
     width: 100%;
     text-align: center;
     
   }
	
	div.pagination a {
     color: black;
     text-decoration: none;
     width: 32px;
     height: 32px;
     text-align: center;
   }
   
   div.pagination a.active {
      border-bottom: solid 2px black;
        
   }
   
   div.pagination a img {
      margin-top: -4px;
      vertical-align: middle;
   
   }
   
   div.pagination a:hover {
      /* filter: brightness(70%);  */
      font-weight: bolder;
      opacity: 0.3;
   }
	
	
</style>
<title>관심상품</title>

<jsp:include page="<%= ctxPath %>/WEB-INF/header.jsp"/>
<div class="container">

	<div class="titleArea">
		<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;관심상품</strong>
		<hr style="border: solid 2px #e8e8e8; margin-bottom: 3%;">
    </div>
		
		 <table class = "tbl_interest">
	          <tr class = "tbl_interest_line" style="background-color:#f2f2f2">
	             <td class="tbl_interest_td"><input type="checkbox"></td>
	             <td class="tbl_interest_td">이미지</td>
	             <td class="tbl_interest_td">상품정보</td>
	             <td class="tbl_interest_td">판매가</td>
	             <td class="tbl_interest_td">적립금</td>
	             <td class="tbl_interest_td">배송구분</td>
	             <td class="tbl_interest_td">배송비</td>
	             <td class="tbl_interest_td">합계</td>
	             <td class="tbl_interest_td">선택</td>
	          </tr>
	          <tr class = "tbl_interest_line">
	             <td class="tbl_interest_td"><input type="checkbox"></td>
	             <td class="tbl_interest_td"><img src="<%= ctxPath%>/images/member/book.gif" style="max-width: 80px; padding-right: 30px;"></td>
	             <td class="tbl_interest_td"><strong>90년대생<br>추억여행<br>노트</strong></td>
	             <td class="tbl_interest_td"><strong>7000원</strong></td>
	             <td class="tbl_interest_td">&nbsp;&nbsp;----</td>
	             <td class="tbl_interest_td">기본배송</td>
	             <td class="tbl_interest_td">3000원<br>조건</td>
	             <td class="tbl_interest_td">10,000원</td>
	             <td class="tbl_interest_td">
		             <input type="button" value="주문하기" style="width: 82%; color:white; background-color:#737373; border-radius:5px; font-size:10pt;">
		             <input type="button" value="장바구니담기" style="width: 82%; background-color:white; border-radius:5px; font-size:10pt;">
		             <input type="button" value="삭제" style="width: 82%; background-color:white; border-radius:5px; font-size:10pt;">
	             </td>
	          </tr>
	          <tr>
	          	 <td style="text-align:right; font-size: 13pt;"><h6><strong>선택상품을</strong></h6></td>
	          	 <td style="text-align:right;"><input type="button" value="삭제하기" style="width: 82%; color:white; background-color:#737373; border-radius:5px; font-size:10pt; font-weight: bold;"></td>
	          	 <td><input type="button" value="장바구니담기" style="width: 82%; background-color:white; border-radius:5px; font-size:10pt; font-weight: bold;"></td>
	          	 <td></td>
	          	 <td></td>
	          	 <td></td>
	          	 <td></td>
	          	 <td style="text-align:right;"><input type="button" value="전체상품주문" style="color:white; font-weight: bold; background-color:#737373; border-radius:5px; width: 130px; height: 45px;"></td>
	          	 <td><input type="button" value="관심상품 비우기"  style="width: 130px; height: 45px; border-radius:5px; font-weight: bold;"></td>
			  </tr>	          
         </table>
         		 <div style="text-align:center;">
			         <span>
				        <div class="pagination pagination-sm justify-content-center">
					      <a href="#"><img src="<%= ctxPath %>/images/btn_page_first.gif" /></a>
					      <a href="#"><img src="<%= ctxPath %>/images/btn_page_prev.gif" /></a>
					      <a class="active" href="#">1</a>
					      <a href="#"><img src="<%= ctxPath %>/images/btn_page_next.gif" /></a>
					      <a href="#"><img src="<%= ctxPath %>/images/btn_page_last.gif" /></a>
   						 </div>
			         </span>
	        	 </div>
</div>	
<jsp:include page="<%= ctxPath %>/WEB-INF/footer.jsp"/>
 
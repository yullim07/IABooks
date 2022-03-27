<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
%>

	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css">
	
	<!-- Optional JavaScript-->
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>

<script type="text/javascript">

	
</script>

<style type="text/css">

li.nav-item {
	background-color: #F2F2F2;
}

table{
	width: 100%;
	margin: 30px 0 ;
}
.option {
	border: 5px solid #e8e8e8;
	height: 70px;
	text-align: center;
}
table.tbl_bottm > tbody >  tr:nth-child(2) > td{
	height: 70px;
	background-color : #fbfafa;
	text-align: center;
}

tr.tbl_bottom_line {
	border-top: 2px solid #e8e8e8;
	border-bottom: 2px solid #e8e8e8;
}

li.sm {
	    font-size: 10pt;
}	
	
table.tbl_bottm > tbody > tr:last-child {
   border-bottom: solid 2px #e8e8e8;
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
<title>주문조회</title>
<jsp:include page="header.jsp"/>
<div class="container">
	
	<div class="titleArea">
		<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;주문조회</strong>
		<hr style="border: solid 2px #e8e8e8; margin-bottom: 3%;">
    </div>
	
         <ul class="nav nav-tabs navbar-expand-sm bg-light navbar-light">
	           <li class="nav-item">
	             <a class="nav-link active" data-toggle="tab" href="#menu1">주문내역조회</a>
	           </li>
	           <li class="nav-item">
	             <a class="nav-link" data-toggle="tab" href="#menu2">취소/반품/교환내역</a>
	           </li>
         </ul>

      <div class="tab-content py-3">
           
           <div class="tab-pane container active"  id="menu1">
              <table>
                 <tr class = "option">
	                 <td >
	                     <select name="전체주문처리상태">
	                       <option value = " ">전체주문처리상태</option>
	                       <option value = " ">입금전</option>
	                       <option value = " ">배송준비중</option>
	                       <option value = " ">배송중</option>
	                       <option value = " ">배송완료</option>
	                       <option value = " ">취소</option>
	                       <option value = " ">교환</option>
	                       <option value = " ">반품</option>
	                     </select>
	                 </td>
	                 <td>
	                 	 <input type = "button" value = "오늘">
		                 <input type = "button" value = "일주일">
		                 <input type = "button" value = "1개월">
		                 <input type = "button" value = "3개월">
		                 <input type = "button" value = "6개월">
	                 </td>
	                 <td><input type = "date" value="2000-01-01"> ~ <input type = "date" value="2022-03-22"> <input type = "button" value="조회"></td>
                 </tr>
              </table>
	            	<ul style= "margin-bottom: 5%;">
						<li class="sm">기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 지난 주문내역을 조회하실 수 있습니다.</li>
				        <li class="sm">주문번호를 클릭하시면 해당 주문에 대한 상세내역을 확인하실 수 있습니다.</li>
	    			</ul>
              <table class = "tbl_bottm">
	              <tr>
	                 <td style="font-weight:bold; padding: 1%;" >주문 상품 정보</td>
	              </tr>
	              <tr class = "tbl_bottom_line">
	                 <td style = "width: 16%;">주문일자<br>[주문번호]</td><td>이미지</td><td>상품정보</td><td>수량</td><td>상품구매금액</td><td>주문처리상태</td><td>취소/교환/반품</td>
	              </tr>
	              <tr>
	                 <td colspan="7" style = "text-align : center; height: 80px;"><strong>주문 내역이 없습니다</strong></td>
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
         
       
	       <div class="tab-pane container" id="menu2">
	            <table>
	                <tr class = "option">
	                   <td>
		                   <input type = "button" value = "오늘">
		                   <input type = "button" value = "일주일">
		                   <input type = "button" value = "1개월">
		                   <input type = "button" value = "3개월">
		                   <input type = "button" value = "6개월">
	                   </td>
	                   <td><input type = "date" value="2000-01-01"> ~ <input type = "date" value="2022-03-22"> <input type = "button" value="조회"></td>
	                </tr>
	            </table>
	            	<ul style= "margin-bottom: 5%;">
						<li class="sm">기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 지난 주문내역을 조회하실 수 있습니다.</li>
				        <li class="sm">주문번호를 클릭하시면 해당 주문에 대한 상세내역을 확인하실 수 있습니다.</li>
	    			</ul>
		        <table class = "tbl_bottm">
	              <tr>
	                 <td style="font-weight:bold; padding: 1%;" >취소/반품/교환내역</td>
	              </tr>
	              <tr class = "tbl_bottom_line">
	                 <td style = "width: 16%;">주문일자<br>[주문번호]</td><td>이미지</td><td>상품정보</td><td>수량</td><td>상품구매금액</td><td>주문처리상태</td><td>취소/교환/반품</td>
	              </tr>
	              <tr>
	                 <td colspan="7" style = "text-align : center; height: 80px;"><strong>주문 내역이 없습니다</strong></td>
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
        </div> 
   
	
	

</div>
	
<jsp:include page="footer.jsp"/>
 
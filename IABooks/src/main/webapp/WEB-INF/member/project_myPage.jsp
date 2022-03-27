<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">


    div.titleArea {
    min-height: 30px;
    margin: 10px 0 20px;
    border-bottom: 1px solid #e8e8e8;
    }
    
    table#tbl_head_second {
    	border: solid 1px;
    	width: 100%;
    }
    
    table#tbl_body{
    	width:100%;
    	margin-bottom: 8%;
    }
    
    strong.sojemok {
    	font-size:21pt;
    }
    p.sojemok_nayong {
    	font-size: 10pt;
    	color:#999999;
    	padding-top: 1%;
    }
    td.tbl_body_td {
    	padding: 2%;
    }
    tr.tbl_body_line {
    	border-bottom: solid 1px lightgray;
    }
    
   
   	table.tbl_head_first{
	   width: 100%;
	   border: 5px solid #e8e8e8;
	   margin-top: 20px;
   
	}

	tr.tbl_head_first{
	   border: solid 1px red;
	}
	
	li.tbl_head_first {
	   height: 70px;
	   padding-top: 20px;
	}
	
	ul.tbl_head_first {
	   list-style-type: none;
	   
	}
	
	td.tbl_head_first {
	   padding-left: 5px;
	}
	
	td.tbl_head_second_td_two {
		padding:3%;
	}
	
</style>
<title>마이페이지</title>

<jsp:include page="header.jsp"/>
<div class="container">

	<div class="titleArea">
		<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;마이 쇼핑</strong>
		<hr style="border: solid 2px #e8e8e8; margin-bottom: 3%;">
    </div>
    
	<table class="tbl_head_first">
         <tr >
            <td class="tbl_head_first" width="35%;">
               <ul class="tbl_head_first" >
                  <li class="tbl_head_first"><img src="<%= ctxPath%>/images/arrow_menu.gif" /> <strong>가용적립금</strong></li>
                  <li class="tbl_head_first"><img src="<%= ctxPath%>/images/arrow_menu.gif" /> <strong>사용립금</strong></li>
                  <li class="tbl_head_first"><img src="<%= ctxPath%>/images/arrow_menu.gif" /> <strong>총주문</strong></li>
               </ul>
            </td>
            <td class="tbl_head_first" width="15%;">
               <ul class="tbl_head_first">
                  <li class="tbl_head_first"><strong>0원</strong>&nbsp;<input type="button" value="조회" style="width: 40px;"></li>
                  <li class="tbl_head_first"><strong>0원</strong></li>
                  <li class="tbl_head_first"><strong>0원(0회)</strong></li>
               </ul>
            </td>
            
            <td class="tbl_head_first" style="border-left :solid 1px #e8e8e8;" width="35%;">
               <ul class="tbl_head_first">
                  <li class="tbl_head_first"><img src="<%= ctxPath%>/images/arrow_menu.gif" /> <strong>총적립금</strong></li>
                  <li class="tbl_head_first"><img src="<%= ctxPath%>/images/arrow_menu.gif" /> <strong>쿠폰</strong></li>
               </ul>
            </td>
            <td class="tbl_head_first" width="15%;">
               <ul class="tbl_head_first">
                  <li class="tbl_head_first"><strong>0원</strong></li>
                  <li class="tbl_head_first"><strong>0개</strong>&nbsp;<input type="button" value="조회" style="width: 40px;"></li>
               </ul>
            </td>
         </tr>
   </table>
    <br><br>
    
    <table id="tbl_head_second" border="1"  style = "text-align : center" >
    	<tr style="border-bottom: solid 1px lightgray;">
    		<td colspan="5" style= "padding: 1%; background-color: #f2f2f2;"><strong style = "font-size: 15pt;">나의 주문처리 현황</strong>&nbsp;(최근 3개월 기준)</td>
    	</tr>
    	
    	<tr>
	    	<td class ="tbl_head_second_td_two"><strong>입금전<br><br>0</strong></td>
	    	<td class ="tbl_head_second_td_two"><strong>배송준비중<br><br>0</strong></td>
	    	<td class ="tbl_head_second_td_two"><strong>배송중<br><br>0</strong></td>
	    	<td class ="tbl_head_second_td_two"><strong>배송완료<br><br>0</strong></td>
    	
	    	<td>
		    	<ul>
		    		<li>취소 : <strong>0</strong></li>
		    		<li>교환 : <strong>0</strong></li>
		    		<li>반품 : <strong>0</strong></li>
		    	</ul>
	    	</td>
    	</tr>
    </table>
    <br>
    
    <table id="tbl_body">
    	<tr class = "tbl_body_line">
    		<td class="tbl_body_td">
	    		<p><strong class="sojemok">order</strong>&nbsp;&nbsp;주문내역 조회<p>
			    <p class="sojemok_nayong">
				    고객님께서 주문하신 상품의 주문내역을 확인하실 수 있습니다.<br>
					비회원의 경우, 주문서의 주문번호와 비밀번호로 주문조회가 가능합니다.
				</p>
			</td>
		</tr>
		<tr class = "tbl_body_line">
    		<td class="tbl_body_td">	
			    <p><strong class="sojemok">profile</strong>&nbsp;&nbsp;회원 정보</p>
		    	<p class="sojemok_nayong">	
			    	회원이신 고객님의 개인정보를 관리하는 공간입니다.<br>
					개인정보를 최신 정보로 유지하시면 보다 간편히 쇼핑을 즐기실 수 있습니다.
				</p>
			</td>
		</tr>
		<tr class = "tbl_body_line">
    		<td class="tbl_body_td">
			    <p><strong class="sojemok">wishlist</strong>&nbsp;&nbsp;관심 상품</p>
			    <p class="sojemok_nayong">
			    관심상품으로 등록하신 상품의 목록을 보여드립니다.
			    </p>
			</td>
		</tr>
		<tr class = "tbl_body_line">
    		<td class="tbl_body_td">
			    <p><strong class="sojemok">mileage</strong>&nbsp;&nbsp;적립금</p>
			    <p class="sojemok_nayong">
			    적립금은 상품 구매 시 사용하실 수 있습니다.<br>
				적립된 금액은 현금으로 환불되지 않습니다.
				</p>
			</td>
		</tr>
		<tr class = "tbl_body_line">
    		<td class="tbl_body_td">
			    <p><strong class="sojemok">coupon</strong>&nbsp;&nbsp;쿠폰</p>
			    <p class="sojemok_nayong">
			    고객님이 보유하고 계신 쿠폰내역을 보여드립니다.
			    </p>
			</td>
		</tr>
		<tr class = "tbl_body_line">
    		<td class="tbl_body_td">
			    <p><strong class="sojemok">board</strong>&nbsp;&nbsp;게시물 관리</p>
			    <p class="sojemok_nayong">
			    고객님께서 작성하신 게시물을 관리하는 공간입니다.<br>
				고객님께서 작성하신 글을 한눈에 관리하실 수 있습니다.
				</p>
			</td>
		</tr>
		<tr class = "tbl_body_line">
    		<td class="tbl_body_td">
			    <p><strong class="sojemok">address</strong>&nbsp;&nbsp;배송 주소록 관리</p>
			    <p class="sojemok_nayong">
			    자주 사용하는 배송지를 등록하고 관리하실 수 있습니다.
			    </p>
    		</td>
		</tr>
	</table>

</div>	
<jsp:include page="footer.jsp"/>
 
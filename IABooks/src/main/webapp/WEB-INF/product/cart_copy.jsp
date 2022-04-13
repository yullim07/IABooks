<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header.jsp" />

<meta charset="UTF-8">
<title>in사과::장바구니</title>

<!-- 부트스트랩 css -->
<link rel="stylesheet" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/cart_list.css" />

<!-- Spinner -->
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">


<style type="text/css">
	/* bootstrap 버튼 */
	.btn {
		border: none;
		color: #fff;
		padding: 5px 10px;
		font-size: 13px;
		cursor: pointer;
		border-radius: 5px;
	}
	
	table#cartlist_tbl > tbody > tr {
		border: solid 1px #eeeeee;
	}
	table#cartlist_tbl > tbody > tr:hover {
		background-color: #e8e8e8;
	}
	table#cartlist_tbl > tbody > tr > td {
		text-align: center;
		height: 100px;
	}
	
	button.btn_option {
		line-height: 12pt;
		font-size: 9pt;
		margin-bottom: 10px;
	}



/* 회원 */


 table.interested {
	width: 100%;
	margin-top: 30px;
	margin-bottom: 10px;
	
}

table.interested td {
	text-align: center;
	padding-left: 10px;
	height: 100px;
}

table.interested >  thead > tr > td {
	height: 50px;
	background-color: #FBFAFA;
}


table.interested  tr {
	border-top: solid 2px #e8e8e8;
}

table.interested tr:last-child {
	border-bottom: solid 2px #e8e8e8;
}

span.interested_choice > img {
	margin: 5px;
}

span.interested_order {
	float: right;
}

table.interested_none {
	width: 100%;
	margin-top: 30px;
	margin-bottom: 10px;
}

table.interested_none td {
	text-align: center;
	height: 100px;
}

table.interested_none tr {
	border-top: solid 2px #e8e8e8;
	border-bottom: solid 2px #e8e8e8;
}

/*  페이징 CSS 중복   */

	div.pagination {
	  display: inline-block;
	  width: 100%;
	  text-align: center;
	  margin: 20px 0;
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

<script type="text/javascript">

	$(document).ready(function() {
		
		var spinner = $( "#spinner" ).spinner();
		
		$(".spinner").spinner({
			spin: function(event, ui) {
				if(ui.value > 100) {
					$(this).spinner("value", 100);
					return false;
				}
				else if(ui.value < 0) {
					$(this).spinner("value", 0);
					return false;
				}
			}
		}); 
		
	});// end of $(document).ready()
	
	
	// Function Declartion
	
	// ------------------------------------------------------------
	// 체크박스 전체선택 전체해제
	function checkSelectAll()  {
		// 전체 체크박스
		const checkboxes = document.querySelectorAll('input[name="checkbox"]');
		// 선택된 체크박스
		const checked = document.querySelectorAll('input[name="checkbox"]:checked');
		// select all 체크박스(전체선택 체크박스)
		const selectAll = document.querySelector('input[name="selectall"]');
		
		if(checkboxes.length === checked.length)  {
		  selectAll.checked = true;
		}
		else {
		  selectAll.checked = false;
		}
	}
	
	// 체크박스 전체선택 전체해제
	function selectAll(selectAll)  {
		const checkboxes = document.getElementsByName("checkbox");
		
		checkboxes.forEach((checkbox) => {
			checkbox.checked = selectAll.checked // 끝에 세미콜론 들어가면 작동 안된다!
		});
	}
	
	// ------------------------------------------------------------
	
	// 체크박스 선택 후 삭제 버튼 클릭 시 이벤트
	/* function goDel() {
		var checkboxArr = [];
		$("input: checkbox[name='checkbox']:checked").each(function() {
			checkboxArr.push($(this).val()); // 체크된 것만 값을 뽑아서 배열에 push
			console.log(checkboxArr);
		});
		
		$.ajax({
			type:"POST",
			url:"",
			data: {
				checkboxArr:checkboxArr // folder seq 값을 가지고 있음
			},
			success: function(result) {
				
			},
			error: function()
		});
		
	} */
	
	// ------------------------------------------------------------
	
	// 삭제버튼 눌렀을 때 삭제해주기
	/*
	function goDel(ths) {
		var ths = $(ths);
		ths.parents("tr").remove;
		alert("삭제!");		
	}
	*/
	// <button type="button" class="btn_option" onclick="goDel('${cvo.pk_cartno}');" value="${cvo.pk_cartno}">삭제하기</button>
	
	// document.querySelector("#cartlist_tbl > tbody > tr:nth-child(1) > td:nth-child(9) > button:nth-child(3)")
	
	// 전체삭제
	function goDelAll(fk_userid) {
		if(confirm("장바구니를 비우시겠습니까?")) {
			const frm = document.cartDelFrm;
			frm.fk_userid.value = fk_userid;
			
			frm.action = "<%= ctxPath%>/product/CartDeleteAll.book?fk_userid="+fk_userid;
			frm.method = "post";
			frm.submit();
		}
		else {
			alert("장바구니 비우기를 취소하셨습니다");
		}
	}
	
</script>

	
	<div class="container">
		<div>
			<img src="<%= ctxPath %>/images/product/img_order_step1.gif" style="width: 100%; margin: 20px 0 20px 0;" />
		</div>
		
		<div class="cart_info">
			<form name="orderFrm">
				<table id="cartlist_tbl" style="border: solid 1px pink; width: 100%;">
					<thead style="background-color: #e8e8e8; text-align: center; font-size: 9pt; height: 40px;">
						<tr>
							<th width="4%">
								<input type="checkbox" name="selectall" value="selectall" onclick="selectAll(this)" />
							</th>
							<th width="8%">이미지</th>
							<th width="30%">상품정보</th>
							<th width="8%">판매가</th>
							<th width="8%">수량</th>
							<th width="8%">적립금</th>
							<th width="8%">배송비</th>
							<th width="8%">합계</th>
							<th width="18%">선택</th>
					</thead>
					
					<tbody>
					
					<%-- 장바구니에 담긴 상품이 없는 경우 --%>
					<c:if test="${empty requestScope.cartList}">
						<tr>
							<td colspan="9" style="text-align: center; font-size: 9pt; height: 60px;">장바구니에 담긴 상품이 없습니다.</td>
						</tr>
					</c:if>
					
					<%-- 장바구니에 담긴 상품이 있는 경우 --%>
					<c:if test="${not empty requestScope.cartList}">
						<c:forEach var="cvo" items="${requestScope.cartList}" varStatus="status">
						<tr>
							<%-- 체크박스 --%>
							<td> 
								<input type="checkbox" name="checkbox" id="checkbox" value="${cvo.fk_pro_num}" onclick="checkSelectAll()" />
								<%-- <input type="checkbox" name="pk_pro_num" id="pk_pro_num${status.index}" value="${cvo.pk_pro_num }" /> --%>
							</td>
							
							<%-- 이미지 --%>
							<td> 
								<a href="<%=ctxPath%>/product/ShowBookDetail.up?pk_pro_num=${cvo.fk_pro_num}">
								<img src="<%=ctxPath%>/images/product/${cvo.category.cate_name}/${cvo.product.pro_imgfile_name}" style="width: 50%;" />
								</a>
							</td>
							
							<%-- 상품정보 --%>
							<td> 
								<a href="<%=ctxPath%>/product/ShowBookDetail.up?pk_pro_num=${cvo.fk_pro_num}">
								<span class="cart_pname">${cvo.product.pro_name}</span>
								</a>
							</td>
							
							<%-- 판매가 --%>
							<td> 
								<span class="order_price${status.index}"><fmt:formatNumber value="${cvo.product.pro_saleprice}" pattern="###,###" /></span>
								<input type="hidden" name="saleprice" id="" value="" />
							<%-- <br/><span style="color: green; font-weight: bold;"><fmt:formatNumber value="$(cvo.product.point}" pattern="###,###" /> POINT</span> --%>
							</td>
							
							<%-- 주문수량 + 장바구니 번호(숨김) --%> 
							<td>
								<%-- 주문수량(ck_odr_qty) --%>
								<span>
								<input type="number" class="spinner" id="spinner" name="ck_odr_qty" value="${cvo.ck_odr_qty}" style="width: 40px;"/>
								  <input id="spinnerPqty" name="pqty" value="1" style="width: 30px; height: 20px;"> 개
								<label for="spinner"></label>
								
								<%-- <input class="spinner oqty" name="oqty" value="${cvo.ck_odr_qty}" style="width: 30px; height: 20px;">개 --%>
								</span>
								
								<%-- 장바구니 번호 --%>
								<span>
								<input class="pk_cartno" type="hidden" name="pk_cartno" value="${cvo.pk_cartno}" />
								<button type="button" class="btn_update" onclick="goOqtyEdit(this);">수정</button>
								</span>
							</td>
							
							<%-- 적립금(기본 비율 사용) --%>
							<td>
								<span id="totalpoint">
									<%-- <fmt:formatNumber value="${cvo.totalPoint}" pattern="###,###" /> --%>
									<%-- <input class="totalPoint" type="hidden" value="${cvo.item.totalPoint}" /> --%>
								</span>
							</td>
							
							<%-- 배송비(주문총액이 5만원 이상이면 무료, 아니면 3000원) --%>
							<td>
							<c:if test="${cvo.totalPrice >= 50000}">무료</c:if>
							<c:if test="${cvo.totalPrice < 50000}">3000원</c:if>
							</td>
							
							<%-- 주문총액 --%>
							<td>
								<span id="totalPrice">
									<fmt:formatNumber value="${cvo.totalPrice}" pattern="###,###" />
									<input class="totalPrice" type="hidden" value="${cvo.totalPrice}" />
								</span>
							</td>
							
							<%-- 선택 --%>
							<td>
								<button type="button" id="btn_goOrder" class="btn btn-primary btn_option" onclick="goOrder('${cvo.pk_cartno}');">주문하기</button>
								<br/>
								<button type="button" id="btn_goWish" class="btn btn-primary btn_option" onclick="goWish('${cvo.pk_cartno}');">관심등록</button>
								<br/>
								<button type="button" id="btn_goDel" class="btn btn-primary btn_option" onclick="goDel('${cvo.pk_cartno}');" id="${cvo.pk_cartno}" value="${cvo.pk_cartno}">삭제하기</button>
								<br/>
							</td>
						</tr>
						</c:forEach>
					</c:if>
					</tbody>
					
					<tfoot style="background-color: #e8e8e8; text-align: center; font-size: 9pt; height: 40px; line-height: 9pt;">
						<tr>
							<td colspan="2">
								<button type="button" id="btn_goDelCheck" class="btn btn-primary" onclick="goDelSelect('${cvo.pk_cartno}');">선택삭제</button>
							</td>
							<td colspan="2">
								<button type="button" id="btn_goDelAll" class="btn btn-primary" onclick="goDelAll('${sessionScope.loginuser.userid}')">전체삭제</button>
							</td>
							<td colspan="5">
								<span id="totalprice">
									상품구매금액&nbsp;
									<fmt:formatNumber value="${cvo.totalPrice}" pattern="###,###" />
									&nbsp;+&nbsp;배송비
									<c:if test="${cvo.totalPrice >= 50000}">0(무료)</c:if>
									<c:if test="${cvo.totalPrice < 50000}">3000원</c:if>
									<input class="totalPrice" type="hidden" value="${cvo.totalPrice}" />
								</span>
							</td>
						</tr>
					</tfoot>
					
				</table>
			</form>	
		</div>
		
		
		
		
<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;관심상품</strong>
<hr style="border: solid 2px #e8e8e8;">
<!-- 	
	나중에 숨김처리 해야함 
	<div class="interestde_empty">
	<table class="interested_none">
		<tr>
			<td>관심상품 내역이 없습니다.</td>
		</tr>
	</table>
	</div>
	 -->
	
	<div class="interestde_not_empty">
	
		<table class="interested">
			<thead>
				<tr>
					<td><input type="checkbox" name="interested_allcheck" /></td>
					<td>이미지</td>
					<td>상품정보</td>
					<td>판매가</td>
					<td>수량</td>
					<td>적립금</td>
					<td>배송비</td>
					<td>합계</td>
					<td>선택</td>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td><input type="checkbox" id="interested_check" /></td>
					<td><img src="<%= ctxPath %>/images/member/e78bdc919df426ed106c57e265db6395.jpg" style="height: 80px; width: 80px;"/></td>
					<td>30대 백수 남편이지만 잘 살고 있습니다.</td>
					<td>15,000원</td>
					<td>-</td>
					<td>기본배송</td>
					<td>3,000원<br>조건</td>
					<td>18,000원</td>
					<td>
						<ul>
							<li><img src="<%= ctxPath %>/images/member/btn_order.gif" style="cursor: pointer;"/></li>
							<li><img src="<%= ctxPath %>/images/member/btn_basket.gif" style="cursor: pointer;"/></li>
							<li><img src="<%= ctxPath %>/images/member/btn_delete.gif" style="cursor: pointer;"/></li>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
		
		
		
		
		<span class="interested_choice">
			<strong>선택상품을</strong><img src="<%= ctxPath %>/images/member/btn_delete2.gif" style="cursor: pointer;" /><img src="<%= ctxPath %>/images/member/btn_basket2.gif"  style="cursor: pointer;"/>
		</span>
		<span class="interested_order"><img src="<%= ctxPath %>/images/member/btn_order_empty.gif" style="cursor: pointer;" />&nbsp;&nbsp;<img src="<%= ctxPath %>/images/member/btn_order_all.gif" style="cursor: pointer;" /></span>
		
		<div class="pagination pagination-sm justify-content-center">
		  <a href="#"><img src="<%= ctxPath %>/images/member/btn_page_first.gif" /></a>
		  <a href="#"><img src="<%= ctxPath %>/images/member/btn_page_prev.gif" /></a>
		  <a class="active" href="#">1</a>
		  <a href="#"><img src="<%= ctxPath %>/images/member/btn_page_next.gif" /></a>
		  <a href="#"><img src="<%= ctxPath %>/images/member/btn_page_last.gif" /></a>
		</div>
	</div>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	</div>
<jsp:include page="/WEB-INF/footer.jsp" />
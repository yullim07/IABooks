<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
%>



<meta charset="UTF-8">
<title>in사과::장바구니</title>
<jsp:include page="../header.jsp" />

<!-- 부트스트랩 css -->
<%-- <link rel="stylesheet" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">
 --%>
<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/cart_list.css" />

<!-- Spinner -->
<%-- <script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script> --%>
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js"></script>
<%-- <script src="/resources/demos/external/jquery-mousewheel/jquery.mousewheel.js"></script> --%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<%-- <link rel="stylesheet" href="/resources/demos/style.css"> --%>



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
}
	
	
	
</style>


<script type="text/javascript">
	$(document).ready(function() {
		
		// 제품 수량에 스피너 달아주기
		$("input#spinnerQty").spinner({
			spin: function(event, ui) {
				if(ui.value > 100) {
					$(this).spinner("value", 100);
					return false;
				}
				else if(ui.value < 1) {
					$(this).spinner("value", 1);
					return false;
				}
			}
		}); // end of $(".spinner").spinner({}); --------------------

		///////////////////////////////////////////////
		// 전체체크+전체해제+잔체체크해제
		
		var chob = document.getElementsByName("rowCheck");
		var rcnt = chob.length;
		
		$("input[name='allCheck']").click(function(){
			var ch_listArr = $("input[name='rowCheck']");
			for(var i=0; i < ch_listArr.length; i++) {
				ch_listArr[i].checked = this.checked;
			}
		});
		///////////////////////////////////////////////
		
		$("input[name='rowCheck']").click(function(){
			if($("input[name='rowCheck']:checked").length == rcnt) {
				$("input[name='allCheck']")[0].checked = true;
			}
			else {
				$("input[name='allCheck']")[0].checked = false;
			}
		});
		///////////////////////////////////////////////
		
		
		
		
		
		
	}); // end of $(document).ready() --------------------
	
	
	// Function Declartion
	
	// ------------------------------------------------------------
	// 체크박스 전체선택 전체해제
	/* function checkSelectAll()  {
		// 전체 체크박스
		const checkboxes = document.querySelectorAll('input[name="rowCheck"]');
		// 선택된 체크박스
		const checked = document.querySelectorAll('input[name="rowCheck"]:checked');
		// select all 체크박스(전체선택 체크박스)
		const selectAll = document.querySelector('input[name="allCheck"]');
		
		if(checkboxes.length === checked.length)  {
		  selectAll.checked = true;
		}
		else {
		  selectAll.checked = false;
		}
	} */ // end of function checkSelectAll()
	
	// ------------------------------------------------------------
	// 체크박스 한 번에 전체선택/전체해제
	/* function selectAll(selectAll)  {
		const checkboxes = document.getElementsByName("rowCheck");
		
		checkboxes.forEach((rowCheck) => {
			rowCheck.checked = selectAll.checked // 끝에 세미콜론 들어가면 작동 안된다!
		});
	} */ // end of function selectAll(selectAll)
	
	// ------------------------------------------------------------
	
	
	/*
		내가 하고 싶은 거 >> 체크를 하고 그 체크된 값의 cartno를 배열에 넣은 뒤 액션단으로 보내서 자른 뒤에 
		그 cartno를 가지고 DAO에서 삭제해준다. => form 이름을 다르게 줘야한다! => 선택삭제가 있는 곳을?
	 */
	
	
	// 이게 선행되기 전에 되야되는 것! 각각의 체크버튼을 클릭했을 때 배열에 넣어줘야 한다.
	<%-- function checkSelectedBox() {
		
	//	var flag = false;
		var value = document.getElementsByName("rowCheck");
		var valueArr = new Array();
		var pk_cartno = 0;
		
		for(var i = 0; i < value.length; i++) {
			if(value[i].checked) {
				pk_cartno = value[i].value;
				console.log(pk_cartno);
				// 선택한 것들이 나온다.
				// 27을 눌렀을 때 - value[i] : 27
				// 27, 28을 눌렀을 때 - value[i] : 27 / value[i] : 28
				// 문제는 계속 반복해서 나온다... => 이걸 구분자와 함께 한 번에 배열에 넣고 쪼개서 삭제하면 된다!
				valueArr.push(value[i].value);
			}
		} // end of for ------------------------------
		
		console.log(valueArr);
		if(valueArr.length == 0) {
			alert("선택된 상품이 없습니다!");
		}
		else {
			// var chk = confirm("선택한 상품을 삭제하시겠습니까?");
			$.ajax({
				url:"<%= ctxPath%>/product/CartDeleteSelect.up",
				type:"post",
				/* data:{"pk_cartno" : pk_cartno}, */
				data:{valueArr : valueArr},
				/* dataType:"json", */
				success:function(n) {
					if(n = 1) {
						alert("선택한 상품을 삭제했습니다!");
						location.replace("value");
					}
					else {
						alert("선택한 상품을 삭제하는데 실패했습니다!");
					}
				}
			});
			
		} // end of else ------------------------------
		
	} --%> // end of function checkSelectedBox() ------------------------------


	
	// 체크박스 선택 후 삭제 버튼 클릭 시 이벤트
	
	<%-- function goDelSelect() {
		var checkboxArr = [];
		$("input: checkbox[name='rowCheck']:checked").each(function() {
			checkboxArr.push($(this).val()); // 체크된 것만 값을 뽑아서 배열에 push
			console.log(checkboxArr);
		});
		
		$.ajax({
			type:"POST",
			url:"<%= ctxPath%>/product/CartDeleteSelect.up",
			data: {
				checkboxArr:checkboxArr // folder seq 값을 가지고 있음
			},
			success: function(result) {
				if(result = 1) {
					alert("선택한 상품을 삭제했습니다!");
					location.replace("value");
				}
				else {
					alert("선택한 상품을 삭제하는데 실패했습니다!");
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	} --%>
	
	<%-- function goDelSel(pk_cartno) {
		const cartcheck_len = $("input:checkbox[name='rowCheck']:checked").length;
		
		if(cartcheck_len == 0) {
			alert("주문할 상품을 1개 이상 선택하세요!!");
			return false; // submit 을 하지 않고 종료한다.
		}
				
		if(confirm("선택한 상품을 삭제하시겠습니까?")) {
			const frm = document.orderFrm;
			frm.pk_cartno.value = pk_cartno;
			
			frm.action = "<%= ctxPath%>/product/CartDeleteSelect.book";
			frm.method = "post";
			frm.submit();
		}
		else {
			alert("선택상품 삭제를 취소하셨습니다.");
		} --%>
	
	// 전체삭제
	function goDelAll(fk_userid) {
		if(confirm("장바구니를 비우시겠습니까?")) {
			const frm = document.orderFrm;
		//	frm.fk_userid.value = fk_userid;
			
			frm.action = "<%= ctxPath%>/product/cartDeleteAll.book";
			frm.method = "post";
			frm.submit();
		}
		else {
			alert("장바구니 비우기를 취소하셨습니다.");
		}
	}
	
	//////////////////////////////////////////////
	function goDelSelect() {
		
		if(confirm("선택한 상품을 삭제하시겠습니까?")) {
			const frm = document.btnCartFrm;
			frm.action = "<%= ctxPath%>/product/cartDeleteSelect.book";
			frm.method = "post";
			frm.submit();
		}
		else {
			alert("선택상품 삭제하기를 취소하셨습니다.");
		}
		<%-- var url="<%= ctxPath%>/product/cartDeleteSelect.book";
		var valueArr = new Array();
		var value = $("input[name='rowCheck']");
		
		for(var i = 0; i < value.length; i++) {
			if(value[i].checked) {
				valueArr.push(value[i].value);
			}
		}
		
		console.log(valueArr);
		
		if(valueArr.length == 0) {
			alert("선택된 상품이 없습니다!");
		}
		else {
			var chk = confirm("선택한 상품을 삭제하시겠습니까?");
			$.ajax({
				url:url,
				type:"post",
				traditional:true,
				data:{
					valueArr : valueArr
				},
				success:function(n) {
					if(n = 1) {
						alert("선택한 상품을 삭제했습니다!");
					}
					else {
						alert("선택한 상품을 삭제하는데 실패했습니다!");
					}
				}
			});
			
		} --%>
	} //////////////////////////////////////////////
	
	
		
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
								<input type="checkbox" name="allCheck" value="allCheck"/>
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
							<%-- 체크박스 + 장바구니 번호(숨김) --%>
							<td>
								<%-- <input type="text" name="fk_userid" value="${sessionScope.loginuser.userid}"> --%> <%-- 나증에 hidden으로 --%>
								<input type="text" name="cartno" value="${cvo.pk_cartno}"> <%-- 나증에 hidden으로 --%>
								<%-- <input type="text" name="cartno" value="${cvo.fk_pro_num}"> --%>
								<input type="checkbox" name="rowCheck" id="rowCheck" value="${cvo.pk_cartno}" />
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
							
							<%-- 주문수량 + 수정버튼 --%> 
							<td>
								<%-- 주문수량(ck_odr_qty) --%>
								<input class="spinner" id="spinnerQty" name="ck_odr_qty" value="${cvo.ck_odr_qty}" style="width: 40px;"/>
								<%-- 주문수량변경버튼 --%>
								<button type="button" id="btn_qtyModify" class="btn_update" onclick="goQtyModify(${cvo.pk_cartno});">수정</button>
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
				</table>
				</form>
				
				
				
				<form name="btnCartFrm">
				<table>
					<tfoot style="background-color: #e8e8e8; text-align: center; font-size: 9pt; height: 40px; line-height: 9pt;">
						<tr>
							<td colspan="2">
								<button type="button" id="btn_goDelCheck" class="btn btn-primary" onclick="goDelSelect();" >선택삭제</button> <!-- checkSelectedBox(); -->
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
			
			<%-- 페이지바 시작 --%>
			<div>
			</div>
			<%-- 페이지바 끝 --%>
			
			<%-- 장바구니 제품수량 수정 from 시작 --%>
			<form name="updateOqtyFrm">
				<input type="hidden" name="cartno" />
				<input type="hidden" name="oqty" />
			</form>
			<%-- 장바구니 제품수량 수정 from 끝 --%>
			
		</div>
		
	<!-- ========================================================================================== -->
	
	
	<br><br><br>
	<jsp:include page="cart_board.jsp" />
				
	</div>


	<jsp:include page="/WEB-INF/footer.jsp" />
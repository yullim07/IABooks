<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String ctxPath = request.getContextPath();
%>

<meta charset="UTF-8">
<title>in사과::장바구니</title>

<!-- 부트스트랩 css -->
<link rel="stylesheet" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/cart_list.css" />

<!-- Spinner -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js"></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<!-- <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script> -->
<script src="/resources/demos/external/jquery-mousewheel/jquery.mousewheel.js"></script>


<style type="text/css">
	.container {
		font-size: 13pt;
		width: 100%;
	}
	
	#frame {
		width: 100%;
		margin: 0 auto;
	}
	
	#frame2 {
		border-bottom: solid 1px #;
		padding-bottom: 10px;
	}
	
	/* 계산 테이블 */
	table.calc1 {
		clear: both;
		border: solid 1px #e0e0eb;
		border-collapse: collapse;
		background-color: #f5f5f0;
		width: 100%;
		font-size: 10pt;
	}
	
	/* 계산 테이블 - 제목 */
	table.calc1 th {
		border: solid 1px #e0e0eb;
		padding: 10px 0;
		text-align: center;
	}
	
	/* 계산 테이블 - 내용 */
	table.calc1 td {
		border: solid 1px #e0e0eb;
		text-align: center;
	}
	
	/* 총 결제예정금액 테이블 */
	table.calc2 {
		border: solid 1px #e0e0eb;
		border-collapse: collapse;
		background-color: #f5f5f0;
		width: 100%;
		font-size: 10pt;
	}
	
	/* 총 결제예정금액 테이블 - 제목 */
	table.calc2 th {
		border: solid 1px #e0e0eb;
	}
	
	/* 총 결제예정금액 테이블 - 내용 */
	table.calc2 td {
		border: solid 1px #e0e0eb;
		text-align: center;
	}
	
	/* calc2 테이블 - 가격 ~원 */
	.price {
		font-size: 20pt;
		font-weight: bold;
	}
	
	/* bootstrap 버튼 */
	.btn {
		border: none;
		color: #fff;
		padding: 5px 10px;
		font-size: 13px;
		cursor: pointer;
		border-radius: 5px;
	}
	
	.default {background-color: #fff; border: solid 1px grey; color: black;}
	.default:hover {background-color: #ddd;}
	.backBtn {background-color: #fff; border: solid 1px grey;}
	
	/* 선택상품 삭제, 해외배송 장바구니로 이동 float */
	.btnfloat {float: left;}
	
	/* 선택상품 장바구니, 견적서 출력 float */
	.btnfloat2 {float: right;}
	
	/* clear */
	.clearboth {clear: both;}
	
	/* 쇼핑계속하기 */
	.footbtn{float: right; font-weight: bold; font-size: 12pt; border-radius: 3px;}
	
	/* 전체상품주문 선택상품주문 쇼핑계속하기 버튼 통합 */
	#allProduct, #productClear, #footerbtn {padding: 11px 25px; }
	
	/* 전체상품주문 버튼 */
	#allProduct {margin-left: 140px; background-color: #264d73; color: #fff; 
		font-weight: bold; font-size: 12pt;}
	/* 선택상품주문 버튼 */ 
	#productClear {background-color: grey; color: #fff; font-weight: bold; font-size: 12pt;}
	
	/* 구매상품 해외상품 hover*/
	.aa:hover { cursor: pointer;}
	
	.delcss {
		background-color: cyan;
		font-weight: bold;
		color: blue;
	}
	
}
	
	
	
</style>

<%-- <jsp:include page="../header.jsp" /> --%>
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
		}); // end of $(".spinner").spinner({}); --------------------
		
		$(".del").hover(function() {
							$(this).addClass("delcss");
						},
						function() {
							$(this).removeClass("delcss");
						});
		
	}); // end of $(document).ready() --------------------
	
	// Function Declartion
	
	
	
	// spinner test
	 $( function() {
    var spinner = $( "#spinner" ).spinner();
 
    $( "button" ).button();
  } );
	
	
	
	
	
	// 체크박스 전체선택 전체해제
	function allCheckBox() {
		var bool = $("#allCheckOrNone").is(":checked");
		/*
			
		*/
		$(".chkboxpnum").prop("checked", bool);
		
	} // end of function allCheckBox() --------------------
	
	function goOqtyEdit(obj) {
		var index = $(".updateBtn").index(obj);
		
		var cartno = $(".pk_cartno").eq(index).val();
		var oqty = $(".ck_odr_qty").eq(index).val();
		
		var reqExp = /^[0-9]+$/g;
		var bool = regExp.test(ck_odr_qty);
		
		if(!bool) {
			alert("수량은 0개 이상이어야 합니다.");
			location.href="javascript:history.go(0);";
			return;
		}
		
	//	alert("장바구니 : " + cartno + "\n주문량 : " + oqty);
		
		else if(oqty == "0") { // 장바구니에 담긴 물건 개수가 0이 되면 삭제
			goDel(cartno);
		}
		
		else {
			$.ajax({
				url:"<%=ctxPath %>/product/cartEdit.book",
				type:"POST",
				data:{"cartno":cartno
					, "oqty":oqty},
				dataType:"JSON",
				success:function(json) {
					if(json.n == 1) {
						location.href="<%=ctxPath %>/${goBackURL}"};
					}
				},
				error:function(request, status, error) {
					alert("code: " + request.c_status + "\n" + "message: " + request.responseText+"\n"+"error:"+error);
					
				}
			});
		}
	} // end of function goOqtyEdit(obj) --------------------
	
	// 장바구니에서 특정 제품을 비우기
	function goDel(pk_cartno) {
		var $target = $(event.target);
		var pro_name = $target.parent().parent().find(".cart_pname").text();
		var bool = confirm(pro_name+" 을(를) 장바구니에서 제거하시겠습니까?");
		
		if(bool) {
			$.ajax({
				url:"",
				type:"POST",
				data:{"cartno":pk_cartno},
				dataType:"JSON",
				success:function(json) {
					if(json.n == 1) {
						location.href="<%=ctxPath %>/${goBackURL}";
					}
				},
				error: function(request, status, error) {
					alert("code: " + request.c_status + "\n" + "message: " + request.responseText+"\n"+"error:"+error);
				}
			});
		}
		else {
			alert(pro_name + "삭제 취소됨");
		}
	} // end of function goDel(pk_cartno) --------------------
	
	
	// 장바구니에서 제품 추가하기 //
	function goOrder() {
		
		// 체크박스의 체크된 갯수
		var checkCnt = $("input:checkbox[name=pk_pro_num]:checked").length;
		
		if(checkCnt < 1) {
			alert("주문하실 제품을 선택하세요!!");
			return;
		}
		
		else {
			// 체크박스에서 체크된 value값(checked 속성이용) //
			// 체크가 된 것만 값을 읽어와서 배열에 넣어준다.
			var allCnt = $("input:checkbox[name=pk_pro_num]").length;
			
			var pnumArr = new Array();
			var oqtyArr= new Array();
			var cartnoArr = new Array();
			var totalPriceArr = new Array();
			var totalPointArr = new Array();
			
			for(var i=0; i < allCnt; i++) {
				if($("input:checkbox[class=chkboxpnum]").eq(i).is(":checked") ) {
					pnumArr.push($("input:checkbox[class=chkboxpnum]").eq(i).val());
					oqtyArr.push($(".oqty").eq(i).val());
					cartnoArr.push($(".cartno").eq(i).val());
					totalPriceArr.push($".totalPrice").eq(i).val() );
				//	totalPointArr.push($".totalPrice").eq(i).val() );
				}
			}
			
			for(var i=0; i<checkCnt; i++) {
				console.log("확인용 제품번호: " + pnumArr[i] 
						+ ", 주문량: " + oqtyArr[i] 
						+ ", 장바구니번호: " + cartnoArr[i]
						+ ", 주문금액: " + totalPriceArr[i]
					//	+ ", 포인트 : " + totalPointArr[i]
				);
			}
			
			var pnumjoin = pnumArr.join();
			var oqtyjoin = oqtyArr.join();
			var cartnojoin = cartnoArr.join();
			var totalPricejoin = totalPriceArr.join();
			
			var sumtotalPrice = 0;
			for(var i = 0; i < totalPriceArr.length; i++) {
				sumtotalPrice += parseInt(totalPriceArr[i]);
			}
			
			var sumtotalPoint = 0;
			for(var i = 0; i < totalPointArr.length; i++) {
				sumtotalPoint += parseInt(totalPointArr[i]);
			} 
			
			console.log("확인용 pnumjoin : " + pnumjoin);
			console.log("확인용 oqtyjoin : " + oqtyjoin);
			console.log("확인용 cartnojoin : " + cartnojoin);
			console.log("확인용 sumtotalPrice : " + sumtotalPrice);
			console.log("확인용 sumtotalPoint : " + sumtotalPoint);
			
			var currentmileage = $(sessionScope.loginuser.mileage);
			
			if(sumtotalPrice > currentmileage) {
				alert("마일리지가 부족하므로 주문이 불가합니다.\n주문총액: " + sumtotalPrice + ", 예치금: " + currentmileage +"");
				return;
			}
			
			else {
				$.ajax({
					url:"<%=ctxPath%>/product/orderAdd.book";,
					type:"POST",
					data:{"pnumjoin":pnumjoin
						, "oqtyjoin":oqtyjoin
						, "cartnojoin":cartnojoin
						, "totalPricejoin":totalPricejoin
						, "sumtotalPrice":sumtotalPrice
						, "sumtotalPoint":sumtotalPoint},
					dataType:"JSON",
					success:function(json) {
						if(json.isSuccess == 1) {
							location.href="/product/orderList.book";
						}						
						else {
							location.href="/product/orderError.book";
						}
					},
					error:function(request, status, error) {
						alert("code: " + request.c_status + "\n" + "message: " + request.responseText+"\n"+"error:"+error);
					}
				});
			}
			
		}  			
		
	} // end of function goOrder()
	
	
	
	
		
		// === 체크박스 === //
<%--	$(".calc1 thead th input:checkbox[id=check]").click(function() {
			
			#(".calc1 tbody input:checkbox[name=checkbox]").prop("checked", bool);
		});
		
		// === 체크박스 === //
		$(".calc1 tbody input:checkbox[name=check]").click(function() {
			var flag = false;
			$(".calc1 tbody input:checkbox[name=checkbox]").each(function() {
				var bool = $(this).prop("checked");
				
				if(!bool) {
					$(".calc1 thead input:checkbox[id=check]").prop("checked", false);
					flag = true;
					return false;
				}
			});
			
			if(!flag) {
				$(".calc1 thead input:checkbox[id=check]").prop("checked", true);
			}
		});
		*/
		
		// === 상품주문 버튼 클릭시 주문페이지로 넘어가기 === //
		$(".orderGobtn").click(function() {
			var frm = document.cartForm;
			frm.method = "POST";
			frm.action = "<%=ctxPath %>/product/order.book";
			frm.submit();
		});
		
		// === 하나의 tr에서 삭제버튼을 누르면 현재 라인을 지워주기 === //
		$(".btndelete").click(function() {
		//	$(this).parent().parent().css('background-color', 'red');
			$(this).parent().parent().remove();
			
			var tr = $("#calc1_tbody tr").val();
			if(tr == null) {
				$("#notproduct").show();
			}
		});
		
		// === 삭제 버튼 눌렀을 때 제품 삭제하기 === //
		$(".choiceProductDelete").click(function() {
			
			var bool = $(".calc1 tbody input:checkbox[name=checkbox]").is(":checked");
			
			if(!bool) {
				alert("선택된 상품이 없습니다.");
			}
			
			else {
				
				if(bool == $(".calc1 tbody tr input:checkbox[id=cbtr1]").is(":checked")) {
					$("#calc1_tbody_tr1").remove();
				}
				else if(bool == $(".calc1 tbody tr input:checkbox[id=cbtr2]").is(":checked")) {
					$("#calc1_tbody_tr2").remove();
				}
			}
			
			// === checkbox 전체선택시 삭제하기 === //
			bool = $(".calc1 thead input:checkbox[id=check]").is(":checked");
			
			if(bool) {
				$(".calc1 > tbody").empty();
				$(".calc1 thead input:checkbox[name=checkbox]").prop("checked", false);
				alert("CCCCC");
			}
		});
	
--%>	
	
</script>

	<jsp:include page="/WEB-INF/header.jsp" />
	
	<div class="container">
		<div>
			<img src="<%= ctxPath %>/images/product/img_order_step1.gif" style="width: 100%; margin: 20px 0 20px 0;" />
		</div>
		
		<div class="cart_info">
			<form name="orderFrm">
				<table id="cartlist" style="border: solid 1px pink; width: 100%;">
					<thead>
						<tr>
							<th width="5%"><input type="checkbox" id="allCheckOrNone" onclick="allCheckBox();" /></th>
							<th width="10%">이미지</th>
							<th width="15%">상품정보</th>
							<th width="10%">판매가</th>
							<th width="10%">수량</th>
							<th width="10%">적립금</th>
							<th width="10%">배송비</th>
							<th width="10%">합계</th>
							<th width="10%">선택</th>
					</thead>
				</table>
			</form>
		</div>
		
		
		<div>
			<label for="spinner">수량</label>
  			<input type="number" id="spinner" name="value" value=100/ >
		</div>
		
		<form name="orderFrm">
			<table id="tblCartList">
				<thead>
					<tr>
						<th>
							<input type="checkbox" id="allCheckOrNone" onclick="allCheckBox();" />
							<span style="font-size: 10pt;"><label for="allCheckOrNone">전체선택</label></span>
						</th>
						<th>
							주문하실 제품을 선택하신 후 주문하기를 클릭하세요.
						</th>
					</tr>
					
					<tr>
						<th>제품번호</th>
						<th>제품명</th>
						<th>수량</th>
						<th>포인트</th>
						<th>판매가</th>
						<th>총액</th>
						<th>삭제</th>
					</tr>
				</thead>
				
				<tbody>
				<c:if test="${empty requestScope.cartList}">
					<tr>
						<td>
							<span>장바구니에 담긴 상품이 없습니다.</span>
						</td>
					</tr>
				</c:if>
					
				<c:if test="${not empty requestScope.cartList}">
					<c:forEach var="cvo" items="${requestScope.cartList}" varStatus="status">
					<tr>
						<td>
							<input type="checkbox" name="pk_pro_num" id="pk_pro_num${status.index}" value="${cvo.pk_pro_num }" />
						</td>
						<td align="center">
							<a href="<%=ctxPath%>/product/ShowBookDetail.up?pk_pro_num=${cvo.pk_pro_num}">
								<img src="<%=ctxPath%>/images/product/${cvo.category.cate_name}/${cvo.product.pro_imgfile_name}" height="100px;" />
								
							</a>
							<br /><span class="cart_pname">${cvo.product.pro_name}</span>
						</td>
						<td align="center">
							<%-- 수량 --%>
							<input class="spinner oqty" name="oqty" value="${cvo.ck_odr_qty}" style="width: 30px; height: 20px;">개
							
							<%-- 장바구니 번호 --%>
							<input class="cartno" type="hidden" name="cartno" value="${cvo.pk_cartno}" />
							<button class="updateBtn" type="button" onclick="goOqtyEdit(this);">수정</button>
						</td>
						<td align="right"> <%-- 실제판매단가 및 포인트 --%>
							<fmt:formatNumber value="${cvo.product.pro_saleprice}" pattern="###,###" />
							<input type="hidden" name="saleprice" id="" value="" />
							<%-- <br/><span style="color: green; font-weight: bold;"><fmt:formatNumber value="$(cvo.product.point}" pattern="###,###" /> POINT</span> --%>
						</td>
						<td align="right"> <%-- 총금액 및 총포인트 --%>
							<span id="totalprice">
								<fmt:formatNumber value="${cvo.totalPrice}" pattern="###,###" />
							</span> 원
							<input class="totalPrice" type="hidden" value="${cvo.totalPrice}" />
							<br/>
							
							<span style="color: green; font-weight: bold;">
							<span id="totalpoint">
								<!-- 포인트 적용 X -->
								<%-- <fmt:formatNumber value="${cvo.totalPoint}" pattern="###,###" /> --%>
							</span> <!-- POINT --></span>
							<%-- <input class="totalPoint" type="hidden" value="${cvo.item.totalPoint}" /> --%>
						</td>
						<td align="center"> <%-- 장바구니에서 해당 제품 삭제하기 --%>
							<span class="del" style="cursor: pointer;" onclick="goDel('${cvo.pk_cartno}');">삭제</span>
						</td>
					</tr>
					</c:forEach>
				</c:if>
				
					<tr>
						<td colspan="3" align="right">
							<span style="font-weight: bold;">장바구니 총액 : </span>
							<span style="color: red; font-weight: bold;"><fmt:formatNumber value="${sumMap.SUNCARTPRICE}" pattern="###,###" /> 원</span>
							<br/>
							<span style="font-weight: bold;">:</span>
							<span style="color: red; font-weight: bold;"><fmt:formatNumber value="${sumMap. SUMCARTPOINT}" pattern="###,###" /> POINT</span>
						</td>
						<td colspan="3" align="center">
							<span class="ordershopping" style="cursor: pointer;" onclick="goOrder();">[주문하기]</span>&nbsp;&nbsp;
							<span class="ordershopping" style="cursor: pointer;" onclick="javascript:location.href='<%=ctxPath %>/product/index.up'">[계속쇼핑]</span>
						</td>
					</tr>
				</tbody>	
		</table>	
	</form>
	
	<%-- 페이지바 시작 --%>
	<div>
		페이지바?
	</div>
	<%-- 페이지바 끝 --%>
	
	<%-- 장바구니 제품수량 수정 from 시작 --%>
	<form name="updateOqtyFrm">
		<input type="hidden" name="cartno" />
		<input type="hidden" name="oqty" />
	</form>
	<%-- 장바구니 제품수량 수정 from 끝 --%>
	
	<!-- ========================================================================================== -->
	
	
	<br><br><br>
	<jsp:include page="cart_board.jsp" />
				
	</div>
	


	<jsp:include page="/WEB-INF/footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<meta charset="UTF-8">
<title>in사과::장바구니</title>

<!-- 부트스트랩 css -->
<link rel="stylesheet" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/cart_list.css" />


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
	
	/* 홈 > 장바구니 */
	.home { 
		float: right;
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
	
	
}
	
	
	
</style>

<%-- <jsp:include page="../header.jsp" /> --%>
<script type="text/javascript">

	$(document).ready(function() {
		
		$("#notproduct").hide();	// 선택된 등록상품이 없습니다.
	
		// 체크박스 전체선택 전체해제
		$("allCheck").click(function() {
			
		});
		
		
		/*
		// === 체크박스 === //
		$(".calc1 thead th input:checkbox[id=check]").click(function() {
			var bool = $(this).prop("checked");
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
		$("#choiceProductDelete").click(function() {
			
			var bool = $(".calc1 tbody input:checkbox[name=checkbox]").is(":checked");
			
			if(!bool) {
				alert("선택된 상품이 없습니다.");
			}
			
			else {
				
				if(bool == $(".calc1 tbody tr input:checkbox[id=cbtr1]").is(":checked")) {
					$(".calc1_tbody_tr1").remove();
				}
				else if(bool == $(".calc1 tbody tr input:checkbox[id=cbtr2]").is(":checked")) {
					$(".calc1_tbody_tr2").remove();
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
		
		
	}); // end of $(document).ready() --------------------
	
	
	// Function Declartion
	
	
	
	
</script>
<body>
	<div class="container">
		<div id="frame">
			<form>
				<div id="frame2">
					<span style="font-size: 16pt; font-weight: bold;">장바구니</span>
					<span class="home">홈 > 장바구니</span>
					<span> </span>
				</div>
				
				<br/>
				
				<div>
					<table class="calc1">
						<tr>
							<th class="aa">구매상품</th>
							<th class="aa">해외상품</th>
							<th style="width: 700px;"></th>
						</tr>
					</table>
				</div>
				
				<br/>
				
				<%-- 상품정보 테이블 --%>
				<div>
					<table class="calc1">
						<thead>
							<tr>
								<th colspan="10" style="text-align: left; padding-left: 10px;">일반상품(1)</th>
							</tr>
							<tr>
								<th><label for="allCheck"><input type="checkbox" name="checkbox" id="check"></label></th>
								<th><span>이미지</span></th>
								<th style="width: 550px;"><span>상품정보</span></th>
								<th>판매가</th>
								<th>수량</th>
								<th style="width: 100px;">적립금</th>
								<th>배송구분</th>
								<th>배송비</th>
								<th>합계</th>
								<th>선택</th>
							</tr>
						</thead>
						
						<%-- <c:if test=""> --%>
						<tbody id="notproduct">
							<tr style="height: 90px; background-color: #fff;">
								<td colspan="10" style="text-align: left; text-align: center; border-right: none;">
									상품이 존재하지 않습니다.
								</td>
							</tr>
						</tbody>
						<%-- </c:if> --%>
						
						<tbody id="calc1tbody">
						<c:if test="${not empty requestScope.cartList}">
						<c:forEach var="items" items="${requestScope.cartList}">
							<tr class="calc1_tbody_tr1" style="height: 90px; background-color: #fff;">
								
								<td style="text-align: left; text-align: center; border-right: none;">
									<input type="checkbox" id="cbtr1" name="checkbox" />
									<input type="hidden" class="buynow">
									<input type="hidden" name="cartAllCnt">
									<%--
										display:none, input type="hidden" 모두 form 전송 가능
										display:none 과 visibillity:hidden, overflow:hidden 은
										스크린리더기에서 읽을 수 있는지 여부
										display:none 은 display:none 영역이 사라지면 아래의 내용이 위로 올라가지만
										visibillity:hidden 은  visibillity:hidden 영역이 사라져도 아래의 내용은 원래 위치에 위치한다.
									--%>
								</td>
								<td style="border-left: none; border-right: none;">
									<img src="<%=ctxPath%>/images/product/book.jpg" width="100px;">
								</td>
								<td style="text-align: left; padding-left: 10px; border-left: none; font-weight: bold;">
									책제목쓸곳
								</td>
								<td>
									<span style="padding-left: 10px;">0</span>원
								</td>
								<td style="width: 80px;">
									<input type="number" style="text-align: right; width: 43px;" min="1" max="99" step="1" value="1">
									<button class="btn default" style="border-radius: 3px; size: 10px;">변경</button>							
								</td>
								
								<td>-</td> <%-- 적립금 --%>
								<td>기본배송</td>
								<td>3000원(5만원 이상 주문 시 배송비무료)</td>
								<td><span>0</span>원</td>
								
								<td>
									<button type="button" class="btn default orderGobtn" style="border-radius: 3px; width: 90px; margin-bottom: 3px; font-size: 11px;">주문하기</button>
									<button type="button" class="btn default" style="border-radius: 3px; width: 90px; margin-bottom: 3px; font-size: 11px;">관심상품등록</button>
									<button type="button" class="btn default btndelete" style="border-radius: 3px; width: 90px; margin-bottom: 3px; font-size: 11px;">삭제</button>
								</td>
							</tr>
							</c:forEach>
							</c:if>
							
							
							
							<tr class="clac1_tbody_tr2" style="height: 90px; background-color: #fff;">
								<td style="text-align: left; text-align: center; border-right: none;">
									<input type="checkbox" id="cbtr2" name="checkbox" />
								</td>
								<td style="border-left: none; border-right: none;">
									<img src="<%=ctxPath%>/images/product/book.jpg" width="100px;">
								</td>
								<td style="text-align: left; padding-left: 10px; border-left: none; font-weight: bold;">
									책제목쓸곳
								</td>
								<td>
									<span style="padding-left: 10px;">0</span>원
								</td>
								<td style="width: 80px;">
									<input type="number" style="text-align: right; width: 43px;" min="1" max="99" step="1" value="1">
									<button type="button" class="btn default" style="border-radius: 3px; size: 10px;">변경</button>							
								</td>
								
								<td>-</td> <%-- 적립금 --%>
								<td>기본배송</td>
								<td>3000원(5만원 이상 주문 시 배송비무료)</td>
								<td><span>0</span>원</td>
								
								<td>
									<button type="button" class="btn default orderGobtn" style="border-radius: 3px; width: 90px; margin-bottom: 3px; font-size: 11px;">주문하기</button>
									<button type="button" class="btn default" style="border-radius: 3px; width: 90px; margin-bottom: 3px; font-size: 11px;">관심상품등록</button>
									<button type="button" class="btn default btndelete" style="border-radius: 3px; width: 90px; margin-bottom: 3px; font-size: 11px;">삭제</button>
								</td>
							</tr>
						</tbody>
						
						<tfoot>
							<tr style="height: 60px;">
								<td colspan="5" style="border-right: none; text-align: left; padding-left: 10px;">
									<span>[기본배송]</span>
								</td>
								<td colspan="5" style="border-left: none; text-align: right; padding-right: 10px;">
									상품금액 <span>0</span> + <span>배송 3000 = 합계</span>&nbsp;<span style="font-weight: bold; font-size: 15pt;">0</span>
								</td>
							</tr>
						</tfoot>
						
					</table>
					
					<div style="margin: 10px 0;">
						<span style="margin: 0 10px;" class="btnfloat">선택상품을</span>
						<button class="btn default btnfloat" id="choiceProductDelete" style="background-color: grey; color: #fff">삭제하기</button>
						<button class="btn default backBtn btnfloat">해외배송 장바구니로 이동</button>
						
						<button class="btn default backBtn btnfloat2 productClear">장바구니 비우기</button>
						<button class="btn default backBtn btnfloat2">견적서 출력</button>
						<span class="clearboth"></span>
					</div>
				</div>
				
				
				<br><br>
				
			
				<%-- 결제예정금액 테이블 --%>
				<table class="calc2">
					<tr>
						<th>총 상품금액</th>
						<th>총 배송비</th>
						<th style="width: 750px; padding: 22px 0;"><span>결제예정금액</span></th>
					</tr>
					<tr style="background-color: #fff;">
						<td style="padding: 22px 0;"><span class="price">0</span>원</td>
						<td>+<span class="price">0</span>원</td>
						<td>=<span class="price">0</span>원</td>
					</tr>
				</table>
				
				<br/><br/>
				
				<div align="center">
					<button class="btn default orderGobtn" id="allProduct">전체상품주문</button>
					<button class="btn default orderGobtn" id="productClear">선택상품주문</button>
					<button class="btn default footerbtn" id="footerbtn" onclick="javascript:location.href='<%=ctxPath %>/index.book'">쇼핑계속하기</button>
					<span class="clearboth"></span>
				</div>
			</form>
		</div>
	</div>
	<%-- <jsp:include page="cart_board.jsp" /> --%>
	<%-- <jsp:include page="<%=ctxPath %>/WEB-INF/product/cart_board.jsp" /> --%>
	<%-- <jsp:include page="../footer.jsp" /> --%>
	<%-- <jsp:include page="<%=ctxPath %>/WEB-INF/footer.jsp" /> --%>
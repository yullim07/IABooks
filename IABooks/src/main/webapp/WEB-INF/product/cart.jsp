<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<meta charset="UTF-8">
<title>in사과북스::장바구니</title>

<!-- css -->
<link rel="stylesheet" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/cart_list.css" />


<style type="text/css">

</style>

<script type="text/javascript">

	$(document).ready(function() {
		$(".calc1 thead input:checkbox[id=check]").click(function() {
			var bool = $(this).prop("checked");
			#(".calc1 tbody input:checkbox[name=checkbox]").prop("checked", bool);
		});
		
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
	}); // end of $(document).ready() --------------------
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
								<th><input type="checkbox" name="checkbox" id="check"></th>
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
						
						<tbody>
							<tr style="height: 90px; background-color: #fff;">
								<td style="text-align: left; text-align: center; border-right: none;">
									<input type="checkbox" name="checkbox" />
								</td>
								<td>
									<img src="<%=ctxPath%>/images/product/book.jpg">
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
									<button class="btn default" style="border-radius: 3px; width: 90px; margin-bottom: 3px; font-size: 11px;">주문하기</button>
									<button class="btn default" style="border-radius: 3px; width: 90px; margin-bottom: 3px; font-size: 11px;">관심상품등록</button>
									<button class="btn default" style="border-radius: 3px; width: 90px; margin-bottom: 3px; font-size: 11px;">삭제</button>
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
						<button class="btn default btnfloat" style="background-color: grey; color: #fff">삭제하기</button>
						<button class="btn default backBtn btnfloat">해외배송 장바구니로 이동</button>
						
						<button class="btn default backBtn btnfloat2">장바구니 비우기</button>
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
					<button class="btn default" id="allProduct">전체상품주문</button>
					<button class="btn default backBtn" id="">선택상품주문</button>
					<button class="btn default footerbtn" id="footerbtn">쇼핑계속하기</button>
					<span class="clearboth"></span>
				</div>
			</form>
		</div>
	</div>
	
	<jsp:include page="<%=ctxPath %>/WEB-INF/product/cart_board.jsp" />
	
	<jsp:include page="<%=ctxPath %>/WEB-INF/footer.jsp" />
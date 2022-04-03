<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<meta charset="UTF-8">
<title>장바구니 이용안내</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="<%=ctxPath %>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_header_footer.css" />

<style type="text/css">
.notosanskr * { 
	font-family: 'Noto Sans KR', sans-serif;
}

.card {
	border: solid 1px #e8e8e8;
	width: 100%;
	margin: 0 auto;
	margin-bottom: 80px;
}
.card-header, .card-title {
	font-size: 9pt;
}

li {
	font-size: 9pt;
	line-height: 12pt;
	list-style-type: decimal;
}

</style>


<div class="card">
	<div class="card-header"><strong>이용안내</strong></div>
	<div class="card-body">
		<p class="card-title">장바구니 이용안내</p>
			<ol>
				<li>해외배송 상품과 국내배송 상품은 함께 결제하실 수 없으니 장바구니 별로 따로 결제해 주시기 바랍니다.</li>
				<li>해외배송 가능 상품의 경우 국내배송 장바구니에 담았다가 해외배송 장바구니로 이동하여 결제하실 수 있습니다.</li>
				<li>선택하신 상품의 수량을 변경하시려면 수량변경 후 [변경] 버튼을 누르시면 됩니다.</li>
				<li>[쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속 하실 수 있습니다.</li>
				<li>장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.</li>
				<li>파일첨부 옵션은 동일상품을 장바구니에 추가할 경우 마지막에 업로드 한 파일로 교체됩니다.</li>
			</ol>
	</div>
	
	<div class="card-body">
		<p class="card-title">무이자할부 이용안내</p>
			<ol>
				<li>상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제 하시면 됩니다.</li>
				<li>[전체 상품 주문] 버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가 이루어집니다.</li>
				<li>단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.</li>
			</ol>
	</div>
	
</div>


</body>
</html>
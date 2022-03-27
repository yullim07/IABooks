<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 수정하기</title>

<style type="text/css">
table, th, td {
	 border: solid 1px grey;
	 border-collapse: collapse;
}
</style>

</head>
<body>

	<div id="text_area">
		<div id="pro_detail_title"></div>
		<br>
		<div id="pro_detail_purchase"></div>
		<br>
		<div id="pro_detail_total"></div>
	</div>

	<script type="text/javascript">

	const arr_product = [ 
		                 {productId : "harrypotter",
		                  productName : "해리포터와 마법사의 돌",
		                  image : "harrypotter1.jpg",
		                  price : 13000,
						  shippingfee: 3000
		                  }
		               ];
	
	// ===================================================================


	// *** 상품제목 시작 *** //
	let html_title = `<table id='tbl_detail_title'>`;
	
	arr_product.forEach(function(elt, i, array) {
	
		html_title += `<tr>
							<th>`+"${elt.productName}"+`</th>
						<tr>
					</table>`;
	});

	console.log(html_title);
	document.querySelector("div#pro_detail_title").innerHTML = html_title;
	// *** 상품제목 끝 *** //


	// ===================================================================

	
	// *** 상품 가격정보 시작 *** //
	let html_purchase = `<table id='tbl_detail_purchase'>
							<thead>`;

	arr_product.forEach(function(elt, i, array) {
		html_purchase += 		`<tr>
									<th scope="row" width="40%">판매가</th>
									<td scope="col"><span id='${elt.productId}'>${elt.price.toLocaleString('en')}</span>원</td>
								<tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row" width="30%">배송방법</th>
									<td scope="col">택배</td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<th scope="row" width="30%">배송비</th>
									<td scope="col"><span id='${elt.productId}'>${elt.shippingfee.toLocaleString('en')}</span>원&nbsp;(50,000원 이상 구매 시 무료)</td>
								</tr>
							</tfoot>
						</table>`;
	});

	document.querySelector("div#pro_detail_purchase").innerHTML = html_purchase;
	// *** 상품 가격정보 끝 *** //


	// ===================================================================


	// *** 상품 주문가격 시작 *** //
	let html_total = `<table id='tbl_pro_total'>
						<thead>
							<tr>
								<th scope="col" width="50%">상품명</th>
								<th scope="col" width="20%">상품수</th>
								<th scope="col" width="30%">가격</th>
							<tr>
						</thead>
						<tbody>`;

	arr_product.forEach(function(elt, i, array) {
			html_total += `<tr>
								<td scope="row">${elt.productName}</td>
								<td scope="row"><input type='number' min='1' max='1000' value='1' id='${elt.productId}' /></td>
	<!-- 생각해보기--!>			<td scope="row"><span id='${elt.productId}'><b>${elt.price.toLocaleString('en')}</b></span>원</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td scope="row">
									<span><b>총상품금액</b></span>&nbsp;(수량) :
								</td>
								<td scope="row"><span><b>${elt.price.toLocaleString('en')}</b></span>원</td>
								<td scope="row"><span id="odr_qty"></span>(1개)</td>
							</tr>
						</tfoot>
					</table>`;
	});

	document.querySelector("div#pro_detail_total").innerHTML = html_total;
	// *** 상품 주문가격 시작 *** //


	// ===================================================================
    

	// *** 주문수량이 바뀌면 주문금액과 수량에 값을 넣어주기 시작 *** //
	const input_number_list = document.querySelectorAll("table#tbl_pro_total input[type='number']");

	// == 주문수량 이벤트 처리하기 == //
	input_number_list.forEach(function(elt) {

		elt.addEventListener('change', () => {
			
			// 주문수량에 대한 금액 알아오기
			/*
			console.log("구매테이블에서 받아온 가격 정보"
				+ document.querySelector("table#tbl_detail_purchase span#"+elt.id).innerText); // 예: 13000
			*/
			
			let odrqty = Number(elt.value);
		//	console.log("1. 수량(Number(elt.value) " + odrqty);

			let price = Number(document.querySelector("table#tbl_detail_purchase > thead > tr > td > span").innerText.split(",").join(""));
		//	console.log("2. 가격(price) " + price);
			
			let odr_price = odrqty*price;
		//	console.log("3. 수량×가격(odr_price) " + odr_price);

		//	console.log("4. odr_price.toLocaleString('en') => " + odr_price.toLocaleString('en'));

			document.querySelector("#tbl_pro_total > tbody > tr > td:last-child").innerHTML = "<b>" + odr_price.toLocaleString('en') + "</b> 원";
			document.querySelector("#tbl_pro_total > tfoot > tr > td:nth-child(2)").innerHTML = "<b>" + odr_price.toLocaleString('en') + "</b> 원";
			document.querySelector("#tbl_pro_total > tfoot > tr > td:last-child").innerHTML = "("+ odrqty + "개)";
		
		});
	});
	// *** 주문수량이 바뀌면 주문금액에 값을 넣어주기 끝 *** //


	// ===================================================================


	// *** 주문수량이 바뀌면 주문수량에 값을 넣어주기 시작 *** //
	/*
	function odr_qty() {
		let val = 0;
		document.querySelectorAll("table#tbl_pro_total > tbody > tr > td:nth-child(3)#odr_qty").forEach(function(elt, i, array) {
			("table#tbl_pro_total > tbody > tr > td:nth-child(3)#odr_qty").forEach(function(elt, i, array) {
			});

		});

	//	document.querySelector("table#tbl_pro_total > tfoot > tr > td:nth-child(3)").innerHTML = val;
	//	document.querySelector("table#tbl_pro_total > tfoot > tr > td:last-child > span").innerHTML = sumPrice.toLocaleString('en') + "원"; 

	}
	*/
	// *** 주문수량이 바뀌면 주문수량에 값을 넣어주기 끝 *** //


	// ===================================================================


	// *** 주문총액을 구해주는 함수 만들기 시작 *** //
	/*
	function sumPrice() {
		let sumPrice = 0;
		
		document.querySelectorAll("table#tbl_pro_total > tbody > tr > td:last-child").forEach(function(elt, i, array) {
			sumPrice += Number(elt.innerText.split(",").join(""));
		});

		document.querySelector("table#tbl_pro_total > tfoot > tr > td:last-child > span").innerHTML = sumPrice.toLocaleString('en') + "원"; 
	}
	*/
	// *** 주문총액을 구해주는 함수 만들기 끝 *** //


	// *** 주문수량 keyup 이벤트 처리하기 시작 *** //
	input_number_list.forEach(function(elt, i, array){
		elt.addEventListener('keyup', ()=>{
			alert("주문수량은 마우스로만 입력하세요.");
			elt.value = 1;
		});
	});
	// *** 주문수량 keyup 이벤트 처리하기 끝 *** //

	</script>

</body>
</html>
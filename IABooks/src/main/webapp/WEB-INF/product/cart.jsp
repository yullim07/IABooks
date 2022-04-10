<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<<<<<<< HEAD
=======
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
>>>>>>> refs/remotes/origin/sub_main

<%
	String ctxPath = request.getContextPath();
%>



<meta charset="UTF-8">
<title>in사과::장바구니</title>
<jsp:include page="../header.jsp" />

<jsp:include page="../header.jsp" />

<!-- 부트스트랩 css -->
<%-- <link rel="stylesheet" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">
 --%>
<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/cart_list.css" />

<!-- Spinner -->
<<<<<<< HEAD
<%-- <script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script> --%>
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js"></script>
<%-- <script src="/resources/demos/external/jquery-mousewheel/jquery.mousewheel.js"></script> --%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<%-- <link rel="stylesheet" href="/resources/demos/style.css"> --%>

=======
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
>>>>>>> refs/remotes/origin/sub_main


<style type="text/css">
<<<<<<< HEAD
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
=======

/* 회원 */


 table.cartListTbl {
	width: 100%;
	margin-top: 30px;
	margin-bottom: 10px;
}

table.cartListTbl td {
	text-align: center;
	padding-left: 10px;
	height: 100px;
	
>>>>>>> refs/remotes/origin/sub_main
}
table.cartListTbl span {
color: #212529;
}

table.cartListTbl a:hover {
text-decoration-line: none;
}

table.cartListTbl img {
cursor: pointer;
}

table.cartListTbl > tfoot > tr:first-child td {
	height: 70px;
	background-color: #FBFAFA;
	padding-right: 10px;
}

table.cartListTbl > tfoot > tr:last-child td {
	height: 90px;
	vertical-align: top;
	padding-right: 10px;
	padding-top: 10px;
	font-size: 15px;
}

table.cartListTbl .pqty{
width: 50px;
height: 26px;
padding-left: 2px;

}

table.cartListTbl > thead > tr > td {
	height: 50px;
	background-color: #FBFAFA;
}

table.cartListTbl  tr {
	border-top: solid 2px #e8e8e8;
}

table.cartListTbl tr:last-child {
	border-bottom: solid 2px #e8e8e8;
}


table.cartTotalTbl {
width: 100%;
}

table.cartTotalTbl tr:first-child td {
	text-align: left;
	padding-left:50px;
	height: 50px;
	background-color: #FBFAFA;
}

table.cartTotalTbl tr:last-child td {
	text-align: left;
	padding-left:50px;
	height: 70px;
	font-weight: bold;
	font-size: 24px;
}

table.cartTotalTbl  tr {
	border-top: solid 2px #e8e8e8;
}

table.cartTotalTbl tr:last-child {
	border-bottom: solid 2px #e8e8e8;
}

	div.order {
	 text-align: center;
	 margin: 20px 0px 200px 0px ;
	}
	
	div.order span:last-child {
	position: relative;
	right: 10px;
	float: right;
	text-align: right;
	}
	
	div.order img {
	cursor: pointer;
	}

/* 상품없음 */
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
		font-weight: bolder;
		opacity: 0.3;
	}
	
 
</style>

<<<<<<< HEAD

<script type="text/javascript">
=======
<script type="text/javascript">
	
>>>>>>> refs/remotes/origin/sub_main
	$(document).ready(function() {
		
<<<<<<< HEAD
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
=======

		 //수량변경(변경시 partPrice, totlaPrice 값변경)
		$("img.pqty_btn").click(function() {
			const pqty_update = $(this).parent().parent().find("input.pqty").val();
			const fk_pro_num = $(this).parent().parent().find("input#fk_pro_num").val();
			const pk_cartno = $(this).parent().parent().find("input#pk_cartno").val();
			
			if(pqty_update ==0){
				alert("1개이상 구매가 가능합니다.");
				location.reload();
				return;
			}
			
			let partPrice = pqtyUpdate(pqty_update, fk_pro_num, pk_cartno);
			partPrice = partPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$(this).parent().parent().parent().find("span#partsaleprice").text(partPrice+"원");
			
			let totalPrice = $("span#totalPrice").text().replace(/\,/g,'');
			totalPrice = totalPrice.replace("원",'');
			if(Number(totalPrice) >= 50000){
			 	$("span.shippingFee").text("무료");	
			}else{
				$("span.shippingFee").text("3,000원");	
			}

		});//end of $("img.pqty_btn").click(function()
		
		$("input.pqty").bind("click", function () {
			const pqty_update = $(this).parent().parent().find("input.pqty").val();
			const fk_pro_num = $(this).parent().parent().find("input#fk_pro_num").val();
			const pk_cartno = $(this).parent().parent().find("input#pk_cartno").val();
			
			if(pqty_update ==0){
				alert("1개이상 구매가 가능합니다.");
				location.reload();
				return;
			}
			
			let partPrice = pqtyUpdate(pqty_update, fk_pro_num, pk_cartno);
			partPrice = partPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			$(this).parent().parent().parent().find("span#partsaleprice").text(partPrice+"원");
			
			let totalPrice = $("span#totalPrice").text().replace(/\,/g,'');
			totalPrice = totalPrice.replace("원",'');
			if(Number(totalPrice) >= 50000){
			 	$("span.shippingFee").text("무료");	
			}else{
				$("span.shippingFee").text("3,000원");	
			}
			
		});//end of $("input.pqty").bind("click", function ()
			
		//삭제버튼 
		$("div#btn_delete").click(function () {
			const pk_cartno = $(this).parent().parent().parent().find("input#pk_cartno").val();
			proDeleteOne(pk_cartno);
		});//end of $("li#btn_delete").click(function ()
				
		//선택상품 삭제		
		$("span#deleteSelect").click(function () {
			var cnt = $("input[name='proCheck']:checked").length;
	      	var cartNoArr = new Array();
	        $("input[name='proCheck']:checked").each(function() {
	        	cartNoArr.push($(this).val());
	        });
	        if(cnt == 0){
	            alert("선택된 제품이 없습니다.");
	        }
	        const cartNoStr = cartNoArr.join();
	        
	        proDeleteSelect(cnt, cartNoStr);
		});//end of $("li#btn_delete").click(function ()
				
		//전체체크박스설정		
		$("input#selectAll").bind("click",function () {
            if ($("input#selectAll").prop("checked")) {
                $("input#proCheck").prop("checked", true);
            } else {
                $("input#proCheck").prop("checked", false);
            }
		});//end of $("input#selectAll").click(function ()
			
        $("input#proCheck").bind("click",function() {
            if ($("input[name='proCheck']:checked").length == $("input[name='proCheck']").length) {
                $("input#selectAll").prop("checked", true);
            } else {
                $("input#selectAll").prop("checked", false);
            }
        });	//end of $(".test").click(function()
						
	});// end of $(document).ready()
 
	//수량변경함수
	function pqtyUpdate(pqty_update, fk_pro_num, pk_cartno) {
		var partPrice=0;
		
		$.ajax({
			url:"<%= ctxPath%>/product/pqtyUpdate.book",
			type:"POST",
			async: false,
			data:{"pk_cartno":pk_cartno,
				  "fk_pro_num":fk_pro_num,
				  "pqty_update":pqty_update}, 
			dataType:"JSON",
			success:function(json) {
				partPrice = json.partPrice;
				let totalPrice = json.totalPrice;
				let finalPrice = json.finalPrice;
				totalPrice = totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				finalPrice = finalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				$("span.totalPrice").text(totalPrice+"원");
				$("span.finalPrice").text(finalPrice+"원");
				
				if(json.pqty_update == 0) {
					alert("수량변경실패");
				}
			},
			error: function(request, status, error){
			//alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			
				if(request.responseText.match("로그인")){
					if(!alert(request.responseText)) document.location = "<%= ctxPath%>/login/join.book";
				}else{
					alert(request.responseText);
					location.reload();
				}
			}
		});//end of $.ajax
		return partPrice;
	}//end of function pqtyUpdate(pqty_update, fk_pro_num, pk_cartno)
	
	//삭제버튼함수
	function proDeleteOne(pk_cartno) {
		$.ajax({
			url:"<%= ctxPath%>/product/proDeleteOne.book",
			type:"POST",
			data:{"pk_cartno":pk_cartno}, 
			dataType:"JSON",
			success:function(json) {
				if(json.proDeleteOne == 1) {
					alert("삭제되었습니다.");
					location.reload();
				}else{
					alert("오류발생"); 
				}

			},
			error: function(request, status, error){
				//alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				
				if(request.responseText.match("로그인")){
					if(!alert(request.responseText)) document.location = "<%= ctxPath%>/login/join.book";
				}else{
					alert(request.responseText);
					location.reload();
				}
				
>>>>>>> refs/remotes/origin/sub_main
			}
<<<<<<< HEAD
		});
		///////////////////////////////////////////////
		
		
		
		
		
		
	}); // end of $(document).ready() --------------------
=======
		});//end of $.ajax
	}//end of function DeleteOne()
>>>>>>> refs/remotes/origin/sub_main
	
	//선택삭제버튼 함수
	function  proDeleteSelect(cnt, cartNoStr) {
		$.ajax({
			url:"<%= ctxPath%>/product/proDeleteSelect.book",
			type:"POST",
			data:{"cnt":cnt,
				  "cartNoStr":cartNoStr}, 
			dataType:"JSON",
			success:function(json) {
				if(json.proDeleteSelect == 1) {
					alert("선택한 제품이 삭제되었습니다.");
					location.reload();
				}else{
					alert("오류발생"); 
				}

			},
			error: function(request, status, error){
				//alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			
				if(request.responseText.match("로그인")){
					if(!alert(request.responseText)) document.location = "<%= ctxPath%>/login/join.book";
				}else{
					alert(request.responseText);
					location.reload();
				}
				
			}
		});//end of $.ajax
	}//end of function  proDeleteSelect(cnt, cartNoStr) 
	
	//장바구니 모두 비우기
	function  cartDeleteAll() {
		$.ajax({
			url:"<%= ctxPath%>/product/cartDeleteAll.book",
			type:"POST",
			data:{}, 
			dataType:"JSON",
			success:function(json) {
				if(json.cartDeleteAll == 1) {
					alert("장바구니 모두 비웠습니다.");
					location.reload();
				}else{
					alert("오류발생"); 
				}

			},
			error: function(request, status, error){
				//alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			
				if(request.responseText.match("로그인")){
					if(!alert(request.responseText)) document.location = "<%= ctxPath%>/login/join.book";
				}else{
					alert(request.responseText);
					location.reload();
				}
				
			}
		});//end of $.ajax
	}//end of function proDeleteAll() 
	
<<<<<<< HEAD
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
=======
	function orderSelect() {
		var cnt = $("input[name='proCheck']:checked").length;
        if(cnt == 0){
            alert("선택된 제품이 없습니다.");
            return;
        }
		const frm = document.cartFrm;
		frm.action = "<%= ctxPath%>/product/orderSelect.book";
		frm.method = "post";
		frm.submit();

	}//end of function orderSelect() 
>>>>>>> refs/remotes/origin/sub_main
	
	function orderAll() {
		const frm = document.cartFrm;
		frm.action = "<%= ctxPath%>/product/orderAll.book";
		frm.method = "post";
		frm.submit();

	}//end of function orderAll()
	
<<<<<<< HEAD
	/*
		내가 하고 싶은 거 >> 체크를 하고 그 체크된 값의 cartno를 배열에 넣은 뒤 액션단으로 보내서 자른 뒤에 
		그 cartno를 가지고 DAO에서 삭제해준다. => form 이름을 다르게 줘야한다! => 선택삭제가 있는 곳을?
	 */
=======
	function orderOne() {
		const frm = document.cartFrm;
		frm.action = "<%= ctxPath%>/product/orderOne.book";
		frm.method = "post";
		frm.submit();

	}//end of function orderOne()
>>>>>>> refs/remotes/origin/sub_main
	
<<<<<<< HEAD
	
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
=======
</script>

	
<div class="container">
>>>>>>> refs/remotes/origin/sub_main
			
<<<<<<< HEAD
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
		
		<%-- if(confirm("선택한 상품을 삭제하시겠습니까?")) {
			const frm = document.btnCartFrm;
			frm.pk_cartno.value = pk_cartno;
			frm.action = "<%= ctxPath%>/product/cartDeleteSelect.book";
			frm.method = "post";
			frm.submit();
		}
		else {
			alert("선택상품 삭제하기를 취소하셨습니다.");
		} --%>
		var url="<%= ctxPath%>/product/cartDeleteSelect.book";
		var valueArr = new Array();
		var value = $("input[name='rowCheck']");
		
		for(var i = 0; i < value.length; i++) {
			if(value[i].checked) {
				valueArr.push(value[i].value);
				console.log(value[i].value);
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
			
		}
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
=======
<br>&nbsp;<strong style="font-size: 16pt;">
<img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;관심상품</strong>
<hr style="border: solid 2px #e8e8e8;">

<div class="cartInfo">
	<form name="cartFrm">
		<table class="cartListTbl">
			<thead>
				<tr>
					<td style="width: 4%"><input type="checkbox" id="selectAll" name="selectAll" /></td>
					<td style="width: 10%">이미지</td>
					<td style="width: 30%">상품정보</td>
					<td style="width: 10%">판매가</td>
					<td style="width: 6%">수량</td>
					<td style="width: 10%">배송비</td>
					<td style="width: 10%">합계</td>
					<td style="width: 10%">선택</td>
				</tr>
			</thead>
				
			<tbody>
				<%-- 장바구니에 담긴 상품이 없는 경우 --%>
				<c:if test="${empty requestScope.cartList}">
					<tr>
						<td colspan="9">장바구니에 담긴 상품이 없습니다.</td>
					</tr>
				</c:if>
			
				<%-- 장바구니에 담긴 상품이 있는 경우 --%>
				<c:if test="${not empty requestScope.cartList}">
					<c:forEach var="cvo" items="${requestScope.cartList}" varStatus="status">
						<tr>							
							<%-- 체크박스 --%>
							<td> 
								<input type="checkbox" name="proCheck" id="proCheck" value="${cvo.pk_cartno}" />
							</td>
							
							<%-- 이미지 --%>
							<td> 
								<a href="<%=ctxPath%>/product/ShowBookDetail.up?pk_pro_num=${cvo.fk_pro_num}">
								<img src="<%=ctxPath%>/images/product/${cvo.category.cate_name}/${cvo.product.pro_imgfile_name}" style="width: 100%"/>
								</a>
							</td>
							
							<%-- 상품정보 --%>
							<td> 
								<a href="<%=ctxPath%>/product/ShowBookDetail.up?pk_pro_num=${cvo.fk_pro_num}">
									<span class="cartPname">${cvo.product.pro_name}</span>
								</a>
							</td>
							
							<%-- 판매가 --%>
							<td> 
								<span class="orderPrice"><fmt:formatNumber value="${cvo.product.pro_saleprice}" pattern="###,###" />원</span>
							</td>
							
							<%-- 주문수량 + 장바구니 번호(숨김) --%> 
 							<td>
								<div>
									<input type="number" class="pqty" id="pqty" name="pqty" value="${cvo.ck_odr_qty}" min='1' max='100' />
								</div>
								
								<div>
									<img src="<%= ctxPath %>/images/product/btn_quantity_modify.gif" class="pqty_btn" />
									<input class="pk_cartno" type="hidden" id="pk_cartno" name="pk_cartno" value="${cvo.pk_cartno}" />
									<input class="fk_pro_num" type="hidden" id="fk_pro_num" name="fk_pro_num" value="${cvo.fk_pro_num}" />
									<input class="pro_saleprice" type="hidden" id="pro_saleprice" name="pro_saleprice" value="${cvo.product.pro_saleprice}" />
								</div>
							</td>
							 					 
							<%-- 배송비(주문총액이 5만원 이상이면 무료, 아니면 3000원) --%>
							<c:if test="${status.first}">
								<td rowspan= "${fn:length(cartList)}" >
									<span class="shippingFee">
										<c:if test="${requestScope.totalPrice >= 50000}">무료</c:if>
										<c:if test="${requestScope.totalPrice < 50000}">3,000원</c:if>
									</span>
								</td>
							</c:if>
							<%-- 주문총액 --%>
							<td>
								<span id="partsaleprice"><fmt:formatNumber value="${cvo.partPrice}" pattern="###,###" />원</span>
							</td>
							
							<%-- 선택 --%>
							<td style="vertical-align: middle">
								<div id="btn_order"><img src="<%= ctxPath %>/images/product/btn_order.gif" onclick="orderOne()" /></div>
								<div id="btn_wish"><img src="<%= ctxPath %>/images/product/btn_wish.gif" /></div>
								<div id="btn_delete"><img src="<%= ctxPath %>/images/product/btn_delete.gif" /></div>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			
			</tbody>
			
			<tfoot>
				<tr>
					<td colspan="2" class="text-left">
						<span>[기본배송]</span>
					</td>

					<td colspan="6" class="text-right">
						<span>상품구매금액&nbsp;</span>
						<span class="totalPrice" id="totalPrice"><fmt:formatNumber value="${requestScope.totalPrice}" pattern="###,###" />원</span>
						<span>&nbsp;+&nbsp;배송비</span>
						<span class="shippingFee">
							<c:if test="${requestScope.totalPrice >= 50000}">무료</c:if>
							<c:if test="${requestScope.totalPrice < 50000}">3,000원</c:if>
						</span>
						<span>&nbsp;=&nbsp;합계&nbsp;:&nbsp;</span>
						<span class="finalPrice"><fmt:formatNumber value="${requestScope.finalPrice}" pattern="###,###" />원</span>
					</td>
				</tr>
				<tr style="border-bottom: none;">
					<td colspan="3" class="text-left">
						<span id="deleteSelect">
							선택상품&nbsp;&nbsp;<img src="<%= ctxPath %>/images/product/btn_delete2.gif" />
						</span>
					</td>
					<td colspan="5" class="text-right">
						<span>
							<img src="<%= ctxPath %>/images/product/btn_clear.gif" onclick="cartDeleteAll()"/>
						</span>	
					</td>
				</tr>	
			</tfoot>	
		</table>
		
		<table class="cartTotalTbl">
			<tbody>
				<tr>
					<td style="width: 30%">
					총 상품금액
					</td>
					<td style="width: 30%">
					총 배송비
					</td>
					<td style="width: 30%">
					결제예정금액
					</td>
				</tr>
				<tr>
					<td>
						<span class="totalPrice"><fmt:formatNumber value="${requestScope.totalPrice}" pattern="###,###" />원</span>
					</td>
					<td>
						<span class="shippingFee">
							<c:if test="${requestScope.totalPrice >= 50000}">무료</c:if>
							<c:if test="${requestScope.totalPrice < 50000}">3,000원</c:if>
						</span>
					</td>
					<td>
						<span class="finalPrice"><fmt:formatNumber value="${requestScope.finalPrice}" pattern="###,###" />원</span>
					</td>
				</tr>
			</tbody>
			
		</table>	
	</form>
</div>

<div class="order">
	<span>
		<img src="<%= ctxPath %>/images/product/btn_order_all.gif" onclick="orderAll()" />&nbsp;&nbsp;
		<img src="<%= ctxPath %>/images/product/btn_order_select.gif" onclick="orderSelect()" />
	</span>

	<span>
		<a href="<%= ctxPath%>/index.book">
			<img src="<%= ctxPath %>/images/product/btn_order_ing.gif" />
		</a>
	</span>
</div>
	
</div>
<jsp:include page="/WEB-INF/footer.jsp" />
>>>>>>> refs/remotes/origin/sub_main

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	//	여기 링크를 꼭 참고하세용 http://www.iamport.kr/getstarted
   var IMP = window.IMP;     // 생략가능
   IMP.init('imp51671394');  // 중요!!  아임포트에 가입시 부여받은 "가맹점 식별코드". 
	
   // 결제요청하기
   IMP.request_pay({
       pg : 'html5_inicis', // 결제방식 PG사 구분
       pay_method : 'card',	// 결제 수단
       merchant_uid : 'merchant_' + new Date().getTime(), // 가맹점에서 생성/관리하는 고유 주문번호
       name : 'in사과_책결제',	 // 코인충전 또는 order 테이블에 들어갈 주문명 혹은 주문 번호. (선택항목)원활한 결제정보 확인을 위해 입력 권장(PG사 마다 차이가 있지만) 16자 이내로 작성하기를 권장
       amount : '100',	 // '${requestScope.coinmoney}'써야하는데 테스트로 100원했다. 결제 금액 number 타입. 필수항목. 
       buyer_email :'${requestScope.email}', //'${requestScope.email}',  // 구매자 email
       buyer_name : '${requestScope.name}',	  // 구매자 이름 
       buyer_tel : '${requestScope.phone}',    // 구매자 전화번호 (필수항목)
       buyer_addr : '${requestScope.address}',  
       buyer_postcode : '${requestScope.postcode}',
       m_redirect_url : ''  // 휴대폰 사용시 결제 완료 후 action : 컨트롤러로 보내서 자체 db에 입력시킬것!
   }, function(rsp) {
       /*
		   if ( rsp.success ) {
			   var msg = '결제가 완료되었습니다.';
			   msg += '고유ID : ' + rsp.imp_uid;
			   msg += '상점 거래ID : ' + rsp.merchant_uid;
			   msg += '결제 금액 : ' + rsp.paid_amount;
			   msg += '카드 승인번호 : ' + rsp.apply_num;
		   } else {
			   var msg = '결제에 실패하였습니다.';
			   msg += '에러내용 : ' + rsp.error_msg;
		   }
		   alert(msg);
	   */

		if ( rsp.success ) { // PC 데스크탑용
		/* === 팝업창에서 부모창 함수 호출 방법 3가지 ===
		    1-1. 일반적인 방법
			opener.location.href = "javascript:부모창스크립트 함수명();";
			opener.location.href = "http://www.aaa.com";
			
			1-2. 일반적인 방법
			window.opener.부모창스크립트 함수명();

			2. jQuery를 이용한 방법
			$(opener.location).attr("href", "javascript:부모창스크립트 함수명();");
		*/
			//	opener.location.href = "javascript:goCoinUpdate('${requestScope.userid}','${requestScope.coinmoney}');";
			///window.opener.goCoinUpdate('${requestScope.userid}','${requestScope.coinmoney}');
			//  $(opener.location).attr("href", "javascript:goCoinUpdate('${requestScope.userid}','${requestScope.coinmoney}');");
			/*
					request.setAttribute("userid", userid);//아이디
					request.setAttribute("name", name);//이름
					request.setAttribute("email", email);//이메일
					request.setAttribute("phone", phone);//전화
					request.setAttribute("postcode", postcode);//우편번호
					request.setAttribute("address", address);//주소
					request.setAttribute("finalPrice", finalPrice);//주문금액
					request.setAttribute("cartno", cartno);//주문한 카트번호 들
					request.setAttribute("useCouponId", useCouponId);//사용한 쿠폰아이디
					
			*/
			
			 var frm = document.paymentEndFrm;
			 frm.action ="<%= ctxPath%>/product/paymentEnd.book";
			 frm.method="post";
			 frm.submit(); 
			
        } else {
            location.href="/IABooks/index.book";
            alert("결제에 실패하였습니다.");
       }

   }); // end of IMP.request_pay()----------------------------

}); // end of $(document).ready()-----------------------------

</script>
</head>
<form name=paymentEndFrm>
	<input type="hidden" id="userid"  name="userid" value="${requestScope.userid}" />
	<input type="hidden" id="name"  name="name" value="${requestScope.name}" />
	<input type="hidden" id="email"  name="email" value="${requestScope.email}" />
	<input type="hidden" id="phone"  name="phone" value="${requestScope.phone}" />
	<input type="hidden" id="postcode"  name="postcode" value="${requestScope.postcode}" />
	<input type="hidden" id="address"  name="address" value="${requestScope.address}" />
	<input type="hidden" id="finalPrice"  name="finalPrice" value="${requestScope.finalPrice}" />
	<input type="hidden" id="useCouponId"  name="useCouponId" value="${requestScope.useCouponId}" />
	
	<input type="hidden" id="pk_cartnoJoin"  name="pk_cartnoJoin" value="${requestScope.pk_cartnoJoin}" />
	<input type="hidden" id="fk_pro_numJoin"  name="fk_pro_numJoin" value="${requestScope.fk_pro_numJoin}" />
	<input type="hidden" id="pqtyJoin"  name="pqtyJoin" value="${requestScope.pqtyJoin}" />
	<input type="hidden" id="pointJoin"  name="pointJoin" value="${requestScope.pointJoin}" />
	<input type="hidden" id="partPriceJoin"  name="partPriceJoin" value="${requestScope.partPriceJoin}" />
	
	
</form>
<body>
</body>
</html>

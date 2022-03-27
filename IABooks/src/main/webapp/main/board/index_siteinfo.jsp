<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">

</style>

	  
<meta charset="UTF-8">
<title>인디펍 :: 독립출판 온라인 서점</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/lee_css/semi_style.css" />

<jsp:include page="/header.jsp"/>

<script type="text/javascript">
	
	$(document).ready(function(){
		
	
	});

</script>




	
<div class="container">

<div class="contents">
  <div class="title" >
  	<div class="title_icon" ><img src="<%= ctxPath%>/images/board/leejh_images/ico_heading.gif" /></div>
  	<h2 >이용안내</h2>
  	
    
  </div>
  <p class="mb-3"></p>
  
  <div class="info_list">
  	
  	<div id="member" >
  		 <ul class="menu" >
  			<li class="selected">
  				<a href="#member">회원가입 안내</a>
  			</li>
  			<li>
  				<a href="#order">주문 안내</a>
  			</li>
  			<li>
  				<a href="#payment">결제 안내</a>
  			</li>
  			<li>
  				<a href="#delivery">배송 안내</a>
  			</li>
  			<li>
  				<a href="#change">교환/반품 안내</a>
  			</li>
  			<li>
  				<a href="#refund">환불 안내</a>
  			</li>
  			<li>
  				<a href="#etc">기타 안내</a>
  			</li>
  		</ul> 
  		<div class="cont">
  			<h3 style="font-size: 15px;">회원가입 안내</h3>
  			<div>
  				[회원가입] 메뉴를 통해 이용약관, 개인정보보호정책 동의 및 일정 양식의 가입항목을 기입함으로써 회원에
				가입되며, 가입 즉시 서비스를 무료로 이용하실 수 있습니다.
				<br/>
				주문하실 때에 입력해야하는 각종 정보들을 일일이 입력하지 않으셔도 됩니다. 인디펍에서 제공하는 다양한 혜택 및 각종 이벤트에 참여하실 수 있습니다.
				
  			</div>
  		</div>
  	</div>
  	
  	<div id="order" >
  		 <ul class="menu" >
  			<li >
  				<a href="#member">회원가입 안내</a>
  			</li>
  			<li class="selected">
  				<a href="#order">주문 안내</a>
  			</li>
  			<li>
  				<a href="#payment">결제 안내</a>
  			</li>
  			<li>
  				<a href="#delivery">배송 안내</a>
  			</li>
  			<li>
  				<a href="#change">교환/반품 안내</a>
  			</li>
  			<li>
  				<a href="#refund">환불 안내</a>
  			</li>
  			<li>
  				<a href="#etc">기타 안내</a>
  			</li>
  		</ul> 
  		<div class="cont">
  			<h3 style="font-size: 15px;">주문 안내</h3>
  			<div>
  				상품주문은 다음단계로 이루어집니다.<br/>
				<br/>
				- Step1: 상품검색<br/>
				- Step2: 장바구니에 담기<br/>
				- Step3: 회원ID 로그인 또는 비회원 주문<br/>
				- Step4: 주문서 작성<br/>
				- Step5: 결제방법선택 및 결제<br/>
				- Step6: 주문 성공 화면 (주문번호)<br/>
				<br/>
				비회원 주문인경우 6단계에서 주문번호와 승인번호(카드결제시)를 꼭 메모해 두시기 바랍니다. 단, 회원인 경우 자동 저장되므로 따로 관리하실 필요가 없습니다.
  			</div>
  		</div>
  	</div>
  	
  	
  	<div id="payment" >
  		 <ul class="menu" >
  			<li>
  				<a href="#member">회원가입 안내</a>
  			</li>
  			<li>
  				<a href="#order">주문 안내</a>
  			</li>
  			<li class="selected">
  				<a href="#payment">결제 안내</a>
  			</li>
  			<li>
  				<a href="#delivery">배송 안내</a>
  			</li>
  			<li>
  				<a href="#change">교환/반품 안내</a>
  			</li>
  			<li>
  				<a href="#refund">환불 안내</a>
  			</li>
  			<li>
  				<a href="#etc">기타 안내</a>
  			</li>
  		</ul> 
  		<div class="cont">
  			<h3 style="font-size: 15px;">결제안내</h3>
  			<div>
  				고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다. 확인과정에서 도난 카드의 사용이나 타인 명의의 주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다.<br/>  
				<br/>
				무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다.  
				주문시 입력한 입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며 입금되지 않은 주문은 자동취소 됩니다.
  			</div>
  		</div>
  	</div>
  	
  	
  	<div id="delivery" >
  		 <ul class="menu" >
  			<li>
  				<a href="#member">회원가입 안내</a>
  			</li>
  			<li>
  				<a href="#order">주문 안내</a>
  			</li>
  			<li>
  				<a href="#payment">결제 안내</a>
  			</li>
  			<li class="selected">
  				<a href="#delivery">배송 안내</a>
  			</li>
  			<li>
  				<a href="#change">교환/반품 안내</a>
  			</li>
  			<li>
  				<a href="#refund">환불 안내</a>
  			</li>
  			<li>
  				<a href="#etc">기타 안내</a>
  			</li>
  		</ul> 
  		<div class="cont">
  			<h3 style="font-size: 15px;">배송 안내</h3>
  			<div>
  				배송 방법 : 택배<br/>
				배송 지역 : 전국지역<br/>
				배송 비용 : 조건부 무료 : 주문 금액 50,000원 미만일 때 배송비 3,000원을 추가합니다.<br/>
				배송 기간 : 3일 ~ 5일<br/>
				배송 안내 :<br/>
				- 고객님께서 주문하신 상품은 입금 확인후 배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.
  			</div>
  		</div>
  	</div>
  	
  	
  	<div id="change" >
  		 <ul class="menu" >
  			<li>
  				<a href="#member">회원가입 안내</a>
  			</li>
  			<li>
  				<a href="#order">주문 안내</a>
  			</li>
  			<li>
  				<a href="#payment">결제 안내</a>
  			</li>
  			<li>
  				<a href="#delivery">배송 안내</a>
  			</li>
  			<li class="selected">
  				<a href="#change">교환/반품 안내</a>
  			</li>
  			<li>
  				<a href="#refund">환불 안내</a>
  			</li>
  			<li>
  				<a href="#etc">기타 안내</a>
  			</li>
  		</ul> 
  		<div class="cont">
  			<h3 style="font-size: 15px;">교환/반품안내</h3>
  			<div>
  				<b>교환 및 반품이 가능한 경우</b><br/>
				- 상품을 공급 받으신 날로부터 7일이내<br/>
				  &nbsp;(반품/교환 비용 고객의 단순변심 및 착오구매일 경우 상품 반송비용은 고객 부담입니다.)<br/>
				- 공급받으신 상품 및 용역의 내용이 표시.광고 내용과<br/>
				  &nbsp;다르거나 다르게 이행된 경우에는 공급받은 날로부터 3월이내, 그사실을 알게 된 날로부터 30일이내<br/>
				<br/>
				<b>교환 및 반품이 불가능한 경우</b><br/>
				- 고객님의 책임 있는 사유로 상품등이 멸실 또는 훼손된 경우. 단, 상품의 내용을 확인하기 위하여<br/>
				  &nbsp;포장 등을 훼손한 경우는 제외<br/>
				- 포장을 개봉하였거나 포장이 훼손되어 상품가치가 상실된 경우<br/>
				- 고객님의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우<br/>
				- 시간의 경과에 의하여 재판매가 곤란할 정도로 상품등의 가치가 현저히 감소한 경우<br/>
				- 복제가 가능한 상품등의 포장을 훼손한 경우<br/>
				  &nbsp;(자세한 내용은 1:1문의, 고객센터(0507-1304-8004)상담을 이용해 주시기 바랍니다.)
  			</div>
  		</div>
  	</div>
  	
  	<div id="refund" >
  		 <ul class="menu" >
  			<li>
  				<a href="#member">회원가입 안내</a>
  			</li>
  			<li>
  				<a href="#order">주문 안내</a>
  			</li>
  			<li>
  				<a href="#payment">결제 안내</a>
  			</li>
  			<li>
  				<a href="#delivery">배송 안내</a>
  			</li>
  			<li>
  				<a href="#change">교환/반품 안내</a>
  			</li>
  			<li class="selected">
  				<a href="#refund">환불 안내</a>
  			</li>
  			<li>
  				<a href="#etc">기타 안내</a>
  			</li>
  		</ul> 
  		<div class="cont">
  			<h3 style="font-size: 15px;">환불안내</h3>
  			<div>
  				환불시 반품 확인여부를 확인한 후 3영업일 이내에 결제 금액을 환불해 드립니다.
				신용카드로 결제하신 경우는 신용카드 승인을 취소하여 결제 대금이 청구되지 않게 합니다.
				(단, 신용카드 결제일자에 맞추어 대금이 청구 될수 있으면 이경우 익월 신용카드 대금청구시 카드사에서 환급처리
				됩니다.)
  			</div>
  		</div>
  	</div>
  	
  	
  	<div id="etc" >
  		 <ul class="menu" >
  			<li>
  				<a href="#member">회원가입 안내</a>
  			</li>
  			<li>
  				<a href="#order">주문 안내</a>
  			</li>
  			<li>
  				<a href="#payment">결제 안내</a>
  			</li>
  			<li>
  				<a href="#delivery">배송 안내</a>
  			</li>
  			<li>
  				<a href="#change">교환/반품 안내</a>
  			</li>
  			<li>
  				<a href="#refund">환불 안내</a>
  			</li>
  			<li class="selected">
  				<a href="#etc">기타 안내</a>
  			</li>
  		</ul> 
  		<div class="cont">
  			<h3 style="font-size: 15px;">기타안내</h3>
  			<div>
  				<b>이용기간</b><br/>
				주문으로 발생한 적립금은 배송완료 체크시점으로 부터 20일이 지나야 실제 사용 가능 적립금으로 변환됩니다. 20일 동안은 미가용 적립금으로 분류 됩니다. 미가용 적립금은 반품, 구매취소 등을 대비한 실질적인 구입이 되지 않은 주문의 적립금 입니다.<br/>
				사용가능한 적립금(총 적립금-사용된적립금-미가용적립금)은 상품구매시 즉시 사용하실 수 있습니다.<br/>
				<br/>
				<b>이용조건</b><br/>
				적립금사용시 최소구매가능적립금(구매가능한 적립금 요구선)은 0원 입니다. 적립금 사용시 최대구매가능적립금(적립금 1회 사용 가능 최대금액)은 '한도제한없음' 입니다.<br/>
				<br/>
				<b>소멸조건</b><br/>
				주문취소/환불시에 상품구매로 적립된 적립금은 함께 취소됩니다. 회원 탈퇴시에는 적립금은 자동적으로 소멸됩니다. 최종 적립금 발생일로부터 3년 동안 추가적립금 누적이 없을 경우에도 적립금은 소멸됩니다.
  			</div>
  		</div>
  	</div>
  	
  	
  	
  </div>
		
  
</div>
</div>


	
<jsp:include page="/footer.jsp"/>
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
%>
<!doctype html>
<html lang="ko">
  <head>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<!-- datepicker 삽입을 위한 link -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css" > 
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js"></script>



<script type="text/javascript">
	
	$(document).ready(function(){
		
	});

</script>


    <title>table</title>
    
<style type="text/css">

	a:link { color: black; text-decoration: none;}
 	a:visited { color: black; text-decoration: none;}
 	a:hover { color: black; text-decoration: underline;}

	html, body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, code, form, fieldset, legend, input, textarea, p, blockquote, th, td, img {
	    list-style: none;
	    margin: 0;
	    padding: 0;
	}

	h1 {
		margin : 20px 0 ;
	}
	
	div#contents {
		width: 80%;
		margin : 0 auto;
	}
	
	div#faqTitle {
	    background: #f4f4f4;
    	border-bottom: solid 1px #ddd;
    	height: 60px;
    	padding: 10px 0;
	}
	
	div#faqmore {
		display: block;
    	padding: 10px 0;
	}

	h3 {
		display: inline;
		padding-left: 10px;
	    height: 35px;
	}
	
	a.more {
		float : right;
		padding-right: 10px;
	}
		
	div.faq {
		border : solid 1px #111;
	}

	.cs_btn {
		display: block;
		clear: both;
		width: 100%;
		margin: 0 0 10px;
		text-align: center;
	}
	
	.cs_btn ul {
	    font-size: 0;
	    line-height: 0;
	    letter-spacing: -4px;
	}
	
	.cs_btn li {
	    display: inline-block;
	    width: 20%;
	    margin: 0 0 10px 0;
	    letter-spacing: 0.1em;
	}
	
	.cs_btn li a {
	    display: block;
	    width: 95%;
	    height: 40px;
	    line-height: 40px;
	    margin: 0 auto;
	    background: #333;
	    border: solid 1px #111;
	    font-size: 13px;
	    text-align: center;
	    color: #fff;
	    letter-spacing: 0.1em;
		border-radius: 5px;
	}
	
	#btnmore {
		display: block;
    	margin: auto;
	}
	
	.p {
		padding-left: 30px; 
	}

</style>
    
</head>
<body>
	<div id="contents" style="align:center;">
	
	
	<h1>고객센터</h1>
		<div class="cs_btn">
			<ul>
				<li>
					<a href="">회원</a>
				</li>
				<li>
					<a href="">상품</a>
				</li>
				<li>
					<a href="">주문/배송</a>
				</li>
				<li>
					<a href="">반품/교환</a>
				</li>
				<li>
					<a href="">제휴</a>
				</li>
			</ul>
		</div>
		
		<div class="faq">
			<div id="faqTitle">
			<h3>FAQ</h3><a href="" class="more"><img src="" alt="more" /></a>
			</div>
			<div class="accordion" id="accordionFaq">
				   <div class="card">
				      <div class="card-header" id="headingOne">
				        <h2 class="mb-0">
				          <button class="btn" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
				            <span>[ 상품 ]</span> 독립출판물이란 무엇인가요?
				          </button>
				        </h2>
				      </div>
				
				      <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionFaq">
				         <!-- .collapse show 는 맨 처음에는  내용물을 보여주도록 하는 것임. -->
				         <div class="card-body">
					           <p>
					      	   		<b>독립출판물</b>이란 상업성을 떠나 창의적이고 실험적인 내용을 주제로 작가 개인이 기획하고 완성하는 저작물을 말합니다.
					           </p>
					           <p>
					           		<b>인디펍</b>에서는 시중 서점에서 쉽게 접할 수 없는 독립출판물을 소개합니다.
					           </p>
				         </div>
				      </div>
				   </div>
				   
				   <div class="card">
				      <div class="card-header" id="headingTwo">
				        <h2 class="mb-0">
				          <button class="btn" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
				            <span>[ 반품/교환 ]</span> 반품은 어떻게 하나요?
				          </button>
				        </h2>
				      </div>
				      
				      <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionFaq">
				         <div class="card-body">
				            <p><b>단순 변심</b>에 의한 반품은 배송완료 후 7일 이내에 가능합니다.</p>
							<p><b>오배송/상품 하자</b>에 의한 반품은 <b>30일 이내</b>에만 접수가능합니다.</p>
							<p>인디펍 지정 택배(CJ대한통운)로 회수 신청 시 택배 반송료 3,000원이 환불 금액에서 차감 후 환불 처리가 되며,</p>
							<p>전체 반품 또는 실 구매한 상품이 무료 배송 대상이 아닐 경우 초도 배송비 3,000원이 추가 차감됩니다.</p>
							<p>(오배송/상품 하자에 의한 반품 배송비는 무료입니다.)</p>
							<p><span style="color: red;">※택배 접수 시 '반품예약'으로 접수하셔야 하며 '일반예약', '타택배사' 접수 시 택배비가 추가 차감됩니다.</span></p>
							<p>상품은 훼손되지 않도록 포장 부탁드리며, 주문자 성함과 연락처를 메모지에 적어서 동봉 부탁드립니다.</p>
							<p><b>1. 반품접수</b></p>
							<p>마이페이지 - 주문조회 - 반품신청</p>
							<p><b>2. 택배접수</b></p>
							<p>CJ대한통운 반품예약 (TEL: 1588-1255)</p>
							<p><b>3. 반품주소</b></p>
							<p>(61180) 광주광역시 북구 용주로40번길 7 인디펍 물류센터 (용봉동)</p>
				         </div>
				      </div>
				   </div>
				  
				   <div class="card">
				      <div class="card-header" id="headingThree">
				        <h2 class="mb-0">
				          <button class="btn" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
				            <span>[ 주문/배송 ]</span> 주문한 상품은 언제 받을 수 있나요?
				          </button>
				        </h2>
				      </div>
				      
				      <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionFaq">
				         <div class="card-body">
				         		<p>오후 3시 결제건까지 당일 발송되며, 발송 후 평균 3~5일 이내에 배송됩니다. (주말/공휴일은 해당기간에서 제외)</p>
								<p><br/></p>
								<p>이용 택배사 : CJ대한통운</p>
								<p><br/></p>
								<p>*택배사 사정이나 기상 악화, 배송 구역 사정에 따라 배송일이 다소 변경될 수 있습니다.</p>
								<p>발송지연이 발생할 경우 별도로 안내를 드립니다.</p>
				         </div>
				      </div>
				   </div>
				   
				   <div class="card">
				      <div class="card-header" id="headingFour">
				        <h2 class="mb-0">
				          <button class="btn" type="button" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
				            <span>[ 주문/배송 ]</span>현금영수증 발행신청은 어디서 하나요?
				          </button>
				        </h2>
				      </div>
				      
				      <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordionFaq">
				         <div class="card-body">
				         		<p>홈페이지 오른쪽 상단 마이페이지>주문조회>를 클릭해주세요.</p>
								<p>해당 상품에 대한 주문번호를 클릭하면, 현금영수증 신청을 하실 수 있습니다.</p>
								<p>신청여부와 관계없이 주문 시 입력하신 번호로 배송 완료 후 발행하여 국세청으로 전송하고 있습니다.</p>
								<p>주문 시 입력하신 번호와 발행되어야 하는 번호가 다를 경우 1:1문의 바랍니다.</p>
				         </div>
				      </div>
				   </div>
				   
				   <div class="card">
				      <div class="card-header" id="headingFive">
				        <h2 class="mb-0">
				          <button class="btn" type="button" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
				            <span>[ 주문/배송 ]</span>배송비는 얼마인가요?
				          </button>
				        </h2>
				      </div>
				      
				      <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#accordionFaq">
				         <div class="card-body">
				         		<p>50,000원 미만 구매 시 배송비 3,000원입니다.</p>
								<p>50,000원 이상 구매 시 무료 배송입니다.</p>
								<p><br/></p>
								<p>도서/산간지역(제주 포함) 추가 배송비 3,000원입니다.</p>
				         </div>
				      </div>
				   </div>
				   
				   <div class="card">
				      <div class="card-header" id="headingSix">
				        <h2 class="mb-0">
				          <button class="btn" type="button" data-toggle="collapse" data-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
				            <span>[ 주문/배송 ]</span>비회원 주문조회는 어떻게 하나요?
				          </button>
				        </h2>
				      </div>
				      
				      <div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-parent="#accordionFaq">
				         <div class="card-body">
				         		<p>결제완료 후 나오는 주문번호로 주문조회가 가능합니다.</p>
								<p>PC로 사이트에 접속하신 후 오른쪽 상단 마이페이지>주문조회로 들어가셔서 로그인 창 하단에 있는 비회원 주문조회를 하시면 됩니다.</p>
								<p>주문하셨을 때 입력하셨던 이름, 주문번호, 비밀번호가 필요합니다.</p>

				         </div>
				      </div>
				   </div>
				   
				   <div class="card">
				      <div class="card-header" id="headingSeven">
				        <h2 class="mb-0">
				          <button class="btn" type="button" data-toggle="collapse" data-target="#collapseSeven" aria-expanded="false" aria-controls="collapseSeven">
				            <span>[ 주문/배송 ]</span>해외 배송이 가능한가요?
				          </button>
				        </h2>
				      </div>
				      
				      <div id="collapseSeven" class="collapse" aria-labelledby="headingSeven" data-parent="#accordionFaq">
				         <div class="card-body">
				         		<p>해외 배송은 불가능합니다.</p>
				         </div>
				      </div>
				   </div>
				   
				   <div class="card">
				      <div class="card-header" id="headingEight">
				        <h2 class="mb-0">
				          <button class="btn" type="button" data-toggle="collapse" data-target="#collapseEight" aria-expanded="false" aria-controls="collapseEight">
				            <span>[ 반품/교환 ]</span>교환은 어떻게 하나요?
				          </button>
				        </h2>
				      </div>
				      
				      <div id="collapseEight" class="collapse" aria-labelledby="headingEight" data-parent="#accordionFaq">
				         <div class="card-body">
				         		<p>단순 변심, 오배송/상품 하자의 빠른 교환 처리를 위하여 교환 대신 반품 후 재주문 정책을 시행하고 있습니다.</p>
								<p>반품 후 재주문 부탁드립니다.</p>
								<p><br/></p>
								<p><a href=""target>관련: 반품은 어떻게 하나요?</a></p>
				         </div>
				      </div>
				   </div>
				   
				   <div class="card">
				      <div class="card-header" id="headingNine">
				        <h2 class="mb-0">
				          <button class="btn" type="button" data-toggle="collapse" data-target="#collapseNine" aria-expanded="false" aria-controls="collapseNine">
				            <span>[ 상품 ]</span>품절된 도서입니다. 재입고는 언제 되나요?
				          </button>
				        </h2>
				      </div>
				      
				      <div id="collapseNine" class="collapse" aria-labelledby="headingNine" data-parent="#accordionFaq">
				         <div class="card-body">
				         		<p></p>
				         		<p>일반적으로 재입고 가능한 도서의 경우 7일 정도 시간이 소요됩니다.</p>
								<p>아래의 방법으로 재입고 가능 여부를 확인하실 수 있습니다.</p>
								<p>상품 문의 남기기</p>
								<p>이메일 문의 <a href="mailto:CS@indiepub.kr">CS@indiepub.kr</a> </p>
								<p>카카오톡 채널 문의</p>
								<p></br></p>
								<p>[절판] 아이콘이 표시된 도서는 절판이 확인된 도서로 재입고가 어려운 점 참고 바랍니다.</p>
				         </div>
				      </div>
				   </div>
				   
				   
			</div>
			
			<div id="faqmore">
				<button type="button" class="btn btn-secondary" id="btnmore">
					<a href="/board/free/list.html?board_no=3">자주 묻는 질문 더보기></a>
				</button>
			</div>
		</div>
		
	</div>
		
	<!-- Optional JavaScript -->
    <script src="../js/jquery-3.6.0.min.js" type="text/javascript"></script>
    <script src="../js/bootstrap.bundle.min.js" type="text/javascript"></script>


</body>
</html>
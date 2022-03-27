<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();

	/* const arr_product = [ 
	                 {productId : "harrypotter",
	                  productName : "해리포터와 마법사의 돌",
	                  image : "harrypotter1.jpg",
	                  price : 13000,
					  shippingfee: 3000
	                  }
	               ]; */
%>


<meta charset="UTF-8">
<title>도서 상세보기 페이지</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product_style.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jaehee_pages/semicss/semi_style.css" />


	<title>제품 상세 보기 페이지</title>
	<jsp:include page="header.jsp" />

	<!-- 컨테이너 시작 -->
	<div class="container detail_container">
		
		<!-- 상세보기 상단 컨텐츠(detail_top) 시작 -->
		<div class="detail_top row">
			
			<!-- 상세보기 상단 그림영역(detail_top_img) 시작 -->
			<div class="detail_top_img col-lg-6">
			
				<!-- 상세보기 메인이미지(detail_img_display) 시작 -->
				<div class="detail_img_display">
					<a href="" onClick="window.open('pop_images.jsp', '미리보기', 'width=500, height=800, toolbar=no, location=no, status=yes, scrollbars=yes, resizeable=no, left=200, top=200')">
						<img class="big" src="<%=ctxPath%>/images/book.jpg">
					</a>
				</div>
				<!-- 상세보기 메인이미지(detail_img_display) 끝 -->

				<!-- 상세보기 썸네일이미지(detail_img_thumbnail) 시작 -->
				<div class="detail_img_thumbnails">
					<img class="small" src="<%=ctxPath%>/images/book.jpg">
					<img class="small" src="<%=ctxPath%>/images/book2.jpg">
					<img class="small" src="<%=ctxPath%>/images/book3.jpg">
					<img class="small" src="<%=ctxPath%>/images/book3.jpg">
					<img class="small" src="<%=ctxPath%>/images/book3.jpg">
					<img class="small" src="<%=ctxPath%>/images/book3.jpg">
				</div>
				<!-- 상세보기 썸네일이미지(detail_img_thumbnail) 끝 -->
			</div>
			<!-- 상세보기 상단 그림영역(detail_top_img) 시작 -->
			
			
			<!-- 상세보기 상단 글영역(detail_top_text) 시작 -->
			<div id="detail_top_text" class="col-lg-6" style="float: none; margin: 0 auto; max-width: 40%;">
				
				<!-- 상품보기 제품제목(detail_text_title) 시작 -->
				<div id="detail_text_title">
					<table id='tbl_detail_title'>
						<tr>
							<th>${elt.productName}</th>
						<tr>
					</table>				
				</div>
				<!-- 상품보기 제품제목(detail_text_title) 끝 -->
				
				<br>
				
				<!-- 상품보기 제품가격(detail_text_purchase) 시작 -->
				<div id="detail_text_purchase">
					<table id='tbl_detail_purchase'>
						<thead>
							<tr>
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
					</table>
				</div>
				<!-- 상품보기 제품가격(detail_text_purchase) 끝 -->
				
				<br>
				
				<!-- 상품보기 총주문액(detail_text_total) 시작 -->
				<div id="detail_text_total">
					<table id='tbl_pro_total'>
						<thead>
							<tr>
								<th scope="col" width="50%">상품명</th>
								<th scope="col" width="20%">상품수</th>
								<th scope="col" width="30%">가격</th>
							<tr></tr>
						</thead>
						<tbody>
							<tr>
								<td scope="row">${elt.productName}</td>
								<td scope="row"><input type='number' min='1' max='1000' value='1' id='${elt.productId}' /></td>
								<td scope="row"><span id='${elt.productId}'><b>${elt.price.toLocaleString('en')}</b></span>원</td>
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
					</table>
				</div>
				<!-- 상품보기 총주문액(detail_text_total) 끝 -->
				
				<br>
								
				<!-- 상품보기 구매버튼(detail_text_button) 시작 -->
				<div id="detail_text_button" class="row" style="margin: 20px 0 20px 0;">
					<button type="button" id="btn_buy" style="width: 120px; height: 40px; margin-right: 10px;">구매하기</button>
					<button type="button" id="btn_cart" style="width: 120px; height: 40px; margin-right: 10px;">장바구니</button>
					<button type="button" id="btn_like" style="width: 120px; height: 40px;">관심상품</button>
				</div>
				<div id="btn_book_kakao" class="row">	
					<button type="button" id="btn_kakao" style="width: 400px; heigth: 600px; background-color: #FEE500">
						<span style="color: #000"><strong>카카오톡으로 공유하기</strong></span>
					</button>
				</div>
				<!-- 상품보기 구매버튼(detail_text_button) 끝 -->
				
			</div>
			<!-- 상세보기 상단 글영역(detail_top_text) 끝 -->
		</div>
		<!-- 상세보기 상단 컨텐츠(detail_top) 끝 -->
		
		
		
		<!-- 상세보기 하단 컨텐츠(detail_bottom) 시작 -->
		<div class="detail_bottom">
			
			<!-- 버튼그룹 시작 -->
			<div class="tab_btngroup">
				<button type="button" class="btn_active" id="btn_detail" onclick="location.href='#btn_detail'">상품상세안내</button>
				<button type="button" onclick="location.href='#btn_purchase'">상품구매안내</button>
				<button type="button" onclick="location.href='#btn_related'">관련상품</button>
				<button type="button" onclick="location.href='#btn_review'">상품후기&nbsp;&nbsp;<span class="badge badge-dark">0</span></button>
				<button type="button" onclick="location.href='#btn_qna'">상품문의&nbsp;<span class="badge badge-dark">0</span></button>
			</div>
			<!-- 버튼그룹 끝 -->
			
			<!-- 상품상세안내(detail_bottom_info) 시작 -->
			<div class="detail_bottom_info">
				<br>
				<p><span class="majorheading">품목정보</span></p>
				<p class="subheading">
					책제목 : <span><b>책제목</b></span><br>
					저자 : <span><b>저자</b></span><br>
					출간일 : <span><b>출간일</b></span><br>
					분야 : <span><b>인문/사회/과학</b></span><br>
					제본 : <span><b>제본방식선택</b></span><br>
					쪽수 : <span><b>쪽수p</b></span><br>
					크기 : <span><b>가로 × 세로 (mm)</b></span><br>
					ISBN : <span><b>ISBN</b></span><br>
					정가 : <span><b>정가</b></span><br>
				</p>
				
				<br><br>
				
				<p><span class="majorheading">책소개</span></p>
				<p class="subheading">
				어느 날, 내가 어머니의 꿈을 궁금해 했던 적이 없다는 사실을 깨달았다. 그날부터 나는 평소라면 궁금해 하지 않았을 다른 사람들의 꿈에 관심을 가지게 되었다.
				분명 눈에는 보이지만 보통 궁금해 하지 않는, 도시의 배경 같은 사람들. 하지만 그들도 분명 소중한 것을 품고 있고 이를 놓치지 않으려 노력하고 있다.
				그들의 꿈과 삶에 대한 다양한 이야기를 책으로 남기고 싶었고, 그렇게 이 책을 만들게 되었다.
				<br><br>
				때때로 도시에서 살아간다는 것은 지켜왔던 소중한 것을 조금씩 내려놓는 일이기도 하다. 도시는 그렇게 우리에게 타협하기를 재촉한다.
				점점 자신의 감정에 솔직할 수 없고, 마음속의 여유 공간을 빼앗긴다. 우리는 이 책에서 그 여유 공간을 '환상의 마을'이라고 비유했다.
				환상의 마을은 인생의 어느 때, 그곳만큼은 그 누구에게도 내어주지 않겠다고 약속했던 꿈의 장소이다.
				<br><br>
				책은 어느 환상의 마을에 살고 있는 귤 왕의 고민에서 출발한다. 귤 왕은 인간들이 약속을 어기고 마을로 침략해올까 걱정이 가득하다.
				도시가 그 크기와 높이를 불려 나가는 것을 지켜봐온 탓이다.
				도시의 일상과 생존에 압도된 끝에 꿈을 완전히 잊게 될까봐 걱정하는 우리의 모습과도 비슷하다.
				<br><br>
				귤 왕의 명을 받은 귤 원정대가 도시로 탐험을 떠난다. 사람들에게 말을 걸어보지만 그들은 귤 원정대의 목소리를 듣지 못한다.
				그러다가 다행히도, 대화할 수 있는 사람들을 몇몇 만난다. 그들은 곧 나의 어머니 같은, 도시의 배경과도 같은 사람들이다.
				귤 원정대는 아주 어린 꼬마에서부터 나이든 할머니에게까지, 지하철 청소 직원과 부동산 사장님을 넘어 환경부 장관에게까지 질문을 던진다.
				'우리 환상의 마을' 을 침략할 것이냐고, 당신의 소중한 것은 어떻게 되어가고 있냐고.
				사람들과 귤 원정대는 자신이 처한 현실과 숨겨온 꿈, 그 사이의 감정에 대해 함께 이야기를 나누게 된다.
				<br><br>
				다시 처음으로 돌아가, 이 책을 읽는 모든 분들이 사랑하는 사람의 꿈을 함께 고민해주길 바라면서, 이 책을 전한다.				
				</p>
				
				<br><br>
				
				<p><span class="majorheading">저자소개</span></p>
				<p class="subheading">
				- 김우상
				프로그램 개발자로 일하지만 글 쓰는 것을 좋아하는 사람.<br>
				사람들의 꿈과 감정에 대한 소설을 계속해서 집필하고 싶은 사람.<br>
				- 최새미<br>
				미술하는 사람. 도시와 결핍에 관심이 많은 사람.<br>
				미술작가 박선호의 『하드카피 리스트: 자연, 산업, 기억과 이미지 도큐먼트 북』, 작품 리뷰 필자로 참여<br>
				미술작가 임창곤의 『불거지는 풍경』, 전시 리뷰 필자로 참여<br>
				Instagram: woosang_kim_j, maemisool<br>
				</p>
				
				<br><br>
				
				<p><span class="majorheading">목차</span></p>
				<p class="subheading">
					『우리의 소중한 마을』<br>
					『도시 원정』<br>
					『심장에 사는 벌레』<br>
					『지하철 모험 1』<br>
					『젊은이』<br>
					『지하철 모험 2』<br>
					『욕심쟁이 리어카 할머니』<br>
					『노인정』<br>
					『광화문 도착!』<br>
					『별명 부자』<br>
					『환상의 마을』<br>
				</p>
				
				<br><br>
				
				<p><span class="majorheading">책 속으로</span></p>
				<p class="subheading">
				"오늘 친구들한테 저희 엄마가 저에게 했던 말이랑 행동들을 이야기 했더니 '다 너를 위해서 사랑해서 그러시는 거겠지' 라는 말을 들었어요.
				제 친구들이니까 그 말은 진심일거에요. 저는 친구들을 좋아하거든요!
				그리고 저는 이상한 사람이 아닌걸요... 하지만 저는 엄마의 사랑을 느끼지 못하고 있어요.
				예전에 학교 보건 선생님한테 들은 이야기인데 구충제를 잘 먹어야 한대요!!
				배속에 벌레가 살고 있으면 밥을 먹어도 먹어도 영양분을 빼앗겨서 배가 고프기도 하고 배탈도 난다고 했어요!
				분명 제 심장에도 벌레가 살고 있어서 엄마가 주는 사랑을 갉아먹고 있는 걸 꺼에요!
				저는 이상한 사람이 아닌걸요. 심장에 벌레가 살 때는 어떤 약을 먹어야 할까요?"
				<br><br>
				'심장에 사는 벌레' 중에서
				</p>
			</div>
			<!-- 상품상세안내(detail_bottom_info) 끝 -->
			
			<br><br>
			
			<!-- 버튼그룹 시작 -->
			<div class="tab_btngroup">
				<button type="button" onclick="location.href='#btn_detail'">상품상세안내</button>
				<button type="button" class="btn_active" id="btn_purchase" onclick="location.href='#btn_purchase'">상품구매안내</button>
				<button type="button" onclick="location.href='#btn_related'">관련상품</button>
				<button type="button" onclick="location.href='#btn_review'">상품후기&nbsp;<span class="badge badge-dark">0</span></button>
				<button type="button" onclick="location.href='#btn_qna'">상품문의&nbsp;<span class="badge badge-dark">0</span></button>
			</div>
			<!-- 버튼그룹 끝 -->
			<!-- 상품구매안내(detail_bottom_purchase) 시작 -->
			<div class="detail_bottom_purchase">
				<br>
				<p><span class="majorheading2">상품결제정보</span></p>
				<hr>
				<p class="subheading">
				고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다.
				확인과정에서 도난 카드의 사용이나 타인 명의의 주문 등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다.<br>
				무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다.<br>
				주문시 입력한 입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며 입금되지 않은 주문은 자동취소 됩니다.<br>
				</p>
				
				<br>
				<p><span class="majorheading2">배송정보</span></p>
				<hr>
				<p class="subheading">
				배송 방법 : 택배<br>
				배송 지역 : 전국지역<br>
				배송 비용 : 3,000원<br>
				배송 기간 : 3일 ~ 5일<br>
				배송 안내 : - 고객님께서 주문하신 상품은 입금 확인후 배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.<br>
				</p>
				
				<br>
				<p><span class="majorheading2">교환 및 반품정보</span></p>
				<hr>
				
				<p class="subheading">
					<b>교환 및 환불이 가능한 경우</b>
					<br>- 상품을 공급 받으신 날로부터 7일 이내 (반품/교환 비용 고객의 단순변심 및 착오구매일 경우 상품 반송비용은 고객 부담입니다.)
					<br>- 공급받으신 상품 및 용역의 내용이 표시, 광고 내용과 다르거나 다르게 이행된 경우에는 공급받은 날로부터 3개월 이내, 그 사실을 알게 된 날로부터 30일 이내
				</p>
				
				<p class="subheading">
					<b>교환 및 반품이 불가능한 경우</b>
					<br>- 고객님의 책임 있는 사유로 상품등이 멸실 또는 훼손된 경우. 단, 상품의 내용을 확인하기 위하여 포장 등을 훼손한 경우는 제외
					<br>- 포장을 개봉하였거나 포장이 훼손되어 상품가치가 상실된 경우
					<br>- 고객님의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우
					<br>- 시간의 경과에 의하여 재판매가 곤란할 정도로 상품등의 가치가 현저히 감소한 경우
					<br>- 복제가 가능한 상품등의 포장을 훼손한 경우
					<br>- 자세한 내용은 1:1문의, 고객센터(0507-1304-8004)상담을 이용해 주시기 바랍니다.
				</p>
			</div>
			<!-- 상품구매안내(detail_bottom_purchase) 끝 -->
			
			<br><br>
			
			<!-- 버튼그룹 시작 -->
			<div class="tab_btngroup">
				<button type="button" onclick="location.href='#btn_detail'">상품상세안내</button>
				<button type="button" onclick="location.href='#btn_purchase'">상품구매안내</button>
				<button type="button" class="btn_active" id="btn_related" onclick="location.href='#btn_related'">관련상품</button>
				<button type="button" onclick="location.href='#btn_review'">상품후기&nbsp;<span class="badge badge-dark">0</span></button>
				<button type="button" onclick="location.href='#btn_qna'">상품문의&nbsp;<span class="badge badge-dark">0</span></button>
			</div>
			<!-- 버튼그룹 끝 -->
			<!-- 관련상품(detail_bottom_related) 시작 -->
			<div class="detail_bottom_related">
				<br>
				<div class="detail_related_contents">
					관련 상품이 없습니다.<br>
				</div>
				<br>
			</div>
			<!-- 관련상품(detail_bottom_related) 끝 -->
		</div>
		<!-- 상세보기 하단 컨텐츠(detail_bottom) 끝 -->
		
		<br><br>
		
		<!-- 상세보기 게시판 영역(detail_board) 시작 -->
		<div class="detail_board">
		
			<!-- 버튼그룹 시작 -->
			<div class="tab_btngroup">
				<button type="button" onclick="location.href='#btn_detail'">상품상세안내</button>
				<button type="button" onclick="location.href='#btn_purchase'">상품구매안내</button>
				<button type="button" onclick="location.href='#btn_related'">관련상품</button>
				<button type="button" class="btn_active" id="btn_review" onclick="location.href='#btn_review'">상품후기&nbsp;<span class="badge badge-dark">0</span></button>
				<button type="button" onclick="location.href='#btn_qna'">상품문의&nbsp;<span class="badge badge-dark">0</span></button>
			</div>
			<!-- 버튼그룹 끝 -->
			
			<!-- 상세보기 게시판 상품후기(detail_board_review) 시작 -->
			<div class="detail_board_review">
				<jsp:include page="detailboard_review.jsp" />
			</div>
			<!-- 상세보기 게시판 상품후기(detail_board_review) 끝 -->
			
			<br><br>
			
			<!-- 버튼그룹 시작 -->
			<div class="tab_btngroup">
				<button type="button" onclick="location.href='#btn_detail'">상품상세안내</button>
				<button type="button" onclick="location.href='#btn_purchase'">상품구매안내</button>
				<button type="button" onclick="location.href='#btn_related'">관련상품</button>
				<button type="button" onclick="location.href='#btn_review'">상품후기&nbsp;<span class="badge badge-dark">0</span></button>
				<button type="button" class="btn_active" id="btn_qna" onclick="location.href='#btn_qna'">상품문의&nbsp;<span class="badge badge-dark">0</span></button>
			</div>
			<!-- 버튼그룹 끝 -->
			<!-- 상세보기 게시판 영역(detail_board) 시작 -->
			<div class="detail_board_qna">
				<jsp:include page="detailboard_qna.jsp" />
			</div>
			<!-- 상세보기 게시판 영역(detail_board) 시작 -->
			
		</div>
		<!-- 상세보기 게시판 영역(detail_board) 끝 -->
		
	</div>
	<!-- 컨테이너 끝 -->
	
	
	
	<%-- ######################################################################################################################3 --%>


	<script type="text/javascript">
	
		$(document).ready(function(){
			
			
			
			// ******************** 썸네일 이미지 클릭 시 메인 이미지 바꾸기 시작 **************************************** //
			var bigPic = document.querySelector(".big");
			var smallPics = document.querySelectorAll(".small");
		
			for(var i=0; i < smallPics.length; i++) {
				smallPics[i].addEventListener("click", changepic);
			} 		
		
			function changepic() {
				var smallPicAttr = this.getAttribute("src");
				bigPic.setAttribute("src", smallPicAttr);
			}
			// ******************** 썸네일 이미지 클릭 시 메인 이미지 바꾸기 끝 **************************************** //
			
			
			
			
			
			// ******************** 상세보기 상단 글영역 테이블 넣기 시작 **************************************** //
			
			// *** 1. 상품 배열 선언 ***// 
 			const arr_product = [ 
				{
					productId : "harrypotter",
					productName : "해리포터와 마법사의 돌",
					image : "harrypotter1.jpg",
					price : 13000,
					shippingfee: 3000
				}
			];
			
 			arr_product.forEach(function(elt, i, array) {
 				console.log("내용 : " + arr_product[i]);
 			});
			
			
			// *** 2-1. 테이블 넣기 - 제품제목 시작 *** //
			let html_title = `<table id=`+'tbl_detail_title'+`>`;
			
			arr_product.forEach(function(elt, i, array) {
				html_title += `<tr>
									<th>${elt.productName}s</th>
								<tr>
							</table>`;
			});
			
		//	console.log(html_title);
			document.querySelector("div#detail_text_title").innerHTML = html_title;
			// *** 2-1. 테이블 넣기 - 제품제목 끝 *** //
			
			
			
			// *** 2-2. 테이블 넣기 - 제품가격 시작 *** //
			let html_purchase = `<table id=`+"tbl_detail_purchase"+`>
									<thead>`;
			
			arr_product.forEach(function(elt, i, array) {
				html_purchase += 		`<tr>
											<th scope="row" width="40%">판매가</th>
											<td scope="col"><span id='${elt.productId}'>${elt.price.toLocaleString('en')}</span>원</td>
										</tr>
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
			
			document.querySelector("div#detail_text_purchase").innerHTML = html_purchase;
			// *** 2-2. 테이블 넣기 - 제품가격 끝 *** //
			
			
			
			// *** 2-3. 테이블 넣기 - 총주문액 시작 *** //
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
										<td scope="row"><span id='${elt.productId}'><b>${elt.price.toLocaleString('en')}</b></span>원</td>
									</tr>
								</tbody>
								<tfoot>
									<tr>
										<td scope="row"><span><b>총상품금액</b></span>&nbsp;(수량)&nbsp;:&nbsp;</td>
										<td scope="row"><span><b>${elt.price.toLocaleString('en')}</b></span>원</td>
										<td scope="row"><span id="odr_qty"></span>(1개)</td>
									</tr>
								</tfoot>
							</table>`;
			});

			document.querySelector("div#pro_detail_total").innerHTML = html_total;
			// *** 2-3. 테이블 넣기 - 총주문액 시작 *** //
			
			// ******************** 상세보기 상단 글영역 테이블 넣기 끝 **************************************** //
			
			
			
			
			
			// ******************** 주문수량이 바뀌면 주문금액과 수량에 값을 넣어주기 시작 **************************************** //
			const input_number_list = document.querySelectorAll("table#tbl_pro_total input[type='number']");

			// *** 1. 주문수량 이벤트 처리하기 *** //
			input_number_list.forEach(function(elt) {
			
				elt.addEventListener('change', () => {
						
				// 주문수량에 대한 금액 알아오기
				
			//	console.log(document.querySelector("table#tbl_detail_purchase span#"+elt.id).innerText); // "구매테이블에서 받아온 가격 정보" 예: 13000
				
				let odrqty = Number(elt.value);
				let price = Number(document.querySelector("table#tbl_detail_purchase > thead > tr > td > span").innerText.split(",").join(""));
				let odr_price = odrqty*price;
				
			//	console.log("1. 수량(Number(elt.value) " + odrqty);
			//	console.log("2. 가격(price) " + price);
			//	console.log("3. 수량×가격(odr_price) " + odr_price);
			//	console.log("4. odr_price.toLocaleString('en') => " + odr_price.toLocaleString('en'));
				
				document.querySelector("#tbl_pro_total > tbody > tr > td:last-child").innerHTML = "<b>" + odr_price.toLocaleString('en') + "</b> 원";
				document.querySelector("#tbl_pro_total > tfoot > tr > td:nth-child(2)").innerHTML = "<b>" + odr_price.toLocaleString('en') + "</b> 원";
				document.querySelector("#tbl_pro_total > tfoot > tr > td:last-child").innerHTML = "("+ odrqty + "개)";
				
				});
				
			});		
			// ******************** 주문수량이 바뀌면 주문금액과 수량에 값을 넣어주기 끝 **************************************** //
			
			
			
			
						
			// ******************** 주문수량 keyup 이벤트 처리하기 시작 **************************************** //
			input_number_list.forEach(function(elt, i, array){
				elt.addEventListener('keyup', ()=>{
					alert("주문수량은 마우스로만 입력하세요.");
					elt.value = 1;
				});
			});
			// ******************** 주문수량 keyup 이벤트 처리하기 끝 **************************************** //
			
			
			
			
			
			
		});
		
		
		
</script>

<jsp:include page="footer.jsp" />
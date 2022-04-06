<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
    String ctxPath = request.getContextPath();
%>

<meta charset="UTF-8">
<title>in사과::도서 상세보기</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="<%=ctxPath %>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">

<!-- Optional JavaScript -->
<script src="<%=ctxPath %>/js/jquery-3.6.0.min.js" type="text/javascript"></script>
<script src="<%=ctxPath %>/bootstrap-4.6.0-dist/js/bootstrap.bundle.js" type="text/javascript"></script>
   
<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/product_detail.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/board/lee_css/semi_style.css" />

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	$(document).ready(function () {
		//총가격측정 숫자포맷
		$("td.pro_qty input").bind("click", function () {
			const price = "${requestScope.pvo.pro_saleprice}";
			const qty = $(this).val();
			const totalprice = qty * price;
	        const totalpricecomma = totalprice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	       
	        $("td.pro_price strong").html(totalpricecomma+"원");
	        $("td.pro_total_price strong").html(totalpricecomma+"원");
		});//end of $("td.pro_qty input").bind("click", function () 
		
		//품절시 버튼 비활성화	
		if(${requestScope.pvo.pro_soldout} == 1) {		
			$("button#btn_buy").attr("disabled", true);
			$("button#btn_cart").attr("disabled", true);
			$("button#btn_like").attr("disabled", true);
		}
		
		$("button#btn_cart").click(function() {
			goCart();
		});
				
				
	});
		
	function goCart() {
		$.ajax({
			url:"<%= ctxPath%>/product/goCart.book",
			type:"POST",
			data:{"pro_saleprice":${requestScope.pvo.pro_saleprice},
				"pk_pro_num":${requestScope.pvo.pk_pro_num},
				"total_pro_qty": $("td.pro_qty input").val()	
		
			}, 
			
			dataType:"JSON",
			success:function(json) {
	
	
			},
			error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		
		});//end of $.ajax
		
		
	}//end of function goCart()
	
</script>

<jsp:include page="/WEB-INF/header.jsp" />

<%-- 컨테이너 시작 --%>
<div class="container d-none d-lg-block">	
	<%--  상세보기 상단 컨텐츠(detail_top) 시작 --%>
	<div class="detail_top">	
	
	<table>
		<%--상세보기 상단 그림영역(detail_top_img) 시작 --%>
		<tr>
			<td class="top_img">
				<div class="top_img_main">
					<img class="pro_imgfile_name" src="<%= ctxPath%>/images/product/${pvo.category.cate_name}/${pvo.pro_imgfile_name}">
				</div>
			</td>	
			
			<td class="top_text">
				<table>
					<tr>
						<td colspan="3" class="pro_title">
							<div id="pro_name" name="pro_name">${requestScope.pvo.pro_name}
							<c:choose>
								<c:when test="${requestScope.pvo.pro_restock eq 1}">
									<a style="color: red; font-size: 15px; margin-left: 10px; position: relative;bottom: 3px;">재입고</a>
								</c:when>
								<c:when test="${requestScope.pvo.pro_restock eq 0}">
								</c:when>
							</c:choose>
							</div>
						<td>
					</tr>
					<tr>
						<td class="pro_list">판매가</td>
						<td colspan="2" class="pro_list_val" id="pro_saleprice" name="pro_saleprice">
							<span><strong><fmt:formatNumber value="${requestScope.pvo.pro_saleprice}" pattern="###,###" /></strong>원</span>
						</td>
					</tr>
					<tr>
						<td class="pro_list">배송방법</td>
						<td colspan="2" class="pro_list_val">택배</td>	
					</tr>
					<tr>
						<td class="pro_list">배송비</td>
						<td colspan="2" class="pro_list_val"><span><fmt:formatNumber value="3000" pattern="###,###" /></span>원&nbsp;(50,000원 이상 구매 시 무료)</td>
					</tr>
					<tr>
						<td colspan="3" class="pro_list" >(최소주문수량 1개 이상)</td>
					</tr>
					<tr >
						<td class="pro_list2" >상품명</td>
						<td class="pro_list2"style="text-align: center;" >상품수</td>
						<td class="pro_list2"style="text-align: center;" >가격</td>
					</tr>
					<tr>
						<c:choose>
							<c:when test="${requestScope.pvo.pro_soldout eq 1}">
							</c:when>
							<c:when test="${requestScope.pvo.pro_soldout eq 0}">
								<td class="pro_list_val2" style="width: 50%">
									<div id="pro_name" name="pro_name">${requestScope.pvo.pro_name}</div>
								</td>
								<td class="pro_list_val2 pro_qty" style="width: 25%">
									<input type='number' name="odr_qty" min='1' max='100' value='1'/>
								</td>
								<td class="pro_list_val2 pro_price">
									<span> <strong><fmt:formatNumber value="${requestScope.pvo.pro_saleprice}" pattern="###,###" />원</strong></span> 						
								</td>
							</c:when>
						</c:choose>
					

					</tr>
					<tr>
						<td style="height: 25px"></td>
					</tr>
					<tr>
						<td colspan="3" class="pro_total_price">
							<c:choose>
								<c:when test="${requestScope.pvo.pro_soldout eq 1}">
									<span  style=" color: red; margin-right: 10px;">품절</span>
								</c:when>
								<c:when test="${requestScope.pvo.pro_soldout eq 0}">
									<span>총 상품금액(수량)&nbsp;:&nbsp;<strong><fmt:formatNumber value="${requestScope.pvo.pro_saleprice}" pattern="###,###" />원</strong></span>
								</c:when>
							</c:choose>
							
						</td>
					</tr>
				</table>
				
				<table>
					<tr>
						<td style="height: 35px"></td>
					</tr>
					<tr>
						<td class="button">
							<button type="button" id="btn_buy" class="btn1" onclick="productPurchase()" >
								구매하기
							</button>
						</td>
						<td class="button">
							<button type="button" id="btn_cart" class="btn2" data-toggle="modal" data-target="#cartModal">
					    		장바구니
							</button>
						</td>
						<td class="button">
							<button type="button" id="btn_like" class="btn2" data-toggle="modal" data-target="#wishModal">
					    		관심상품
							</button>
						</td>
					<tr>			
				</table>
				
			</td>
		</tr>
	</table>
	</div>
	
	
	<!-- 상세보기 하단 컨텐츠(detail_bottom) 시작 -->
	<div class="detail_bottom">
		<!-- 버튼그룹 시작 -->
		<br><br>
		<div class="tab_btngroup text-center">			 
			<button type="button" class="btn_active" id="btn_detail" onclick="location.href='#btn_detail'">상품상세안내</button>
			<button type="button" class="btn1" onclick="location.href='#btn_purchase'">상품구매안내</button>
			<button type="button" class="btn1" onclick="location.href='#btn_related'">관련상품</button>
			<button type="button" class="btn1" onclick="location.href='#btn_review'">상품후기&nbsp;&nbsp;<span class="badge badge-dark">0</span></button>
			<button type="button" class="btn1" onclick="location.href='#btn_qna'">상품문의&nbsp;<span class="badge badge-dark">0</span></button> 
		</div>
		<!-- 버튼그룹 끝 -->
				
		<!-- 상품상세안내(detail_bottom_info) 시작 -->
		<div class="detail_bottom_info">
			<br>
			<p><span class="majorheading">품목정보</span></p>
			<p class="subheading">
				책제목 : <span>${requestScope.pvo.pro_name}</span><br>
				저자 : <span>${requestScope.pvo.writer.wr_name}</span><br>
				<fmt:parseDate value="${requestScope.pvo.pro_publish_date}" var="parseDateValue" pattern="MM/dd/yyyy"/>
				출간일 : <span><fmt:formatDate value="${parseDateValue}" pattern="yyyy-MM-dd"/>	</span><br>
				분야 : <span>
						<c:choose>
							<c:when test="${requestScope.pvo.category.cate_name eq 'total'}">
								종합
							</c:when>
							<c:when test="${requestScope.pvo.category.cate_name eq 'humanities'}">
								인문
							</c:when>
							<c:when test="${requestScope.pvo.category.cate_name eq 'society'}">
								사회
							</c:when>
							<c:when test="${requestScope.pvo.category.cate_name eq 'science'}">
								과학
							</c:when>
							<c:when test="${requestScope.pvo.category.cate_name eq 'other'}">
								기타
							</c:when>
						</c:choose>
						
	
						
				</span><br>
				제본 : <span>${requestScope.pvo.pro_bindtype}</span><br>
				쪽수 : <span>${requestScope.pvo.pro_pages}p</span><br>
				크기 : <span>${requestScope.pvo.pro_size}</span><br>
				ISBN   : <span>${requestScope.pvo.pk_pro_num}</span><br>
				정가 : <span><fmt:formatNumber value="${requestScope.pvo.pro_price}" pattern="###,###" />원</span><br>

			</p>
				
			<br><br>
				
			<p><span class="majorheading">책소개</span></p>
			<%-- <p class="subheading">${requestScope.pvo.pro_content}</p> --%>
		
			<br><br>
				
			<p><span class="majorheading">저자소개</span></p>
			<%-- <p class="subheading">${requestScope.wvo.wr_name}</p> --%>
		
			<br><br>
				
			<p><span class="majorheading">목차</span></p>
			<%-- <p class="subheading">${requestScope.pvo.pro_index}</p> --%>
	
			<br><br>

		</div>
		<!-- 상품상세안내(detail_bottom_info) 끝 -->

		<!-- 버튼그룹 시작 -->
		<div class="tab_btngroup text-center">
			<button type="button" class="btn1" onclick="location.href='#btn_detail'">상품상세안내</button>
			<button type="button" class="btn_active" id="btn_purchase" onclick="location.href='#btn_purchase'">상품구매안내</button>
			<button type="button" class="btn1" onclick="location.href='#btn_related'">관련상품</button>
			<button type="button" class="btn1" onclick="location.href='#btn_review'">상품후기&nbsp;<span class="badge badge-dark">0</span></button>
			<button type="button" class="btn1" onclick="location.href='#btn_qna'">상품문의&nbsp;<span class="badge badge-dark">0</span></button>	 
		</div>
		<!-- 버튼그룹 끝 -->
		<!-- 상품구매안내(detail_bottom_purchase) 시작 -->
		<div class="detail_bottom_purchase">
			<br>
			<p><span class="majorheading2">상품결제정보</span></p>
			<hr>
			고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다.
			확인과정에서 도난 카드의 사용이나 타인 명의의 주문 등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다.<br>
			무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다.<br>
			주문시 입력한 입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며 입금되지 않은 주문은 자동취소 됩니다.<br>
			</p>
			
			<br><br>
			<p><span class="majorheading2">배송정보</span></p>
			<hr>
			
			<p class="subheading">
			배송 방법 : 택배<br>
			배송 지역 : 전국지역<br>
			배송 비용 : 3,000원<br>
			배송 기간 : 3일 ~ 5일<br>
			배송 안내 : - 고객님께서 주문하신 상품은 입금 확인후 배송해 드립니다. 다만, 상품종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.<br>
			</p>
			
			<br><br>
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
		<div class="tab_btngroup text-center">
			<button type="button" class="btn1" onclick="location.href='#btn_detail'">상품상세안내</button>
			<button type="button" class="btn1" onclick="location.href='#btn_purchase'">상품구매안내</button>
			<button type="button" class="btn_active" id="btn_related" onclick="location.href='#btn_related'">관련상품</button>
			<button type="button" class="btn1" onclick="location.href='#btn_review'">상품후기&nbsp;<span class="badge badge-dark">0</span></button>
			<button type="button" class="btn1" onclick="location.href='#btn_qna'">상품문의&nbsp;<span class="badge badge-dark">0</span></button>
		</div>
		<!-- 버튼그룹 끝 -->
		<!-- 관련상품(detail_bottom_related) 시작 -->
		<div class="detail_bottom_related">
			<br>
			<div class="detail_related_contents">
				관련 상품이 없습니다.
			</div>
			<hr><br>
		</div>
		<!-- 관련상품(detail_bottom_related) 끝 -->
		</div>
		<!-- 상세보기 하단 컨텐츠(detail_bottom) 끝 -->
		
		<br><br>
		
		<!-- 상세보기 게시판 영역(detail_board) 시작 -->
		<div class="detail_board">
			<!-- 버튼그룹 시작 -->
			<div class="tab_btngroup text-center">
				<button type="button" class="btn1" onclick="location.href='#btn_detail'">상품상세안내</button>
				<button type="button" class="btn1" onclick="location.href='#btn_purchase'">상품구매안내</button>
				<button type="button" class="btn1" onclick="location.href='#btn_related'">관련상품</button>
				<button type="button" class="btn_active" id="btn_review" onclick="location.href='#btn_review'">상품후기&nbsp;<span class="badge badge-dark">0</span></button>
				<button type="button" class="btn1" onclick="location.href='#btn_qna'">상품문의&nbsp;<span class="badge badge-dark">0</span></button>
			</div>
			<!-- 버튼그룹 끝 -->
			
			<!-- 상세보기 게시판 상품후기(detail_board_review) 시작 -->
			<div class="detail_board_review">
				<jsp:include page="detailboard_review.jsp">
					<jsp:param value="${requestScope.pvo.pk_pro_num}" name="pk_pro_num"/>
				</jsp:include>
			</div>
			<!-- 상세보기 게시판 상품후기(detail_board_review) 끝 -->
			
			<br><br>
			
			<!-- 버튼그룹 시작 -->
			<div class="tab_btngroup text-center">
				<button type="button" class="btn1" onclick="location.href='#btn_detail'">상품상세안내</button>
				<button type="button" class="btn1" onclick="location.href='#btn_purchase'">상품구매안내</button>
				<button type="button" class="btn1" onclick="location.href='#btn_related'">관련상품</button>
				<button type="button" class="btn1" onclick="location.href='#btn_review'">상품후기&nbsp;<span class="badge badge-dark">0</span></button>
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
	
	<!-- Modal -->
	<div class="modal fade" id="cartModal" data-backdrop="static">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <!-- Modal header -->
	            <div class="modal-header">
	                <h5 class="modal-title">장바구니 추가</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
	            </div>
	
	            <!-- Modal body -->
	            <div class="modal-body">
	               해당 상품이 장바구니에 추가되었습니다.<br>
	               장바구니로 이동하시겠습니까?<br>
	            </div>
	
	            <!-- Modal footer -->
	            <div class="modal-footer">
	                <button type="button" class="btn1" data-dismiss="modal">쇼핑 계속하기</button>
	                <button type="button" class="btn2" onclick="goCart()">장바구니 확인</button>
	            </div>
	        </div>
	    </div>
	</div>
	
	<div class="modal fade" id="wishModal" data-backdrop="static">
    	<div class="modal-dialog">
	        <div class="modal-content">
	
	            <!-- Modal header -->
	            <div class="modal-header">
	                <h5 class="modal-title">관심상품 추가</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">&times;</button>
	            </div>
	
	            <!-- Modal body -->
	            <div class="modal-body">
	               해당 상품이 관심상품에 추가되었습니다.<br>
	               관심상품으로 이동하시겠습니까?<br>
	            </div>
	
	            <!-- Modal footer -->
	            <div class="modal-footer" style="margin: 0 auto;">
	                <button type="button" class="btn1" data-dismiss="modal">쇼핑 계속하기</button>
	                <button type="button" class="btn2">관심상품 확인</button>
	            </div>
	        </div>
    	</div>
	</div>
	<!-- Modal end -->
	
	
<jsp:include page="/WEB-INF/footer.jsp" />

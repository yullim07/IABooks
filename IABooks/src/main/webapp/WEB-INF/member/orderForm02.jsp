<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
%>

<title>주문서작성</title>

	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css">
	
	<!-- 내가만든 CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/style_member.css" />
	
	<!-- Optional JavaScript-->
	<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
	
	 
<script type="text/javascript">
	
	$(document).ready(function(){
		
		
	});
	
	function openDaumPOST() {
	
		new daum.Postcode({
			oncomplete: function (data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				let addr = ''; // 주소 변수
				let extraAddr = ''; // 참고항목 변수
	
				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}
	
				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("extraAddress").value = extraAddr;
					
				} else {
					document.getElementById("extraAddress").value = '';
				}
	
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postcode').value = data.zonecode;
				document.getElementById("address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("detailAddress").focus();
			}
		}).open();
	
	}// end of openDaumPOST()
	
	function detailOrder() {
		
		$("div.deiailOrderBox").show();
		
	}
	
</script>

<style type="text/css">
	div.deiailOrderBox {
		display: none;
		border: solid 1px #495164;
		width: 300px;
		height: 187px;
	}
	
	div.deiailOrderBox strong {
		color: white;
		padding-left: 10px;
		padding-top: 5px;
	}
	
	div.deiailOrderBox button {
		background-color: rgba( 0, 0, 0, 0 );
		border: none;
		color: white;
		margin-bottom: 20px;
	}
	
	div.deiailOrderBox_header {
		display: flex;
		background-color: #495164;
		height: 35px;
	}
	
	div.deiailOrderBox span {
  		margin-left: auto;
  		font-size: 24pt;
  		vertical-align: middle;
	}
	
</style>


<jsp:include page="<%= ctxPath %>/WEB-INF/header.jsp"/>


<div class="container">
	<br>
	&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"  /> 주문서작성 </strong> &nbsp;
	<hr style="border: solid 1px #e8e8e8;">
	
	<div style="text-align: center;"><img src="<%= ctxPath %>/images/member/img_order_step2.gif" style="margin: 10px 0;" /></div>
		
	<form>
		<table class="benefit_info">
			<tr>
				<td>
					<span style="padding-left: 30px;">혜택정보</span>
					<img src="<%= ctxPath%>/images/bar_eee.gif" style="width: 2px; height: 20px;" />
					가용적립금 : <span name="point">테스트</span>
					쿠폰 : <span name="coupon"></span>
				</td>
			</tr>
		</table>
		
		<!-- 영준님 테이블 가져오기 -->

		<hr style="border: solid 1px black;">	
		
		<strong style="font-size: 12pt; padding-left: 20px;">배송정보</strong>
			<p class="floatR"><span id="star">*</span> 필수입력사항</p>
			<table class="shipping_info">
				<tr>
					<th>배송지선택&nbsp;</th>
					<td>
						<input type="radio" id="user_address" name="shippingInfo" checked required autocomplete="off" />&nbsp; <label class="title" for="user_address">회원정보와 동일</label>&nbsp;&nbsp;    
						<input type="radio" id="new_address" name="shippingInfo" required autocomplete="off" />&nbsp; <label class="title" for="new_address">새로운 배송지</label>
					</td>    
				</tr>
				<tr>
				<th>받으시는분&nbsp;<span id="star">*</span></th>
				    <td>
				        <input required type="text" name="name" id="name" maxlength="20">
				    </td>
				</tr>
				<tr>
					<th>우편번호</th>
				      <td>
				         <input required type="text" id="postcode" size="5" placeholder="우편번호" values="addr" style="width: 100px;" />
				         &nbsp;&nbsp;
				         <img src="<%= ctxPath %>/images/btn_zipcode.gif" style="cursor: pointer;" onclick="openDaumPOST();"/>
				      </td>
				</tr>
				<tr>
					<th id="register">주소 &nbsp;<span id="star">*</span></th>
						<td>
							<input class="my-1" required type="text" id="address" size="50" placeholder="주소" /><br>
							<input class="my-1" type="text" id="detailAddress" size="50" placeholder="상세주소" /><br>
							<input class="my-1" type="text" id="extraAddress" size="50" placeholder="참고항목" />                
						</td>
					</tr>
				<tr>
					<th>휴대전화 &nbsp;<span id="star">*</span></th>
				        <td>
				        	<select>
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="019">019</option>
							</select>&nbsp;-&nbsp;
							<input required type="text" size="5" maxlength="4">&nbsp;-&nbsp; 
							<input required type="text" size="5" maxlength="4">
						 </td>
				     </tr>
				<tr>
					<th>이메일 &nbsp;<span id="star">*</span></th>
						<td>
							<input type="email" class="myinput" id="email" size="20" maxlength="20" required placeholder="email@gmail.com" />
							<br>이메일을 통해 주문처리과정을 보내드립니다. 
							<br>이메일 주소란에는 반드시 수신가능한 이메일주소를 입력해 주세요.
						</td>
				</tr>
				            
				<tr>
			        <th>배송메세지</th>
			        <td>
			        	<textarea maxlength="255"></textarea>
			        </td>
			    </tr>
			</table>
		
			<strong style="font-size: 12pt;">결제 예정 금액</strong>
			<table class="paymentExpected">
				<thead>
					<tr>
						<td>
							<strong>총 주문 금액</strong>
							<a style="cursor: pointer;" onclick="detailOrder()"><img src="<%= ctxPath %>/images/member/btn_list.gif" style="cursor: pointer;"/></a>
						</td>
						<td>
							<strong>총 할인 + 부가결제 금액</strong>
						</td>
						<td>
							<strong>총 결제예정 금액</strong>
						</td>
					</tr>
					<tr>
						<td>
							<span>14,000원</span>
						</td>
						<td>
							- <span>0원</span>
						</td>
						<td style="color: #008BCC;">
							= <span>14,000원</span>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>총 할인금액</td>
						<td colspan="2"><div>0원</div></td>
					</tr>
					<tr>
						<td>총 부가결제금액</td>
						<td colspan="2"><div>0원</div></td>
					</tr>
				</tbody>
			</table>
			<div class="btn_order"><img src="<%= ctxPath%>/images/member/btn_place_order.gif" onclick="#"  ></div>
		
	</form>
	
	<div class="deiailOrderBox" >
       <div class="deiailOrderBox_header">
         <strong>총 주문금액 상세내역</strong>
         <span><button type="button" >&times;</button></span>
       </div>
       <div class="deiailOrderBox_body">
         
       </div>
	</div>
	
	
</div>	
	
<jsp:include page="<%= ctxPath %>/WEB-INF/footer.jsp"/>
 
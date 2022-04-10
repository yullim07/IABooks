<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
%>
<title>쿠폰</title>
<jsp:include page="/WEB-INF/header.jsp"/>
<!-- 내가만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/style_member.css" />


<script type="text/javascript">

$(document).ready(function() {
	/* 
	const frm = document.sizePerPageFrm;
	frm.action = "coupon.book";
	frm.method = "post";
	frm.submit();
	 */
	 
	
})

function generateCoupon(userid) {
	
	// 쿠폰생성
	const url = "<%= request.getContextPath()%>/member/generateCoupon.book?userid="+userid;
	
	// 너비 800, 높이 600 인 팝업창을 화면 가운데 위치시키기
	const pop_width = 800;
	const pop_height = 600;
	const pop_left = Math.ceil( ((window.screen.width)-pop_width)/2 ) ; <%-- 정수로 만든다 --%>
	const pop_top = Math.ceil( ((window.screen.height)-pop_height)/2 ) ;
	
	window.open(url, "memberEdit",
			   	"left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height );
	
}; // end of function generateCoupon()


function couponCheck() {
	
	if( $("input#userCoupon").val().trim() == "" ){
		alert("쿠폰번호를 입력해주세요");
	} else {
		couponRegister();
	}
	
}


function couponRegister() {
	
	const frm = document.userCouponRegisterFrm;
	frm.action = "<%= ctxPath%>/member/userCouponRegister.book";
	frm.method = "post";
	frm.submit();
	
}

//쿠폰 중복 여부 검사하기		
function isExistCouponCheck() {
	
	// ==== jQuery 를 이용한 Ajax (Asynchronous JavaScript and XML)처리하기 ====
		$.ajax({
 			url:"<%= ctxPath%>/member/couponDuplicateCheck.book",
 			data:{"userCoupon":$("input#userCoupon").val()}, // data 는 MyMVC/member/idDuplicateCheck.up로 전송해야할 데이터를 말한다.
 			type: "post" , // type 은 생략하면 "get" 이다.
 		//	async:false,   // 동기처리(지도는 동기처리로 해야한다.)
 		//	async:true,	   // 비동기처리(기본값)	
 			
 			success: function(text){
 				//console.log("확인용 : text => "+ text);
 				// 확인용 : text => {"isExist":false}    
 				//console.log("확인용 타입 typeof(text) : "+typeof(text))
 				// 확인용 타입 typeof(text) : string
 				
 				const json = JSON.parse(text);
 				
 				if(json.isExist) {	// 입력한 $("input#userid").val() 값이 이미 사용중이라면
  	 				$("input#userCoupon").val("");
 					alert("이미 등록되어진 쿠폰번호입니다.")
 				} else {	// 입력한 $("input#userid").val() 값이 DB테이블(tbl_member)에 존재하지 않는 경우라면
 					if( $("input#userCoupon").val().trim() == "" ){
 						alert("쿠폰번호를 입력해주세요");
 					} else if(!(json.isCoupon)){
 						alert("잘못된 쿠폰번호입니다.");
 					} else {
 						$("a#isExistCouponCheck").html("<img src='<%= ctxPath %>/images/member/btn_coupon_serial.gif' class='btn_userCouponRegister' onclick='couponCheck();' />");
 					}
 				}
	 		}, 
	 		error: function (request, status, error) {
 				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 			}
 		})	
 		
};


</script>

<style type="text/css">

	a.admin_coupon {
		margin-top: 20px;
		width: 200px;
		height: 36px;
		background-color: #1a6dff;
		color: white;
		font-weight: bold;
		float: right;
		border: none;
		text-align: center;
		padding-top: 5px;
		
	}
	
	img.btn_userCouponRegister {
		cursor: pointer;
	}

</style>

<title>쿠폰조회</title>



<div class="container">
	<c:if test="${sessionScope.loginuser.userid eq 'admin'}">
		<a class="admin_coupon" href="javascript:generateCoupon('${(sessionScope.loginuser).userid}');" >coupon 발급하기</a>
	</c:if>
	<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;마이쿠폰</strong>
	<hr style="border: solid 2px #e8e8e8;">
		<strong>마이 쿠폰 목록</strong><p style="float: right;">사용가능 쿠폰 <span>${requestScope.couponNum}</span> 장</p>
	<table class="coupon">
		<thead>
			<tr>
				<td>번호</td>
				<td>쿠폰명</td>
				<td>쿠폰혜택</td>
				<td>최소주문금액</td>
				<td>사용가능기간</td>
				<td>쿠폰사용여부</td>
			</tr>
		</thead>
		<tbody>		
			<c:if test="${not empty (requestScope.couponListP)}">
				<c:forEach var="cvo" items="${requestScope.couponListP}" >
					<tr>
						<td align="center" class="numAsc">${cvo.rno}</td>
						<td align="center">${cvo.cname }</td>
						<td align="center"><fmt:formatNumber type="number" pattern="###,###" >${cvo.cprice }</fmt:formatNumber>원</td>
						<td align="center"><fmt:formatNumber type="number" pattern="###,###" >${cvo.cminprice }</fmt:formatNumber>원</td>
						<td align="center">${cvo.cstartdate }~${cvo.cenddate }</td>
						<td align="center">
						<c:choose>
	   	  	  	  	  		<c:when test="${cvo.ucvo.user_cp_status eq '1' or cvo.cenddate > sysdate}"><!-- 조건변경 -->
	   	  	  	  	  			<span style="color: blue;">사용가능</span>
	   	  	  	  	  		</c:when>
	   	  	  	  	  		<c:otherwise>
	   	  	  	  	  			<span style="color: red;">사용불가</span>
	   	  	  	  	  		</c:otherwise>
	   	  	  	  	  	</c:choose>
					
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty (requestScope.couponListP)}">
				<tr>
					<td colspan="7" align="center">
						보유하고 계신 쿠폰내역이 없습니다.
					</td>
				</tr>
			</c:if>
		</tbody>	
	</table>
	
	<nav class="my-5">
    	<div style="display: flex; width: 100%;">
    		<ul class="pagination" style='margin:auto;'>
    			${requestScope.pageBar}
    		</ul>
    	</div>
    </nav>
        


<!--  
	<div class="pagination pagination-sm justify-content-center">
	  <a href="#"><img src="<%= ctxPath %>/images/member/btn_page_first.gif" /></a>
	  <a href="#"><img src="<%= ctxPath %>/images/member/btn_page_prev.gif" /></a>
	  <a class="active" href="#">1</a>
	  <a href="#"><img src="<%= ctxPath %>/images/member/btn_page_next.gif" /></a>
	  <a href="#"><img src="<%= ctxPath %>/images/member/btn_page_last.gif" /></a>
	</div>
-->		
	<br><br>
	<strong>쿠폰인증번호 등록하기</strong>
	<form name="userCouponRegisterFrm">
		<table class="couponKey" >
			<tr>
				<td>
					<input type="hidden" name="userid" value="${sessionScope.loginuser.userid }"/>
					<input type="text" style="height: 40px; width: 350px;" name="userCoupon" id="userCoupon" />
					<a id="isExistCouponCheck"><img src="<%= ctxPath %>/images/member/btn_coupon_serial.gif" class="btn_userCouponRegister" onclick="isExistCouponCheck();" /></a>
				</td>
			</tr>
			<tr>
				<td>반드시 쇼핑몰에서 발행한 쿠폰번호만 입력해주세요. (15자 일련번호 "-" 제외)</td>
			</tr>
		</table>
	</form>
	<table class="couponInfo">
		<tr>
			<td>쿠폰이용안내</td>
		</tr>
		<tr>
			<td>
				<ol>
					<li><strong>쿠폰인증번호 등록하기</strong>에서 쇼핑몰에서 발행한 종이쿠폰/시리얼쿠폰/모바일쿠폰 등의 인증번호를 등록하시면 온라인쿠폰으로 발급되어 사용이 가능합니다.</li>
					<li>쿠폰은 주문 시 1회에 한해 적용되며, 1회 사용 시 재 사용이 불가능합니다.</li>
					<li>쿠폰은 적용 가능한 상품이 따로 적용되어 있는 경우 해당 상품 구매 시에만 사용이 가능합니다.</li>
					<li>특정한 종이쿠폰/시리얼쿠폰/모바일쿠폰의 경우 단 1회만 사용이 가능할 수 있습니다.</li>
				</ol>
			</td>
		</tr>
	
	</table>


</div>
	
	
	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%
	String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- Required meta tags --%>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<%-- Bootstrap CSS --%>
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css">
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css" >
	
	<%-- Bootstrap Icons --%>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
	
	<%-- Font Awesome 5 Icons --%>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	
	<%-- 직접 만든 CSS --%>
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/style_member.css" />
	
	<%-- Optional JavaScript --%>
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>
	<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
	<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js" ></script>

<title>in사과::쿠폰등록하기</title>




<style type="text/css">

	div#head {
		margin: 30px;
		text-align: center;
	}
	
	table#generateCoupon {
		border: solid 5px grey;
		margin-bottom: 20px;
	}
	
	table#generateCoupon tr {
		border: solid 1px grey;
	}
	
	
	table#generateCoupon td {
		padding: 10px;
	}
	table#generateCoupon td:first-child {
		background-color: #FBFAFA;
	}
	
	a.btn_coupon {
		padding: 5px 20px;
		background-color: white;
		color: navy;
		border: solid 1px black;
	}
	
	span.error {
		color: red;
	}
	
	a.btn_coupon:hover {
		cursor: pointer;
		text-decoration: none;
		color: white;
		background-color: navy;
		font-weight: bold;
	}
	
</style>


<script type="text/javascript">

$(document).ready(function() {
	
	$("span.error").hide();
	$("input#couponName").focus();

	
	//=== jQuery UI 의 datepicker === //
	$("input.datepicker").datepicker({
	           dateFormat: 'yy-mm-dd'  //Input Display Format 변경
	          ,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	          ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	          ,changeYear: true        //콤보박스에서 년 선택 가능
	          ,changeMonth: true       //콤보박스에서 월 선택 가능                
	       // ,showOn: "both"          //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
	       // ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	       // ,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	       // ,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	          ,yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
	          ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	          ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	          ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	          ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	        //,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	        //,maxDate: "+1M" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)                
	 });                    
	      
	 //초기값을 오늘 날짜로 설정
	 $('input[name="coupondateStart"]').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후) 
	 $('input[name="coupondateEnd"]').datepicker('setDate', '+1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후) 
	 /////////////////////////////////////////////////////
	
	// 아이디가 couponName 제약 조건 
		$("input#couponName").blur(() => {
			const $target = $(event.target);
			
			const name = $target.val().trim();
			if(name == "" ){
				
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
				
				
			} else {
				// 공백이 아닌 글자를 입력했을 경우
				
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		}); 
	
	 // 아이디가 couponDiscount 제약 조건 
		$("input#couponDiscount").blur(() => {
			const $target = $(event.target);
			
			const name = $target.val().trim();
			if(name == "" ){
				
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
				
				
			} else {
				// 공백이 아닌 글자를 입력했을 경우
				
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		}); 
	
	// 아이디가 minDiscount 제약 조건 
		$("input#minDiscount").blur(() => {
			const $target = $(event.target);
			
			const name = $target.val().trim();
			if(name == "" ){
				
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
				
				
			} else {
				// 공백이 아닌 글자를 입력했을 경우
				
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		}); 

	
	 
}); // end of $(document).ready(function()
 

		
		
function couponCancel() {
	
	self.close();
	
}// end of function couponCancel()
	
function couponOk() {
	
	// *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
	let b_FlagRequiredInfo = false;
	
	$("input.requiredInfo").each(function(index, item) {
		const data = $(item).val().trim();
		if(data == ""){
			alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
			b_FlagRequiredInfo = true;
			return false; // each문에서 for문에서 break; 와 같은 기능이다.
		}
	});
	
	if(b_FlagRequiredInfo) {
		return;
	}
	
	const frm = document.couponFrm;
	frm.action = "generateCoupon.book";
	frm.method = "post";
	frm.submit();
	
} // end of function couponOk()

</script>


</head>
<body>
<div align="center">
	
	<form name="couponFrm">
		<div id="head" >
			<h4>쿠폰등록하기 (<span style="font-size: 10pt; font-style: italic;"><span id="star"> * </span>표시는 필수입력사항</span>)</h4>
		</div>
		<table id="generateCoupon">
			
			<tr>
				<td><label>쿠폰명<span id="star"> * </span></label></td>
				<td><input class="requiredInfo" type="text" id="couponName" name="couponName" maxlength="50" /><span class="error">쿠폰명을 입력해주세요.(최대 50자) </span></td>
			</tr>
			<tr>
				<td><label for="couponDiscount">할인설정</label></td>
				<td><input class="requiredInfo" type="text" id="couponDiscount" name="couponDiscount"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" /> 원 할인<span class="error" >할인설정을 입력해주세요 </span></td>
			</tr>
			<tr>
				<td><label>최소주문금액<span id="star"> * </span></label></td>
				<td colspan="2"><input class="requiredInfo" type="text" id="minDiscount" name="minDiscount"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" /> 원<span class="error">최소주문금액을 입력해주세요 </span></td>
			</tr>
			<tr>
				<td>혜택기간<span id="star"> * </span></td>
				<td><input type="text" class="datepicker" name="coupondateStart"/> ~ </td> 
				<td><input type="text" class="datepicker" name="coupondateEnd" style="margin-left: -40px;"/>
			</tr>
		</table>
		
		<div style="display: inline-block; ">
			<a onclick="couponOk()" class="btn_coupon">확인</a>
		</div>
		<div style="display: inline-block;">
			<a class="btn_coupon" onclick="couponCancel();">취소</a>
		</div>
	</form>
</div>

</body>
</html>
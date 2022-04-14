<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
%>

<title>회원 정보 수정</title>


<jsp:include page="/WEB-INF/header.jsp"/>	


	<!-- 내가만든 CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/style_member.css" />

	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css">
	
	<!-- Optional JavaScript-->
	<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
 	
<script type="text/javascript">
	
	let b_flagEmailDuplicateClick = false;
	// 가입하기 버튼 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도이다.
	
$(document).ready( function () {
	
	const tel ="${sessionScope.loginuser.tel}";
	let num = tel.split("-");
	
	$("select[name='num1']").val(num[0])
	$("input#num2").val(num[1])
	$("input#num3").val(num[2])

	const phone ="${sessionScope.loginuser.phone}";
	let hp = phone.split("-");
	
	$("select[name='hp1']").val(hp[0])
	$("input#hp2").val(hp[1])
	$("input#hp3").val(hp[2])
	
	// 아이디가 name 제약 조건 
	$("input#name").blur(() => {
		const $target = $(event.target);
		
		const name = $target.val().trim();
		if(name == ""){
			
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
	
	
	// 아이디가 pwd 제약 조건 
	$("input#pwd").blur(() => {
		const $target = $(event.target);
		
		const regExp = new RegExp(/^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		// 영어대/소문자 , 숫자, 특수기호를 모두 사용한 8글자 이상 16자 이하로 구성된 정규표현식
		
		const bool = regExp.test($target.val());  
		
		if(!bool){ // !bool == false 암호가 정규표현식에 위배된 경우
			// 입력하지 않거나 공백만 입력했을 경우
			$target.prop("disabled",false);
		//	$target.next().show();
		// 	또는
			$target.parent().find(".error").show();
			
		} else {
			// bool == true 암호가 정규표현식에 맞는 경우
			$target.parent().find(".error").hide();
		}
	 
	}); 
	
	// 아이디가 pwdcheck 제약 조건 패스워드 확인 검사
	$("input#pwdCheck").blur(() => {
		const $target = $(event.target);

		const pwd = $("input#pwd").val();
		const pwdcheck = $target.val();
		
		if(pwdcheck != pwd){ // 암호와 암호확인값이 다른 경우 
			$target.prop("disabled",false);
			$("input#pwd").prop("disabled",false);
			
		//	$target.next().show();
		// 	또는
			$target.parent().find(".error").show();
			
		} else {
			// 암호와 암호확인값이 같은 경우
			//	$target.next().hide();
			// 	또는
			$target.parent().find(".error").hide();
		}
	}); 
	
	// 아이디가 email 제약 조건 
	$("input#email").blur(() => {
		const $target = $(event.target);
		
        const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
        // 이메일 정규표현식 객체 생성
	    
         const bool = regExp.test($target.val());  
        
		if(!bool){ // !bool == false 이메일이 정규표현식에 위배된 경우
			// 입력하지 않거나 공백만 입력했을 경우
			
		//	$target.next().show();
		// 	또는
			$target.parent().find(".error").show();
			
		} else {
			// bool == true 이메일이 정규표현식에 맞는 경우
			//	$target.next().hide();
			// 	또는
			$target.parent().find(".error").hide();
		}
	}); 
	
	$("input#email").bind("change", ()=>{
		b_flagEmailDuplicateClick = false;
	});

	
}); //end of $(document).ready( function ()

//이메일값이 변경되면 가입하기 버튼을 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도 초기화 시키기    


//이메일 중복여부 검사하기
function isExistEmailCheck() {
	
	$("span#emailCheckResult").hide();
	
	b_flagEmailDuplicateClick = true;
	// 가입하기 버튼을 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
	
	// 첫번째 방법
	$.ajax({
		url:"<%= ctxPath%>/member/emailDuplicateCheck.book",
		type:"post",
		data:{"email":$("input#email").val()},
		dataType:"json",
		success:function(json) {
			
			const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
	 			const bool = regExp.test($("input#email").val());  	
	 			
	 				if(json.isExist) {	// 입력한 $("input#email").val() 값이 이미 사용중이라면
	 					$("span#emailCheckResult").show();
	 					$("span#emailCheckResult").html($("input#email").val()+"은 중복된 ID 이므로 사용 불가합니다.").css("color","red");
	 					$("input#email").val("");
	 				} else if( !bool ) {
	 					
	 				} else {	// 입력한 $("input#email").val() 값이 DB테이블(tbl_member)에 존재하지 않는 경우라면
	 					$("span#emailCheckResult").show();
	 					$("span#emailCheckResult").html($("input#email").val()+"은 사용 가능합니다.").css("color","green");
	 				}
			
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});		
	
}// end of function isExistEmailCheck() {}----------------------------------



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
	
// 정보 수정하기 
function goUpdateInfo() {
	
	// *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
	let flagBool = false;
	
	$("input.requiredInfo").each( (index, item)=>{
		const data = $(item).val().trim();
		if(data == "") {
			flagBool = true;
			return false;
			/*
			   for문에서의 continue; 와 동일한 기능을 하는것이 
			   each(); 내에서는 return true; 이고,
			   for문에서의 break; 와 동일한 기능을 하는것이 
			   each(); 내에서는 return false; 이다.
			*/
		}
	});
	
	if(flagBool) {
		alert("필수입력란은 모두 입력하셔야 합니다.");
		return; // 종료
	}
	
	if(!b_flagEmailDuplicateClick) {
    	// "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
    	alert("이메일중복확인 클릭하여 이메일중복검사를 하세요!!");
    	return; // 종료
    }
	
	const frm = document.updateFrm;
	frm.method = "POST";
	frm.action = "<%= ctxPath%>/member/memberUpdateEnd.book";
	frm.submit();
}


// 회원 탈퇴하기
function updateInfoCancel() {
	
	const frm = document.updateFrm;
	frm.method = "POST";
	frm.action = "<%= ctxPath%>/member/memberDeleteEnd.book";
	frm.submit();
	
}
	
</script>

<style type="text/css">

	span.error {
		color: red;
		display: none;
	}
	
	span.duplicateCheck {
		display: inline-block;
		font-size: 9pt;
		border: solid 1px #999;
		height: 25px;
		background-color: white;
		margin-left: 10px;
		width: 120px;
		cursor: pointer;
		text-align: center;
		padding-top: 2px;
		border-radius: 5%;
	}
	

</style>


<div class="container">
	<form name="updateFrm" action="updateMember.book">
		<br>
		<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"  />  회원 정보 수정</strong>
		<hr style="border: solid 2px #e8e8e8;">
		
		<br><br>
		<strong style="font-size: 16pt;">기본정보</strong>
		<p id="floatR"><span id="star">*</span> 필수입력사항</p>
		
		<table class="register">
			<tr>
			<th >성명 &nbsp;<span id="star">*</span></th>
			    <td>
					<input type="hidden" class="myinput" id="userid" name="userid" size="20" maxlength="20"  required autocomplete="off" value="${sessionScope.loginuser.userid}"/>     
			        <input required type="text" class="requiredInfo" id="name" name="name" maxlength="20" value="${sessionScope.loginuser.name}"><span class="error">성명은 필수입력 사항입니다.</span>
			    </td>
			</tr>
			<tr>
				<th><label for="pwd">비밀번호&nbsp;<span id="star">*</span></label></th>
				<td><input type="password" class="requiredInfo" id="pwd" name="pwd" size="20" maxlength="20" required />&nbsp;(영문 대소문자/숫자/특수문자 모두 조합, 8자~16자)<br><span class="error" style="margin-left: 200px;">암호가 올바르지 않습니다.</span></td>
			</tr>
			<tr>
				<th><label class="title" for="pwdcheck">비밀번호확인&nbsp;<span id="star">*</span></label></th>
				<td><input type="password" class="requiredInfo" id="pwdCheck" size="20" maxlength="20" required  /><span class="error">암호가 일치하지 않습니다.</span></td>
			</tr>
			<tr>
				<th>이메일 &nbsp;<span id="star">*</span></th>
				<td>
					<input type="email" class="requiredInfo" id="email" name="email" size="20" maxlength="20" required placeholder="example@gmail.com"  value="${sessionScope.loginuser.email}"/>
					<span id="isExistIdCheck" class="duplicateCheck" onclick="isExistEmailCheck();">이메일중복확인&nbsp;&nbsp;<i class="fas fa-angle-right"></i></span>
					<br>
					<span class="error">올바른 이메일 양식이 아닙니다.</span>
					<span id="emailCheckResult"></span>
				</td>
			</tr>
			<tr>
				<th>우편번호</th>
		        <td>
		           <input required type="text" class="requiredInfo" id="postcode" name="postcode" size="5" placeholder="우편번호" values="addr" style="width: 100px;"  value="${sessionScope.loginuser.postcode}" />
		           &nbsp;&nbsp;
		           <img src="<%= ctxPath %>/images/member/btn_zipcode.gif" style="cursor: pointer;" onclick="openDaumPOST();"/>
		        </td>
			</tr>
			<tr>
				<th>주소 &nbsp;<span id="star">*</span></th>
				<td>
					<input class="my-1" class="requiredInfo" required type="text" id="address" name="address"  size="50" placeholder="주소" value="${sessionScope.loginuser.address}"/><br>
					<input class="my-1" type="text" id="detailAddress" name="detailAddress" size="50" placeholder="상세주소"value="${sessionScope.loginuser.detailaddress}" /><br>
					<input class="my-1" type="text" id="extraAddress" name="extraAddress" size="50" placeholder="참고항목" value="${sessionScope.loginuser.extraaddress}" />                               
				</td>
			</tr>
			<tr>
				<th>일반전화 </th>
				<td>
					<select id="num1" name="num1">
						<option value="">선택</option>
						<option value="02">02</option>
						<option value="031">031</option>
						<option value="032">032</option>
						<option value="033">033</option>
						<option value="041">041</option>
						<option value="042">042</option>
						<option value="043">043</option>
						<option value="044">044</option>
						<option value="051">051</option>
						<option value="052">052</option>
						<option value="053">053</option>
						<option value="054">054</option>
						<option value="055">055</option>
						<option value="061">061</option>
						<option value="062">062</option>
						<option value="063">063</option>
						<option value="064">064</option>
						<option value="070">070</option>
						<option value="010">010</option>
					</select>&nbsp;-&nbsp;
					<input id="num2" name="num2" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">&nbsp;-&nbsp; 
					<input id="num3" name="num3" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
				</td>
			</tr >
			<tr>
				<th>휴대전화 &nbsp;<span id="star">*</span></th>
		        <td>
		        	<select id="hp1" name="hp1">
						<option value="010">010</option>
					</select>&nbsp;-&nbsp;
					<input class="requiredInfo" required id="hp2" name="hp2" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">&nbsp;-&nbsp; 
					<input class="requiredInfo" required id="hp3" name="hp3" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
				 	<span class="error">올바른 휴대전화 번호가 아닙니다.</span>
				 </td>
			</tr>
		    <tr>
		    	<th>이메일 수신여부</th>
		    	<td>
			    	<input type="radio" id="agree" name="emailAgree" value="1" checked /><label for="agree" style="margin-left: 2%;">수신함</label>
		            <input type="radio" id="disagree" name="emailAgree" value="2" style="margin-left: 5%;" /><label for="disagree" style="margin-left: 2%;">수신거부</label>
		    	</td>
		    </tr>
		    
		    <tr align="center">
			        <td style="line-height: 90px;" class="text-center"  colspan="2">
			           <img id="btnRegister" onClick="goUpdateInfo();" style="cursor: pointer;" src="<%= ctxPath%>/images/member/btn_modify_member.gif"/>
			           &nbsp;&nbsp;
			           <img id="btnRegisterCancel" onClick="registerCancel()" style="cursor: pointer;" src="<%= ctxPath%>/images/member/btn_modify_cancel.gif"/>
			           <p class="floatR" style="padding-top: 30px;"><img id="btnRegisterCancel" onClick="updateInfoCancel()" style="cursor: pointer;" src="<%= ctxPath%>/images/member/btn_modify_out.gif" /></p>
			        </td>
			</tr>    
		</table>
	</form>
</div>	
	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
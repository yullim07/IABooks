<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
%>

<title>in사과::회원가입</title>

<jsp:include page="/WEB-INF/header.jsp"/>


	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css">
	
	<!-- 내가만든 CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/style_member.css" />
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_header_footer.css" />	
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css" >
	
	<!-- Optional JavaScript-->
	
	<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js" ></script> 
	<script type="text/javascript" src="<%= ctxPath%>/js/datepicker.js" ></script> 
	
<script type="text/javascript">
	
$(document).ready(function() {
	
	let b_flagIdDuplicateClick = false;
	// 가입하기 버튼 클릭시 "아이디중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도이다.
	
	let b_flagEmailDuplicateClick = false;
	// 가입하기 버튼 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도이다.
	
	//$("span.error").hide();
	$("input#userid").focus();
	
	// 아이디가 userid 제약 조건 
	$("input#userid").blur(() => {
		const $target = $(event.target);
		
		const name = $target.val().trim();
		if(name == "" && flagError==false){
			
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
	$("input#pwdcheck").blur(() => {
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
	
	
	// 아이디가 hp2인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
	
	$("input#hp2").blur(() => {
		const $target = $(event.target);
		
        const regExp = new RegExp(/^[1-9][0-9]{3}$/g); 
        // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성(첫글자는 숫자 1~9까지만 가능함)
	    
         const bool = regExp.test($target.val());  
        
		if(!bool){ // !bool == false 국번이 정규표현식에 위배된 경우
		//	$target.next().show();
		// 	또는
			$target.parent().find(".error").show();
			
		} else {
			// bool == true 국번이 정규표현식에 맞는 경우
			//	$target.next().hide();
			// 	또는
			$target.parent().find(".error").hide();
		}
	}); 
	
	$("img#zipcodeSearch").click(function() {
			
 	      new daum.Postcode({
            oncomplete: function(data) {
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
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
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
 			
	});
	
	
	// 아이디값이 변경되면 가입하기 버튼 클릭시 "아이디중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도를 초기화 시키기
 	$("input#userid").bind("change",()=>{
  	 	b_flagIdDuplicateClick = false;
 	});
	
	

	
	// 이메일값이 변경되면 가입하기 버튼 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도를 초기화 시키기
 	$("input#email").bind("change",()=>{
 		b_flagEmailDuplicateClick = false;
 	});

	
 // 한글입력막기 스크립트
 	$("#userid").keyup(function(e) { 
 		if (!(e.keyCode >=37 && e.keyCode<=40)) {
 			var v = $(this).val();
 			$(this).val(v.replace(/[^a-z0-9]/gi,''));
 		}
 	});


});// end of $(document).ready(function() 
	
	// 아이디 중복 여부 검사하기		
	function isExistIdCheck() {
	
		b_flagIdDuplicateClick = true;
		// ==== jQuery 를 이용한 Ajax (Asynchronous JavaScript and XML)처리하기 ====
 		$.ajax({
	 			url:"<%= ctxPath%>/member/idDuplicateCheck.book",
	 			data:{"userid":$("input#userid").val()}, // data 는 MyMVC/member/idDuplicateCheck.up로 전송해야할 데이터를 말한다.
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
	 					$("span#idcheckResult").html($("input#userid").val()+"은 중복된 ID 이므로 사용 불가합니다.").css("color","red");
	  	 				$("input#userid").val("");
	 				} else if($("input#userid").val().length < 4 ) {
	 					$("span#idcheckResult").html("아이디는 4글자 이상 16글자 이하로 작성하세요!").css("color","red");
	 				} else {	// 입력한 $("input#userid").val() 값이 DB테이블(tbl_member)에 존재하지 않는 경우라면
	 					$("span#idcheckResult").html($("input#userid").val()+"은 사용 가능합니다.").css("color","green");
	 				}
		 		}, 
		 		error: function (request, status, error) {
	 				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	 			}
	 		})	
	 		
 		};
	
 	// 이메일 중복여부 검사하기
 		function isExistEmailCheck(){
 			b_flagEmailDuplicateClick = true;
 		 	// 가입하기 버튼 클릭시 "아이디중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도이다.
 		 	
 		 	
 		 	// 입력하고자 하는 이메일이 데이터베이스 테이블에 존재하는지 존재하지 않는지 알아와야한다.
 		 	/*
 	     	    Ajax (Asynchronous JavaScript and XML)란?
 	       		==> 이름만 보면 알 수 있듯이 '비동기 방식의 자바스크립트와 XML' 로서
 	       	    Asynchronous JavaScript + XML 인 것이다.
 	       	    한마디로 말하면, Ajax 란? Client 와 Server 간에 XML 데이터를 JavaScript 를 사용하여 비동기 통신으로 주고 받는 기술이다.
 	       	    하지만 요즘에는 데이터 전송을 위한 데이터 포맷방법으로 XML 을 사용하기 보다는 JSON 을 더 많이 사용한다.
 	       	    참고로 HTML은 데이터 표현을 위한 포맷방법이다.
 	       	    그리고, 비동기식이란 어떤 하나의 웹페이지에서 여러가지 서로 다른 다양한 일처리가 개별적으로 발생한다는 뜻으로서, 
 	       	    어떤 하나의 웹페이지에서 서버와 통신하는 그 일처리가 발생하는 동안 일처리가 마무리 되기전에 또 다른 작업을 할 수 있다는 의미이다.
 	        */
 			// ==== jQuery 를 이용한 Ajax (Asynchronous JavaScript and XML)처리하기 ====
 		 		$.ajax({
 		 			url:"<%= ctxPath%>/member/emailDuplicateCheck.book",
 		 			data:{"email":$("input#email").val()}, // data 는 MyMVC/member/emailDuplicateCheck.up로 전송해야할 데이터를 말한다.
 		 			type: "post" , // type 은 생략하면 "get" 이다.
 					dataType: "json",
 				//	async:false,   // 동기처리(지도는 동기처리로 해야한다.)
 	       	 	//	async:true,	   // 비동기처리(기본값)	
 					success: function(json){
 		 			//	console.log("확인용 json =>"+ json);
 		 				//확인용 json =>[object Object]
 		 			//	console.log("확인용 typeof(json) =>"+ typeof(json));
 		 				// 확인용 typeof(json) =>object
 		 			
 		 			const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
 		 			const bool = regExp.test($("input#email").val());  	
 		 			
 		 				if(json.isExist) {	// 입력한 $("input#email").val() 값이 이미 사용중이라면
 		 					$("span#emailCheckResult").html($("input#email").val()+"은 중복된 ID 이므로 사용 불가합니다.").css("color","red");
 		 					$("input#email").val("");
 		 				} else if( !bool ) {
 		 					
 		 				} else {	// 입력한 $("input#email").val() 값이 DB테이블(tbl_member)에 존재하지 않는 경우라면
 		 					$("span#emailCheckResult").html($("input#email").val()+"은 사용 가능합니다.").css("color","green");
 		 				}
 	                   
 		 			}, 
 		 			error: function(request, status, error){
 		 				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 		 			}
 		 			
 		 		});
 		 	
 		}
	
 		
 		
		
	// 동의 모두선택 / 해제
	function selectAll(selectAll)  {
	  const agree_checkbox = document.getElementsByName('agree');
	  
	  agree_checkbox.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked;
	  })
	}
	
	
		
	// 체크박스 개별 선택
	function checkSelect()  {
	 	// 전체 체크박스
	  	const all_checkbox 
	    = document.querySelectorAll('input[name="agree"]');
	 	 // 선택된 체크박스
	 	 const checked 
	    = document.querySelectorAll('input[name="agree"]:checked');
	 	 // select all 체크박스
	 	 const selectAll 
	    = document.querySelector('input#agreeAllChecked');
	  
	  	if(all_checkbox.length == checked.length)  {
	   		selectAll.checked = true;
	 	} else {
	    	selectAll.checked = false;
	 	}
	}

	// 가입하기		
	function goRegister() {
		
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
		
		// *** 성별이 선택 되었는지 검사한다. *** //
		const genderCheckedLength = $("input:radio[name='gender']:checked").length;
		
		if(genderCheckedLength == 0){
			alert("성별을 선택하셔야 합니다.");
			return; // 종료
		}
		
		// *** 이용약관에 동의 했는지 검사한다. *** //
		const agreeCheckedLengthMust = $("input:checkbox[class='agree_must']:checked").length;
		
		if(agreeCheckedLengthMust != 2){
			alert("필수이용약관에 동의하셔야 합니다.");
			return; // 종료
		} 
	/*	
		// *** 아이디 중복확인을 클릭 했는지 검사한다. *** //
		
		if(!b_flagIdDuplicateClick){ // 아이디 중복검사를 클릭하지 않았다면
			alert("아이디중복확인 클릭하여 아이디중복검사를 하세요.");
			return; // 종료
		}
		
		
		// *** 이메일 중복확인을 클릭 했는지 검사한다. *** //
		
		if(!b_flagEmailDuplicateClick){ // 이메일 중복검사를 클릭하지 않았다면
			alert("이메일중복확인 클릭하여 이메일중복검사를 하세요.");
			return; // 종료
		}
	*/	
		const frm = document.registerFrm;
		frm.action = "memberRegister.book";
		frm.method = "post";
		frm.submit();
		
		
	}// end of 	function goRegister()
	
	// 가입하기 취소 버튼 클릭 시 
	function registerCancel() {
		
		location.href = "<%=ctxPath%>/index.book";
		
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

	<form name="registerFrm" action="registerSuccess.book">
<%-- 		<br>
		<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"  />  회원 가입</strong>
		<hr style="border: solid 2px #e8e8e8;">
		<br><br> --%>
		<div class="title">
		<br>
		<h2 >회원 가입</h2>
		</div>
		
			<strong style="font-size: 16pt;">기본정보</strong>
			<p><img src="<%= ctxPath%>/images/member/bar_eee.gif" style="width: 2px; height: 20px;" />&nbsp;&nbsp;<span id="star">*</span> 필수입력사항</p>
			<table class="register">
				<tr>
					<th><label for="userid">아이디&nbsp;<span id="star">*</span></label></th>
					<td>
						<input type="text" class="requiredInfo" id="userid" name="userid" size="20"  maxlength='16' autofocus required autocomplete="off" style="ime-mode:inactive;"  />
						<span id="isExistIdCheck" class="duplicateCheck" onclick="isExistIdCheck();">아이디중복확인&nbsp;&nbsp;<i class="fas fa-angle-right"></i></span>
						<br>
						<span class="error">아이디를 입력해주세요.</span> 
						<span id="idcheckResult"></span>
					</td>    
				</tr>
				<tr>
					<th><label for="pwd">비밀번호&nbsp;<span id="star">*</span></label></th>
					<td><input type="password" class="requiredInfo" id="pwd" name="pwd" size="20" maxlength="20" required />&nbsp;(영문 대소문자/숫자/특수문자 모두 조합, 8자~16자)<br><span class="error" style="margin-left: 200px;">암호가 올바르지 않습니다.</span></td>
				</tr>
				<tr>
					<th><label for="pwdCheck">비밀번호확인&nbsp;<span id="star">*</span></label></th>
					<td><input type="password" class="requiredInfo" id="pwdCheck" size="20" maxlength="20" required /><span class="error">암호가 일치하지 않습니다.</span></td>
				</tr>
				<tr>
					<th>성명 &nbsp;<span id="star">*</span></th>
				    <td>
				        <input required type="text" class="requiredInfo" id="name" name="name" maxlength="20"><span class="error">성명은 필수입력 사항입니다.</span>
				    </td>
				</tr>
				<tr>
					<th>우편번호 &nbsp;<span id="star">*</span></th>
				    <td>
				       <input required type="text" class="requiredInfo" id="postcode" name="postcode" size="5" placeholder="우편번호" values="addr" style="width: 100px;" />
				       &nbsp;&nbsp;
				       <img id="zipcodeSearch" src="<%= ctxPath %>/images/member/btn_zipcode.gif" style="cursor: pointer;" />
				    </td>
				</tr>
				<tr>
					<th>주소 &nbsp;<span id="star">*</span></th>
					<td>
						<input class="my-1" class="requiredInfo" required type="text" id="address" name="address"  size="50" placeholder="주소" /><br>
						<input class="my-1" type="text" id="detailAddress" name="detailAddress" size="50" placeholder="상세주소" /><br>
						<input class="my-1" type="text" id="extraAddress" name="extraAddress" size="50" placeholder="참고항목" />                
					</td>
				</tr>
				<tr>
					<th>일반전화</th>
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
					<th>이메일 &nbsp;<span id="star">*</span></th>
					<td>
						<input type="email" class="requiredInfo" id="email" name="email" size="20" maxlength="20" required placeholder="example@gmail.com" />
						<span id="isExistIdCheck" class="duplicateCheck" onclick="isExistEmailCheck();">이메일중복확인&nbsp;&nbsp;<i class="fas fa-angle-right"></i></span>
						<br>
						<span class="error">올바른 이메일 양식이 아닙니다.</span>
						<span id="emailCheckResult"></span>
					</td>
				</tr>
				            
				 <tr>
			        <th>생년월일&nbsp;<span id="star">*</span></th> 
			        <td>
			           <input class="requiredInfo" type="text" id="datepicker" name="birthday">
			        </td>
			      </tr>
				<tr>
			        <th>성별&nbsp;<span id="star">*</span></th>
			        <td>
			           <input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%;">남자</label>
			           <input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%;">여자</label>
			        </td>
			    </tr>
			</table>
		
			<strong style="font-size: 16pt; margin-left: 20px;">전체 동의</strong>
				<table class="agree">
					<tr>
						 <td>
						 	<div class="checkbox_group">
					    	<label for="agreeAllChecked"><strong>이용약관 및 개인정보수집 및 이용, 쇼핑정보 수신(선택)에 모두 동의합니다.</strong></label>&nbsp;&nbsp;<input type="checkbox" id="agreeAllChecked" onclick='selectAll(this)' >
					    	</div>
						</td>
					</tr>
					<tr>
						<td>
					        <strong style="font-size: 16pt;">[필수] 이용약관 동의</strong>
					   	</td>
					</tr>        
					 <tr>
				         <td colspan="2" align="center">
				            <textarea readonly="readonly" class="agree">제1조(목적)
이 약관은 주식회사 연지출판사(전자상거래 사업자)가 운영하는 사이버 몰(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.
※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다.」

제2조(정의)
① “몰”이란 주식회사 연지출판사가 재화 또는 용역(이하 “재화 등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.
② “이용자”란 “몰”에 접속하여 이 약관에 따라 “몰”이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
③ ‘회원’이라 함은 “몰”에 회원등록을 한 자로서, 계속적으로 “몰”이 제공하는 서비스를 이용할 수 있는 자를 말합니다.
④ ‘비회원’이라 함은 회원에 가입하지 않고 “몰”이 제공하는 서비스를 이용하는 자를 말합니다.

제3조 (약관 등의 명시와 설명 및 개정)
① “몰”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호·모사전송번호·전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보보호책임자등을 이용자가 쉽게 알 수 있도록 사이버몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.
② “몰은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회·배송책임·환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.
③ “몰”은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.
④ “몰”이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 “몰“은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.
⑤ “몰”이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 “몰”에 송신하여 “몰”의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.
⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.

제4조(서비스의 제공 및 변경)
① “몰”은 다음과 같은 업무를 수행합니다.
  1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결
  2. 구매계약이 체결된 재화 또는 용역의 배송
  3. 기타 “몰”이 정하는 업무
② “몰”은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.
③ “몰”이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.
④ 전항의 경우 “몰”은 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.

제5조(서비스의 중단)
① “몰”은 컴퓨터 등 정보통신설비의 보수점검·교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.
② “몰”은 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.
③ 사업종목의 전환, 사업의 포기, 업체 간의 통합 등의 이유로 서비스를 제공할 수 없게 되는 경우에는 “몰”은 제8조에 정한 방법으로 이용자에게 통지하고 당초 “몰”에서 제시한 조건에 따라 소비자에게 보상합니다. 다만, “몰”이 보상기준 등을 고지하지 아니한 경우에는 이용자들의 마일리지 또는 적립금 등을 “몰”에서 통용되는 통화가치에 상응하는 현물 또는 현금으로 이용자에게 지급합니다.

제6조(회원가입)
① 이용자는 “몰”이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.
② “몰”은 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다.
  1. 가입신청자가 이 약관 제7조제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제7조제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 “몰”의 회원재가입 승낙을 얻은 경우에는 예외로 한다.
  2. 등록 내용에 허위, 기재누락, 오기가 있는 경우
  3. 기타 회원으로 등록하는 것이 “몰”의 기술상 현저히 지장이 있다고 판단되는 경우
③ 회원가입계약의 성립 시기는 “몰”의 승낙이 회원에게 도달한 시점으로 합니다.
④ 회원은 회원가입 시 등록한 사항에 변경이 있는 경우, 상당한 기간 이내에 “몰”에 대하여 회원정보 수정 등의 방법으로 그 변경사항을 알려야 합니다.

제7조(회원 탈퇴 및 자격 상실 등)
① 회원은 “몰”에 언제든지 탈퇴를 요청할 수 있으며 “몰”은 즉시 회원탈퇴를 처리합니다.
② 회원이 다음 각 호의 사유에 해당하는 경우, “몰”은 회원자격을 제한 및 정지시킬 수 있습니다.
  1. 가입 신청 시에 허위 내용을 등록한 경우
  2. “몰”을 이용하여 구입한 재화 등의 대금, 기타 “몰”이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우
  3. 다른 사람의 “몰” 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우
  4. “몰”을 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우
③ “몰”이 회원 자격을 제한?정지 시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 “몰”은 회원자격을 상실시킬 수 있습니다.
④ “몰”이 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.

제8조(회원에 대한 통지)
① “몰”이 회원에 대한 통지를 하는 경우, 회원이 “몰”과 미리 약정하여 지정한 전자우편 주소로 할 수 있습니다.
② “몰”은 불특정다수 회원에 대한 통지의 경우 1주일이상 “몰” 게시판에 게시함으로서 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.

제9조(구매신청)
① “몰”이용자는 “몰”상에서 다음 또는 이와 유사한 방법에 의하여 구매를 신청하며, “몰”은 이용자가 구매신청을 함에 있어서 다음의 각 내용을 알기 쉽게 제공하여야 합니다.
  1. 재화 등의 검색 및 선택
  2. 받는 사람의 성명, 주소, 전화번호, 전자우편주소(또는 이동전화번호) 등의 입력
  3. 약관내용, 청약철회권이 제한되는 서비스, 배송료·설치비 등의 비용부담과 관련한 내용에 대한 확인
  4. 이 약관에 동의하고 위 3.호의 사항을 확인하거나 거부하는 표시(예, 마우스 클릭)
  5. 재화등의 구매신청 및 이에 관한 확인 또는 “몰”의 확인에 대한 동의
  6. 결제방법의 선택
② “몰”이 제3자에게 구매자 개인정보를 제공?위탁할 필요가 있는 경우 실제 구매신청 시 구매자의 동의를 받아야 하며, 회원가입 시 미리 포괄적으로 동의를 받지 않습니다. 이 때 “몰”은 제공되는 개인정보 항목, 제공받는 자, 제공받는 자의 개인정보 이용 목적 및 보유?이용 기간 등을 구매자에게 명시하여야 합니다. 다만 「정보통신망이용촉진 및 정보보호 등에 관한 법률」 제25조 제1항에 의한 개인정보 처리위탁의 경우 등 관련 법령에 달리 정함이 있는 경우에는 그에 따릅니다.

제10조 (계약의 성립)
① “몰”은 제9조와 같은 구매신청에 대하여 다음 각 호에 해당하면 승낙하지 않을 수 있습니다. 다만, 미성년자와 계약을 체결하는 경우에는 법정대리인의 동의를 얻지 못하면 미성년자 본인 또는 법정대리인이 계약을 취소할 수 있다는 내용을 고지하여야 합니다.
  1. 신청 내용에 허위, 기재누락, 오기가 있는 경우
  2. 미성년자가 담배, 주류 등 청소년보호법에서 금지하는 재화 및 용역을 구매하는 경우
  3. 기타 구매신청에 승낙하는 것이 “몰” 기술상 현저히 지장이 있다고 판단하는 경우
② “몰”의 승낙이 제12조제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다.
③ “몰”의 승낙의 의사표시에는 이용자의 구매 신청에 대한 확인 및 판매가능 여부, 구매신청의 정정 취소 등에 관한 정보 등을 포함하여야 합니다.

제11조(지급방법)
“몰”에서 구매한 재화 또는 용역에 대한 대금지급방법은 다음 각 호의 방법중 가용한 방법으로 할 수 있습니다. 단, “몰”은 이용자의 지급방법에 대하여 재화 등의 대금에 어떠한 명목의 수수료도 추가하여 징수할 수 없습니다.
1. 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체
2. 선불카드, 직불카드, 신용카드 등의 각종 카드 결제
3. 온라인무통장입금
4. 전자화폐에 의한 결제
5. 수령 시 대금지급
6. 마일리지 등 “몰”이 지급한 포인트에 의한 결제
7. “몰”과 계약을 맺었거나 “몰”이 인정한 상품권에 의한 결제
8. 기타 전자적 지급 방법에 의한 대금 지급 등

제12조(수신확인통지?구매신청 변경 및 취소)
① “몰”은 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 합니다.
② 수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고 “몰”은 배송 전에 이용자의 요청이 있는 경우에는 지체 없이 그 요청에 따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는 제15조의 청약철회 등에 관한 규정에 따릅니다.

제13조(재화 등의 공급)
① “몰”은 이용자와 재화 등의 공급시기에 관하여 별도의 약정이 없는 이상, 이용자가 청약을 한 날부터 7일 이내에 재화 등을 배송할 수 있도록 주문제작, 포장 등 기타의 필요한 조치를 취합니다. 다만, “몰”이 이미 재화 등의 대금의 전부 또는 일부를 받은 경우에는 대금의 전부 또는 일부를 받은 날부터 3영업일 이내에 조치를 취합니다. 이때 “몰”은 이용자가 재화 등의 공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 합니다.
② “몰”은 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 명시합니다. 만약 “몰”이 약정 배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상하여야 합니다. 다만 “몰”이 고의?과실이 없음을 입증한 경우에는 그러하지 아니합니다.

제14조(환급)
“몰”은 이용자가 구매신청한 재화 등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 3영업일 이내에 환급하거나 환급에 필요한 조치를 취합니다.

제15조(청약철회 등)
① “몰”과 재화등의 구매에 관한 계약을 체결한 이용자는 「전자상거래 등에서의 소비자보호에 관한 법률」 제13조 제2항에 따른 계약내용에 관한 서면을 받은 날(그 서면을 받은 때보다 재화 등의 공급이 늦게 이루어진 경우에는 재화 등을 공급받거나 재화 등의 공급이 시작된 날을 말합니다)부터 7일 이내에는 청약의 철회를 할 수 있습니다. 다만, 청약철회에 관하여 「전자상거래 등에서의 소비자보호에 관한 법률」에 달리 정함이 있는 경우에는 동 법 규정에 따릅니다.
② 이용자는 재화 등을 배송 받은 경우 다음 각 호의 1에 해당하는 경우에는 반품 및 교환을 할 수 없습니다.
  1. 이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는 청약철회를 할 수 있습니다)
  2. 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우
  3. 시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우
  4. 같은 성능을 지닌 재화 등으로 복제가 가능한 경우 그 원본인 재화 등의 포장을 훼손한 경우
③ 제2항제2호 내지 제4호의 경우에 “몰”이 사전에 청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회 등이 제한되지 않습니다.
④ 이용자는 제1항 및 제2항의 규정에 불구하고 재화 등의 내용이 표시?광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날부터 3월 이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다.

제16조(청약철회 등의 효과)
① “몰”은 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화 등의 대금을 환급합니다. 이 경우 “몰”이 이용자에게 재화등의 환급을 지연한때에는 그 지연기간에 대하여 「전자상거래 등에서의 소비자보호에 관한 법률 시행령」제21조의2에서 정하는 지연이자율(괄호 부분 삭제)을 곱하여 산정한 지연이자를 지급합니다.
② “몰”은 위 대금을 환급함에 있어서 이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화 등의 대금을 지급한 때에는 지체 없이 당해 결제수단을 제공한 사업자로 하여금 재화 등의 대금의 청구를 정지 또는 취소하도록 요청합니다.
③ 청약철회 등의 경우 공급받은 재화 등의 반환에 필요한 비용은 이용자가 부담합니다. “몰”은 이용자에게 청약철회 등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만 재화 등의 내용이 표시?광고 내용과 다르거나 계약내용과 다르게 이행되어 청약철회 등을 하는 경우 재화 등의 반환에 필요한 비용은 “몰”이 부담합니다.
④ 이용자가 재화 등을 제공받을 때 발송비를 부담한 경우에 “몰”은 청약철회 시 그 비용을 누가 부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다.

제17조(개인정보보호)
① “몰”은 이용자의 개인정보 수집시 서비스제공을 위하여 필요한 범위에서 최소한의 개인정보를 수집합니다.
② “몰”은 회원가입시 구매계약이행에 필요한 정보를 미리 수집하지 않습니다. 다만, 관련 법령상 의무이행을 위하여 구매계약 이전에 본인확인이 필요한 경우로서 최소한의 특정 개인정보를 수집하는 경우에는 그러하지 아니합니다.
③ “몰”은 이용자의 개인정보를 수집?이용하는 때에는 당해 이용자에게 그 목적을 고지하고 동의를 받습니다.
④ “몰”은 수집된 개인정보를 목적외의 용도로 이용할 수 없으며, 새로운 이용목적이 발생한 경우 또는 제3자에게 제공하는 경우에는 이용?제공단계에서 당해 이용자에게 그 목적을 고지하고 동의를 받습니다. 다만, 관련 법령에 달리 정함이 있는 경우에는 예외로 합니다.
⑤ “몰”이 제2항과 제3항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보보호 책임자의 신원(소속, 성명 및 전화번호, 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보제공 관련사항(제공받은자, 제공목적 및 제공할 정보의 내용) 등 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 제22조제2항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다.
⑥ 이용자는 언제든지 “몰”이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 “몰”은 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 “몰”은 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.
⑦ “몰”은 개인정보 보호를 위하여 이용자의 개인정보를 처리하는 자를 최소한으로 제한하여야 하며 신용카드, 은행계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출, 동의 없는 제3자 제공, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다.
⑧ “몰” 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.
⑨ “몰”은 개인정보의 수집·이용·제공에 관한 동의란을 미리 선택한 것으로 설정해두지 않습니다. 또한 개인정보의 수집·이용·제공에 관한 이용자의 동의거절시 제한되는 서비스를 구체적으로 명시하고, 필수수집항목이 아닌 개인정보의 수집·이용·제공에 관한 이용자의 동의 거절을 이유로 회원가입 등 서비스 제공을 제한하거나 거절하지 않습니다.

제18조(“몰“의 의무)
① “몰”은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화·용역을 제공하는데 최선을 다하여야 합니다.
② “몰”은 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.
③ “몰”이 상품이나 용역에 대하여 「표시·광고의 공정화에 관한 법률」 제3조 소정의 부당한 표시?광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.
④ “몰”은 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.

제19조(회원의 ID 및 비밀번호에 대한 의무)
① 제17조의 경우를 제외한 ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.
② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.
③ 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 “몰”에 통보하고 “몰”의 안내가 있는 경우에는 그에 따라야 합니다.

제20조(이용자의 의무)
이용자는 다음 행위를 하여서는 안 됩니다.
1. 신청 또는 변경시 허위 내용의 등록
2. 타인의 정보 도용
3. “몰”에 게시된 정보의 변경
4. “몰”이 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시
5. “몰” 기타 제3자의 저작권 등 지적재산권에 대한 침해
6. “몰” 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위
7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 몰에 공개 또는 게시하는 행위

제21조(연결“몰”과 피연결“몰” 간의 관계)
① 상위 “몰”과 하위 “몰”이 하이퍼링크(예: 하이퍼링크의 대상에는 문자, 그림 및 동화상 등이 포함됨)방식 등으로 연결된 경우, 전자를 연결 “몰”(웹 사이트)이라고 하고 후자를 피연결 “몰”(웹사이트)이라고 합니다.
② 연결“몰”은 피연결“몰”이 독자적으로 제공하는 재화 등에 의하여 이용자와 행하는 거래에 대해서 보증 책임을 지지 않는다는 뜻을 연결“몰”의 초기화면 또는 연결되는 시점의 팝업화면으로 명시한 경우에는 그 거래에 대한 보증 책임을 지지 않습니다.

제22조(저작권의 귀속 및 이용제한)
① “몰“이 작성한 저작물에 대한 저작권 기타 지적재산권은 ”몰“에 귀속합니다.
② 이용자는 “몰”을 이용함으로써 얻은 정보 중 “몰”에게 지적재산권이 귀속된 정보를 “몰”의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.
③ “몰”은 약정에 따라 이용자에게 귀속된 저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다.

제23조(분쟁해결)
① “몰”은 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치·운영합니다.
② “몰”은 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해 드립니다.
③ “몰”과 이용자 간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시·도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.

제24조(재판권 및 준거법)
① “몰”과 이용자 간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.
② “몰”과 이용자 간에 제기된 전자상거래 소송에는 한국법을 적용합니다.

부 칙(시행일) 이 약관은 2018년 1월 1일부터 시행합니다.</textarea>
				         </td>
				    </tr>
					<tr>
				      <td>
				      	<div class="checkbox_group">
				          <span>[필수] 개인정보 수집 및 이용 동의</span>&nbsp;&nbsp;<input type="checkbox" id="agree_privacy" name="agree" class="agree_must" onclick='checkSelect()'/><label for="agree_privacy" >동의함</label>
				        </div>  
				      </td>
				    </tr>
					<tr>
						<td>
					        <strong style="font-size: 16pt;">[필수] 개인정보 수집 및 이용 동의</strong>
					   	</td>
					</tr>    
				    <tr>
				         <td colspan="2" align="center">
				            <textarea readonly="readonly" class="agree">1. 개인정보 수집목적 및 이용목적

가. 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산

콘텐츠 제공 , 구매 및 요금 결제 , 물품배송 또는 청구지 등 발송 , 금융거래 본인 인증 및 금융 서비스

나. 회원 관리

회원제 서비스 이용에 따른 본인확인 , 개인 식별 , 불량회원의 부정 이용 방지와 비인가 사용 방지 , 가입 의사 확인 , 연령확인 , 만14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인, 불만처리 등 민원처리 , 고지사항 전달

2. 수집하는 개인정보 항목 : 이름 , 생년월일 , 성별 , 로그인ID , 비밀번호 , 자택 전화번호 , 휴대전화번호 , 이메일 , 14세미만 가입자의 경우 법정대리인의 정보

3. 개인정보의 보유기간 및 이용기간

원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.

가. 회사 내부 방침에 의한 정보 보유 사유

o 부정거래 방지 및 쇼핑몰 운영방침에 따른 보관 : 5년

나. 관련 법령에 의한 정보보유 사유

o 계약 또는 청약철회 등에 관한 기록

-보존이유 : 전자상거래등에서의소비자보호에관한법률

-보존기간 : 5년

o 대금 결제 및 재화 등의 공급에 관한 기록

-보존이유: 전자상거래등에서의소비자보호에관한법률

-보존기간 : 5년 

o 소비자 불만 또는 분쟁처리에 관한 기록

-보존이유 : 전자상거래등에서의소비자보호에관한법률

-보존기간 : 3년 

o 로그 기록 

-보존이유: 통신비밀보호법

-보존기간 : 3개월

※ 동의를 거부할 수 있으나 거부시 회원 가입이 불가능합니다.</textarea>
				         </td>
				    </tr>
				    <tr>
				      <td>
				      	<div class="checkbox_group">
				          <span>개인정보 수집 및 이용에 동의하십니까?</span>&nbsp;&nbsp;<input type="checkbox" id="agree_information" name="agree" class="agree_must" onclick='checkSelect()'/><label for="agree_information">동의함</label>
				        </div>  
				      </td>
				    </tr>
					
					<tr>
						<td>
					         <strong style="font-size: 16pt;">[선택] 쇼핑정보 수신 동의</strong>
					   	</td>
					</tr>        
					<tr>
				         <td colspan="2" align="center">
				            <textarea readonly="readonly" class="agree">할인쿠폰 및 혜택, 이벤트, 신상품 소식 등 쇼핑몰에서 제공하는 유익한 쇼핑정보를 SMS와 이메일로 받아보실 수 있습니다. 

단, 주문/거래 정보 및 주요 정책과 관련된 내용은 수신동의 여부와 관계없이 발송됩니다. 

선택 약관에 동의하지 않으셔도 회원가입은 가능하며, 회원가입 후 회원정보수정 페이지에서 언제든지 수신여부를 변경하실 수 있습니다.</textarea>
				         </td>
				    </tr>       
					<tr>
				      <td>
				      	<div class="checkbox_group">
				          <span>SMS 수신을 동의하십니까?</span>&nbsp;&nbsp;<input type="checkbox" id="agree_sms" name="agree" onclick='checkSelect()' /><label for="agree_sms">동의함</label>
				      	</div>
				      </td>
				    </tr>
				    <tr>  
				      <td>
				      	<div class="checkbox_group">
				          <span>이메일 수신을 동의하십니까?</span>&nbsp;&nbsp;<input type="checkbox" id="agree_email" name="agree" onclick='checkSelect()'/><label for="agree_email">동의함</label>
				      	</div>
				      </td>
				    </tr>  
				    <tr align="center">
				        <td style="line-height: 90px;" class="text-center"  colspan="2">
				           <img id="btnRegister" onClick="goRegister();" style="cursor: pointer;" src="<%= ctxPath%>/images/member/btn_member_join1.gif"/>
				           &nbsp;&nbsp;
				           <img id="btnRegisterCancel" onClick="registerCancel()" style="cursor: pointer;" src="<%= ctxPath%>/images/member/btn_member_join_cancel.gif"/>
				        </td>
				    </tr>    
				
			</table> 
		</form>


</div>
	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
%>

<title>회원 정보 수정</title>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_header_footer.css" />

	<!-- 내가만든 CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/member/style_member.css" />
		


	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css">
	
	<!-- Optional JavaScript-->
	<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
 	
<script type="text/javascript">
	
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
	
</script>

<style type="text/css">

</style>

<jsp:include page="/header.jsp"/>

<div class="container">
	<form name="registerFrm" action="updateMember.book">
		<br>
		<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"  />  회원 정보 수정</strong>
		<hr style="border: solid 2px #e8e8e8;">
		
		<br><br>
		<strong style="font-size: 16pt;">기본정보</strong>
		<p id="floatR"><span id="star">*</span> 필수입력사항</p>
		
		<table class="register">
			<tr class="register">
				<th><label class="title" for="userid">아이디&nbsp;<span id="star">*</span></label></th>
				<td><input type="text" class="myinput" id="userid" size="20" maxlength="20" autofocus required autocomplete="off" /> </td>    
			</tr>
			<tr class="register">
				<th><label class="title" for="passwd1">비밀번호&nbsp;<span id="star">*</span></label></th>
				<td><input type="password" class="myinput" id="passwd1" size="20" maxlength="20" required />&nbsp;(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자)</td>
			</tr>
			<tr class="register">
				<th><label class="title" for="passwd2">비밀번호확인&nbsp;<span id="star">*</span></label></th>
				<td><input type="password" class="myinput" id="passwd2" size="20" maxlength="20" required /></td>
			</tr>
			<tr class="register">
			<th id="register">이름 &nbsp;<span id="star">*</span></th>
			    <td>
			        <input required type="text" name="name" id="name" maxlength="20">
			    </td>
			</tr>
			<tr class="register">
				<th>우편번호</th>
			      <td class="register">
			         <input required type="text" id="postcode" size="5" placeholder="우편번호" values="addr" style="width: 100px;" />
			         &nbsp;&nbsp;
			         <img src="<%= ctxPath %>/images/member/btn_zipcode.gif" style="cursor: pointer;" onclick="openDaumPOST();"/>
			      </td>
			</tr>
			<tr class="register">
				<th>주소 &nbsp;<span id="star">*</span></th>
					<td class="register">
						<input class="my-1" required type="text" id="address" size="50" placeholder="주소" /><br>
						<input class="my-1" type="text" id="detailAddress" size="50" placeholder="상세주소" /><br>
						<input class="my-1" type="text" id="extraAddress" size="50" placeholder="참고항목" />                
					</td>
				</tr>
			<tr>
				<th>일반전화 </th>
					<td>
						<select>
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
							<option value="011">011</option>
						</select>&nbsp;-&nbsp;
						<input type="text" size="5" maxlength="4">&nbsp;-&nbsp; 
						<input type="text" size="5" maxlength="4">
					</td>
			</tr >
			<tr>
				<th>휴대전화 &nbsp;<span id="star">*</span></th>
			        <td >
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
					</td>
			</tr>
			<tr>
		         <th>성별&nbsp;<span id="star">*</span></th>
		         <td>
		            <input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%;">남자</label>
		            <input type="radio" id="female" name="gender" value="2" style="margin-left: 7%;" /><label for="female" style="margin-left: 2%;">여자</label>
		         </td>
		    </tr>
		    <tr>
		    	<th>이메일 수신여부</th>
		    	<td>
			    	<input type="radio" id="agree" name="emailAgree" value="1" /><label for="agree" style="margin-left: 2%;">수신함</label>
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
	
<jsp:include page="/footer.jsp"/>
 
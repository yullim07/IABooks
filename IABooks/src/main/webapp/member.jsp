<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
%>

	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css">
	
	<!-- Optional JavaScript-->
	<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
	<%-- 테스트용  --%>
 
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

</script>



<style type="text/css">



table {
	height: 50px;
	margin: 20px 10px; 
	width: 100%;
	
}

th#register {
	width: 150px; 
	padding-left: 20px;
	background-color: #FBFAFA;
}

tr:nth-child(1)  {
	border-top: solid 2px #747474 !important; 
}

tr.register {
	
	border-top: solid 1px #747474;
	border-bottom: solid 1px #747474;
}

td.register {
	padding-left: 20px; 
}

td.agree {
	border-left: solid 1px #747474;
	border-right: solid 1px #747474;
	padding-left: 20px;
	 
	background-color: #FBFAFA;
}

tr {
	height: 50px;
}

span#star {
	color: red;
}

textarea.agree {
	width: 90%;
	height: 200px;
	
}

div#agreebox {
	border: solid 2px #747474;
}

 tr:nth-child(14) {
 	border-bottom: solid 2px #747474 !important; 
 }

td.line {
	border-top: solid 1px #747474 !important; 
}

</style>




<jsp:include page="header.jsp"/>


<div class="container">

	<form name="registerFrm" action="registermember.do">
		<br>
		<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/bar_555.gif" style="width: 6px; height: 20px;"  />  회원 가입</strong>
		<br><br><br>
		
		
			<strong style="font-size: 16pt;">기본정보</strong>
			<p><img src="<%= ctxPath%>/images/bar_eee.gif" style="width: 2px; height: 20px;" />&nbsp;&nbsp;<span id="star">*</span> 필수입력사항</p>
			<table>
				<tr class="register">
					<th id="register"><label class="title" for="userid">아이디&nbsp;<span id="star">*</span></label></th>
					<td class="register"><input type="text" class="myinput" id="userid" size="20" maxlength="20" autofocus required autocomplete="off" /> </td>    
				</tr>
				<tr class="register">
					<th id="register"><label class="title" for="passwd1">비밀번호&nbsp;<span id="star">*</span></label></th>
					<td class="register"><input type="password" class="myinput" id="passwd1" size="20" maxlength="20" required />(영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자)</td>
				</tr>
				<tr class="register">
					<th id="register"><label class="title" for="passwd2">비밀번호확인&nbsp;<span id="star">*</span></label></th>
					<td class="register"><input type="password" class="myinput" id="passwd2" size="20" maxlength="20" required /></td>
				</tr>
				<tr class="register">
				<th id="register">이름 &nbsp;<span id="star">*</span></th>
				    <td class="register">
				        <input required type="text" name="name" id="name" maxlength="20">
				    </td>
				</tr>
				
				
				<tr class="register">
					<th id="register">우편번호</th>
				      <td class="register">
				         <input required type="text" id="postcode" size="5" placeholder="우편번호" values="addr" style="width: 100px;" />
				         &nbsp;&nbsp;
				         <img src="<%= ctxPath %>/images/btn_zipcode.gif" style="cursor: pointer;" onclick="openDaumPOST();"/>
				      </td>
				</tr>
				<tr class="register">
					<th id="register">주소 &nbsp;<span id="star">*</span></th>
						<td class="register">
							<input class="my-1" required type="text" id="address" size="50" placeholder="주소" />기본주소<br>
							<input class="my-1" type="text" id="detailAddress" size="50" placeholder="상세주소" />나머지주소 (선택입력가능)<br>
							<input class="my-1" type="text" id="extraAddress" size="50" placeholder="참고항목" />                
						</td>
					</tr>
				<tr class="register">
					<th id="register">일반전화 <span id="star">*</span></th>
						<td class="register">
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
				<tr class="register">
					<th id="register">휴대전화 &nbsp;<span id="star">*</span></th>
				        <td class="register">
				        	<select>
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="019">019</option>
							</select>&nbsp;-&nbsp;
							<input required type="text" size="5" maxlength="4">&nbsp;-&nbsp; 
							<input required type="text" size="5" maxlength="4">
						 </td>
				     </tr>
				<tr class="register">
					<th id="register">이메일 &nbsp;<span id="star">*</span></th>
						<td class="register">
							<input type="email" class="myinput" id="email" size="20" maxlength="20" required placeholder="email@gmail.com" />
						</td>
				</tr>
				            
				 <tr class="register">
			         <th id="register">생년월일&nbsp;<span id="star">*</span></th>
			         <td class="register">
			            <input type="text" id="datepicker" name="birthday">
			         </td>
			      </tr>
				<tr class="register">
			         <th id="register">성별&nbsp;<span id="star">*</span></th>
			         <td class="register">
			            <input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%;">남자</label>
			            <input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%;">여자</label>
			         </td>
			    </tr>
			</table>
		
			<strong style="font-size: 16pt; margin-left: 20px;">전체 동의</strong>
				<table>
					<tr>
						 <td class="agree">
						 	<div class="checkbox_group">
					    	<label for="agreeAllChecked"><strong>이용약관 및 개인정보수집 및 이용, 쇼핑정보 수신(선택)에 모두 동의합니다.</strong></label>&nbsp;&nbsp;<input type="checkbox" id="agreeAllChecked" onclick='selectAll(this)' >
					    	</div>
						</td>
					</tr>
					<tr>
						<td class="agree line">
					        <strong style="font-size: 16pt;">[필수] 이용약관 동의</strong>
					   	</td>
					</tr>        
					 <tr>
				         <td class="agree" colspan="2" align="center">
				            <textarea readonly="readonly" class="agree">
				            약관내용
							</textarea>
				         </td>
				    </tr>
					<tr>
				      <td class="agree">
				      	<div class="checkbox_group">
				          <span>[필수] 개인정보 수집 및 이용 동의</span>&nbsp;&nbsp;<input type="checkbox" id="agree_privacy" name="agree" onclick='checkSelect()'/><label for="agree_privacy" >동의함</label>
				        </div>  
				      </td>
				    </tr>
					<tr>
						<td class="agree line">
					        <strong style="font-size: 16pt;">[선택] 개인정보 제3자 제공 동의</strong>
					   	</td>
					</tr>    
				    <tr>
				         <td class="agree" colspan="2" align="center">
				            <textarea readonly="readonly" class="agree">
				            약관내용
							</textarea>
				         </td>
				    </tr>
				    <tr>
				      <td class="agree">
				      	<div class="checkbox_group">
				          <span>개인정보 제3자 제공에 동의하십니까?</span>&nbsp;&nbsp;<input type="checkbox" id="agree_information" name="agree" onclick='checkSelect()'/><label for="agree_information">동의함</label>
				        </div>  
				      </td>
				    </tr>
					<tr>
						<td class="agree line">
					        <strong style="font-size: 16pt;">[선택] 개인정보 처리 위탁 동의</strong>
					   	</td>
					</tr>    
					<tr>
				         <td class="agree" colspan="2" align="center">
							<textarea readonly="readonly" class="agree">
				            약관내용
							</textarea>
				         </td>
				    </tr>       
					<tr>
				      <td class="agree" >
				      	<div class="checkbox_group">
				          <span>개인정보 처리 위탁에 동의하십니까?</span>&nbsp;&nbsp;<input type="checkbox" id="agree_consignment" name="agree" onclick='checkSelect()'/><label for="agree_consignment">동의함</label>
				        </div>  
				      </td>
				    </tr>
					<tr>
						<td class="agree line">
					         <strong style="font-size: 16pt;">[선택] 쇼핑정보 수신 동의</strong>
					   	</td>
					</tr>        
					<tr>
				         <td class="agree" colspan="2" align="center">
				            <textarea readonly="readonly" class="agree">
				            약관내용
							</textarea>
				         </td>
				    </tr>       
					<tr>
				      <td class="agree">
				      	<div class="checkbox_group">
				          <span>SMS 수신을 동의하십니까?</span>&nbsp;&nbsp;<input type="checkbox" id="agree_sms" name="agree" onclick='checkSelect()' /><label for="agree_sms">동의함</label>
				      	</div>
				      </td>
				    </tr>
				    <tr>  
				      <td class="agree">
				      	<div class="checkbox_group">
				          <span>이메일 수신을 동의하십니까?</span>&nbsp;&nbsp;<input type="checkbox" id="agree_email" name="agree" onclick='checkSelect()'/><label for="agree_email">동의함</label>
				      	</div>
				      </td>
				    </tr>  
				    <tr align="center">
				        <td style="line-height: 90px;" class="text-center"  colspan="2">
				           <img id="btnRegister" onClick="goRegister();" style="cursor: pointer;" src="<%= ctxPath%>/images/btn_member_join1.gif"/>
				           &nbsp;&nbsp;
				           <img id="btnRegisterCancel" onClick="registerCancel()" style="cursor: pointer;" src="<%= ctxPath%>/images/btn_member_join_cancel.gif"/>
				        </td>
				    </tr>    
				
			</table> 
		</form>


</div>
	
<jsp:include page="footer.jsp"/>
 
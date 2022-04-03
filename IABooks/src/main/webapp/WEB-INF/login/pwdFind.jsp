<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>

	

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
		
		const method = "${requestScope.method}";
		console.log("method =>" + method);
		
		if(method == "GET") {
			$("div#div_findResult").hide();
		}
		else if( method == "POST") {
			$("div#div_findResult").show();
			
			if(${requestScope.sendMailSuccess == true}) {
				$("div#div_btnFind").hide();
			}
		} 
		
		$("input#email").bind("keyup", function(event){
			if(event.keyCode == 13) { 
				 goFind();
			}
		});
		
		$("button#btnFind").click(function() {
			 goFind();
		});
	
		
		$(function(){
			//페이지 로드후 적용되는 스크립트
			
			if("${requestScope.radio}" == 0){
				$("#emailcheck").attr("checked", true)
				$("#phonecheck").attr("checked", false)					
			} else if("${requestScope.radio}" == 1){
				$("#phonecheck").attr("checked", true)
				$("#emailcheck").attr("checked", false)
			}
			
			show();
		});
		
   		// 인증하기 
		$("button#btnConfirmCode").click(function(){
			
			const frm = document.verifyCertificationFrm;
			
			frm.userCertificationCode.value = $("input#input_confirmCode").val();
			frm.userid.value = $("input#userid").val();
			
			frm.action = "<%=ctxPath %>/login/verifyCertification.book";
			frm.method = "post";
			frm.submit();
			
		});
	
	
	
	});	// end of $(document).ready(function()
	
	function show() {
	
	if($('input:radio[id=emailcheck]').is(':checked')){
		$('#mobilefound').hide()
		$('#emailfound').show()
		
	}
	else if($('input:radio[id=phonecheck]').is(':checked')){
		$('#mobilefound').show()
		$('#emailfound').hide()
		
	}
	
	}
	
	
	function goFind() {
	
	const frm = document.pwdFindFrm;
	frm.action = "<%= ctxPath%>/login/pwdFind.book";
	frm.method = "post";
	frm.submit();
	
	}


</script>
<style type="text/css">

	table.pwdFind {
		
		margin: 0 auto;
	}
	
	table.pwdFind > thead > tr > td {
		height: 50px;
		text-align: center;
	}
	
	input[type="radio"] {
	  margin-top: -1px;
	  vertical-align: middle;
	}
	
	table.pwdFind > tbody > tr > td {
		height: 50px;
		text-align: center;
	}
	
	
	table.pwdFind > tbody > tr > th {
		padding-right: 30px;
		height: 50px;
	}
	
	table.pwdFind > tfoot > tr > td {
		width:200px;
		height: 100px;
	}
	
	div.titleArea  {
		margin-top:10px;
	}
 	
	div#found {
		text-align : center;
		border: 5px solid #d7d5d5;
		margin: 30px 0;
	}
	
	input {
		height: 35px;
	}
	
	input.phonenb {
		width: 50px;
	}

 	button#btnFind {
	    color: white;
	    background-color: #00334d;
	    border-radius: 5px;
	    height: 50px;
	    width: 100px;
	    font-size: 13pt;
	    font-weight: bold;
		}
	
</style>
<title>비밀번호 찾기</title>
<jsp:include page="/WEB-INF/header.jsp"/>
<div class="container">
	<div class="titleArea">
		<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;비밀번호 찾기</strong>
    </div>
	<hr style="border: solid 2px #e8e8e8;">
    
   	<div id="found">
    	<form name="pwdFindFrm">
    		<table class="pwdFind" >
	    		<thead>
	    			<tr>
	    				<td colspan="3" style="text-align: center;">
	    					<strong style="font-size: 16pt;">비밀번호 찾기</strong>
	    				</td>
	    			</tr>
		    		<tr>
		    			<td colspan="2">
			    			<label for="emailcheck">이메일</label>&nbsp;
			    			<input type="radio" name="check" id="emailcheck" value="0" checked="checked" onchange="show()">
		    			</td>
		    			<td>
		    				<label for="phonecheck">휴대폰번호</label>&nbsp;
		    				<input type="radio" name="check" id="phonecheck" value="1" onchange="show()">
		    			</td>
					</tr>
	    		</thead>	
				
				<tbody>
					<tr>
						<th>
							<img src="<%= ctxPath%>/images/member/arrow_menu.gif" />&nbsp;아이디
						</th>
						<td colspan="2">	
							<input  type="text" placeholder="ID" name="userid">
						</td>	
					</tr>
					<tr>
						<th>
							<img src="<%= ctxPath%>/images/member/arrow_menu.gif" />&nbsp;이름
						</th>
						<td colspan="2">
							<input type="text" placeholder="홍길동" name="name">
						</td>	
					</tr>
					<tr id = "emailfound">				
						<th>
							<img src="<%= ctxPath%>/images/member/arrow_menu.gif" />&nbsp;이메일로찾기
						</th>
						<td colspan="2">	
							<input type="text" placeholder="hongkd@email.com" name="email">
						</td>	
					</tr>
					<tr id = "mobilefound">
						<th>
							<img src="<%= ctxPath%>/images/member/arrow_menu.gif" />&nbsp;휴대폰번호로찾기
						</th>	
						<td colspan="2">
							<input type="text" class="phonenb" maxlength='3' value="010" readonly>&nbsp;-&nbsp;<input type="text" class="phonenb" name="phone_one" maxlength='4'  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />&nbsp;-&nbsp;<input type="text" class="phonenb" name="phone_two" maxlength='4'  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3" style="text-align: center;" >
							<button type="button" class="btn btn-success" id="btnFind" onclick="goFind();">확인</button>
						</td>	
					</tr>
				</tfoot>
			</table>
			
			<div class="my-3" id="div_findResult">
		        	<p class="text-center">
		        <c:if test="${requestScope.isUserExist == false}">
		        	<span style="color: red;">사용자 정보가 없습니다.</span>
		        </c:if>	
	        	
		        <c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == true }">
		        	 <span style="font-size: 10pt;">인증코드가 ${requestScope.email}로 발송되었습니다.</span><br>
		             <span style="font-size: 10pt;">인증코드를 입력해주세요.</span><br>
		             <input type="text" name="input_confirmCode" id="input_confirmCode" required />
		             <br><br>
		             <button type="button" class="btn btn-info" id="btnConfirmCode">인증하기</button>
		             
		        </c:if>	
		        	
		        <c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == false}">
		        	<span style="color: red;">메일발송이 실패했습니다.</span>
		        </c:if>	
		      </p>
	  		</div>
		</form>	
	</div>
	
	<form name="verifyCertificationFrm">
	<input type="hidden" name="userCertificationCode">
	<input type="hidden" name="userid">
</form>
		
</div>	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
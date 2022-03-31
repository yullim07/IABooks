<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>

	

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		//페이지 로드후 적용되는 스크립트
		show()
	});
	
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

 	#commit {
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
    	
    	<form>
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
			    			<input type="radio" name="check" id="emailcheck" checked="checked" onchange="show()">
		    			</td>
		    			<td>
		    				<label for="phonecheck">휴대폰번호</label>&nbsp;
		    				<input type="radio" name="check" id="phonecheck" onchange="show()">
		    			</td>
					</tr>
	    		</thead>	
				
				<tbody>
					<tr>
						<th>
							<img src="<%= ctxPath%>/images/member/arrow_menu.gif" />&nbsp;아이디
						</th>
						<td colspan="2">	
							<input  type="text" placeholder="ID">
						</td>	
					</tr>
					<tr>
						<th>
							<img src="<%= ctxPath%>/images/member/arrow_menu.gif" />&nbsp;이름
						</th>
						<td colspan="2">
							<input type="text" placeholder="홍길동">
						</td>	
					</tr>
					<tr id = "emailfound">				
						<th>
							<img src="<%= ctxPath%>/images/member/arrow_menu.gif" />&nbsp;이메일로찾기
						</th>
						<td colspan="2">	
							<input type="text" placeholder="hongkd@email.com">
						</td>	
					</tr>
					<tr id = "mobilefound">
						<th>
							<img src="<%= ctxPath%>/images/member/arrow_menu.gif" />&nbsp;휴대폰번호로찾기
						</th>	
						<td colspan="2">
							<input type="text" class="phonenb" maxlength='3' value="010" readonly>&nbsp;-&nbsp;<input type="text" class="phonenb" maxlength='4'  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />&nbsp;-&nbsp;<input type="text" class="phonenb" maxlength='4'  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3" style="text-align: center;" >
							<input type="button" id="commit" value = "확인">
						</td>	
					</tr>
				</tfoot>
			</table>
		</form>	
	</div>
		
</div>	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
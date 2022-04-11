<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="/WEB-INF/header.jsp"/>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("div#smsResult").hide();
		
		// 휴대폰으로 문자를 보내기 위해서 -를 없애준다.
	 	let phone = "${requestScope.mvo.phone}".split("-");	
		
		$("button#btnSend").click( ()=>{
			
		//	console.log( $("input#reservedate").val() + " " + $("input#reservetime").val() );
		//  2022-04-05 11:20
		
		    let reservedate = $("input#reservedate").val();
		    reservedate = reservedate.split("-").join("");
		    
		    let reservetime = $("input#reservetime").val();
		    reservetime = reservetime.split(":").join("");
		    
		    const datetime = reservedate + reservetime;
		    
		 // console.log(datetime);
		 // 202204051120
		    
		    let dataObj;

		 
		    if( reservedate == "" || reservetime == "" ) {
		    	dataObj = {"phone":phone[0]+phone[1]+phone[2], 
		    			   "smsContent":$("textarea#smsContent").val()};
		    }
		    else {
		    	dataObj = {"phone":phone[0]+phone[1]+phone[2], 
		    			   "smsContent":$("textarea#smsContent").val(),
		    			   "datetime":datetime};
		    }
		    
		    $.ajax({
		    	url:"<%= request.getContextPath()%>/member/smsSend.book",
		    	type:"POST",
		    	data:dataObj,
		    	dataType:"json",
		    	success:function(json) {
		    		// json 은 {"group_id":"R2GTf32L02lB7JAk","success_count":1,"error_count":0}
		    		
		    		if(json.success_count == 1) {
		    			$("div#smsResult").html("문자전송이 성공되었습니다.");
		    		} else if(json.error_count != 0) {
		    			$("div#smsResult").html("문자전송이 실패되었습니다.");
		    		}
		    		
		    		$("div#smsResult").show();
		    		$("textarea#smsContent").val("");

		    	},
		    	error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
		    });
			
		});
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		
	}); // end of $(document).ready(function()

	
			
			
	// function declaration 
	function goMemberList() {
		let goBackURL = "${requestScope.goBackURL}";
		// /member/memberList.up?currentShowPageNo=5 sizePerPage=10 searchType=name searchWord=유
		
		// 자바스크립트에서는  replaceall 이 없고 replace 밖에 없다.
    	// !!! 자바스크립트에서 replace를 replaceall 처럼 사용하기 !!! //
     	// "korea kena" ==> "korea kena".replace("k","y") ==> "yorea kena"
    	// "korea kena".replace(/k/gi, "y") ==> "yorea yena"  여기서 주의할 것은 /"k"/ 아니라 /k/ 와 같이 "" 가 없어야 한다.
		
    	// 변수 goBackURL 에 공백 " " 을 모두 "&"로 변경하도록 한다.
    	goBackURL = goBackURL.replace(/ /gi , "&");
    //	또는
	//	goBackURL = goBackURL.replaceAll(" ", "&"); // 20년도에 스크립트에 replaceAll 함수 추가되었음
		location.href = "<%= ctxPath%>" +goBackURL;
	}		
	
	// 쿠폰조회
	let userid = "${requestScope.mvo.userid}";
	function userCouponList(userid) {
		
		
		// 쿠폰조회
		const url = "<%= request.getContextPath()%>/member/admin/userCouponList.book?userid="+userid;
		
		// 너비 800, 높이 600 인 팝업창을 화면 가운데 위치시키기
		const pop_width = 800;
		const pop_height = 600;
		const pop_left = Math.ceil( ((window.screen.width)-pop_width)/2 ) ; <%-- 정수로 만든다 --%>
		const pop_top = Math.ceil( ((window.screen.height)-pop_height)/2 ) ;
		
		window.open(url, "userCouponList",
				   	"left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height );
		
	}		
		
	
	// 유저상태 변경
	function userStatusUpdate() {
		
		const frm = document.userStatusFrm;
		frm.action = "userStatus.book"
		frm.method = "post";
		frm.submit();
		
	}
	
	
</script>

<style type="text/css">

table#userInfo {
	width: 60%;
	margin : auto;
	border-bottom: solid 3px grey;
	border-top: solid 3px grey;
}



table#userInfo tr {
	border-bottom: solid 1px grey;
	border-top: solid 1px grey;
	
}

table#userInfo td {
	padding: 10px;	
	margin-left: 20px; 
}

table#userInfo > tbody >  tr > td:first-child {
	background-color: #FBFAFA;
	font-weight: bold;
}



div#sms {
		text-align: center;
		margin: 0 auto; 
		/* border: solid 1px red; */ 
		overflow: hidden; 
		width: 50%;
		padding: 10px 0 10px 80px;
	}
	
span#smsTitle {
	display: block;
	font-size: 13pt;
	font-weight: bold;
	margin-bottom: 10px;
}

textarea#smsContent {
	float: left;
	height: 100px;
}

button#btnSend {
	float: left;
	border: none;
	width: 50px;
	height: 100px;
	background-color: #212529;
	color: white;
}

div#smsResult {
	clear: both;
	color: red;
	padding: 20px;
}	

button.btn {
	height: 50px;
	padding: 10px;
	border: none;
	background-color: #212529;
	color: white;
}

button.btn:hover {
	color: grey;
}

a#btn_coupon {
	cursor: pointer;
}	
	
button#btn_userStatus {
	border: none;
	background-color: #212529;
	color: white;
}	
	
</style>


<div class="container">

	<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px; "/>&nbsp;${requestScope.mvo.name} 님의 회원 상세정보</strong>
		<hr style="border: solid 2px #e8e8e8;">

	<c:if test="${empty requestScope.mvo}">
		존재하지 않는 회원입니다.<br>
	</c:if>
	
	<c:if test="${not empty requestScope.mvo}">
		
		<div id="mvoInfo">
		   <table id="userInfo">
		   	  <tr style="border-top: none;">
		   	  	<td><span class="myli">아이디</span></td>
		   	  	<td><span>${requestScope.mvo.userid}</span></td> 
		   	  </tr>
		   	  <tr>
		   	  	<td><span class="myli">회원명</span></td>
		   	  	<td><span>${requestScope.mvo.name}</span></td>
		   	  </tr>
		   	  <tr>
		   	  	<td><span class="myli">이메일</span></td>
		   	  	<td><span>${requestScope.mvo.email}</span></td>
		   	  </tr>
		   	  <tr>
		   	  	<td><span class="myli">휴대폰</span></td>
		   	  	<td><span>${requestScope.mvo.phone}</span></td>
		   	  </tr>
		   	  <tr>
		   	  	<td><span class="myli">우편번호</span></td>
		   	  	<td><span>${requestScope.mvo.postcode}</span></td>
		   	  </tr>
		   	  <tr>
		   	  	<td> <span class="myli">주소</span></td>
		   	  	<td><span>${requestScope.mvo.address}&nbsp;${requestScope.mvo.detailaddress}&nbsp;${requestScope.mvo.extraaddress}</span></td>
		   	  </tr>
		   	  <tr>
		   	  	<td><span class="myli">성별</span></td>
		   	  	<td><span><c:choose><c:when test="${requestScope.mvo.gender eq '1'}">남</c:when><c:otherwise>여</c:otherwise></c:choose></span></td>
		   	  </tr>
		   	  <tr>
		   	  	<td><span class="myli">생년월일</span></td>
		   	  	<td><span>${requestScope.mvo.birthday}</span></td>
		   	  </tr>
		   	  <tr>
		   	  	<td><span class="myli">나이</span>	</td>
		   	  	<td><span>${requestScope.mvo.age}세</span></td>
		   	  </tr>
		   	  <tr style="border-bottom: none;">
		   	  	<td><span class="myli">가입일자</span></td>
		   	  	<td><span>${requestScope.mvo.registerday}</span></td>
		   	  </tr>
		   	  <tr>
		   	  	<td><span class="myli"> 쿠폰내역조회</span></td>
		   	  	<td><a onclick="userCouponList(userid);" id="btn_coupon">${requestScope.mvo.name}님의 쿠폰</a></td>
		   	  </tr>
		   	  <tr>
		   	  	<td><span class="myli"> 회원상태변경</span></td>
		   	  	<td>
					<form name="userStatusFrm">
						<select name="userStatus">
							<option value="normal">일반회원</option>
							<option value="u_status">휴면계정전환</option>
							<option value="status">회원탈퇴</option>
						</select>	
							<input type="hidden" value="${requestScope.mvo.userid}"  name="userid"/>
						<button onclick="userStatusUpdate(userid);" id="btn_userStatus" >변경하기</button>
					</form>			   	  	
		   	  	</td>
		   	  </tr>
		   </table>
		</div>
		
		<%-- ==== 휴대폰 SMS(문자) 보내기 ==== --%>
		<div id="sms" align="left" class="my-5 mx-auto">
		  	<span id="smsTitle"><i class="far fa-comment-alt"></i>&nbsp;&nbsp;휴대폰 SMS(문자) 보내기 내용 입력란</span>
		  	<div style="margin-bottom : 20px;">
		  		발송예약일&nbsp;<input type="date" id="reservedate" />&nbsp;<input type="time" id="reservetime" />
		  	</div>
		  	<textarea rows="4" cols="40" id="smsContent"></textarea>
		  	<button id="btnSend">전송</button>
		  	<div id="smsResult"></div>
		</div>
		
	</c:if>
	
	<div style="text-align: center; margin-bottom: 80px;">
		<button class="btn" style="margin-top: 50px;" type="button" onclick="javascript:location.href='memberList.book'">이전페이지로 돌아가기</button> 
		&nbsp;&nbsp;
		<button class="btn" style="margin-top: 50px;" type="button" onclick="goMemberList()">확인</button>
	</div>
	
</div>	
	
	
<jsp:include page="/WEB-INF/footer.jsp"/>
    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>도서 등록</title>

<style type="text/css">

	body {
	 /* border: solid 1px gray; */
		margin: 0;
		padding: 0;
		font-family: Arial, "MS Trebuchet", sans-serif;
		word-break: break-all;  /* 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */
	}

	div#container {
	 /* border: solid 1px gray; */
		width: 80%;
		margin: 0 auto;
	}
	
	form {
		margin: 100px 0; 
	}
	
	legend {
		font-size: 20pt;
	}
	
	label.title {
		display: inline-block;
		width: 150px;
		color: navy;
		font-weight: bold; 
	}
	
	ul {
	 /* border: solid 1px red; */
		list-style-type: none;
		padding-left: 0;
	}
	
	li {
		line-height: 40px;
	}

    input.myinput {
    	height: 20px; 
    }


  /* 
    input[type="radio"] {
    	margin-right: 50px; 
    } 
  */

    /* 라디오 요소에 체크를 했을 경우 라디오 요소의 테두리를 오렌지색으로 주겠다.  */
    input[type="radio"]:checked { 
    	box-shadow: 0 0 0 3px orange;
    }
    
    
    /* 체크박스 요소에 체크를 했을 경우 체크박스 요소의 테두리를 분홍색으로 주겠다.  */
    input[type="checkbox"]:checked {
    	box-shadow: 0 0 0 3px pink;
    }
    

    label[for="female"] {
    	padding-left: 50px; 
    }
    
     
    select {
    	width: 150px;
    }  
    
    select.myselect {
    	height: 25px;
    }

    input.btn {
    	width: 100px;
    	height: 40px;
    	margin: 20px 0 0 40px; 
    	font-size: 14pt;
    	cursor: pointer;
    	color: #fff; 
    	border: none;
    	
    	border-radius: 10%;  /* 사각형을 깍어서 둥근사각형으로 만들어 주는 것  */
    }
    
    input[type="submit"] {
    	background-color: #001a66;
    }
    
    input[type="reset"] {
    	background-color: #990000; 
    } 
    
    
    span.errmsg {
    	font-size: 9pt;
    	color: red;
    	font-weight: bold; 
    }

</style>

</head>
<body>
	<div id="container">
    <form name="registerFrm" action="register.do" method="post"> 
 
  <!--  form 태그에서 method 를 지정하지 않으면 즉,생략하면 기본은 "GET"방식이다.
 	    form 태그에서 사용하는 method 는 2가지가 있는데 get 과 post 가 있다.
		get 은 전송하고자 하는 데이터를 웹브라우저 주소창에 실어서 보내는 방식이고,
		post 는 전송하고자 하는 데이터를 본문속에 감추어서 보내는 방식이다.
		그래서 get 은 보안성이 떨어지는 반면에 속도는 post 보다 빠르다.
		post는 보안성은 좋지만 속도는 get 보다는 느린편이다.
		그러므로 외부에 공개해서는 안되는 작업인 회원가입, 물품구매, 회원수정 등 DML(insert, update, delete)작업은 
		일반적으로 post 방식으로 하고, 
		외부에 공개하더라도 전혀 무관한 데이터 검색(예: 물품조회, 게시판글 검색)인 select 작업은
		일반적으로 get 방식으로 한다.
		method 를 기재하지 않으면 get 방식이다. 
		 
		!!! 또한 파일을 첨부하려면 반드시 method="post" 이어야만 한다. !!!
   -->	    
  <!--  <form name="registerFrm" action="register.do" method="get"> -->
	   		<!-- fieldset 태그는 폼을 그룹핑(묶어주는 것)하는 역할 -->
	   		<fieldset>
	   		
	   		    <!-- legend 태그는 fieldset 에 대한 제목을 지정하는 것이다. -->
	   			<legend>도서 등록하기</legend>
	   			
	   			<h3>품목 정보</h3>
	   			
	   			<ul>
	   				<li>
	   				    <label class="title">카테고리 분야</label>
	   				    <select class="myselect" name="cate_num">
	   				        <option>카테고리</option>
	   				        <option value="1">인문</option>
	   				        <option value="2">사회</option>
	   				        <option value="3">과학</option>
	   				    </select>
	   				    &nbsp;&nbsp;<span id="errCate_num" class="errmsg"></span>
	   				</li>
	   				
	   				<li>
	   				    <label for="pro_num" class="title">국제표준도서번호</label>
	   				    <input type="text" name="pro_num" id="pro_num" class="myinput" size="20" maxlength="20" autofocus required />
	   				    <span id="errPro_num" class="errmsg"></span>
	   				</li>
	   				
	   				<li>
	   				    <label for="pro_name" class="title">도서명</label>
	   				    <input type="text" name="pro_name" id="pro_name" class="myinput" size="20" maxlength="20" autofocus required />
	   				    <span id="errPro_name" class="errmsg"></span>
	   				</li>
	   				
	   				<li>
	   				    <label for="pro_subname" class="title">부제</label>
	   				    <input type="text" name="pro_subname" id="pro_subname" class="myinput" size="20" maxlength="20" autofocus required />
	   				    <span id="errPro_subname" class="errmsg"></span>
	   				</li>
	   			
	   				<li>
	   				    <label for="wr_code" class="title">저자코드</label>
	   				    <input type="text" name="wr_code" id="wr_code" class="myinput" size="20" maxlength="20" autofocus required />
	   				    <span id="errWr_code" class="errmsg"></span>
	   				</li>
	   				
	   				<li>
	   				    <label for="wr_name" class="title">저자명</label>
	   				    <input type="text" name="wr_name" id="wr_name" class="myinput" size="20" maxlength="20" autofocus required />
	   				    <span id="errWr_name" class="errmsg"></span>
	   				</li>
	   				
	   				
	   				
	   				<li>
	   				    <label for="publisher" class="title">출판사</label>
	   				    <input type="text" name="publisher" id="publisher" class="myinput" size="20" maxlength="20" autofocus required />
	   				    <span id="errPublisher" class="errmsg"></span>
	   				</li>
	   				
	   				<li>
	   				    <label for="publish_date" class="title">출간일자</label>
	   				    <input type="text" name="publish_date" id="publish_date" class="myinput" size="20" maxlength="20" autofocus required />
	   				    <span id="errPublish_date" class="errmsg"></span>
	   				</li>
	   				
	   				<li>
	   				    <label for="genre" class="title">분야</label>
	   				    <input type="text" name="genre" id="genre" class="myinput" size="20" maxlength="20" autofocus required />
	   				    <span id="errGenre" class="errmsg"></span>
	   				</li>
	   				
	   				<li>
	   				    <label class="title">제본형태</label>
	   				    <select class="myselect" name="bindtype">
	   				        <option>제본형태</option>
	   				        <option value="1">양장제본</option>
	   				        <option value="2">반양장제본</option>
	   				        <option value="3">무선제본</option>
	   				        <option value="4">중철제본</option>
	   				        <option value="5">무선제본</option>
	   				        <option value="6">스프링제본</option>
	   				    </select>
	   				    &nbsp;&nbsp;<span id="errBindtype" class="errmsg"></span>
	   				</li>
	   				
	   				<li>
	   				    <label for="spec_pages" class="title">쪽수</label>
	   				    <input type="text" name="spec_pages" id="spec_pages" class="myinput" size="20" maxlength="40" required /> 
	   				    <span id="errSpec_pages" class="errmsg"></span>
	   				</li>
	   				
	   				<li>
	   				    <label for="spec_size" class="title">크기</label>
	   				    <input type="text" name="spec_size" id="spec_size" class="myinput" size="20" maxlength="40" required /> 
	   				    <span id="errSpec_size" class="errmsg"></span>
	   				</li>
	   				
	   				<li>
	   				    <label for="pro_price" class="title">정가</label>
	   				    <input type="text" name="pro_price" id="pro_price" class="myinput" size="20" maxlength="20" required />
	   				    <span id="errPro_price" class="errmsg"></span>
	   				</li>
	   				
	   				<li>
	   				    <label for="saleprice" class="title">판매가</label>
	   				    <input type="text" name="saleprice" id="saleprice" class="myinput" size="20" maxlength="40" required /> 
	   				    <span id="errSaleprice" class="errmsg"></span>
	   				</li>
	   			</ul>
	   			
	   			
	   			<hr>
	   			
	   			<h3>책 정보</h3>
	   			
	   			<ul>
	   				<li>
	   				    <label for="book_info" class="title">책소개</label>
	   				    <textarea rows="5" cols="30" id="book_info" name="book_info"></textarea>
	   				    <span id="errBook_info" class="errmsg"></span>
	   				</li>
	   			
	   				<li>
	   				    <label for="wr_info" class="title">저자소개</label>
	   				    <textarea rows="5" cols="30" id="wr_info" name="wr_info"></textarea>
	   				    <span id="errWr_info" class="errmsg"></span>
	   				</li>
	   			
	   				<li>
	   				    <label for="pro_index" class="title">목차</label>
	   				    <textarea rows="5" cols="30" id="pro_index" name="pro_index"></textarea>
	   				    <span id="errPro_index" class="errmsg"></span>
	   				</li>
	   			
	   				<li>
	   				    <label for="extract_book" class="title">책속으로</label>
	   				    <textarea rows="5" cols="30" id="extract_book" name="extract_book"></textarea>
	   				    <span id="errExtract_book" class="errmsg"></span>
	   				</li>
	   			</ul>
	   				
	   			<hr>
	   			<h3>판매 정보</h3>
	   			<ul>
	   				<li>
	   				    <label for="pro_qty" class="title">재고량</label>
	   				    <input type="text" name="pro_qty" id="pro_qty" class="myinput" size="20" maxlength="20" autofocus required />
	   				    <span id="errPro_qty" class="errmsg"></span>
	   				</li>
	   				
	   				<li>
	   				    <label for="pro_sales" class="title">판매량</label>
	   				    <input type="text" name="pro_sales" id="pro_sales" class="myinput" size="20" maxlength="20" autofocus required />
	   				    <span id="errPro_sales" class="errmsg"></span>
	   				</li>
	   			</ul>
	   			
	   			<hr>	
	   			<h3>이미지 정보</h3>
	   			<ul>
	   				<li>
	   				    <label for="addFile" class="title">파일첨부</label>
	   				    <input type="file" id="addFile" /> 
	   				</li>
	   			</ul>
	   			
	   			<hr>
	   			
	   			<ul>
	   				<li>
	   				    <input type="submit" value="확인" class="btn" />
	   				    <input type="reset" value="취소"  class="btn" />
	   				</li>
	   			</ul>
	   			
	   		</fieldset>
	   </form>
	</div>
	
<script type="text/javascript">

    const now = new Date();                // 자바스크립트에서 현재날짜시각을 알려주는 것이다.
    const currentYear = now.getFullYear(); // 현재년도 

	let sOption_1 = "<option>출생년도1</option>";
	for(let i=0; i<currentYear-1950+1; i++) {
		sOption_1 +=  "<option>"+(1950+i)+"</option>";
	}// end of for----------------------------------------
	
	document.querySelector("select#birthYear1").innerHTML = sOption_1;
	
	
	let sOption_2 = "<option>출생년도2</option>";
	for(let i=0; i<currentYear-1950+1; i++) {
		sOption_2 +=  "<option>"+(1950+i)+"</option>";
	}// end of for----------------------------------------
	
	document.querySelector("select#birthYear2").innerHTML = sOption_2;
	
	
	let sOption_3 = "<option>출생년도3</option>";
	for(let i=0; i<currentYear-1950+1; i++) {
		sOption_3 +=  "<option>"+(1950+i)+"</option>";
	}// end of for----------------------------------------
	
	document.querySelector("select#birthYear3").innerHTML = sOption_3;
	
	/////////////////////////////////////////////////////////////////////
	
	const select1 = document.querySelector("select#birthYear1");
	
	select1.addEventListener("change", function() {
		
		const val = select1.value;
		
	//	console.log(isNaN(val));
		// NaN 은 Not a Number 인데 
		/*
		   isNaN(값); ==> 값이 숫자가 아니라면 true
		   isNaN(값); ==> 값이 숫자가 이라면  false
		*/
		
		// 현재나이 구하기
		if(isNaN(val)) { // "출생년도1" 을 선택한 경우임.
			alert("태어나신 년도를 선택하세요");
			document.querySelector("span#age").innerHTML = "";
		}
		else {  // 올바른 숫자년도를 선택한 경우임.
			const age = currentYear - val + 1;
			document.querySelector("span#age").innerHTML = age;
		}
	});
	
	
	
	const select2 = document.querySelector("select#birthYear2");
	
	select2.onchange = function(){  // onchange 으로 해야지 onChange 하면 작동을 하지 않는다.!!
		
		const val = select2.value;
		
	 // console.log(isNaN(val));
		// NaN 은 Not a Number 인데 
		/*
		   isNaN(값); ==> 값이 숫자가 아니라면 true
		   isNaN(값); ==> 값이 숫자가 이라면  false
		*/
		
		// 현재나이 구하기
		if(isNaN(val)) { // "출생년도2" 을 선택한 경우임.
			alert("태어나신 년도를 선택하세요");
			document.querySelector("span#age").innerHTML = "";
		}
		else {  // 올바른 숫자년도를 선택한 경우임.
			const age = currentYear - val + 1;
			document.querySelector("span#age").innerHTML = age;
		}
	};
	
	
	
    const select3 = document.querySelector("select#birthYear3");
	
	select3.onchange = ()=>{  // onchange 으로 해야지 onChange 하면 작동을 하지 않는다.!!
		
		const val = select3.value;
		
	 // console.log(isNaN(val));
		// NaN 은 Not a Number 인데 
		/*
		   isNaN(값); ==> 값이 숫자가 아니라면 true
		   isNaN(값); ==> 값이 숫자가 이라면  false
		*/
		
		// 현재나이 구하기
		if(isNaN(val)) { // "출생년도3" 을 선택한 경우임.
			alert("태어나신 년도를 선택하세요");
			document.querySelector("span#age").innerHTML = "";
		}
		else {  // 올바른 숫자년도를 선택한 경우임.
			const age = currentYear - val + 1;
			document.querySelector("span#age").innerHTML = age;
		}
	};
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////
	
	// === submit 버튼을 클릭하면 해야할 일들을 기술하기 === //
	const frm = document.registerFrm;
	
	frm.onsubmit = () => {
		
		let isSubmit = true;
		
		// 1. 사용자 ID는 5글자 이상 20글자 이하 이어야 하고 첫글자는 영문대문자 이어야 하고 그 나머지는 영문자 또는 숫자로 이루어져야 한다. 
		// 올바른예 : Superman , Batman007
		// 틀린예: superman, Lees, Batman007$
		
		// === 정규표현식 객체 만들기 === //
		// 정규표현식 객체는 항상 / 로 시작해서 / 로 끝나고 ; 을 붙여주면 된다.
		let regExp = /^[A-Z][A-Za-z0-9]{4,19}$/;
		
		// 위에서 생성한 정규표현식 객체에 데이터값을 넣어서 검사를 한다.
		const bUserid = regExp.test(frm.userid.value);
		// frm.userid.value 값이 regExp 패턴에 맞으면 true,
		// frm.userid.value 값이 regExp 패턴에 틀리면 false
		
		if(!bUserid) {
		    
			document.querySelector("span#errUserid").innerHTML = "5글자~20글자 이어야 하고 첫글자는 영문대문자 나머지는 소문자 또는 숫자 이어야 합니다";
			frm.userid.value = "";
			frm.userid.focus();
			
			isSubmit = false;
		}
		else {
			document.querySelector("span#errUserid").innerHTML = "";
		}
		
		
		
		// 2. 암호는 8글자 이상 15글자 이하이어야 하고, 영문자, 숫자, 특수문자가 혼합되어야만 한다.
		// 올바른예 : qwer1234$ , Abcd007!
		// 틀린예: qw12$ , qwer12345 
		regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
		
		// 위에서 생성한 정규표현식 객체에 데이터값을 넣어서 검사를 한다.
		const bPasswd = regExp.test(frm.passwd.value);
		// frm.passwd.value 값이 regExp 패턴에 맞으면 true,
		// frm.passwd.value 값이 regExp 패턴에 틀리면 false
		
		if(!bPasswd) {
		    
			document.querySelector("span#errPasswd").innerHTML = "비밀번호는 8글자 이상 15글자 이하이어야 하고, 영문자, 숫자, 특수문자가 혼합되어야 합니다";
			frm.passwd.value = "";
			frm.passwd.focus();
			
			isSubmit = false;
		}
		else {
			document.querySelector("span#errPasswd").innerHTML = "";
		}
		
		
		// 3. 암호 입력란과 암호확인 입력란의 데이터가 동일한지 아닌지 검사하기
		if(frm.passwd.value != document.querySelector("input[type=password]#passwd2").value) {
			
			document.querySelector("span#errPasswd2").innerHTML = "비밀번호와 비밀번호확인 값이 일치하지 않습니다";
			frm.passwd.value = "";
			document.querySelector("input[type=password]#passwd2").value = "";
			frm.passwd.focus();
			
			isSubmit = false;
		}
		else {
			document.querySelector("span#errPasswd2").innerHTML = "";
		}
		
		
		// 4. 성명은 공백만으로 이루어지면 안된다. 반드시 공백이 아닌 값을 입력해주어야 한다.
		regExp = /\s/g;
		
		// 위에서 생성한 정규표현식 객체에 데이터값을 넣어서 검사를 한다.
		const bName = regExp.test(frm.name.value);
		// frm.name.value 값이 regExp 패턴에 맞으면 true,
		// frm.name.value 값이 regExp 패턴에 틀리면 false
		
		if(bName) {
			document.querySelector("span#errName").innerHTML = "성명은 공백만으로는 안됩니다";
			frm.name.value = "";
			frm.name.focus();
			
			isSubmit = false;
		}
		else {
			document.querySelector("span#errName").innerHTML = "";
		}
		
		
		// 5. 이메일은 필수 입력사항이므로 반드시 값을 입력해야 한다.
		// 올바른예 : leess@naver.com
		// 틀린예: leessnaver.com , leess@naver.@com
		
		regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; 
			
		const bEmail = regExp.test(frm.email.value); 
		
		if(!bEmail) {
			document.querySelector("span#errEmail").innerHTML = "e메일 형식에 맞지 않습니다";
			frm.email.value = "";
			frm.email.focus();
			
			isSubmit = false;
		}
		else {
			document.querySelector("span#errEmail").innerHTML = "";
		}
		
		
		// 6. 성별을 선택했는지 검사하기(라디오에서 선택했는지 안했는지 검사하기)
		const gender_list = document.querySelectorAll("input[name='gender']:checked");
		
		if(gender_list.length == 0) {
			document.querySelector("span#errGender").innerHTML = "성별을 선택하셔야 합니다";
			isSubmit = false;
		}
		else {
			document.querySelector("span#errGender").innerHTML = "";
		} 
			
		
		// 7. 취미는 최소 2개 이상 선택했는지 검사하기(체크박스에서 선택했는지 안했는지 검사하기)
		const hobby_list = document.querySelectorAll("input[name='hobby']:checked");
		
		if(hobby_list.length < 2) {
			document.querySelector("span#errHobby").innerHTML = "취미는 최소 2개 이상을 선택하셔야 합니다";
			isSubmit = false;
		}
		else {
			document.querySelector("span#errHobby").innerHTML = "";
		} 
		
		
		// 8. 출생년도를 선택했는지 검사하기
		const birthYear = document.querySelector("select#birthYear1").value;
		
		if( isNaN(birthYear) ) {
			// isNaN(birthYear) 은 birthYear 가 숫자로 되어있지 않으면 true
			// isNaN(birthYear) 은 birthYear 가 숫자로 되어 있으면 false
			
			document.querySelector("span#errBirthYear").innerHTML = "출생년도를 올바르게 선택하세요";
			isSubmit = false;
		}
		else {
			document.querySelector("span#errBirthYear").innerHTML = "";
		}
		
		
		// 9. 최종학력을 선택했는지 검사하기
		const school = document.querySelector("select[name='school']").value;
		
		if(school == "최종학력") {
			document.querySelector("span#errSchool").innerHTML = "최종학력을 올바르게 선택하세요";
			isSubmit = false;
		}
		else {
			document.querySelector("span#errSchool").innerHTML = "";
		}
		
		// 10. 가입인사말을 입력했는지 검사하기
		const registerComment = document.querySelector("textarea#registerComment").value;
		
		if(registerComment.trim() == "") {
			document.querySelector("span#errRegisterComment").innerHTML = "가입인사말을 입력하시되 공백만으로는 되지 않습니다.";
			isSubmit = false;
		}
		else {
			document.querySelector("span#errRegisterComment").innerHTML = "";
		}
		
		
		if(!isSubmit) {
			return false; // 서브밋(submit)을 하지 말라는 뜻이다.
		}
	};
	

</script>	
	
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
%>
<!doctype html>
<html lang="ko">
  <head>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<!-- datepicker 삽입을 위한 link -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css" > 
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js"></script>

<!-- 실험 

include libraries(jQuery, bootstrap)
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

    include summernote css/js
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

 -->


	<script type="text/javascript">
		
		$(document).ready(function(){
			
		});
	
	</script>

    <title>상품 Q&A</title>

    
<style type="text/css">

	@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

	.notosanskr * { 
	  	font-family: 'Noto Sans KR', sans-serif;
	}
	
	html, body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, code, form, fieldset, legend, input, textarea, p, blockquote, th, td, img {
	    list-style: none;
	    margin: 0;
	    padding: 0;
	}

	a:link { color: black; text-decoration: none;}
 	a:visited { color: black; text-decoration: none;}
 	a:hover { color: black; text-decoration: underline;}
 	
 	div#container {
    	margin: 0 auto;
    }

	table {
	    position: relative;
	    margin: 10px 0 0;
	    border: 1px solid #d7d5d5;
	    border-right: 0;
	    border-left: 0;
	    border-top-color: #fff;
	    line-height: 1.5;
	    
	    width: 100%;
	    border: 0;
	    border-spacing: 0;
	    border-collapse: collapse;
	}
	
	td {
		padding: 10px 10px 9px;
	}
	
	#container > div.table-responsive > table > tbody > tr > th {
		padding: 11px 0 10px 18px;
	    border: solid 1px #dfdfdf;
	    border-right: 0;
	    border-bottom-width: 0;
	    color: #333333;
	    text-align: left;
	    font-weight: normal;
	    background-color: #fbfafa;
	}
	
	th:first-child {
		border-left: 0;
	}
	
	#container > div.table-responsive > table > tbody > tr > td {
		padding: 11px 10px 10px;
	    border-top: 1px solid #dfdfdf;
	    color: #333333;
	    vertical-align: middle;
	}
	
	div.detail {
		padding: 30px 20px;
	    border-top: 1px solid #eaeaea;
	    margin: -9px 0 0;
	    word-break: break-all;
	    line-height: 20px;
	}
	
	p {
		line-height: 1.5;
	}
	
	div.ec-base-button {
   		margin: 10px 0 40px;
   		padding: 10px 0;
    	text-align: left;
	}
	
	button#btnList {
		border: solid 1px gray;
	}
	
	strong {
		width: 10%;
	    padding-left: 15px;
	    border-right: 1px solid #e9e9e9;
	    font-weight: normal;
	}
	
	li {
		overflow: hidden;
	    padding: 0 20px;
	    border-bottom: 1px solid #e9e9e9;
	    line-height: 140%;
	    color: #353535;
	}
	
	li > strong, li > a {
		float: left;
		padding: 10px;
	}
	
	span.gRight {
		float: right;
	}
	
	tr.notMember {
		 display: none;  /* 추후 수정 예정 비회원 모드일때 보이게*/
	}
	
	textarea {
		padding: 10px;
	}
    
</style>
    
</head>
<body>
	<div class="row">
	
	    <div id="container" class="col-10">
	    
			<div id="title">
				<p>
				<span style="font-size: 20pt; font-weight:bold;">상품 Q&amp;A</span>
				<span style="font-color: gray; font-size:10pt;">&nbsp;&nbsp;&nbsp;상품 Q&amp;A입니다. 상품에 관해서 궁금하신 점을 질문해주세요.</span>
				</p>
			</div>

			<hr>
						
			<br>
			
			<div class="table-responsive">
				<table border="1">
					<colgroup>
						<col style="width:130px;">
						<col style="width:auto;">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">제목</th>
							<td><input type="text" id="subject" /></td>
						</tr>
						<tr class="notMember">
				            <th>작성자</th>
				            <td><input id="writer" name="writer" /></td>
				          </tr>
				          
				          <tr class="notMember">
				            <th>이메일</th>
				            <td>
				               <input id="email1" name="email1" />
				               @
				               <input id="email2" name="email2" />
				               <select id="email3">
				                  <option selected="selected">-이메일선택-</option>
				                  <option>naver.com</option>
				                  <option>daum.net</option>
				                  <option>nate.com</option>
				                  <option>hotmail.com</option>
				                  <option>yahoo.com</option>
				                  <option>empas.com</option>
				                  <option>korea.com</option>
				                  <option>dreamwiz.com</option>
				                  <option>gmail.com</option>
				                  <option>직접입력</option>
				               </select>
				            </td>
				          </tr>
						<tr class="notMember">
			            <th>평점</th>
				            <td>
				              <input type="radio" id="point0" name="point" value="5">
				              <label for="point0"><span class="point5"><p>★★★★★</p></span></label>
				              <input type="radio" id="point1" name="point" value="5">
				              <label for="point1"><span class="point5"><p>★★★★</p></span></label>
				              <input type="radio" id="point2" name="point" value="5">
				              <label for="point2"><span class="point5"><p>★★★</p></span></label>
				              <input type="radio" id="point3" name="point" value="5">
				              <label for="point3"><span class="point5"><p>★★</p></span></label>
				              <input type="radio" id="point4" name="point" value="5">
				              <label for="point4"><span class="point5"><p>★</p></span></label>
				            </td>
			          	</tr>
						<tr>
							<td colspan="2">
								<textarea class="boardContent" placeholder="글 내용" name="boardContent" style="height: 350px; width: 100%;"></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row">UCC URL</th>
							<td><input type="text" id="uccurl" /></td>
						</tr>
						<tr>
							<th scope="row">비밀번호</th>
							<td><input type="text" id="qnaWritePwd" /></td>
						</tr>
						<tr>
							<th scope="row">비밀글설정</th>
							<td><input type="radio" name="public" id="qnaPublic" />공개글&nbsp;<input type="radio" name="public" id="qnaSecret" />비밀글</td>
						</tr>
						<tr class="notMember">
							<th scope="row">자동등록방지 보안문자</th>
							<td><input type="text" id="securitymessage" /></td>
						</tr>
						<tr class="notMember">
							<th scope="row">개인정보 수집 및 이용 동의</th>
							<td><textarea id="terms" name="terms" style="width: 60%;"></textarea></td>
						</tr>
					</tbody>
				</table>
			</div>
			

			
			<div class="ec-base-button">
				<span class="gLeft">
					<button type="button" class="btn" id="btnList">
						<a href="">목록</a>
					</button>
				</span>
				<span class="gRight">
					<button type="button" class="btn" id="btnList">
						<a href="">등록</a>
					</button>
					<button type="button" class="btn" id="btnList">
						<a href="">취소</a>
					</button>
				</span>
			</div>
			
		</div> <!-- container 끝 -->
		
	</div>
		
		

    <!-- Optional JavaScript -->
    <script src="../js/jquery-3.6.0.min.js" type="text/javascript"></script>
    <script src="../js/bootstrap.bundle.min.js" type="text/javascript"></script>
</body>
</html>


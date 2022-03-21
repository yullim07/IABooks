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



	<script type="text/javascript">
		
		$(document).ready(function(){
			
		});
	
	</script>

    <title>table</title>

    
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
	
	div.prevnext {
		border: 1px solid #d7d5d5;
    	margin: 20px 0;
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
    
</style>
    
</head>
<body>
	<div class="row">
	
	    <div id="container" class="col-10">
	    
			<div id="title">
				<p>
				<span style="font-size: 20pt; font-weight:bold;">FAQ</span>
				<span style="font-color: gray; font-size:10pt;">&nbsp;&nbsp;&nbsp;이용안내 FAQ입니다.</span>
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
							<td>해외 배송이 가능한가요?</td>
						</tr>
						<tr>
							<th scope="row">작성자</th>
							<td>인디펍</td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="detail">
									<div class="fr-view fr-view-article">
										<p></p>
						         		<p><b>단순 변심</b>에 의한 반품은 배송완료 후 7일 이내에 가능합니다.</p>
										<p><b>오배송/상품 하자</b>에 의한 반품은 <b>30일 이내</b>에만 접수가능합니다.</p>
										<p>인디펍 지정 택배(CJ대한통운)로 회수 신청 시 택배 반송료 3,000원이 환불 금액에서 차감 후 환불 처리가 되며,</p>
										<p>전체 반품 또는 실 구매한 상품이 무료 배송 대상이 아닐 경우 초도 배송비 3,000원이 추가 차감됩니다.</p>
										<p>(오배송/상품 하자에 의한 반품 배송비는 무료입니다.)</p>
										<p><span style="color: red;">※택배 접수 시 '반품예약'으로 접수하셔야 하며 '일반예약', '타택배사' 접수 시 택배비가 추가 차감됩니다.</span></p>
										<p>상품은 훼손되지 않도록 포장 부탁드리며, 주문자 성함과 연락처를 메모지에 적어서 동봉 부탁드립니다.</p>
										<p><b>1. 반품접수</b></p>
										<p>마이페이지 - 주문조회 - 반품신청</p>
										<p><b>2. 택배접수</b></p>
										<p>CJ대한통운 반품예약 (TEL: 1588-1255)</p>
										<p><b>3. 반품주소</b></p>
										<p>(61180) 광주광역시 북구 용주로40번길 7 인디펍 물류센터 (용봉동)</p>
									</div>
								</div>
							</td>
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
			</div>
			
			<div class="prevnext">
				<ul>
					<li class="prev">
						<strong>이전글</strong>
						<a href="">프로젝트는 원래 이렇게 어렵나요?</a>
					</li>
					<li class="next">
						<strong>다음글</strong>
						<a href="">다들 화이팅입니다!</a>
					</li>
				</ul>
			</div>
			
		</div> <!-- container 끝 -->
		
	</div>
		
		

    <!-- Optional JavaScript -->
    <script src="../js/jquery-3.6.0.min.js" type="text/javascript"></script>
    <script src="../js/bootstrap.bundle.min.js" type="text/javascript"></script>
</body>
</html>


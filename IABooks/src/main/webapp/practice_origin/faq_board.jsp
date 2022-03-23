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

	a:link { color: black; text-decoration: none;}
 	a:visited { color: black; text-decoration: none;}
 	a:hover { color: black; text-decoration: underline;}

	div#title {
		margin: 10px 0;
	}
   
    .row {
    	margin: 0 auto;
    	width: 80%;
    }
    
    div#container {
    	margin: 0 auto;
    }
    
    tr {
    	border-bottom: solid 1px gray;
    }
    
    tr > td:nth-child(1), td:nth-child(2), td:nth-child(4) {
    	text-align: center;
    }
    
    tr > td:nth-child(3) {
    	text-align: left;
    }
    
    div#searchtab {
    	display : inline-block;
    	vertical-align: middle;
    	padding-top: 1px;
    	
    }
    
    select {
    	height: 24px;
    	border: 1px solid #d5d5d5;
    	vertical-align: middle;
    	
    }
    
    input[type=text], input[type=button] {
    	height: 24px;
	    line-height: 20px;
	    border: 1px solid #d5d5d5;
	    color: #353535; 
	    font-size: 12px;
	    vertical-align: middle;
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
			
			<br>
			<!-- <div class="dropdown">
			  <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			    전체
			  </a>
			
		    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			    <a class="dropdown-item" href="#">회원</a>
			    <a class="dropdown-item" href="#">상품</a>
			    <a class="dropdown-item" href="#">반품/교환</a>
			    <a class="dropdown-item" href="#">주문/배송</a>
			    <a class="dropdown-item" href="#">제휴</a>
			  </div>
			</div> -->
			
            <select name="faqcategory" id="faqcategory">
               <option value="">전체</option>
               <option>회원</option>
               <option>상품</option>
               <option>반품/교환</option>
               <option>주문/배송</option>
               <option>제휴</option>
            </select>
			
			<hr>
			<div class="table-responsive">
			  <table class="table">
			  <thead class="thead-light">
			    <tr style="text-align: center;">
			      <th style="width:10%;">번호</th>
			      <th style="width:15%;">카테고리</th>
			      <th style="width:60%;">제목</th>
			      <th style="width:15%;">작성자</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <td>9</td>
			      <td>상품</td>
			      <td><a href="">독립출판물이란 무엇인가요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>8</td>
			      <td>반품/교환</td>
			      <td><a href="">반품은 어떻게 하나요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>7</td>
			      <td>주문/배송</td>
			      <td><a href="">주문한 상품은 언제 받을 수 있나요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>6</td>
			      <td>주문/배송</td>
			      <td><a href="">현금영수증 발행신청은 어디서 하나요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>5</td>
			      <td>주문/배송</td>
			      <td><a href="">배송비는 얼마인가요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>4</td>
			      <td>주문/배송</td>
			      <td><a href="">비회원 주문조회는 어떻게 하나요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>3</td>
			      <td>주문/배송</td>
			      <td><a href="">해외 배송이 가능한가요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>2</td>
			      <td>반품/교환</td>
			      <td><a href="">교환은 어떻게 하나요?</a></td>
			      <td>인디펍</td>
			    </tr>
			    <tr>
			      <td>1</td>
			      <td>상품</td>
			      <td><a href="">품절된 도서입니다. 재입고는 언제 되나요?</a></td>
			      <td>인디펍</td>
			    </tr>
			  </tbody>
			</table>
			</div>
			<div id="searchtab">
				<p>검색어&nbsp;
				<select name="searchtime" id="searchtime">
	                <option value="">기간</option>
	                <option>일주일</option>
	                <option>한달</option>
	                <option>세달</option>
            	</select>
            	&nbsp;
            	<select name="searchtype" id="searchtype">
	                <option value="">전체</option>
	                <option>내용</option>
	                <option>글쓴이</option>
	                <option>아이디</option>
	                <option>별명</option>
            	</select>
            	&nbsp;
            	<input type="text" id="search" name="search"/>
            	<input type="button" id="searchbtn" name="searchbtn" value="찾기"/> 
            	</p>
			</div>
			
		</div> <!-- container 끝 -->
		
	</div>
		
		

    <!-- Optional JavaScript -->
    <script src="../js/jquery-3.6.0.min.js" type="text/javascript"></script>
    <script src="../js/bootstrap.bundle.min.js" type="text/javascript"></script>
</body>
</html>


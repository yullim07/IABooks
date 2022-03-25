<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">

</style>

	  
<meta charset="UTF-8">
<title>상품검색</title>



<jsp:include page="../header.jsp"/>


<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jaehee_pages/semicss/semi_style.css" />

<style type="text/css">

.out {
	 text-align: center;
	 border: solid 5px #e8e8e8;
	 padding: 20px;
	 margin: 15px;
 }
 
.in {
	 display: inline-block;
	 width: 50%;
	 /* border: solid 1px red; */
	 height: 240px;
 }

table#p_search_tbl, #p_search_tbl > tbody > tr, #p_search_tbl > tbody > tr > th, #p_search_tbl > tbody > tr > td {
	border: none !important;
}

#p_search_tbl > tbody > tr {
	height: 35px;
	vertical-align: middle;
}
 
#p_search_tbl > tbody > tr > th {
	width: 100px;
	text-align: right;
	padding-right: 10px;
	font-weight: normal;
}

#p_search_tbl > tbody > tr > td {
	padding-right: 5px;
}
	
#p_search_tbl > tbody > tr > td > select {
	font-size: 13px;
	margin-right: 5px;
}

button.btn_pro_search {
    width: 150px;
    height: 30px;
    border: solid 1px #aaa;
    font-size: 18px;
    padding: 0;
    margin: 20px 0 0 5px;
    background-color: #999;
    color: white;
    border-radius: 5%;
}

</style>

<script type="text/javascript">
		
		$(document).ready(function(){
			
		});
	
	</script>

 <div class="container">
  	<div class="title" >
	  	<div class="title_icon" ><img src="<%= ctxPath%>/jaehee_pages/semi_images/ico_heading.gif" /></div>
	  	<h2>상품검색</h2>
   
	</div>
	
	<div class="out">
	    <div class="in" style="overflow-x:auto;">
	    	<table id="p_search_tbl">
	 			
	 			<tr>
				 	<th>
				 		<strong class="s_title">상품분류</strong> 
				    </th>
			    	<td>
				    	<select id="product_type" name="product_type" class="p_search">
					       <option selected="selected">상품분류 선택</option>
					       <option value="recent">종합</option>
					       <option value="humanities">종합 > 인문</option>
					       <option value="Society">종합 > 사회</option>
					       <option value="science">종합 > 과학</option>
				    	</select>
				    </td>
				</tr>
				
				<tr>
				 	<th>
				 	<strong class="s_title">검색조건</strong> 
				 	</th>
			    	<td>
					    <select id="search_condition" name="search_condition" class="p_search">
					       <option selected="selected">상품명</option>
					       <option value="pnun">상품코드</option>
					       <option value="private_pnum">자체상품코드</option>
					       <option value="model">모델명</option>
					       <option value="brand">브랜드명</option>
					    </select>
					    <input type="text" id="product_name" class="product_name p_search" placeholder="도서명" />
					</td>
				</tr>
			
				<tr>
				 	<th>
						<strong class="s_title">제외검색어</strong>
					</th>
					<td>
						<input type="text" id="search_exception" class="search_exception p_search"/> 
					</td>
				</tr>
				
			
				<tr>
				 	<th>
				    	<strong class="s_title">판매가격대</strong> 
				    </th>
				    <td>
					   <input class="price p_search" type="text" />
					   ~
					   <input class="price p_search" type="text"/>
					</td>
				</tr>
				
				<tr>
				 	<th>
				   		<strong class="s_title">검색정렬기준</strong> 
				    </th>
				    <td>
					   <select id="order_by" name="order_by" class="p_search">
					      <option selected="selected">::: 기준선택 :::</option>
					      <option value="recent">신상품 순</option>
					      <option value="name">상품명 순</option>
					      <option value="favor">인기상품 순</option>
					   </select>
					</td>
				</tr>
				
			</table> 
				
				
			<div class="pro_search">
			   <button class="btn_pro_search">검색하기</button>
			</div>  	
	    	
       		
	        
	 
	 		     
	    </div>
	</div>
	  	



</div> <!-- container 끝 -->


<jsp:include page="../footer.jsp"/>
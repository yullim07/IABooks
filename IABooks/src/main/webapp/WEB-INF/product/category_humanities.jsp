<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();	
%>

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_category.css" />

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
 	$("li.pagenum > a").click(function(){//pagination active 설정
		const $target = $(event.target);
		/* $("li.pagenum > a.active").removeClass("active");  */
	 	$(this).parent().siblings().children() .removeClass("active"); 
	 	$target.addClass("active"); 
	}); 
});


</script>

<style type="text/css">

</style>

<title>in사과 : humanities</title>

<jsp:include page="/WEB-INF/header.jsp"/>
<%-- main --%>		
<div class="container d-none d-lg-block">

<%-- 인문 foreach 사용 출간일순 이름순 판매순 --%>	

	<div class="title ">
		<br>
		<h2>인문</h2>
	</div>

	<div class="divClear"></div>

	<div class="itemslist">
		<span class="itemscount"><strong>0</strong> ITEMS</span>
		<ul class="nav nav-tabs Justify-content-end">
			<li class="nav-item">
		    	<a class="nav-link active rounded-0" data-toggle="tab" href="#new">신상품</a>
			</li>
			<li class="nav-item">
				<a class="nav-link rounded-0" data-toggle="tab" href="#name">상품명</a>
			</li>
			<li class="nav-item">
				<a class="nav-link rounded-0" data-toggle="tab" href="#popularity">인기상품</a>
			</li>
		</ul>
		<br/>
	
		<div class="tab-content"><%-- foreach 사용해서 불러옴 --%>	
			<div class="tab-pane fade show active" id="new">
	
				<div class="row">
				
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>
		
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>
		
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>
		
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>
					
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>
		
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>
					
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>
					
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>	
		
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>
					
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>
					
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>
					
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>	
					
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>
					
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>
		
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>
		
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>		
				</div>	
						
			</div>

			<div class="tab-pane fade" id="name">
			
				<div class="row">
					<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">Ordinary</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">16,000원</span>
							</li>  
						</ul>
					</div>
				</div>	
	
			</div>

			<div class="tab-pane fade" id="popularity">
			</div>


		</div>	
	</div>

	<%--페이지 네비게이션 --%>
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center ">
			<li class="page-item pageicon">
				<a class="page-link" href="#" aria-label="Previous">
					<span aria-hidden="true"><i class="bi bi-chevron-double-left"></i></span>
				</a>
			</li>
	    
			<li class="page-item pageicon">
				<a class="page-link" href="#" aria-label="Previous">
	        		<span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
	      		</a>
	    	</li>
	    
	    	<li class="page-item pagenum"><a class="page-link active" href="#">1</a></li>
	    	<li class="page-item pagenum"><a class="page-link" href="#">2</a></li>
	    	<li class="page-item pagenum"><a class="page-link" href="#">3</a></li>
	    	<li class="page-item pagenum"><a class="page-link" href="#">4</a></li>
	    	<li class="page-item pagenum"><a class="page-link" href="#">5</a></li>
	    
	    	<li class="page-item pageicon">
	      		<a class="page-link" href="#" aria-label="Next">
	        	<span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
	      		</a>
	    	</li>
	    
	   		<li class="page-item pageicon">
	      		<a class="page-link" href="#" aria-label="Next">
	        	<span aria-hidden="true"><i class="bi bi-chevron-double-right"></i></span>
	      		</a>
	    	</li>
	  	</ul>
	</nav>


</div><%-- <div class="container d-none d-lg-block"> --%>

<br>
<br>
<%-- footer --%>
<jsp:include page="/WEB-INF/footer.jsp"/>
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();	
%>

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style_category_search.css" />

<style type="text/css">

</style>

<title>in사과 : Best 20</title>

<jsp:include page="header.jsp"/>
<%-- main --%>		
<div class="container d-none d-lg-block">

<%-- Best 20 foreach 사용 판매량순--%>	
<h2 class="listtile">Best 20</h2>
<h3 class="listtile2">최근 30일 간의 판매량을 기준으로 매일 1회 집계됩니다.</h3>
<br>
<br>

	<div class="row">
	
		<div class="col-3">
			<ul class="booklist">
				<li>
				<div class="card">
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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
			  		<img src="<%= ctxPath%>/images/12.jpg" class="card-img-top" >
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

<br>
<br>
<%-- footer --%>
<jsp:include page="footer.jsp"/>
 
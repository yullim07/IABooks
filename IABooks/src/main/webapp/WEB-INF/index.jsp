<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>




<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<%-- Bootstrap --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_index.css" /> 
<%-- slick CSS --%>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$( document ).ready( function() {
    $( '.slider' ).slick( {
      autoplay: true,
    /*   arrows: false; */
      autoplaySpeed: 1000,
      slidesToShow: 5,
      slidesToScroll: 1,
    });
  });
</script>

<style type="text/css">

   
</style>


<title>in사과 : main</title>

<jsp:include page="header.jsp"/>
<%-- main --%>	
	<div class="container d-none d-lg-block">
		
		<%-- carousel foreash사용 --%>
		<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
 			<ol class="carousel-indicators">
		   		<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active" style="opacity: 0.5; "></li>
		    	<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
		    	<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		  	</ol>
		  	
		 	<div class="carousel-inner">
		   		<div class="carousel-item active">
		      		<img src="<%= ctxPath%>/images/product/1.jpg" class="d-block w-100"> 
		    
		    	</div>
		    	<div class="carousel-item">
		      		<img src="<%= ctxPath%>/images/product/2.jpg" class="d-block w-100">
		    	</div>
		   		<div class="carousel-item">
		      		<img src="<%= ctxPath%>/images/product/3.jpg" class="d-block w-100">
		      
		    	</div>
		  	</div>
		  	
		  	<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
		    	<span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    	<span class="sr-only">Previous</span>
		  	</a>
		  	<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
		  		
		   		<span class="carousel-control-next-icon" aria-hidden="true"></span>
		    	<span class="sr-only">Next</span>
		  	</a> 
		</div>	

		<br/>
		<br/>
		<h2 class="sliderheader"><span>NEW </span>새로들어온 책</h2>
		
	</div><%-- <div class="container d-none d-lg-block">끝 --%>	
		
		<%-- slick 사용 --%>
		<div class="slider d-none d-lg-block">
			<div>
				<div class="card">
		  			<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
					<a href="#" class="stretched-link"></a>
				</div>
				<p>Ordinary</p>	
				<p>16,000원</p>
			</div>
	
			<div>
				<div class="card">
		  			<img src="<%= ctxPath%>/images/product/13.jpg" class="card-img-top" >
					<a href="#" class="stretched-link"></a>
				</div>
				<p>Ordinary</p>	
				<p>16,000원</p>
			</div>		
	
			<div>
				<div class="card">
		  			<img src="<%= ctxPath%>/images/product/14.jpg" class="card-img-top" >
					<a href="#" class="stretched-link"></a>
				</div>
				<p>Ordinary</p>	
				<p>16,000원</p>
			</div>		
	
			<div>
				<div class="card">
		  			<img src="<%= ctxPath%>/images/product/15.jpg" class="card-img-top" >
					<a href="#" class="stretched-link"></a>
				</div>
				<p>Ordinary</p>	
				<p>16,000원</p>
			</div>
		
			<div>
				<div class="card">
		  			<img src="<%= ctxPath%>/images/product/16.jpg" class="card-img-top" >
					<a href="#" class="stretched-link"></a>
				</div>
				<p>Ordinary</p>	
				<p>16,000원</p>
			</div>	
	
			<div>
				<div class="card">
		  			<img src="<%= ctxPath%>/images/product/17.jpg" class="card-img-top" >
					<a href="#" class="stretched-link"></a>
				</div>
				<p>Ordinary</p>	
				<p>16,000원</p>
			</div>
	
			<div>
				<div class="card">
		  			<img src="<%= ctxPath%>/images/product/18.jpg" class="card-img-top" >
					<a href="#" class="stretched-link"></a>
				</div>
				<p>Ordinary</p>	
				<p>16,000원</p>
			</div>
		
	    </div>

		<div class="container d-none d-lg-block">
		<div style="border-bottom :solid 1px #DEE2E6"></div>
			
	 	<br/>
		<br/>	
		<br/>	

		<%-- nav-tabs foreash사용 --%>
		<div class="contents">
			<ul class="nav nav-tabs row">
		  		<li class="nav-item col-3">
		   			<a class="nav-link active rounded-0 actvie" data-toggle="tab" href="#total">종합 Best</a>
		  		</li>
			  	<li class="nav-item col-3">
			    	<a class="nav-link rounded-0" data-toggle="tab" href="#humanities">인문 Best</a>
			  	</li>
		  		<li class="nav-item col-3">
		   			 <a class="nav-link rounded-0" data-toggle="tab" href="#Society">사회 Best </a>
		  		</li>
		  
		   		<li class="nav-item col-3">
		    		<a class="nav-link rounded-0" data-toggle="tab" href="#science">과학 Best </a>
		  		</li>
			</ul>
		
			<div class="tab-content">
				<div class="tab-pane fade show active" id="total">
					<table>
						<tr>
						
							<td>
								<div class="bookrank">
									<div class="card">
									  	<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
									  	<div class="card-img-overlay firstrank">
											<p class="card-title">1</p>
		    								<p class="card-text">Ordinary</p>
		    								<p class="card-text line"></p> 
		   									<p class="card-text">16,000원</p>
		    							</div>
										<a href="#" class="stretched-link"></a>
									</div>	
								</div>
							</td>
							
							<td>
								<div class="row">		
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">2</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
					
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">3</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">4</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">5</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">6</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/12.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">7</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
								</div>
								
							</td>
						</tr>
					</table>				
				</div>
				
				<div class="tab-pane fade show" id="humanities">
					<table>
						<tr>
						
							<td>
								<div class="bookrank">
									<div class="card">
									  	<img src="<%= ctxPath%>/images/product/13.jpg" class="card-img-top" >
									  	<div class="card-img-overlay firstrank">
											<p class="card-title">1</p>
		    								<p class="card-text">Ordinary</p>
		    								<p class="card-text line"></p> 
		   									<p class="card-text">16,000원</p>
		    							</div>
										<a href="#" class="stretched-link"></a>
									</div>	
								</div>
							</td>
							
							<td>
								<div class="row">		
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/13.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">2</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
					
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/13.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">3</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/13.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">4</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/13.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">5</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/13.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">6</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/13.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">7</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
								</div>
								
							</td>
						</tr>
					</table>				
				</div>
				
				<div class="tab-pane fade show" id="Society">
					<table>
						<tr>
						
							<td>
								<div class="bookrank">
									<div class="card">
									  	<img src="<%= ctxPath%>/images/product/14.jpg" class="card-img-top" >
									  	<div class="card-img-overlay firstrank">
											<p class="card-title">1</p>
		    								<p class="card-text">Ordinary</p>
		    								<p class="card-text line"></p> 
		   									<p class="card-text">16,000원</p>
		    							</div>
										<a href="#" class="stretched-link"></a>
									</div>	
								</div>
							</td>
							
							<td>
								<div class="row">		
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/14.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">2</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
					
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/14.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">3</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/14.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">4</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/14.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">5</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/14.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">6</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/14.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">7</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
								</div>
								
							</td>
						</tr>
					</table>			
				</div>
			
				<div class="tab-pane fade show" id="science">
					<table>
						<tr>
						
							<td>
								<div class="bookrank">
									<div class="card">
									  	<img src="<%= ctxPath%>/images/product/15.jpg" class="card-img-top" >
									  	<div class="card-img-overlay firstrank">
											<p class="card-title">1</p>
		    								<p class="card-text">Ordinary</p>
		    								<p class="card-text line"></p> 
		   									<p class="card-text">16,000원</p>
		    							</div>
										<a href="#" class="stretched-link"></a>
									</div>	
								</div>
							</td>
							
							<td>
								<div class="row">		
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/15.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">2</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
					
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/15.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">3</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/15.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">4</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/15.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">5</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/15.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">6</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
						
									<div class="col-4 bookrank">
										<div class="card">
									  		<img src="<%= ctxPath%>/images/product/15.jpg" class="card-img-top" >
									  		<div class="card-img-overlay remainrank">
		    									<p class="card-title">7</p>
			    								<p class="card-text">Ordinary</p>
			    								<p class="card-text line"></p> 
			   									<p class="card-text">16,000원</p>
		    								</div>							  		
											<a href="#" class="stretched-link"></a>
										</div>	
									</div>
								</div>
								
							</td>
						</tr>
					</table>				
				</div>
			
			</div>
		</div>
		<br/>
		<br/>

		
		<%-- 화제의 책 조회순순? 판매순 나중에 foreach사용 --%>
		<div class="contents">
			<h2 class="title">화제의 책</h2>
					
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
			
			</div>
		</div>	
		
		<%-- 이책어때요? 랜덤으로 추천 나중에 foreach사용 --%>
		<div class="contents">	
		<h2 class="title">이책어때요?</h2>
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
			
			</div>	

		</div>


	</div><%-- <div class="container d-none d-lg-block">끝 --%>	
	
<%-- footer --%>
<jsp:include page="footer.jsp" />
 
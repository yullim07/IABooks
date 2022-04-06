<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	
	$(document).ready( function() {
		 
	    $( '.slider' ).slick( {
	      autoplay: true,
	      autoplaySpeed: 2000,
	      slidesToShow: 5,
	      slidesToScroll: 1,
	      
	    });
	   
	    $("ul.bookbest li.nav-item a").bind("click", function () {
	    	var cate_name = $(this).attr("id");
	    	showIndexBest(cate_name);
		});
	    
	    showIndexBest("total");
	    showIndexHot();
	    showIndexRandom();
	    
	    
	    //탭자동 이동
	    var tabs = $('ul.nav-tabs li a');
	    var timerId = 0;
	    
	    timerId = setInterval(function() { 
	    	var onTab = tabs.filter('.active');
			var nextTab = onTab.parent().index() < tabs.parent().length-1 ? onTab.parent().next() : tabs.parent().first();
			nextTab.children().click(); 
		}, 4000);
 	    
	    $("li.nav-item").mouseleave(function () {
	    	timerId = setInterval(function() { 
    		var onTab = tabs.filter('.active');
    		var nextTab = onTab.parent().index() < tabs.parent().length-1 ? onTab.parent().next() : tabs.parent().first();
    		nextTab.children().click(); 
    	}, 4000); });
	    
	    $("li.nav-item ").mouseenter(function () {
	    	clearInterval(timerId); 
	    	$(this).children().click();
	    });
	    $("li.nav-item").mouseenter(function () {
	    	clearInterval(timerId); 
	    	$(this).children().click();
	    });
		//

 

	     
	});//end of $(document).ready( function()
	
 	function showBookDetail(pronum) {
 		//console.log(pronum);
 		location.href="<%= ctxPath%>/product/showBookDetail.book?pronum="+pronum;
	}	
	
	function showIndexBest(cate_name) {
		//alert(cate_name);
		$.ajax({
			url:"<%= ctxPath%>/product/showIndexBest.book",
			//type:"GET",
			data:{"cate_name":cate_name}, 
			dataType:"JSON",
			success:function(json) {
	
				let html = "";
				
				html +=  "<div class='tab-content'>"
							+"<div class='tab-pane fade show active' id='total'>"
								+"<table>"
									+"<tr>";
				
				$.each(json, function(index, item) {
					const totalpricecomma = item.pro_saleprice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					if(index > 0){
						return false;
					}
					
					html += "<td>"
								+"<div class='bookrank'>"
									+"<div class='card'>"
									+"<img src='<%= ctxPath%>/images/product/"+item.cate_name+"/"+item.pro_imgfile_name+"' class='card-img-top'>"
									  
									  	+"<div class='card-img-overlay firstrank'>"
											+"<p class='card-title'>+(index+1)+</p>"
		    								+"<p class='card-text'>"+item.pro_name+"</p>"
		    								+"<p class='card-text line'></p>"
		   									+"<p class='card-text'>"+totalpricecomma+"원</p>"
		    							+"</div>"
		    							+"<a href='javascript:showBookDetail("+item.pk_pro_num+")' class='stretched-link'></a>"
									+"</div>"	
								+"</div>"
							+"</td>"		
							+"<td>"
								+"<div class='row'>";
				});//end of $.each(json, function(index, item)
								
				$.each(json, function(index, item) {
					const totalpricecomma = item.pro_saleprice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					if(index == 0){
						 return true;
					}
			
					html +=	"<div class='col-4 bookrank'>"
								+"<div class='card'>"
								+"<img src='<%= ctxPath%>/images/product/"+item.cate_name+"/"+item.pro_imgfile_name+"' class='card-img-top'>"
							  		+"<div class='card-img-overlay remainrank'>"
    									+"<p class='card-title'>"+(index+1)+"</p>"
	    								+"<p class='card-text'>"+item.pro_name+"</p>"
	    								+"<p class='card-text line'></p>"
	   									+"<p class='card-text'>"+totalpricecomma+"원</p>"
    								+"</div>"
									+"<a href='javascript:showBookDetail("+item.pk_pro_num+")' class='stretched-link'></a>"
								+"</div>"	
							+"</div>";
				});//end of $.each(json, function(index, item)

					
				html += "</div>"
					+"</td>"
				+"</tr>"
			+"</table>"				
		+"</div>"
		+"</div>";				
	
				$("div.bestview").html(html); 
				
	
				
			},
			error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		
		});//end of $.ajax
	
		
	}//end of function showIndexBest(cate_name)
	
	function showIndexHot() {
		$.ajax({
			url:"<%= ctxPath%>/product/showIndexHot.book",
			//type:"GET",
			//data:{}, 
			dataType:"JSON",
			success:function(json) {

				let html = "";
				
				html +=	"<div class='contents'>"
						+"<h2 class='title'>화제의 책</h2>"
						+"<div class='row'>";
				
				$.each(json, function(index, item) {
					const totalpricecomma = item.pro_saleprice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					html +=	"<div class='col-3'>"
							+"<ul class='booklist'>"
								+"<li>"
									+"<div class='card'>"
									+"<img src='<%= ctxPath%>/images/product/"+item.cate_name+"/"+item.pro_imgfile_name+"' class='card-img-top'>"
									+"<a href='javascript:showBookDetail("+item.pk_pro_num+")' class='stretched-link'></a>"
									+"</div>"	
								+"</li>"
								+"<li>"
									+"<a href='javascript:showBookDetail("+item.pk_pro_num+")'><span class='name'>"+item.pro_name+"</span></a>"
								+"</li>"
								+"<li>"
									+"<div class='line'></div>" 
								+"</li>"
						   		 +"<li>"
									+"<span class='price'>"+totalpricecomma+"원</span>"
								+"</li>" 
							+"</ul>"
						+"</div>";
					
				});//end of $.each(json, function(index, item)
					
				html +=	"</div>"
					+"</div>";	
				
				$("div.hotview").html(html);
				
			},
			error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
			});//end of $.ajax
	}//end of function showIndexHot()
	
	function showIndexRandom() {
		$.ajax({
			url:"<%= ctxPath%>/product/showIndexRandom.book",
			//type:"GET",
			//data:{}, 
			dataType:"JSON",
			success:function(json) {
				
				let html = "";
				
				html +=	"<div class='contents'>"
						+"<h2 class='title'>이책어때요?</h2>"
						+"<div class='row'>";
				
				$.each(json, function(index, item) {
					const totalpricecomma = item.pro_saleprice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					html +=	"<div class='col-3'>"
							+"<ul class='booklist'>"
								+"<li>"
									+"<div class='card'>"
									+"<img src='<%= ctxPath%>/images/product/"+item.cate_name+"/"+item.pro_imgfile_name+"' class='card-img-top'>"
									+"<a href='javascript:showBookDetail("+item.pk_pro_num+")' class='stretched-link'></a>"
									+"</div>"	
								+"</li>"
								+"<li>"
									+"<a href='javascript:showBookDetail("+item.pk_pro_num+")'><span class='name'>"+item.pro_name+"</span></a>"
								+"</li>"
								+"<li>"
									+"<div class='line'></div>" 
								+"</li>"
						   		 +"<li>"
									+"<span class='price'>"+totalpricecomma+"원</span>"
								+"</li>" 
							+"</ul>"
						+"</div>";
					
				});//end of $.each(json, function(index, item)
					
				html +=	"</div>"
					+"</div>";	
				
				$("div.randomview").html(html);
				
			},
			error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
			});//end of $.ajax
	}//end of function showIndexRandom()
	
		
</script>

<style type="text/css">

</style>


<title>in사과 : main</title>

<jsp:include page="header.jsp"/>
<%-- main --%>	
	<div class="container d-none d-lg-block">
		
		<%-- carousel foreash사용 나중에 테이블만들어서 생성 --%>
		<div id="carouselExampleIndicators" class="carousel carousel-dark slide" data-ride="carousel">
 			<ol class="carousel-indicators">
		   		<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active" style="opacity: 0.5; "></li>
		    	<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
		    	<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		  	</ol>
		  	
		 	<div class="carousel-inner">
		   		<div class="carousel-item active">
		      		<img src="<%= ctxPath%>/images/product/banner/9700000000001.jpg" class="d-block w-100"> 
		    		<a href="javascript:showBookDetail(9700000000001)" class="stretched-link"></a>
		    	</div>
		    	<div class="carousel-item">
		      		<img src="<%= ctxPath%>/images/product/banner/9700000000002.jpg" class="d-block w-100">
		      		<a href="javascript:showBookDetail(9700000000002)" class="stretched-link"></a>
		    	</div>
		   		<div class="carousel-item">
		      		<img src="<%= ctxPath%>/images/product/banner/9791167560605.jpg" class="d-block w-100">
		      		<a href="javascript:showBookDetail(9791167560605)" class="stretched-link"></a>
		      
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
			<c:forEach var="pvo" items="${requestScope.prodList}">
				<div>
					<div class="card">
			  			<img src="<%= ctxPath%>/images/product/${pvo.category.cate_name}/${pvo.pro_imgfile_name}" class="card-img-top" >
						<a href="javascript:showBookDetail(${pvo.pk_pro_num})" class="stretched-link"></a>
					</div>
					<p>${pvo.pro_name}</p>	
					<p><fmt:formatNumber value="${pvo.pro_saleprice}" pattern="###,###" />원</p>
				</div>
				
			</c:forEach>
		 </div>
		<%-- slick 끝--%>

		<div class="container d-none d-lg-block">
			<div style="border-bottom :solid 1px #DEE2E6"></div>
			
		 	<br/>
			<br/>	
			<br/>	

			<%-- nav-tabs foreash사용 --%>
			<div class="contents">
				<ul class="nav nav-tabs row bookbest">
			  		<li class="nav-item col-3 a1">
			   			<a class="nav-link active rounded-0" data-toggle="tab" id="total" href="#">종합 Best</a>
			  		</li>
				  	<li class="nav-item col-3 a2">
				    	<a class="nav-link rounded-0" data-toggle="tab" id="humanities" href="#">인문 Best</a>
				  	</li>
			  		<li class="nav-item col-3 a3">
			   			 <a class="nav-link rounded-0" data-toggle="tab" id="society" href="#">사회 Best </a>
			  		</li>
			  
			  		<li class="nav-item col-3 a4">
			    		<a class="nav-link rounded-0" data-toggle="tab" id="other" href="#">기타 Best </a>
			  		</li>
				</ul>
			
				<!-- <div class="tab-content"> -->
				<div class="bestview"></div>
				
			</div>
			<br/>
			<br/>
	
			<%-- 화제의 책 조회순순? 판매순 나중에 foreach사용 --%>
			<div class="hotview"></div>
		
			<%-- 이책어때요? 랜덤으로 추천 나중에 foreach사용 --%>
			<div class="randomview"></div>

	</div><%-- <div class="container d-none d-lg-block">끝 --%>	
	
<%-- footer --%>
<jsp:include page="footer.jsp" />
 
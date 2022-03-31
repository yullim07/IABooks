<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();	
%>

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
<%-- 직접 만든 CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_category_search.css" />

<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
	
	$(document).ready(function(){
	 	$("li.pagenum > a").click(function(){//pagination active 설정
			const $target = $(event.target);
			/* $("li.pagenum > a.active").removeClass("active");  */
		 	$(this).parent().siblings().children() .removeClass("active"); 
		 	$target.addClass("active"); 
		 	
		 	
			const activeTab = $(this).attr("href");
			$("#" + activeTab).fadeIn();
	
			console.log("확인");
			
			if(activeTab == "#new"){
				$(activeTab).load("<%= ctxPath%>/product/category_best20.book");
			}else if(activeTab == "#name"){
				$(activeTab).load("<%= ctxPath%>/product/showBookList.book?category=${requestScope.category}&sort=name");
			}else if(activeTab == "#popularity"){
				$(activeTab).load("<%= ctxPath%>/product/showBookList.book?category=${requestScope.category}&sort=popularity");
			}
	 	
		
	 
		}); 
	 	
	 	$("li.nav-item > a").click(function(){//pagination active 설정
	 		
			const activeTab = $(this).attr("href");
			//$("#" + activeTab).fadeIn();
	
			console.log("확인"+activeTab);
			
			if(activeTab == "#new"){
				$(activeTab).load("<%= ctxPath%>/product/category_best20.book");
			}else if(activeTab == "#name"){
				$(activeTab).load("<%= ctxPath%>/product/showBookList.book?category=${requestScope.category}&sort=name");
			}else if(activeTab == "#popularity"){
				$(activeTab).load("<%= ctxPath%>/product/showBookList.book?category=${requestScope.category}&sort=popularity");
			}
	
	 	});
	 	


	 

	});

		function isExistEmailCheck() {
			b_flagEmailDuplicatClick = true;
			
			/*
            Ajax (Asynchronous JavaScript and XML)란?
          ==> 이름만 보면 알 수 있듯이 '비동기 방식의 자바스크립트와 XML' 로서
              Asynchronous JavaScript + XML 인 것이다.
              한마디로 말하면, Ajax 란? Client 와 Server 간에 XML 데이터를 JavaScript 를 사용하여 비동기 통신으로 주고 받는 기술이다.
              하지만 요즘에는 데이터 전송을 위한 데이터 포맷방법으로 XML 을 사용하기 보다는 JSON(javascript object notation 자바스크립트 객체 표기법) 을 더 많이 사용한다.
              참고로 HTML은 데이터 표현을 위한 포맷방법이다.
              그리고, 비동기식이란 어떤 하나의 웹페이지에서 여러가지 서로 다른 다양한 일처리가 개별적으로 발생한다는 뜻으로서, 
              어떤 하나의 웹페이지에서 서버와 통신하는 그 일처리가 발생하는 동안 일처리가 마무리 되기전에 또 다른 작업을 할 수 있다는 의미이다.
            */
            
            $.ajax({
            	url:"<%= ctxPath%>/member/emailDuplicateCheck.up",		
            	data:{"sort":$("li.nav-item > a").attr("id")},  //data는 MyMVC/member/emailDuplicateCheck.up로 전송할 데이터 
            	type:"post",        //get post 결정	생략하면get
            	//async:false,//동기처리
            	//async:true,//비동기처리 디폴트값 
            	dataType:"json",
            	success:function(json){//json 대신 아무거나 가능   대신 const json = JSON.parse(text);사용가능
            	 /*
         		    //console.log("확인용 text : "+text);
            		//console.log("확인용 typeof(text) : "+typeof(text));
            		
            		const json = JSON.parse(text);//자바스크립트 객체 object로변경
            		//console.log("확인용 json : "+json);
            		//console.log("확인용 typeof(json) : "+typeof(json));
            		// JSON.parse(text); 은 JSON 형식으로 되어진 문자열을 자바스크립트 객체로 변환해주는 것이다.
                    // 조심할 것은 text 는 반드시 JSON 형식으로 되어진 문자열이어야 한다.
                    
            		console.log("확인용 json : "+json.isExist); 
            		
            		또는 
            		dataType:"json",
            		*/
            		
            		console.log("확인용 json : "+json);
            		console.log("확인용 typeof(json) : "+typeof(json));
            		
            		
            		if(json.isExist){//중복아이디 존재  $("input#userid").val()이미사용중
            			$("span#emailCheckResult").html($("input#email").val()+"은중복된 email이므로 사용불가 합니다.").css({"color":"orange"});
            			$("input#email").val("");
            			
            			
            		}else{//$("input#userid").val()값이 tbl_member테이블에 존재하지않음
            			$("span#emailCheckResult").html($("input#email").val()+"은 사용이 가능한 email입니다.").css({"color":"green"});
            		}

            	 },
           	      error:function(request, status, error){
           	    	  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
           	      }
             });
            

		}//end of function isExistEmailCheck() 	
		
		
		

</script>

<style type="text/css">

</style>

<title>in사과 : total</title>

<jsp:include page="/WEB-INF/header.jsp"/>
<%-- main --%>		
<div class="container d-none d-lg-block">

<%-- 종합 foreach 사용 출간일순 이름순 판매순 --%>	

	<div class="title ">
		<br>
		<h2>
			<c:choose>
				<c:when test="${requestScope.category eq 'total'}">
					종합
				</c:when>
				<c:when test="${requestScope.category eq 'humanities'}">
					인문
				</c:when>
				<c:when test="${requestScope.category eq 'society'}">
					사회
				</c:when>
				<c:when test="${requestScope.category eq 'science'}">
					과학
				</c:when>
				<c:when test="${requestScope.category eq 'other'}">
					기타
				</c:when>
			</c:choose>
		</h2>
	</div>

	<div class="divClear"></div>

	<div class="itemslist">
		<span class="itemscount"><strong>0</strong> ITEMS</span>
		<ul class="nav nav-tabs Justify-content-end">
			<li class="nav-item">
		    	<a class="nav-link active rounded-0" data-toggle="tab" id="new" href="#new">신상품</a>
			</li>
			<li class="nav-item">
				<a class="nav-link rounded-0" data-toggle="tab"  id="name" href="#name">상품명</a>
			</li>
			<li class="nav-item">
				<a class="nav-link rounded-0" data-toggle="tab" id="popularity" href="#popularity">인기상품</a>
			</li>
		</ul>
		<br/>
	
		<div class="tab-content"><%-- foreach 사용해서 불러옴 --%>	
			<div class="tab-pane fade show active" id="new">
	
				<div class="row">
				
				
			<c:forEach var="pvo" items="${requestScope.productList}">
			
				<div class="col-3">
						<ul class="booklist">
							<li>
							<div class="card">
						  		<img src="<%= ctxPath%>/images/product/${pvo.category.cate_name}/${pvo.pro_imgfile_name}" class="card-img-top">
								<a href="#" class="stretched-link"></a>
							</div>	
							</li>
							<li>
								<a href="#"><span class="name">${pvo.pro_name}</span></a>
							</li>
							<li>
								<div class="line"></div> 
							</li>
						    <li>
								<span class="price">${pvo.pro_saleprice}원</span>
							</li>  
						</ul>
					</div>	
			
			</c:forEach>	
				
			
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



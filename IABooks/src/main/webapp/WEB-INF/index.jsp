<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
   //      /MyMVC
%>
  
<style type="text/css">

</style>    

<jsp:include page="header.jsp"/>
	
	
	<h1>테스트</h1>
	<div class="container">
	  <div style="width: 80%; margin: 0 auto;">
	  
		<div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-ride="carousel">
		  <ol class="carousel-indicators">
		  <%-- 
		    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
		    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
		    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		  --%>
		    <c:forEach items="${requestScope.imgList}" varStatus="status">
		        <c:if test="${status.index == 0}">
		        	<li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" class="active"></li>
		        </c:if>
		        <c:if test="${status.index > 0}">
		        	<li data-target="#carouselExampleIndicators" data-slide-to="${status.index}"></li>
		        </c:if>
		    </c:forEach>
		  </ol>
		  <div class="carousel-inner">
		  <%-- 
		    <div class="carousel-item active">
		      <img src="../images/Koala.jpg" class="d-block w-100" alt="..."> <!-- d-block 은 display: block; 이고  w-100 은 width 의 크기는 <div class="carousel-item active">의 width 100% 로 잡으라는 것이다. -->
		    </div>
		    <div class="carousel-item">
		      <img src="../images/Lighthouse.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="../images/Penguins.jpg" class="d-block w-100" alt="...">
		    </div>
		  --%>
		    <c:forEach var="imgvo" items="${requestScope.imgList}" varStatus="status">
		    	<c:if test="${status.index == 0}">
		        	<div class="carousel-item active">
				      <img src="<%= ctxPath%>/images/${imgvo.imgfilename}" class="d-block w-100"> <!-- d-block 은 display: block; 이고  w-100 은 width 의 크기는 <div class="carousel-item active">의 width 100% 로 잡으라는 것이다. -->
				    </div>
		        </c:if>
		        <c:if test="${status.index > 0}">
		        	<div class="carousel-item">
				      <img src="<%= ctxPath%>/images/${imgvo.imgfilename}" class="d-block w-100">
				    </div>
		        </c:if>
		    </c:forEach>
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
	   
	  </div>		
	</div>

<jsp:include page="footer.jsp"/>

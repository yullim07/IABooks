<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
  <head>
  <title>My Now Amazing Webpage</title>
  
  
  <%-- Required meta tags --%>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<%-- Bootstrap CSS --%>
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
	
	<%-- Bootstrap Icons --%>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
	
	<%-- Font Awesome 5 Icons --%>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	
	<%-- 직접 만든 CSS --%>
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/style_header_footer.css" />
	
	<%-- Optional JavaScript --%>

	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>
	<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script> 
	  
  
  <link rel="stylesheet" type="text/css" href="slick/slick.css"/>
  <link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>
  </head>
  <body>

  <div>
    <div class="multiple-items"><img src="<%=ctxPath%>/images/product/book.jpg" style="width: 200px;"></div>
    <div class="multiple-items"><img src="<%=ctxPath%>/images/product/book2.jpg" style="width: 200px;"></div>
    <div class="multiple-items"><img src="<%=ctxPath%>/images/product/book3.jpg" style="width: 200px;"></div>
    <div class="multiple-items"><img src="<%=ctxPath%>/images/product/book4.jpg" style="width: 200px;"></div>
    <div class="multiple-items"><img src="<%=ctxPath%>/images/product/book5.jpg" style="width: 200px;"></div>
    <div class="multiple-items"><img src="<%=ctxPath%>/images/product/book6.jpg" style="width: 200px;"></div>
  </div>

  <script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
  <script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
  <script type="text/javascript" src="slick/slick.min.js"></script>

  <script type="text/javascript">
    $(document).ready(function(){
    	$('.multiple-items').slick({
    		  infinite: true,
    		  slidesToShow: 4,
    		  slidesToScroll: 4
    		});
    			
    });
  </script>

  </body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="<%=ctxPath %>/bootstrap-4.6.0-dist/css/bootstrap.min.css" type="text/css">

	<!-- Optional JavaScript -->
    <script src="<%=ctxPath %>/js/jquery-3.6.0.min.js" type="text/javascript"></script>
    <script src="<%=ctxPath %>/bootstrap-4.6.0-dist/js/bootstrap.bundle.js" type="text/javascript"></script>

<!-- slick css -->
<link rel="stylesheet" type="text/css" href="slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>

<script type="text/javascript">

$(document).ready(function(){
	$('.multiple-items').slick({
	  infinite: true,
	  slidesToShow: 3,
	  slidesToScroll: 3
	});
});

</script>

<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="slick/slick.min.js"></script>
    
</head>
<body>

<div class="container">
<img src="<%=ctxPath %>/images/product/book.jpg" class="d-block w-100" alt="...">
<img src="<%=ctxPath %>/images/product/book2.jpg" class="d-block w-100" alt="...">
<img src="<%=ctxPath %>/images/product/book3.jpg" class="d-block w-100" alt="...">
<img src="<%=ctxPath %>/images/product/book4.jpg" class="d-block w-100" alt="...">
<img src="<%=ctxPath %>/images/product/book5.jpg" class="d-block w-100" alt="...">
<div class="multiple-items">
	
</div>


		<!-- 상세보기 메인이미지(detail_img_display) 시작 -->
		<div class="detail_img_display carousel slide carousel-fade" data-ride="carousel">
		
		
			
		
		
		
			<ol class="carousel-indicators">
			</ol>
			
			<a href="" onClick="window.open('pop_images.jsp', '미리보기', 'width=500, height=800, toolbar=no, location=no, status=no, scrollbars=no, resizeable=no, left=200, top=200')">
				<img class="big" src="<%=ctxPath%>/images/product/book.jpg">
			</a>
		</div>
		<!-- 상세보기 메인이미지(detail_img_display) 끝 -->
				

		
		<div id="img_display" class="carousel slide carousel-fade" data-ride="carousel">
		  <ol class="carousel-indicators">
		    <li data-target="#img_display" data-slide-to="0" class="active"></li>
		    <li data-target="#img_display" data-slide-to="1"></li>
		    <li data-target="#img_display" data-slide-to="2"></li>
		  </ol>
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="<%=ctxPath %>/images/product/book.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="<%=ctxPath %>/images/product/book2.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="<%=ctxPath %>/images/product/book3.jpg" class="d-block w-100" alt="...">
		    </div>
		  </div>
		  <a class="carousel-control-prev" href="#img_display" role="button" data-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="sr-only">Previous</span>
		  </a>
		  <a class="carousel-control-next" href="#img_display" role="button" data-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="sr-only">Next</span>
		  </a>
		</div>

</div>
</body>
</html>










   
<!DOCTYPE html>
<html>
<head>
  <title>Slick Playground</title>
  <meta charset="UTF-8">
  <link rel="stylesheet" type="text/css" href="./slick/slick.css">
  <link rel="stylesheet" type="text/css" href="./slick/slick-theme.css">
  <style type="text/css">
    html, body {
      margin: 0;
      padding: 0;
    }

    * {
      box-sizing: border-box;
    }

    .slider {
        width: 50%;
        margin: 100px auto;
    }

    .slick-slide {
      margin: 0px 20px;
    }

    .slick-slide img {
      width: 100%;
    }

    .slick-prev:before,
    .slick-next:before {
      color: black;
    }


    .slick-slide {
      transition: all ease-in-out .3s;
      opacity: .2;
    }
    
    .slick-active {
      opacity: .5;
    }

    .slick-current {
      opacity: 1;
    }
  </style>
</head>
<body>

  <section class="vertical-center-4 slider">
    <div>
      <img src="http://placehold.it/350x100?text=1">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=2">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=3">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=4">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=5">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=6">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=7">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=8">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=9">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=10">
    </div>
  </section>

  <section class="vertical-center-3 slider">
    <div>
      <img src="http://placehold.it/350x100?text=1">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=2">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=3">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=4">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=5">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=6">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=7">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=8">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=9">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=10">
    </div>
  </section>

  <section class="vertical-center-2 slider">
    <div>
      <img src="http://placehold.it/350x100?text=1">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=2">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=3">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=4">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=5">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=6">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=7">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=8">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=9">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=10">
    </div>
  </section>

  <section class="vertical-center slider">
    <div>
      <img src="http://placehold.it/350x100?text=1">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=2">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=3">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=4">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=5">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=6">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=7">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=8">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=9">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=10">
    </div>
  </section>

  <section class="vertical slider">
    <div>
      <img src="http://placehold.it/350x100?text=1">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=2">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=3">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=4">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=5">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=6">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=7">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=8">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=9">
    </div>
    <div>
      <img src="http://placehold.it/350x100?text=10">
    </div>
  </section>
  <section class="regular slider">
    <div>
      <img src="http://placehold.it/350x300?text=1">
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=2">
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=3">
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=4">
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=5">
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=6">
    </div>
  </section>

  <section class="center slider">
    <div>
      <img src="http://placehold.it/350x300?text=1">
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=2">
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=3">
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=4">
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=5">
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=6">
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=7">
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=8">
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=9">
    </div>
  </section>

  <section class="variable slider">
    <div>
      <img src="http://placehold.it/350x300?text=1">
    </div>
    <div>
      <img src="http://placehold.it/200x300?text=2">
    </div>
    <div>
      <img src="http://placehold.it/100x300?text=3">
    </div>
    <div>
      <img src="http://placehold.it/200x300?text=4">
    </div>
    <div>
      <img src="http://placehold.it/350x300?text=5">
    </div>
    <div>
      <img src="http://placehold.it/300x300?text=6">
    </div>
  </section>

  <section class="lazy slider" data-sizes="50vw">
    <div>
      <img data-lazy="http://placehold.it/350x300?text=1-350w" data-srcset="http://placehold.it/650x300?text=1-650w 650w, http://placehold.it/960x300?text=1-960w 960w" data-sizes="100vw">
    </div>
    <div>
      <img data-lazy="http://placehold.it/350x300?text=2-350w" data-srcset="http://placehold.it/650x300?text=2-650w 650w, http://placehold.it/960x300?text=2-960w 960w" data-sizes="100vw">
    </div>
    <div>
      <img data-lazy="http://placehold.it/350x300?text=3-350w"  data-srcset="http://placehold.it/650x300?text=3-650w 650w, http://placehold.it/960x300?text=3-960w 960w" data-sizes="100vw">
    </div>
    <div>
      <img data-lazy="http://placehold.it/350x300?text=4-350w"  data-srcset="http://placehold.it/650x300?text=4-650w 650w, http://placehold.it/960x300?text=4-960w 960w" data-sizes="100vw">
    </div>
    <div>
      <img data-lazy="http://placehold.it/350x300?text=5-350w"  data-srcset="http://placehold.it/650x300?text=5-650w 650w, http://placehold.it/960x300?text=5-960w 960w" data-sizes="100vw">
    </div>
    <div>
      <!-- this slide should inherit the sizes attr from the parent slider -->
      <img data-lazy="http://placehold.it/350x300?text=6-350w"  data-srcset="http://placehold.it/650x300?text=6-650w 650w, http://placehold.it/960x300?text=6-960w 960w">
    </div>
  </section>

  <script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
  <script src="./slick/slick.js" type="text/javascript" charset="utf-8"></script>
  <script type="text/javascript">
    $(document).on('ready', function() {
      $(".vertical-center-4").slick({
        dots: true,
        vertical: true,
        centerMode: true,
        slidesToShow: 4,
        slidesToScroll: 2
      });
      $(".vertical-center-3").slick({
        dots: true,
        vertical: true,
        centerMode: true,
        slidesToShow: 3,
        slidesToScroll: 3
      });
      $(".vertical-center-2").slick({
        dots: true,
        vertical: true,
        centerMode: true,
        slidesToShow: 2,
        slidesToScroll: 2
      });
      $(".vertical-center").slick({
        dots: true,
        vertical: true,
        centerMode: true,
      });
      $(".vertical").slick({
        dots: true,
        vertical: true,
        slidesToShow: 3,
        slidesToScroll: 3
      });
      $(".regular").slick({
        dots: true,
        infinite: true,
        slidesToShow: 3,
        slidesToScroll: 3
      });
      $(".center").slick({
        dots: true,
        infinite: true,
        centerMode: true,
        slidesToShow: 5,
        slidesToScroll: 3
      });
      $(".variable").slick({
        dots: true,
        infinite: true,
        variableWidth: true
      });
      $(".lazy").slick({
        lazyLoad: 'ondemand', // ondemand progressive anticipated
        infinite: true
      });
    });
</script>

</body>
</html>
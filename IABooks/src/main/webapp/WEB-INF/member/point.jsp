<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
%>

<title>적립금</title>

	<!-- 내가만든 CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style_member.css" />	

	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css">
	
	<!-- Optional JavaScript-->
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>

<script type="text/javascript">

	
</script>

<style type="text/css">

</style>

<jsp:include page="header.jsp"/>

<div class="container">
	<br>
	&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/ico_heading.gif" style="width: 6px; height: 20px;"  /> 적립금 </strong> &nbsp;
	<img src="<%= ctxPath%>/images/bar_eee.gif" style="width: 2px; height: 20px;" /> &nbsp; 고객님의 사용가능한 적립금 입니다.
	<hr style="border: solid 2px #e8e8e8;">
	
	<table class="pointTable">
			<tr >
				<td class="pointTable" width="35%;">
					<ul class="pointTable" >
						<li class="pointTable"><img src="<%= ctxPath%>/images/arrow_menu.gif" /> 총 적립금</li>
						<li class="pointTable"><img src="<%= ctxPath%>/images/arrow_menu.gif" /> 사용된 적립금</li>
						<li class="pointTable"><img src="<%= ctxPath%>/images/arrow_menu.gif" /> 환불예정 적립금</li>
					</ul>
				</td>
				<td class="pointTable" width="15%;">
					<ul class="pointTable">
						<li class="pointTable">0원</li>
						<li class="pointTable">원</li>
						<li class="pointTable">원</li>
					</ul>
				</td>
				
				<td class="pointTable" style="border-left :solid 1px #e8e8e8;" width="35%;">
					<ul class="pointTable">
						<li class="pointTable"><img src="<%= ctxPath%>/images/arrow_menu.gif" /> 사용가능 적립금</li>
						<li class="pointTable"><img src="<%= ctxPath%>/images/arrow_menu.gif" /> 미가용 적립금</li>
					</ul>
				</td>
				<td class="pointTable" width="15%;">
					<ul class="pointTable">
						<li class="pointTable">원</li>
						<li class="pointTable">원</li>
					</ul>
				</td>
			</tr>
	</table>
		
		
		<!-- 여기부터 탭  -->	
	
		<!-- 탭을 토글 가능하게 만들려면 각 링크에 data-toggle="tab" 속성을 추가하십시오. 
		         그런 다음 모든 탭에 대해 고유한 ID가 있는 .tab-pane 클래스를 추가하고 .tab-content 클래스가 있는 <div> 요소 안에 래핑합니다.
        -->
		
		<ul class="nav nav-tabs navbar-expand-sm bg-light navbar-light">
		  <li class="nav-item">
		    <a class="nav-link active" data-toggle="tab" href="#menu1">적립내역보기</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" data-toggle="tab" href="#menu2">적립예정내역보기</a>
		  </li>
		  <li class="nav-item">
		    <a class="nav-link" data-toggle="tab" href="#menu3">사용가능한쿠폰/회원등급적립내역</a>
		  </li>
		</ul>

		<!-- Tab panes -->
		<div class="tab-content py-3">
		  <!-- 적립내역보기 -->
		  <div class="tab-pane container active" id="menu1">
		    <table class="point_menu">
		    	<thead>
		    		<tr>
						<td width="24%">주문날짜</td>
						<td width="24%">적립금</td>
						<td width="24%">관련주문</td>
						<td width="28%">내용</td>
		    		</tr>
		    	</thead>
		    	<tbody>
		    		<tr>
		    			<td colspan="4" align="center"><span>적립금내역이없습니다.</span></td>
		    			<!-- 나중에 데이터값에 따라 태그 수정 -->
		    		</tr>
		    	</tbody>	
		    </table>
		  </div>
		  
		  <!-- 적립예정내역보기 -->
		  <div class="tab-pane container" id="menu2">
		     <table class="point_menu">
		    	<thead >
		    		<tr>
						<td width="20%">주문날짜</td>
						<td width="20%">적립금</td>
						<td width="20%">관련주문</td>
						<td width="20%">사용가능 예정일</td>
						<td width="20%">내용</td>
		    		</tr>
		    	</thead>
		    	<tbody class="menu">
		    		<tr class="menu">
		    			<td colspan="5" align="center"><span>적립금내역이없습니다.</span></td>
		    			<!-- 나중에 데이터값에 따라 태그 수정 -->
		    		</tr>
		    	</tbody>	
		    </table>
		  </div>
		  
		  <!-- 사용가능한쿠폰/회원등급적립내역 -->
		  <div class="tab-pane container" id="menu3">
		     <table class="point_menu">
		    	<thead>
		    		<tr>
						<td width="24%">주문날짜</td>
						<td width="24%">적립금</td>
						<td width="24%">관련주문</td>
						<td width="28%">내용</td>
		    		</tr>
		    	</thead>
		    	<tbody>
		    		<tr>
		    			<td colspan="4" align="center"><span>적립금내역이없습니다.</span></td>
		    			<!-- 나중에 데이터값에 따라 태그 수정 -->
		    		</tr>
		    	</tbody>	
		    </table>
		  </div>
		</div>	
	
	
	

</div>
	
<jsp:include page="footer.jsp"/>
 
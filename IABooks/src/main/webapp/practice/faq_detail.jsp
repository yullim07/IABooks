<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
	
%>
<style type="text/css">

</style>

	  
<meta charset="UTF-8">
<title>상품 Q&A</title>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jaehee_pages/semicss/semi_style.css" />

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<script type="text/javascript">
	
	$(document).ready(function(){
		
	
	});

</script>


<jsp:include page="../header.jsp"/>
    


	
 <div class="container">
	
	<div class="content">
	    
	<div class="title" >
		  	<div class="title_icon" ><img src="<%= ctxPath%>/jaehee_pages/semi_images/ico_heading.gif" /></div>
		  	<h2>FAQ</h2>
		  	<div class="bar_icon" ><img src="<%= ctxPath%>/jaehee_pages/semi_images/bar_eee.gif" /></div>
		  	<span >이용안내 FAQ입니다.</span>
	    
	   </div>
				<table class=" review_table table_content">
				  	<tbody>
				    <tr>
				      <th class="col-2" >제목</th>
				      <td class="col-10 subject" id="td_left" >배송도 빠르도 책도 잘 포장돼서 왔어요!</td>
				    </tr>
				  	
				    <tr>
				      <th>작성자</th>
				      <td class="writer" id="td_left" >네****</td>
				    </tr>
				    <tr>
				      
				      <td colspan="2" class="td_content">
				      	<div class="detail detail_contents">
				      		<div class="fr-view fr-view-article">
								<p id="2px"></p>
				         		<p id="2px"><b>단순 변심</b>에 의한 반품은 배송완료 후 7일 이내에 가능합니다.</p>
								<p id="2px"><b>오배송/상품 하자</b>에 의한 반품은 <b>30일 이내</b>에만 접수가능합니다.</p>
								<p id="2px">인디펍 지정 택배(CJ대한통운)로 회수 신청 시 택배 반송료 3,000원이 환불 금액에서 차감 후 환불 처리가 되며,</p>
								<p id="2px">전체 반품 또는 실 구매한 상품이 무료 배송 대상이 아닐 경우 초도 배송비 3,000원이 추가 차감됩니다.</p>
								<p id="2px">(오배송/상품 하자에 의한 반품 배송비는 무료입니다.)</p>
								<p id="2px"><span style="color: red;">※택배 접수 시 '반품예약'으로 접수하셔야 하며 '일반예약', '타택배사' 접수 시 택배비가 추가 차감됩니다.</span></p>
								<p id="2px">상품은 훼손되지 않도록 포장 부탁드리며, 주문자 성함과 연락처를 메모지에 적어서 동봉 부탁드립니다.</p>
								<p id="2px"><b>1. 반품접수</b></p>
								<p id="2px">마이페이지 - 주문조회 - 반품신청</p>
								<p id="2px"><b>2. 택배접수</b></p>
								<p id="2px">CJ대한통운 반품예약 (TEL: 1588-1255)</p>
								<p id="2px"><b>3. 반품주소</b></p>
								<p id="2px">(61180) 광주광역시 북구 용주로40번길 7 인디펍 물류센터 (용봉동)</p>
							</div>
				      	</div>
				      
				      </td>
				    
				    
				    </tr>
				    </tbody>
				  
				</table>
			
			<div class="buttons">
				
				<button class="btn btn_list" type="button">목록</button>
				<button class="btn btn_update" type="button">수정</button>
				<button class="btn btn_delete" type="button">삭제</button>	
				
			</div>
			
			<div class="prev_next table table-responsive">
				<table class="prev_next">
					<tbody>
						<tr>
							<th><img src="<%=ctxPath%>/jaehee_pages/semi_images/ico_move_prev.gif" id="img_prev" /><a>이전글</a></th>
							<td id="td_left" class="board_prev"><a href="">만족</a></td>
						</tr>
						<tr>
							<th><img src="<%=ctxPath%>/jaehee_pages/semi_images/ico_move_next.gif" id="img_next" /><a>다음글</a></th>
							<td id="td_left" class="board_next"><a href="">고민하며 성장하는 모습은 감동적이고 아름답다.</a></td>
						</tr>
					</tbody>
					
				</table>
			</div>
		
	</div>	
			
</div> <!-- container 끝 -->
		
		
		

    <!-- Optional JavaScript -->
    <script src="../js/jquery-3.6.0.min.js" type="text/javascript"></script>
    <script src="../js/bootstrap.bundle.min.js" type="text/javascript"></script>
</body>
</html>


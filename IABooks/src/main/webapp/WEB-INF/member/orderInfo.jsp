<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>


<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="/WEB-INF/header.jsp"/>

	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css" >
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css">
	
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css">
	
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js" ></script>
<script type="text/javascript">

$(document).ready(function(){

	
	sessionStorage.setItem("fromDate", "${requestScope.fromDate}");
	
	// === 전체 datepicker 옵션 일괄 설정하기 ===  
    //     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
    $(function() {
        //모든 datepicker에 대한 공통 옵션 설정
        $.datepicker.setDefaults({
            dateFormat: 'yy-mm-dd' //Input Display Format 변경
            ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
            ,changeYear: true //콤보박스에서 년 선택 가능
            ,changeMonth: true //콤보박스에서 월 선택 가능                
            ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
            ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
            ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
         // ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
            ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
            ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
         // ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
         // ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
     	});
		
	       /////////////////////////////////////////////////////

        //input을 datepicker로 선언
        $("input#fromDate").datepicker();                    
        $("input#toDate").datepicker();
        
        
        if($("input#toDate").val() == "" ){
            //From의 초기값을 오늘 날짜로 설정
            $('input#fromDate').datepicker('setDate', 'today-3M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
            //To의 초기값을 3일후로 설정
            $('input#toDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)

        } else {
            $('input#fromDate').datepicker('setDate', '${requestScope.fromDate}'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
            //To의 초기값을 3일후로 설정
            $('input#toDate').datepicker('setDate', '${requestScope.toDate}'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
        }
        
        
    });
	
	
	
	
	
}); // end of $(document).ready(function()

function today() {
	 $('input#fromDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
	 $('input#toDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
}

function week() {
	 $('input#fromDate').datepicker('setDate', '-7D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
	 $('input#toDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
}

function month() {
	 $('input#fromDate').datepicker('setDate', '-1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
	 $('input#toDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
}

function threeMonth() {
	 $('input#fromDate').datepicker('setDate', '-3M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
	 $('input#toDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
}

function halfYear() {
	 $('input#fromDate').datepicker('setDate', '-6M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
	 $('input#toDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
}



function goOrderInfo() {
	
	
	
    const frm = document.orderInfoFrm;
    frm.action = "<%=request.getContextPath()%>/member/orderInfo.book"
    frm.method = "post"
    frm.submit();

}


</script>



<style type="text/css">

li.nav-item {
	background-color: #F2F2F2;
}

table{
	width: 100%;
	margin: 30px 0 ;
}
.option {
	border: 5px solid #e8e8e8;
	height: 70px;
	text-align: center;
}
table.tbl_bottm > tbody >  tr:nth-child(2) > td{
	height: 70px;
	background-color : #fbfafa;
	text-align: center;
}

tr.tbl_bottom_line {
	border-top: 2px solid #e8e8e8;
	border-bottom: 2px solid #e8e8e8;
}

li.sm {
	    font-size: 10pt;
}	
	
table.tbl_bottm > tbody > tr:last-child {
   border-bottom: solid 2px #e8e8e8;
}

div.pagination {
     display: inline-block;
     width: 100%;
     text-align: center;
     
   }
   
   div.pagination a {
     color: black;
     text-decoration: none;
     width: 32px;
     height: 32px;
     text-align: center;
   }
   
   div.pagination a.active {
      border-bottom: solid 2px black;
        
   }
   
   div.pagination a img {
      margin-top: -4px;
      vertical-align: middle;
   
   }
   
   div.pagination a:hover {
      /* filter: brightness(70%);  */
      font-weight: bolder;
      opacity: 0.3;
   }
	
	input.orderDay {
		background-color: white;
		border: solid 1px grey;
		margin-left: -5;
		padding: 2px;
	}
	
	input.orderDay:hover {
		color: white;
		font-weight:bold;
		background-color: black;
	}
	
	input.orderDay.clicked {
        color: white;
		font-weight:bold;
		background-color: black;
     }


</style>
<title>주문조회</title>
<div class="container">
	
	<div class="titleArea">
		<br>&nbsp;<strong style="font-size: 16pt;"><img src="<%= ctxPath%>/images/member/ico_heading.gif" style="width: 6px; height: 20px;"/>&nbsp;주문조회</strong>
		<hr style="border: solid 2px #e8e8e8; margin-bottom: 3%;">
    </div>
	
         <ul class="nav nav-tabs navbar-expand-sm bg-light navbar-light">
	           <li class="nav-item">
	             <a class="nav-link active" data-toggle="tab" href="#menu1">주문내역조회</a>
	           </li>
	          
         </ul>

      <div class="tab-content py-3">
           
           <div class="tab-pane container active"  id="menu1">
             <form name="orderInfoFrm" >
              <table>
                 <tr class = "option">
	                 <td >
	                     <select name="orderstatus">
	                       <option value = "0" >전체</option>
	                       <option value = "1" >주문완료</option>
	                       <option value = "2" >배송준비중</option>
	                       <option value = "3" >배송중</option>
	                       <option value = "4" >배송완료</option>
	                       <option value = "5" >주문취소</option>
	                     </select>
	                 </td>
	                 
	                 <td>
	                 	 <input class="orderDay" type = "button" value = "오늘" onclick="today();">
		                 <input class="orderDay" type = "button" value = "일주일" onclick="week();">
		                 <input class="orderDay" type = "button" value = "1개월" onclick="month();">
		                 <input class="orderDay" type = "button" value = "3개월" onclick="threeMonth();">
		                 <input class="orderDay" type = "button" value = "6개월" onclick="halfYear();">
	                 </td>
	                 <!-- <td><input type="date" id="currentDate1"> ~ <input type = "date" id="endDate1"> <input type = "button" value="조회"></td> -->
					 <td>
                        From: <input type="text" id="fromDate" name="fromDate" value="${requestScope.fromDate }" >&nbsp;&nbsp; 
                        To: <input type="text" id="toDate" name="toDate" value="${requestScope.toDate }">
                        <button id="goOrderInfo" onClick="goOrderInfo()">조회</button>
                     </td>	                 
                 </tr>
              </table>
	         </form>
	            	<ul style= "margin-bottom: 5%;">
						<li class="sm">기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 지난 주문내역을 조회하실 수 있습니다.</li>
				        <li class="sm">주문번호를 클릭하시면 해당 주문에 대한 상세내역을 확인하실 수 있습니다.</li>
	    			</ul>
              <table class = "tbl_bottm">
	              <tr>
	                 <td style="font-weight:bold; padding: 1%;" >주문 상품 정보</td>
	              </tr>
	              <tr class = "tbl_bottom_line">
	                 <td style = "width: 16%;">주문일자</td><td style=width:20%;>이미지</td><td>상품정보</td><td>수량</td><td>상품구매금액</td><td>주문처리상태</td>
	              </tr>
	              <c:if test="${not empty (requestScope.orderInfoPageList)}">
	              <c:forEach var="map" items="${requestScope.orderInfoPageList}">
	              <tr>
	                 <td style="text-align:center;"><strong>${map.odr_date}</strong></td>
	                 <td style="text-align:center;"><strong><img style="width: 60%;" src="<%= ctxPath %>/images/product/${map.cate_name}/${map.pro_imgfile_name}" /></strong></td>
	              	 <td style="text-align:center;"><strong>${map.pro_name}</strong></td>
	              	 <td style="text-align:center;"><strong>${map.ck_odr_totalqty}</strong></td>
	              	 <td style="text-align:center;"><strong><fmt:formatNumber type="number" pattern="###,###">${map.odr_totalprice}</fmt:formatNumber>원</strong></td>
	              	 <td style="text-align:center;"><strong>${map.delivername}</strong></td>
	              </tr>
	              </c:forEach>
	              </c:if>
	              <c:if test="${empty (requestScope.orderInfoPageList)}">
				<tr>
					<td colspan="7" align="center" style="height: 100px;">
						<strong>주문 정보가 존재하지 않습니다ㅎㅎ</strong>
					</td>
				</tr>
			</c:if>
              </table>
	                   
              	 <nav class="my-5">
			    	<div style="display: flex; width: 100%;">
			    		<ul class="pagination" style='margin:auto;'>
			    			${requestScope.pageBar}
			    		</ul>
			    	</div>
			    </nav>    
	        </div>
        </div> 
   
	
	

</div>
	
<jsp:include page="/WEB-INF/footer.jsp"/>
 
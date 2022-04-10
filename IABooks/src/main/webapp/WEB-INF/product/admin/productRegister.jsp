<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	String ctxPath = request.getContextPath();
%>

<meta charset="UTF-8">
<title>in사과::제품등록</title>
<jsp:include page="../../header.jsp" />

<!-- Spinner -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js"></script>

<!-- datePicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>



<style type="text/css">
</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		
		$("span.error").hide();
		
		// 제품 수량에 스피너 달아주기
		$("input#spinnerPqty").spinner({
			spin:function(event,ui){
				if(ui.value > 100) {
					$(this).spinner("value", 100); // $(this)는 자기자신, 즉 $("input#spinnerPqty")
					return false;
				}
				else if(ui.value < 1) {
					$(this).spinner("value", 1);
					return false;
				}
			}
		}); // end of $("input#spinnerPqty").spinner() --------------------
		
		// 추가이미지파일에 스피너 달아주기 << 주석처리?
		$("input#spinnerImgQty").spinner({
			spin:function(event,ui){
				if(ui.value > 10) {
					$(this).spinner("value", 10); // $(this)는 자기자신, 즉 $("input#spinnerImgQty")
		 			return false;
				}
				else if(ui.value < 0) {
					$(this).spinner("value", 0);
					return false;
				}
			}
		}); // end of $("input#spinnerImgQty").spinner() --------------------
		
		// #### [암기]스피너의 이벤트는 click 도 아니고, change 도 아니고 "spinstop" 이다 #### //
		$("input#spinnerImgQty").bind("spinstop", function(){
			let html = "";
			const cnt = $(this).val();
			// 화살표 함수를 쓰면 $(this)가 작동되지 않고, $("input#spinnerImgQty") 라고 직접 써주어야 한다.
			// 반면 function을 사용하면 $(this)는 자기 자신을 가리킨다.
			
			console.log("확인용 cnt : " + cnt); // 웹은 항상 String 타입이다
			console.log("확인용 typeof cnt : " + typeof cnt);
			
			for(let i=0; i<parseInt(cnt); i++) {
				html += "<br>";
				html += "<input type='file' name='attach"+i+"' class='btn btn-default' />";
				// file을 보낼 거니까 name을 반드시 써주어야 한다!
				
			} // end of for --------------------
			
			$("div#divfileattach").html(html);
			$("input#attachCount").val(cnt);
		}); // end of $("input#spinnerImgQty").bind() --------------------
		
		// 제품 등록하기
		$("input#btnRegister").click(function() {
			let flag = false;
			$(".infoData").each(function(index, item) { // 필수입력을 채웠는지 검사
				
				const val = $(item).val().trim();
				
				if(val == "") {
					$(item).next().show();
					flag = true;	// 뭔가 잘못된 경우
					return false;	// break와 같은 역할
				}
			});
				
			if(!flag) { // flag가 바뀌지 않은 경우, 즉 false라면 모든 것을 올바르게 채운 것이다! 
				var frm = document.prodInputFrm
				frm.submit();
			}
		});
			
		// 제품 등록 취소하기
		$("input[type='reset']").click(function() {
			$("span.error").hide();			// 다시 에러 메시지를 숨겨준다.
			$("div#divfileattach").empty();	// 파일이 첨부된 곳을 다시 비운다.
		});
		
		
		
		
		// datapicker 사용
		$(function() {
			$("#datepicker").datepicker();
		});
		
		
		
		
		
	}); // end of $(document).ready(function()) --------------------
	
</script>

<div class="container">
	<%-- !!!!! ==== 중요 ==== !!!!! --%>
	<%-- 폼에서 파일을 업로드 하려면 반드시 method 는 POST 이어야 하고 
     enctype="multipart/form-data" 으로 지정해주어야 한다.!! 
     enctype="application/x-www-form-urlencoded" 은 기본값인데, 파일을 업로드할 수 없다!
     --%>
	<form name="prodInputFrm" action="<%= request.getContextPath()%>/product/admin/productRegister.book" method="POST" enctype="multipart/form-data">

		<table id="tblProdInput" style="width: 80%;">
			<tbody>
				<tr>
					<td><label class="title">재입고 상품 여부</label></td>
					<td width="30%">
						<label for="restock_yes"></label>
						<input type="checkbox" name="restock_yes" id="restock_yes" />
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName" style="padding-top: 10px;">카테고리</td>
					<td width="75%" align="left" style="padding-top: 10px;">
						<select name="fk_cate_num" class="infoData">
						<option value="">카테고리 선택</option>
						<c:forEach var="map" items="${requestScope.categoryList}">
							<option value="${map.pk_cate_num}">${map.cate_name}</option>
							<%-- value에 숫자 쓰면 안됨 --%>
							<%-- var가 vo라면 get변수에서 get다음소문자 var가 map이라면 put의 키값 --%>
						</c:forEach>
						</select>
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">국제표준도서번호(ISBN번호)</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" style="width: 300px;" name="pk_pro_num" class="box infoData" /> 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">도서명</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" style="width: 300px;" name="pro_name" class="box infoData" /> 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">저자코드</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" style="width: 300px;" name="fk_wr_code" class="box infoData" /> 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">저자명</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" style="width: 300px;" name="wr_name" class="box infoData" /> 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">출판사</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" style="width: 300px;" name="publisher" class="box infoData" /> 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">출간일자</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" id="datepicker" style="width: 300px;" name="pro_publish_date" class="box infoData" /> 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">제품정가</td>
					<td width="35%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" style="width: 100px;" name="pro_price" class="box infoData" /> 원 
						<span class="error">필수입력</span>
						<input type="checkbox" id="priceCheck" name="priceCheck">판매가와 동일
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">제품판매가</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" style="width: 100px;" name="pro_saleprice" class="box infoData" /> 원 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">포인트적립율</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" style="width: 100px;" name="point_rate" class="box infoData" /> 퍼센트 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">메인이미지</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="file" name="pro_imgfile_name" class="infoData" />
						<span class="error">필수입력</span>
					</td>
				</tr>


				<tr>
					<td width="25%" class="prodInputName">규격</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" style="width: 100px;" name="pro_size" class="box infoData" /> 원 
						<span class="error">필수입력</span>
					</td>
				</tr>
				
				<tr>
					<td width="25%" class="prodInputName">제본형태</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<select name="pro_bindtype" class="infoData">
							<option value="">제본형태 선택</option>
							<option value="">양장제본</option>
							<option value="">반양장제본</option>
							<option value="">무선제본</option>
							<option value="">낱장제본</option>
							<option value="">기타</option>
						</select>
						<span class="error">필수입력</span>
					</td>
				</tr>
				
				<tr>
					<td width="25%" class="prodInputName">쪽수</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" style="width: 100px;" name="pro_pages" class="box infoData" /> 원 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<%-- ----------------------------------------------------------------- --%>

				<tr>
					<td width="25%" class="prodInputName">제품수량</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input id="spinnerPqty" name="pro_qty" value="1" style="width: 30px; height: 20px;"> 개 
						<span class="error">필수입력</span>
					</td>
				</tr>

				<tr>
					<td width="25%" class="prodInputName">목차</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<textarea name="pro_index" rows="5" cols="60"></textarea>
					</td>
				</tr>

				<tr>
					<td width="25%" class="prodInputName">책소개</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<textarea name="pro_content" rows="5" cols="60"></textarea>
					</td>
				</tr>

				<%--
				<tr>
					<td width="25%" class="prodInputName">제품스펙</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<select name="fk_snum" class="infoData">
						<option value="">:::선택하세요:::</option>
						<c:forEach var="spvo" items="${requestScope.specList}">
							<option value="${spvo.snum}">${spvo.sname}</option>
						</c:forEach>
						</select>
						<span class="error">필수입력</span>
					</td>
				</tr>
				--%>

				<%--====첨부파일 타입 추가하기====--%>
				<tr>
					<td width="25%" class="prodInputName" style="padding-bottom: 10px;">추가이미지파일(선택)</td>
					<td>
						<label for="spinnerImgQty">파일갯수 : </label> 
						<input id="spinnerImgQty" value="0" style="width: 30px; height: 20px;">
						<div id="divfileattach"></div> 
						<input type="text" name="attachCount" id="attachCount" />
					</td>
				</tr>

				<tr style="height: 70px;">
					<td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden;">
						<input type="button" value="제품등록" id="btnRegister" style="width: 80px;" /> &nbsp; 
						<input type="reset" value="취소" style="width: 80px;" />
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<jsp:include page="../../footer.jsp" />

<!-- 

(1) 스펙 대신 카테고리만 넣기
(2) 재입고 구분하는 거(PRO_RESTOCK) 넣기 [재입고시 insert가 아닌 update]
(3) 제품명과 이미지파일명의 이름이 동일하므로 제품코드 입력 시 자동으로 이미지 첨부 가능하면 좋겠다.
(4) 저자코드 입력 시 저자 이름 불러오기 가능한가? => 그러려면 DB에 등록된 작가만 가능! => 저자도 나눠서? 이건 좀 생각해보자...


1. 재입고 여부(pro_restock)				체크박스
2. 카테고리(fk_cate_num, cate_name)	select
3. 기본정보
(1) 도서명(pro_name), ISBN번호(pk_pro_num) 
(2) 저자코드(fk_wr_code), 저자명(wr_name), 저자소개(wr_info), 출판사(publisher), 출간일자(pro_publish_date)
(3) 정가(pro_price), 판매가(pro_saleprice), 포인트적립률(point_rate)
(4) 책소개(pro_content-clob) 
(5)메인이미지(pro_imgfile_name)
4. 기타정보
(1) 규격(pro_size), 제본형태(pro_bindtype), 쪽수(pro_pages)
5. 상세정보
(1) 목차(pro_index-clob)
6. hidden
(1) 입고일자(pro_inputdate) sysdate
입고량/재고량(pro_qty)

안 써도 되는 것
1. 포인트 적립율 >> 모든 제품 동일
2. 입고일자 >> sysdate

 -->


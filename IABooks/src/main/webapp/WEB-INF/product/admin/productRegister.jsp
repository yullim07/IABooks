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

<%-- 직접 만든 CSS --%>
<%-- <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/product/register.css" />
 --%>
<!-- datePicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->

<style type="text/css">

	table#tblProdInput {
		border: solid 1px grey;
	}
	
	table#tblProdInput > tbody > tr > td {
		font-size: 12pt;
		height: 20pt;
		font-weight: bold;
		border-collapse: collapse;
	}
	
	table#tblProdInput > tbody > tr > td:first-child {
		border: none;
	}
	
	table#tblProdInput > tbody > tr > td#second_td {
		width: 80%;
		align: left;
	}
	
	span.error {
		color: red;
	}
	.star {
		color: red;
		font-weight: bold;
		font-size: 13pt;
	}

</style>

<script type="text/javascript">
	

	$(document).ready(function() {
		
		$("span.error").hide();
		$("select#catesel").focus();
		
		// not null 입력 안했을 때 에러 메시지 출력하기
		// fk_cate_num(int), pro_name, publisher, pro_publish_date, pro_imgfile_name, pk_pro_num    
		
		// * 카테고리 국제표준도서번호(ISBN번호) 도서명	 재입고상품여부 저자코드 저자명 출판사 출간일자
		// 제품정가 제품판매가 포인트적립율 메인이미지 제본형태 규격 쪽수 제품수량 목차 책소개 추가이미지파일(선택)

		// 카테고리를 선택하지 않은 경우 에러 메시지 출력
		if ($("select#cateSel option:selected").length == 0) {
			$("span.error").show();
			$("select#catesel").focus();
		}
		
		// 카테고리를 선택한 경우 에러 메시지 숨기기
		if ($("select#cateSel option:selected").length != 0) {
			$("span.error").hide();
		}
		
		// --------------------------------------------------------------------------- // 
		
		// 카레고리 선택값 받아오기
		$("select#cateSel").on("change", function() {   
	         const catesel = $(this).val();
			 let cateSel = $("select#cateSel > option:selected").attr("value2");
			 $("input#cateNameChoice").val(cateSel);
			
	      });//end of $("select#cateSel").on("change", function() 
		
		// 재입고여부 확인용 변수
		let restock_yes = 0; // 테이블에서 0값이면 신간, 1값이면 재입고 
		
		// 재입고 여부 확인용 라디오 버튼
		$("input:radio[name='restock']").bind("click", ()=>{
			const $target = $(event.target);	// 클릭한 라디오
			restock_yes = $target.val();		// 라디오를 선택하면 restock_yes 가 얼마인지 잡히게 된다.
			
			let index = $("input:radio[name='restock']").index($target);
			// 전체에서 index하고 2개 중에 실제로 선택한 것
			
			if(index == 0) {		// 신간 선택한 경우 
				restock_yes = 0;
			} 
			else if(index == 1) {	// 재입고 선택한 경우
				restock_yes = 1;
			}
		//	console.log("~~~ 확인용 index => " + index);
		});
		
		// 재입고 라디오를 선택했는지 아닌지를 알아오기
		$("td#purchase").click(function() {
			const checkedCnt = $("input:radio[name='restock']:checked").length;
			if(checkedCnt == 0) {
				// 재입고 여부 선택하지 않았을 경우
				$("span.error").show();
				return; // 종료
			}
		});
		
		// --------------------------------------------------------------------------- // 
		
		// 및 엔터 치면 밑으로 내려가기 
		/* $("#pk_pro_num").keydown(function (e) {
			if (e.which == 13) { // 엔터쳤을 때 밑으로 내려가기
				$("#pro_name").focus();
			}
		}); */
		
		// --------------------------------------------------------------------------- // 
		
		
		// datapicker 사용
		$(function() {
			$("#datepicker").datepicker();
		});	
		
		// 초기값을 오늘 날짜로 설정
	    $("input#datepicker").datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후) 
		
		
		// --------------------------------------------------------------------------- // 
		
		// 제품 수량에 스피너 달아주기
		$("input#spinnerPqty").spinner({
			spin:function(event,ui){
				if(ui.value > 100) {
					$(this).spinner("value", 100); // $(this)는 자기자신, 즉 $("input#spinnerPqty")
					alert("100보다 큰 값을 입력할 수 없습니다!");
					return false;
				}
				else if(ui.value < 1) {
					$(this).spinner("value", 1);
					alert("1보다 작은 값을 입력할 수 없습니다!");
					return false;
				}
			}
		}); // end of $("input#spinnerPqty").spinner() --------------------
		
		
		// --------------------------------------------------------------------------- // 
		

		// 제품 등록하기
		$("input#btnRegister").click(function() {
			
			let flag = false; // 필수입력사항 검사용 flag
			
			$(".infoData").each(function(index, item) { // 필수입력을 채웠는지 검사
				const val = $(item).val().trim();
				if(val == "") {
					alert("* 표시된 필수입력사항은 모두 입력하셔야 합니다.");
					$(item).next().show();
					flag = true;	// 뭔가 잘못된 경우
					return false;	// break와 같은 역할
				}
				else {
					$("span.error").hide();
				}
			});
			
			if(!flag) { // flag가 바뀌지 않은 경우, 즉 false라면 모든 것을 올바르게 채운 것이다! 
				var frm = document.prodInputFrm;
				$("span.error").hide();
				frm.submit();
			}
		});
		
		
		// --------------------------------------------------------------------------- // 
		
		
		// 제품 등록 취소하기
		$("input[type='reset']").click(function() {
			$("span.error").hide();			// 다시 에러 메시지를 숨겨준다.
			$("div#divfileattach").empty();	// 파일이 첨부된 곳을 다시 비운다.
		});
		
		
	}); // end of $(document).ready(function()) --------------------
	
	// Function Declaration
	
	// 양쪽 공백만 제거해주기
	function blanck_trim1(obj) {
		obj.focus();
		var str_obj = $(this).val();
		str_obj.value = str_obj.trim().val();
		
		return false;
		
	} // end of function blanck_trim1(obj) ------------------------------
	
	// 문장 내에 존재하는 모든 공백 자동 제거해주고 맨 앞으로 가져가기
	function blanck_trim2(obj) {
		var str_space = /\s/;
		if(str_space.exec(obj.value)) { //공백 체크
			obj.focus();
			obj.value = obj.value.replace(/\s| /gi,''); // 공백제거
			
			return false;
		}
	} // end of function blanck_trim2(obj) ------------------------------

</script>

<div class="container">
	<form name="prodInputFrm"
		  action="<%= request.getContextPath()%>/product/admin/productRegister.book"
		  method="POST"
		  enctype="multipart/form-data">

		<table id="tblProdInput" style="width: 100%; margin-top: 40px;  margin-bottom: 40px;">
			<thead>
				<tr>
					<td colspan="2"><span style="font-size: 20pt; font-weight: bold;">도서등록</span></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td width="20%" class="prodInputName" style="padding-top: 10px;">
						<span class="star">*</span>&nbsp;카테고리
					</td>
					<td width="80%" align="left" style="padding-top: 10px;">
						<select name="fk_cate_num" class="infoData" id="cateSel">
						<option value="">카테고리 선택</option>
						<c:forEach var="map" items="${requestScope.categoryList}">
							<option value="${map.pk_cate_num}" value2="${map.cate_name}">
							<c:if test="${map.cate_name eq 'humanities'}">인문</c:if>
							<c:if test="${map.cate_name eq 'science'}">과학</c:if>
							<c:if test="${map.cate_name eq 'society'}">사회</c:if>
							<c:if test="${map.cate_name eq 'other'}">기타</c:if>
							</option>
						</c:forEach>
						</select>
						<span class="error">필수입력</span>
						<input type="hidden" id="cateNameChoice" name="cateNameChoice" value="">
					</td>
				</tr>
				<tr>
					<td width="20%" class="prodInputName">
						<span class="star">*</span>&nbsp;국제표준도서번호
					</td>
					<td class="second_td">
						<input type="text" style="width: 300px;" id="pk_pro_num" name="pk_pro_num" class="box infoData" 
							oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
							onkeyup="blanck_trim2(this);" onchange="blanck_trim2(this);
							maxlength="20" />
						<span class="error">필수입력</span>
					</td>
				</tr>				
				<tr>
					<td width="20%" class="prodInputName">
						<span class="star">*</span>&nbsp;도서명
					</td>
					<td class="second_td">
						<input type="text" style="width: 300px;" name="pro_name" id="pro_name" class="box infoData"
							onkeyup="blanck_trim1(this);" onchange="blanck_trim1(this);" 
							maxlength="66" />
						<span class="error">필수입력</span>
					</td>
				</tr>
				
				<tr>
					<td>
						<label class="title"><span class="star">*</span>&nbsp;재입고 상품 여부</label>
					</td>
					<td class="second_td">
						<label for="restock_no" style="margin-left: 2%;">신간</label>
						<input type="radio" name="restock" value="0" id="restock_no" class="infoData" checked="checked"/>
						
						<label for="restock_yes" style="margin-left: 2%;">재입고</label>
						<input type="radio" name="restock" value="1" id="restock_yes" class="infoData"/>
						
						<span class="error">필수입력</span>
					</td>
				</tr>
				
				<tr>
					<td width="20%" class="prodInputName">
						<span class="star">*</span>&nbsp;저자명
					</td>
					<td class="second_td">
						<input type="text" style="width: 300px;" name="wr_name" id="wr_name" class="box infoData" 
							onkeyup="blanck_trim1(this);" onchange="blanck_trim1(this);"
							maxlength="66" />
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="20%" class="prodInputName">
						<span class="star">*</span>&nbsp;출판사
					</td>
					<td class="second_td">
						<input type="text" style="width: 300px;" name="publisher" id="publisher" class="box infoData"
							onkeyup="blanck_trim1(this);" onchange="blanck_trim1(this);"
							maxlength="16"/>
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="20%" class="prodInputName">
						<span class="star">*</span>&nbsp;출간일자
					</td>
					<td class="second_td">
						<input type="text" id="datepicker" style="width: 300px;" name="pro_publish_date" class="box infoData" /> 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="20%" class="prodInputName">
						<span class="star">*</span>&nbsp;제품정가
					</td>
					<td width="40%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" style="width: 100px;" name="pro_price" id="pro_price" class="box infoData" 
							oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
							onkeyup="blanck_trim2(this);" onchange="blanck_trim2(this);"
							maxlength="8" /> 원 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="20%" class="prodInputName">
						<span class="star">*</span>&nbsp;제품판매가
					</td>
					<td class="second_td">
						<input type="text" style="width: 100px;" name="pro_saleprice" id="pro_saleprice" class="box infoData" 
							oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
							onkeyup="blanck_trim2(this);" onchange="blanck_trim2(this);"
							maxlength="8" /> 원 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="20%" class="prodInputName">포인트적립율</td>
					<td class="second_td">
						<input type="text" style="width: 100px;" name="point_rate" id="point_rate" class="box" value="0.1"
							oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
							onkeyup="blanck_trim2(this);" onchange="blanck_trim2(this);"
							maxlength="10" /> 퍼센트
					</td>
				</tr>
				<tr>
					<td width="20%" class="prodInputName">
						<span class="star">*</span>&nbsp;메인이미지
					</td>
					<td class="second_td">
						<input type="file" name="pro_imgfile_name" class="infoData" />
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="20%" class="prodInputName"><span class="star">*</span>&nbsp;제본형태</td>
					<td class="second_td">
						<select name="pro_bindtype" id="pro_bindtype" class="infoData"> 
							<option value="">제본형태 선택</option>
							<option value="양장제본">양장제본</option>
							<option value="반양장제본">반양장제본</option>
							<option value="무선제본">무선제본</option>
							<option value="낱장제본">낱장제본</option>
							<option value="기타">기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="20%" class="prodInputName">&nbsp;규격</td>
					<td class="second_td">
						<input type="text" style="width: 100px;" name="pro_size" id="pro_size" class="box"
							onkeyup="blanck_trim1(this);" onchange="blanck_trim1(this);"
							maxlength="20" />
						<!-- <span class="error">필수입력</span> -->
					</td>
				</tr>
				<tr>
					<td width="20%" class="prodInputName">&nbsp;쪽수</td>
					<td class="second_td">
						<input type="text" style="width: 100px;" name="pro_pages" id="pro_pages" class="box" 
						oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
						onkeyup="blanck_trim2(this);" onchange="blanck_trim2(this);"
						maxlength="5" /> 쪽
					</td>
				</tr>



				<%-- ----------------------------------------------------------------- --%>


				<tr>
					<td width="25%" class="prodInputName">제품수량</td>
					<td class="second_td">
						<input id="spinnerPqty" name="pro_qty" value="1" style="width: 30px; height: 20px;"> 개
					</td>
				</tr>

				<tr>
					<td width="25%" class="prodInputName">&nbsp;목차</td>
					<td class="second_td">
						<textarea name="pro_index" id="pro_index" rows="5" cols="60"
							onkeyup="blanck_trim1(this);" onchange="blanck_trim1(this);" /></textarea>
					</td>
				</tr>

				<tr>
					<td width="25%" class="prodInputName">&nbsp;책소개</td>
					<td class="second_td">
						<textarea name="pro_content" id="pro_content" rows="5" cols="60"
							onkeyup="blanck_trim1(this);" onchange="blanck_trim1(this);" /></textarea>
					</td>
				</tr>
				
				<tr>
					<td width="25%" class="prodInputName">&nbsp;저자소개</td>
					<td class="second_td">
						<textarea name="wr_info" id="wr_info" rows="5" cols="60"
							onkeyup="blanck_trim1(this);" onchange="blanck_trim1(this);" /></textarea>
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


				<%-- 제품 등록 --%>				
				<tr style="height: 80px;">
					<td colspan="2" align="center">
						<input type="button" value="제품등록" id="btnRegister" style="width: 80px;" /> &nbsp; 
						<input type="reset" value="취소" style="width: 80px;" />
					</td>
				</tr>
				<%-- 제품 등록 --%>
				
				
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


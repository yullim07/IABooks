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
<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>



<style type="text/css">

	table#tblProdInput {
		border: solid 1px grey;
	}
	
	table#tblProdInput > tbody > tr > td {
		font-size: 12pt;
		line-height: 12pt;
		background-color: #e8e8e8;
	}
</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		
		$("span.error").hide();
		
		let restock_yes = 0;
		
		// 재입고 여부 확인용 라디오 버튼
		$("input:radio[name='restock']").bind("click", ()=>{
			const $target = $(event.target);	// 클릭한 라디오
			restock_yes = $target.val();		// 라디오를 선택하면 restock_yes 가 얼마인지 잡히게 된다.
			let index = $("input:radio[name='restock']").index($target); // 전체에서 index하고 2개 중에 실제로 선택한 것
			console.log("~~~ 확인용 index => " + index);
			$("span.error").hide();
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
		
		// 카테고리명 알아오기 콘솔출력
		/* $("select[name='fk_cate_num']").change({
			const catenumSelect = $("select[name='fk_cate_num']").val();
			console.log("선택된 카테고리명 " + catenumSelect);
		}); */
		
		// 카레고리 선택값 바당오기
		$("select#cateSel").on("change", function() {   
	         const catesel = $(this).val();
	         $("input#cateselhide").val(catesel);
	        // alert(catesel);
	      });
		
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
				var frm = document.prodInputFrm;
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
	
	
	// 재입고 여부 체크 시 반환해주기?
	function getRestock(event) {
		let result = 0;
		if(event.target.checked) {
			result = event.target.value;
			console.log(result);
		}
		else {
			result = 0;
			console.log(result);
		}
	}
	
</script>

<div class="container">
	<%-- !!!!! ==== 중요 ==== !!!!! --%>
	<%-- 폼에서 파일을 업로드 하려면 반드시 method 는 POST 이어야 하고 
     enctype="multipart/form-data" 으로 지정해주어야 한다.!! 
     enctype="application/x-www-form-urlencoded" 은 기본값인데, 파일을 업로드할 수 없다!
     --%>
<form name="prodInputFrm"
	action="<%= request.getContextPath()%>/product/admin/productRegister.book"
	method="POST"
	enctype="multipart/form-data">

	<table id="tblProdInput" style="width: 80%;">
		<tr>
			<td width="25%" class="prodInputName" style="padding-top: 10px;">cate</td>
			<td width="75%" align="left" style="padding-top: 10px;">
				<select name="fk_cate_num" class="infoData" id="cateSel">
				<option value="">Select Cate</option>
					<c:forEach var="map" items="${requestScope.categoryList}">
						<option value="${map.pk_cate_num}">${map.cate_name}</option>
					</c:forEach>
				</select>
			<input type="text" id="cateselhide" value="">
			</td>
		</tr>
	</table>
</form>
	
</div>

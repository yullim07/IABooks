<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>

<style type="text/css">

</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		$(".calc thead input:checkbox[id-check]").click(function() {
			var bool = $(this).prop("checked");
			#(".calc tbody input:checkbox[name=checkbox]").prop("checked", bool);
		});
		
		$(".calc tbody input:checkbox[id=check]").click(function() {
			var flag = false;
			$(".calc tbody input:checkbox[name=checkbox]").each(function() {
				var bool = $(this).prop("checked");
				
				if(!bool) {
					$(".calc thead input:checkbox[id=check]").prop("checked", false);
					flag = true;
					return false;
				}
			});
			
			if(!flag) {
				$(".calc thead input:checkbox[id=check]").prop("checked", true);
			}
		});
	}); // end of $(document).ready() --------------------
	
</script>


</head>
<body>
	<div class="container">
		<div id="frame">
			<form>
				<div id="frame2">
					<span>장바구니</span>
					<span class="home">홈 > 장바구니</span>
					<span></span>
				</div>
				
				<hr>
				
				<div>
					<table>
						<tr>
							<th class="aa">구매상품</th>
							<th class="aa">해외상품</th>
							<th></th>
						</tr>
					</table>
				</div>
				
				<hr>
				
				<div>
					<table class="calc">
						<thead>
							<tr>
								<th colspan="10">일반상품(1)</th>
							</tr>
							<tr>
								<th><input type="checkbox" name="checkbox" id="check"></th>
								<th><span>이미지</span></th>
								<th><span>상품정보</span></th>
								<th>판매가</th>
								<th>수량</th>
								<th>적립금</th>
								<th>배송구분</th>
								<th>배송비</th>
								<th>합계</th>
								<th>선택</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									<input type="checkbox" name="checkbox" id="check">
								</td>
								<td>
									<img src=어쩌고 />
								</td>
							</tr>
						</tbody>
					</table>
					
				</div>
				
			</form>
		</div>
	</div>
</body>
</html>
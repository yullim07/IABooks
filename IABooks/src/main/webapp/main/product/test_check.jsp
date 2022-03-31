<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>체크박스에 대해서 알아봅니다. -1</title>

</head>
<body>
	<div id="container" align="center">
	<!-- 또는 display:flex 로 만든 후에 margin 을 auto 로 주면 중앙정렬된다. -->
		<h2>거래처등록1</h2>
		<table id="tbl">
			<!-- 
				>>> === checkbox 제어의 기본개념 === <<<
				checkbox 는 동일한 이름을 가진 체크박스들이 여러개 존재하며 다수의 선택을 가능하게 하는 기능을 제공한다.
				checkbox 는 배열의 개념이 필요하기 때문에 getElementById 가 아닌 getElementsByName 을 이용하여 제어한다.
				그래서 id 가 아닌 name 을 이용하기 때문에 태그에 id 를 지정할 필요가 없다.
				반드시 태그에  name 을 지정해야만 한다.  
				                    
				>>> === checkbox 의 주요속성 === <<<
					1. name		=> 체크박스의 이름.
					2. length	=> 동일한 이름의 체크박스의 갯수.
					3. checked	=> 체크박스의 체크여부. 체크가 되어지면 true, 체크가 해제되면 false 를 리턴함.
					4. value	=> 체크박스의 값.             
			-->
			
			<tr>
				<td class="title">
					<label for="allCheck">모두선택/해제</label><input type="checkbox" id="allCheck" onclick="allCheck(this.checked)"/>
					<br/>품명(베트남산)
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" name="product_vietnam" id="product_vietnam1" onclick="vietnamCheck()" /><label for="product_vietnam1">메인보드</label>&nbsp;
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" name="product_vietnam" id="product_vietnam2" onclick="vietnamCheck()" /><label for="product_vietnam2">모니터</label>&nbsp;
				</td>
			</tr>
			<tr>
				<td>	
					<input type="checkbox" name="product_vietnam" id="product_vietnam3" onclick="vietnamCheck()" /><label for="product_vietnam3">프린터</label>&nbsp;
					
				</td>
				<td><span>하하하</span></td>
			</tr>
			<tr>
				<td>	
					<input type="checkbox" name="product_vietnam" id="product_vietnam4" onclick="vietnamCheck()" /><label for="product_vietnam4">하드디스크</label>&nbsp;
				</td>
				<td><span>하하하</span></td>
			</tr>
			<tr>
				<td>	
					<input type="checkbox" name="product_vietnam" id="product_vietnam5" onclick="vietnamCheck()" /><label for="product_vietnam5">메모리</label>&nbsp;
				</td>
				<td><span>하하하</span></td>
			</tr>
			<tr>
				<td>	
					<input type="checkbox" name="product_vietnam" id="product_vietnam6" onclick="vietnamCheck()" /><label for="product_vietnam6">CPU</label>&nbsp;
				</td>
				<td><span>하하하</span></td>
			</tr>
		</table>
	</div>
	
	<script type="text/javascript">

		// ===	체크박스 전체선택 OR 전체해제 === //
		function allCheck(bool) {
			const vietnam_checkBox_List = document.getElementsByName("product_vietnam");
			
			for(let vietnam_checkBox of vietnam_checkBox_List) {
				vietnam_checkBox.checked = bool;
			} // end of for --------------------
			
		} // end of function allCheck() --------------------
		
		// ===	체크박스 전체선택 / 전체해제 에서 
		//		하위 체크박스에 체크가 1개라도 체크가 해제되면 체크박스 전체선택/전체해제 체크박스도 체크가 해제되고
		//		하위 체크박스에 체크가 모두 체크가 되어지지면  체크박스 전체선택/전체해제 체크박스도 체크가 되어지도록 하는 것 == //
		function  vietnamCheck() {
			const vietnam_checkBox_List = document.getElementsByName("product_vietnam");
			
			let bFlag = false;
			for(let vietnam_checkBox of vietnam_checkBox_List) {
				if(!vietnam_checkBox.checked) {
					// 하위 체크박스(베트남산 체크박스)에 체크가 1개라도 체크가 해제되었다면
					bFlag = true;
					break; // for문을 빠져나온다.
				}				
			} // end of for --------------------
			
			if(bFlag) {
				// 하위 체크박스(베트남산 체크박스)에 체크가 1개라도 체크가 되었다면
				document.getElementById("allCheck").checked = false;
			}
			else {
				// 하위 체크박스(베트남산 체크박스)에 체크가 모두 체크되었다면
				document.getElementById("allCheck").checked = true;
			}
			
		} // end of function vietnamCheck() --------------------
		
		
	</script>
</body>
</html>
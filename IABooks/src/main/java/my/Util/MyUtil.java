package my.Util;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {

	// *** ? 다음의 데이터까지 포함한 현재 URL 주소를 알려주는 메소드를 생성 *** //
	
	public static String getCurrentURL(HttpServletRequest request) {
	
	// 만약에 웹브라우저 주소입력란에 아래와 같이 입력되었다면 
		// http://localhost:9090/MyMVC/member/memberList.up?currentShowPageNo=7&sizePerPage=10&searchType=name&searchWord=%EC%9C%A0

		String currentURL = request.getRequestURL().toString();		
		// http://localhost:9090/MyMVC/member/memberList.up 
		
		String queryString = request.getQueryString();
		// currentShowPageNo=7&sizePerPage=10&searchType=name&searchWord=%EC%9C%A0 (GET 방식일 경우)
		// null (POST 방식일 경우)
		
		if(queryString != null) { // get 방식일 경우
			currentURL += "?"+queryString;
		// http://localhost:9090/MyMVC/member/memberList.up?currentShowPageNo=7&sizePerPage=10&searchType=name&searchWord=%EC%9C%A0
		} 		
		
		String ctxPath = request.getContextPath();
		//               /MyMVC
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
		//	   27	   =	  21 					 +			6	
		
		currentURL = currentURL.substring(beginIndex);
		// 		/member/memberList.up?currentShowPageNo=7&sizePerPage=10&searchType=name&searchWord=%EC%9C%A0
		
		
		return currentURL;
		
	}
	
	
	
}

package member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import my.Util.MyUtil;

public class MileageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
        // 메모리에 생성되어져 있는 session 을 불러오는 것이다.
		
		if(session.getAttribute("loginuser") == null) {
			
			session.setAttribute("myPageLogin", "myPageLogin");
			
			setRedirect(false);
			setViewPage("/login/join.book");
			
		} else { // 로그인 되었을 때
			
			String userid = (String)session.getAttribute("userid");
			String count = "1";
			
			InterMemberDAO mdao = new MemberDAO(); // mdao 라는 새로운 dao 객체 생성
			
			Map<String, String> paraMap = new HashMap<String, String>(); // paraMap 이라는 Map 객체 생성 (파라미터값으로 String)
			paraMap.put("userid", userid); // 세션에서 userid 값을 받아와서 파라맵에 넣어줌
			paraMap.put("count", count);
			
			// 적립금 조회
			int mileage = mdao.useMileage(userid);
			
			/////////////////////////////////////////////////////////////////////////////////////////// 전체조회 시작
			
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			// currentShowPageNo 은 사용자가 보고자 하는 페이지바의 페이지번호 이다.
			// 메뉴에서 회원목록 만을 클릭했을 경우에는 currentShowPageNo 은 null 이 된다.
			// currentShowPageNo 이 null 이라면 currentShowPageNo 을 1 페이지로 바꾸어야 한다.
			
			String sizePerPage = "10";
			// 한 페이지당 화면상에 보여줄 회원의 개수
			// 메뉴에서 회원목록 만을 클릭했을 경우에는 sizePerPage 는 null 이 된다.
			// sizePerPage 가 null 이라면 sizePerPage 를 10 으로 바꾸어야 한다.
			// "10" 또는 "5" 또는 "3" 
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
			//     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
			try {
				Integer.parseInt(currentShowPageNo);
			} catch(NumberFormatException e) {
				currentShowPageNo = "1";
			}
			
			paraMap.put("sizePerPage", sizePerPage);
			
			// 페이징 처리를 위한 전체 마일리지 내역 조회
			int totalPage = mdao.getMileageTotalPage(paraMap); // 마일리지의 전체조회를 알아온다. 
			
			
			//	System.out.println("확인용 totalMileageCount => "+ totalMileageCount);
		//	System.out.println("~~~ 확인용 totalPage => " + totalPage);
			
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 
			//     토탈페이지수 보다 큰 값을 입력하여 장난친 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
			if( Integer.parseInt(currentShowPageNo) > totalPage ) {
				currentShowPageNo = "1";
			}
			
			paraMap.put("currentShowPageNo", currentShowPageNo);
			
			List<Map<String, String>> mileageList = mdao.selectPagingmileage(paraMap);
		//	System.out.println("~~~ 확인용 memberList.size() => " + memberList.size());
			
			
			request.setAttribute("mileageList", mileageList);
			request.setAttribute("sizePerPage", sizePerPage);
			
			
			
			String pageBar = "";
			
			int blockSize = 10;
			// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다. 
			
			int loop = 1;
			// loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(blockSize 지금은 10개) 까지만 증가하는 용도이다. 
			
			// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //
			int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다. 
			
			int index = 0;
			// **** [맨처음][이전] 만들기 **** //
			if( pageNo != 1 ) {
				pageBar += "<li class='page-item'><a class='page-link' href='mileage.book?currentShowPageNo=1&sizePerPage="+sizePerPage+"&index="+index+"'>[맨처음]</a></li>"; 
				pageBar += "<li class='page-item'><a class='page-link' href='mileage.book?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&index="+index+"'>[이전]</a></li>";  
			}
						
			while( !(loop > blockSize || pageNo > totalPage) ) {
			
				if( pageNo == Integer.parseInt(currentShowPageNo) ) {
					pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='mileage.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a></li>";   
				}
				
				loop++;
				pageNo++;
			}// end of while---------------------------------
			
			// **** [다음][마지막] 만들기 **** //
			// pageNo ==> 11
			if( pageNo <= totalPage ) {
				pageBar += "<li class='page-item'><a class='page-link' href='mileage.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&index="+index+"'>[다음]</a></li>";  
				pageBar += "<li class='page-item'><a class='page-link' href='mileage.book?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&index="+index+"'>[마지막]</a></li>"; 
			}
			
			request.setAttribute("pageBar", pageBar); 
			// **** ============ 페이지바 만들기 끝 ============ **** //
			
			// **** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 ****
			
			String currentURL = MyUtil.getCurrentURL(request);
			// 회원조회를 했을 시 현재 그 페이지로 그대로 되돌아가기 위한 용도로 쓰인다.
			
	//		System.out.println("확인용 currentURL =>"+currentURL);
			/*
			 	확인용 currentURL =>/member/memberList.up?searchType=name&searchWord=%EC%9C%A0&sizePerPage=10
				확인용 currentURL =>/member/memberList.up?currentShowPageNo=5&sizePerPage=10&searchType=name&searchWord=%EC%9C%A0
			 */
			
			// &이 구분자이기 때문에 &을 " "으로 바꾼다.
			currentURL = currentURL.replaceAll("&", " ");
			// 확인용 currentURL =>/member/memberList.up?currentShowPageNo=5 sizePerPage=10 searchType=name searchWord=%EC%9C%A0
			
			request.setAttribute("goBackURL", currentURL);
			
			request.setAttribute("index", index);
			/////////////////////////////////////////////////////////////////////////////////////////// 전체조회 끝
			
			/////////////////////////////////////////////////////////////////////////////////////////// 전체조회 시작
			index = 1;
			String currentShowPageNo2 = request.getParameter("currentShowPageNo");
			// currentShowPageNo 은 사용자가 보고자 하는 페이지바의 페이지번호 이다.
			// 메뉴에서 회원목록 만을 클릭했을 경우에는 currentShowPageNo 은 null 이 된다.
			// currentShowPageNo 이 null 이라면 currentShowPageNo 을 1 페이지로 바꾸어야 한다.
			
			String sizePerPage2 = "10";
			// 한 페이지당 화면상에 보여줄 회원의 개수
			// 메뉴에서 회원목록 만을 클릭했을 경우에는 sizePerPage 는 null 이 된다.
			// sizePerPage 가 null 이라면 sizePerPage 를 10 으로 바꾸어야 한다.
			// "10" 또는 "5" 또는 "3" 
			
			if(currentShowPageNo2 == null) {
				currentShowPageNo2 = "1";
			}
			
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
			//     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
			try {
				Integer.parseInt(currentShowPageNo2);
			} catch(NumberFormatException e) {
				currentShowPageNo2 = "1";
			}
			
			paraMap.put("sizePerPage2", sizePerPage2);
			
			// 페이징 처리를 위한 전체 마일리지 내역 조회
			int totalPage2 = mdao.getMileageTotalPage2(paraMap); // 마일리지의 전체조회를 알아온다. 
			
			
			//	System.out.println("확인용 totalMileageCount => "+ totalMileageCount);
			//	System.out.println("~~~ 확인용 totalPage => " + totalPage);
			
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 
			//     토탈페이지수 보다 큰 값을 입력하여 장난친 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
			if( Integer.parseInt(currentShowPageNo2) > totalPage2 ) {
				currentShowPageNo2 = "1";
			}
			
			paraMap.put("currentShowPageNo2", currentShowPageNo2);
			
			List<Map<String, String>> mileageList2 = mdao.selectPagingmileage2(paraMap);
			//	System.out.println("~~~ 확인용 memberList.size() => " + memberList.size());
			
			
			request.setAttribute("mileageList2", mileageList2);
			request.setAttribute("sizePerPage", sizePerPage2);
			
			
			
			String pageBar2 = "";
			
			int blockSize2 = 10;
			// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다. 
			
			int loop2 = 1;
			// loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(blockSize 지금은 10개) 까지만 증가하는 용도이다. 
			
			// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //
			int pageNo2 = ( ( Integer.parseInt(currentShowPageNo2) - 1)/blockSize2 ) * blockSize2 + 1;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다. 
			
			
			// **** [맨처음][이전] 만들기 **** //
			if( pageNo2 != 1 ) {
				pageBar2 += "<li class='page-item'><a class='page-link' href='mileage.book?currentShowPageNo=1&sizePerPage="+sizePerPage2+"&index="+index+"'>[맨처음]</a></li>"; 
				pageBar2 += "<li class='page-item'><a class='page-link' href='mileage.book?currentShowPageNo="+(pageNo2-1)+"&sizePerPage="+sizePerPage2+"&index="+index+"'>[이전]</a></li>";  
			}
			
			while( !(loop2 > blockSize2 || pageNo2 > totalPage2) ) {
				
				if( pageNo2 == Integer.parseInt(currentShowPageNo2) ) {
					pageBar2 += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo2+"</a></li>"; 
				}
				else {
					pageBar2 += "<li class='page-item'><a class='page-link' href='mileage.book?currentShowPageNo="+pageNo2+"&sizePerPage="+sizePerPage2+"&index="+index+"'>"+pageNo2+"</a></li>";   
				}
				
				loop2++;
				pageNo2++;
			}// end of while---------------------------------
			
			// **** [다음][마지막] 만들기 **** //
			// pageNo ==> 11
			if( pageNo2 <= totalPage2 ) {
				pageBar2 += "<li class='page-item'><a class='page-link' href='mileage.book?currentShowPageNo="+pageNo2+"&sizePerPage="+sizePerPage2+"&index="+index+"'>[다음]</a></li>";  
				pageBar2 += "<li class='page-item'><a class='page-link' href='mileage.book?currentShowPageNo="+totalPage2+"&sizePerPage="+sizePerPage2+"&index="+index+"'>[마지막]</a></li>"; 
			}
			
			request.setAttribute("pageBar2", pageBar2); 
			// **** ============ 페이지바 만들기 끝 ============ **** //
			
			// **** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 ****
			
			String currentURL2 = MyUtil.getCurrentURL(request);
			// 회원조회를 했을 시 현재 그 페이지로 그대로 되돌아가기 위한 용도로 쓰인다.
			
			//		System.out.println("확인용 currentURL =>"+currentURL);
			/*
			 	확인용 currentURL =>/member/memberList.up?searchType=name&searchWord=%EC%9C%A0&sizePerPage=10
				확인용 currentURL =>/member/memberList.up?currentShowPageNo=5&sizePerPage=10&searchType=name&searchWord=%EC%9C%A0
			 */
			
			// &이 구분자이기 때문에 &을 " "으로 바꾼다.
			currentURL2 = currentURL2.replaceAll("&", " ");
			// 확인용 currentURL =>/member/memberList.up?currentShowPageNo=5 sizePerPage=10 searchType=name searchWord=%EC%9C%A0
			
			request.setAttribute("goBackURL2", currentURL2);
			request.setAttribute("index", index);
			/////////////////////////////////////////////////////////////////////////////////////////// 전체조회 끝
			
			/////////////////////////////////////////////////////////////////////////////////////////// 전체조회 시작
			index = 2;
			String currentShowPageNo3 = request.getParameter("currentShowPageNo3");
			// currentShowPageNo 은 사용자가 보고자 하는 페이지바의 페이지번호 이다.
			// 메뉴에서 회원목록 만을 클릭했을 경우에는 currentShowPageNo 은 null 이 된다.
			// currentShowPageNo 이 null 이라면 currentShowPageNo 을 1 페이지로 바꾸어야 한다.
			
			String sizePerPage3 = "10";
			// 한 페이지당 화면상에 보여줄 회원의 개수
			// 메뉴에서 회원목록 만을 클릭했을 경우에는 sizePerPage 는 null 이 된다.
			// sizePerPage 가 null 이라면 sizePerPage 를 10 으로 바꾸어야 한다.
			// "10" 또는 "5" 또는 "3" 
			
			if(currentShowPageNo3 == null) {
				currentShowPageNo3 = "1";
			}
			
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
			//     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
			try {
				Integer.parseInt(currentShowPageNo3);
			} catch(NumberFormatException e) {
				currentShowPageNo3 = "1";
			}
			
			paraMap.put("sizePerPage3", sizePerPage3);
			
			// 페이징 처리를 위한 전체 마일리지 내역 조회
			int totalPage3 = mdao.getMileageTotalPage3(paraMap); // 마일리지의 전체조회를 알아온다. 
			
			
			//	System.out.println("확인용 totalMileageCount => "+ totalMileageCount);
			//	System.out.println("~~~ 확인용 totalPage => " + totalPage);
			
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 
			//     토탈페이지수 보다 큰 값을 입력하여 장난친 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
			if( Integer.parseInt(currentShowPageNo3) > totalPage3 ) {
				currentShowPageNo3 = "1";
			}
			
			paraMap.put("currentShowPageNo3", currentShowPageNo3);
			
			List<Map<String, String>> mileageList3 = mdao.selectPagingmileage3(paraMap);
			//	System.out.println("~~~ 확인용 memberList.size() => " + memberList.size());
			
			
			request.setAttribute("mileageList3", mileageList3);
			request.setAttribute("sizePerPage3", sizePerPage3);
			
			
			
			String pageBar3 = "";
			
			int blockSize3 = 10;
			// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다. 
			
			int loop3 = 1;
			// loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(blockSize 지금은 10개) 까지만 증가하는 용도이다. 
			
			// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //
			int pageNo3 = ( ( Integer.parseInt(currentShowPageNo3) - 1)/blockSize3 ) * blockSize3 + 1;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다. 
			
			
			// **** [맨처음][이전] 만들기 **** //
			if( pageNo3 != 1 ) {
				pageBar3 += "<li class='page-item'><a class='page-link' href='mileage.book?currentShowPageNo=1&sizePerPage="+sizePerPage3+"&index="+index+"'>[맨처음]</a></li>"; 
				pageBar3 += "<li class='page-item'><a class='page-link' href='mileage.book?currentShowPageNo="+(pageNo3-1)+"&sizePerPage="+sizePerPage3+"&index="+index+"'>[이전]</a></li>";  
			}
			
			while( !(loop3 > blockSize3 || pageNo3 > totalPage3) ) {
				
				if( pageNo3 == Integer.parseInt(currentShowPageNo3) ) {
					pageBar3 += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo3+"</a></li>"; 
				}
				else {
					pageBar3 += "<li class='page-item'><a class='page-link' href='mileage.book?currentShowPageNo="+pageNo3+"&sizePerPage="+sizePerPage3+"&index="+index+"'>"+pageNo3+"</a></li>";   
				}
				
				loop3++;
				pageNo3++;
			}// end of while---------------------------------
			
			// **** [다음][마지막] 만들기 **** //
			// pageNo ==> 11
			if( pageNo3 <= totalPage3 ) {
				pageBar3 += "<li class='page-item'><a class='page-link' href='mileage.book?currentShowPageNo="+pageNo3+"&sizePerPage="+sizePerPage3+"&index="+index+"'>[다음]</a></li>";  
				pageBar3 += "<li class='page-item'><a class='page-link' href='mileage.book?currentShowPageNo="+totalPage3+"&sizePerPage="+sizePerPage3+"&index="+index+"'>[마지막]</a></li>"; 
			}
			
			request.setAttribute("pageBar3", pageBar3); 
			// **** ============ 페이지바 만들기 끝 ============ **** //
			
			// **** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 ****
			
			String currentURL3 = MyUtil.getCurrentURL(request);
			// 회원조회를 했을 시 현재 그 페이지로 그대로 되돌아가기 위한 용도로 쓰인다.
			
			//		System.out.println("확인용 currentURL =>"+currentURL);
			/*
			 	확인용 currentURL =>/member/memberList.up?searchType=name&searchWord=%EC%9C%A0&sizePerPage=10
				확인용 currentURL =>/member/memberList.up?currentShowPageNo=5&sizePerPage=10&searchType=name&searchWord=%EC%9C%A0
			 */
			
			// &이 구분자이기 때문에 &을 " "으로 바꾼다.
			currentURL = currentURL.replaceAll("&", " ");
			// 확인용 currentURL =>/member/memberList.up?currentShowPageNo=5 sizePerPage=10 searchType=name searchWord=%EC%9C%A0
			
			request.setAttribute("goBackURL3", currentURL3);
			request.setAttribute("index", index);
			/////////////////////////////////////////////////////////////////////////////////////////// 전체조회 끝
			
			request.setAttribute("index", index);
			request.setAttribute("mileage", mileage);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/mileage.jsp");
    	  
      }
		
			
	
}

}

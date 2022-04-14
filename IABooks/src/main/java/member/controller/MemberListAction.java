package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;
import my.Util.MyUtil;


public class MemberListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 해야 한다. == //
		HttpSession session = request.getSession();
		
		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임.
		super.goBackURL(request);
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser == null || !"admin".equals(loginuser.getUserid()) ) {
			// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우
			String message = "관리자만 접근이 가능합니다.";
			String loc = request.getContextPath()+"/index.book";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg_pop.jsp");
		}
		
		else {
			// 관리자(admin)로 로그인 했을 경우 
			// == 페이징 처리가 되어진 모든 회원 또는 검색한 회원 목록 보여주기 == //
			
			// 검색이 있을 경우 시작 //
			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("search");
			// 검색이 있을 경우 끝 //
			
			InterMemberDAO mdao = new MemberDAO();
			
			Map<String, String> paraMap = new HashMap<>();
			
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			// currentShowPageNo 은 사용자가 보고자 하는 페이지바의 페이지번호 이다.
			// 메뉴에서 회원목록 만을 클릭했을 경우에는 currentShowPageNo 은 null 이 된다.
			// currentShowPageNo 이 null 이라면 currentShowPageNo 을 1 페이지로 바꾸어야 한다.
			
			String sizePerPage = request.getParameter("sizePerPage");
			// 한 페이지당 화면상에 보여줄 회원의 개수
			// 메뉴에서 회원목록 만을 클릭했을 경우에는 sizePerPage 는 null 이 된다.
			// sizePerPage 가 null 이라면 sizePerPage 를 10 으로 바꾸어야 한다.
			// "10" 또는 "5" 또는 "3" 
			
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			if(sizePerPage == null || 
			   !("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage)) ) {
				sizePerPage = "10";
			}
			
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
			//     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
			try {
				Integer.parseInt(currentShowPageNo);
			} catch(NumberFormatException e) {
				currentShowPageNo = "1";
			}
			
			paraMap.put("sizePerPage", sizePerPage);
			
			// === 검색이 있을 경우 시작 === //
			if(searchType != null && !"".equals(searchType) && !"name".equals(searchType) && !"userid".equals(searchType) && !"email".equals(searchType)) {
			    // 사용자가 웹브라우저 주소입력란에서 searchType 란에 장난친 경우 
				String message = "부적절한 검색 입니다. 장난치지 마세요~~";
				String loc = request.getContextPath()+"/member/memberList.book";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return; // execute() 메소드를 종료시킨다.
			}
			
			paraMap.put("searchType", searchType); 
			paraMap.put("searchWord", searchWord); 
			// === 검색이 있을 경우 끝 === //
			
			// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총페이지 알아오기 
			int totalPage = mdao.getMemberTotalPage(paraMap);
		//	System.out.println("~~~ 확인용 totalPage => " + totalPage);
			
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 
			//     토탈페이지수 보다 큰 값을 입력하여 장난친 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
			if( Integer.parseInt(currentShowPageNo) > totalPage ) {
				currentShowPageNo = "1";
			}
			
			paraMap.put("currentShowPageNo", currentShowPageNo);
			
			List<MemberVO> memberList = mdao.selectPagingMember(paraMap);
		//	System.out.println("~~~ 확인용 memberList.size() => " + memberList.size());
			
			request.setAttribute("memberList", memberList);
			request.setAttribute("sizePerPage", sizePerPage);
			
			
			// **** ============ 페이지바 만들기 시작 ============ **** //
			/*
			    1개 블럭당 10개씩 잘라서 페이지 만든다.
			    
			    1개 페이지당 3개행 또는 5개행 또는 10개행을 보여주는데
			        만약에 1개 페이지당 5개행을 보여준다라면 
			        총 몇개 블럭이 나와야 할까? 
			        총 회원수가 207명 이고, 1개 페이지당 보여줄 회원수가 5 이라면
			    207/5 = 41.4 ==> 42(totalPage)        
			        
			    1블럭               1 2 3 4 5 6 7 8 9 10 [다음]
			    2블럭   [이전] 11 12 13 14 15 16 17 18 19 20 [다음]
			    3블럭   [이전] 21 22 23 24 25 26 27 28 29 30 [다음]
			    4블럭   [이전] 31 32 33 34 35 36 37 38 39 40 [다음]
			    5블럭   [이전] 41 42 
		    */
			
			// ==== !!! pageNo 구하는 공식 !!! ==== // 
			/*
			    1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은  1 이다.
			    11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.	
			    21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
			    
			     currentShowPageNo        pageNo  ==> ( (currentShowPageNo - 1)/blockSize ) * blockSize + 1 
			    ---------------------------------------------------------------------------------------------
			           1                   1 = ( (1 - 1)/10 ) * 10 + 1 
			           2                   1 = ( (2 - 1)/10 ) * 10 + 1 
			           3                   1 = ( (3 - 1)/10 ) * 10 + 1 
			           4                   1 = ( (4 - 1)/10 ) * 10 + 1  
			           5                   1 = ( (5 - 1)/10 ) * 10 + 1 
			           6                   1 = ( (6 - 1)/10 ) * 10 + 1 
			           7                   1 = ( (7 - 1)/10 ) * 10 + 1 
			           8                   1 = ( (8 - 1)/10 ) * 10 + 1 
			           9                   1 = ( (9 - 1)/10 ) * 10 + 1 
			          10                   1 = ( (10 - 1)/10 ) * 10 + 1 
			           
			          11                  11 = ( (11 - 1)/10 ) * 10 + 1 
			          12                  11 = ( (12 - 1)/10 ) * 10 + 1
			          13                  11 = ( (13 - 1)/10 ) * 10 + 1
			          14                  11 = ( (14 - 1)/10 ) * 10 + 1
			          15                  11 = ( (15 - 1)/10 ) * 10 + 1
			          16                  11 = ( (16 - 1)/10 ) * 10 + 1
			          17                  11 = ( (17 - 1)/10 ) * 10 + 1
			          18                  11 = ( (18 - 1)/10 ) * 10 + 1 
			          19                  11 = ( (19 - 1)/10 ) * 10 + 1
			          20                  11 = ( (20 - 1)/10 ) * 10 + 1
			           
			          21                  21 = ( (21 - 1)/10 ) * 10 + 1 
			          22                  21 = ( (22 - 1)/10 ) * 10 + 1
			          23                  21 = ( (23 - 1)/10 ) * 10 + 1
			          24                  21 = ( (24 - 1)/10 ) * 10 + 1
			          25                  21 = ( (25 - 1)/10 ) * 10 + 1
			          26                  21 = ( (26 - 1)/10 ) * 10 + 1
			          27                  21 = ( (27 - 1)/10 ) * 10 + 1
			          28                  21 = ( (28 - 1)/10 ) * 10 + 1 
			          29                  21 = ( (29 - 1)/10 ) * 10 + 1
			          30                  21 = ( (30 - 1)/10 ) * 10 + 1			           

			 */
			
			String pageBar = "";
			
			int blockSize = 10;
			// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다. 
			
			int loop = 1;
			// loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(blockSize 지금은 10개) 까지만 증가하는 용도이다. 
			
			// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //
			int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다. 
			
			if(searchType == null) {
				searchType = "";
			}
			
			if(searchWord == null) {
				searchWord = "";
			}
			
			// **** [맨처음][이전] 만들기 **** //
			if( pageNo != 1 ) {
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.book?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a></li>"; 
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.book?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a></li>";  
			}
						
			while( !(loop > blockSize || pageNo > totalPage) ) {
			
				if( pageNo == Integer.parseInt(currentShowPageNo) ) {
					pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='memberList.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a></li>";   
				}
				
				loop++;
				pageNo++;
			}// end of while---------------------------------
			
			// **** [다음][마지막] 만들기 **** //
			// pageNo ==> 11
			if( pageNo <= totalPage ) {
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a></li>";  
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.book?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[마지막]</a></li>"; 
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
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberList.jsp");
		}
		
	}

}

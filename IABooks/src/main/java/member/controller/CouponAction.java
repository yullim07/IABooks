package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;
import my.Util.MyUtil;

public class CouponAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
        // 메모리에 생성되어져 있는 session 을 불러오는 것이다.
		
		
		
		if(session.getAttribute("loginuser") == null) {
			
			session.setAttribute("myPageLogin", "myPageLogin");
			
			setRedirect(false);
			setViewPage("/login/join.book");
			
		} else { // 로그인을 한 상태에서 들어왔을 때
			
			String userid = (String)session.getAttribute("userid");
			
			String sizePerPage = "5";
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("sizePerPage", sizePerPage);
			
			
			InterMemberDAO mdao = new MemberDAO();
			//////////////////////////////////////////////////////////////리스트가져오기
			int n = mdao.deleteCouponList(paraMap);
			if(n == 1) {
				request.setAttribute("deleteCouponList", n);
			}
			
			int couponNum = mdao.CouponNum(paraMap);
			
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

			
			
			
			// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총페이지 알아오기 
			int totalPage = mdao.getTotalPage(paraMap);
		//	System.out.println("~~~ 확인용 totalPage => " + totalPage);
			
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 
			//     토탈페이지수 보다 큰 값을 입력하여 장난친 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
			if( Integer.parseInt(currentShowPageNo) > totalPage ) {
				currentShowPageNo = "1";
			}
			
			paraMap.put("currentShowPageNo", currentShowPageNo);
			List<CouponVO> couponListP = mdao.selectPagingCouponList(paraMap);
			
			
			request.setAttribute("sizePerPage", sizePerPage);
			
			String pageBar = "";
			
			int blockSize = 5; // 수정
			// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다. 
			
			int loop = 1;
			// loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(blockSize 지금은 5개) 까지만 증가하는 용도이다. 
			// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //
			int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다. 
			
			
			// **** [맨처음][이전] 만들기 **** //
			if( pageNo != 1 ) {
				
				pageBar += "<li class='page-item'><a class='page-link' href='coupon.book?currentShowPageNo=1&sizePerPage="+sizePerPage+"'><i class='fal fa-angle-double-left'></i></a></li>"; 
				pageBar += "<li class='page-item'><a class='page-link' href='coupon.book?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'><i class='fal fa-angle-left'></i></a></li>";  
			}
						
			while( !(loop > blockSize || pageNo > totalPage) ) { 
			
				if( pageNo == Integer.parseInt(currentShowPageNo) ) {
					pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='coupon.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a></li>";   
				}
				
				loop++;
				pageNo++;
				
			}// end of while---------------------------------
			
			// **** [다음][마지막] 만들기 **** //
			// pageNo ==> 11
			if( pageNo <= totalPage ) {
				pageBar += "<li class='page-item'><a class='page-link' href='coupon.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'><i class='fal fa-angle-right'></i></a></li>";  
				pageBar += "<li class='page-item'><a class='page-link' href='coupon.book?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"'><i class='fal fa-angle-double-right'></i></a></li>"; 
			}
			
			 
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
			
			request.setAttribute("couponListP", couponListP);
			request.setAttribute("pageBar", pageBar);
			request.setAttribute("couponNum", couponNum);
			request.setAttribute("goBackURL", currentURL);

			setRedirect(false);
			setViewPage("/WEB-INF/member/coupon.jsp");
			
		}
			
			
			
		
	}

}

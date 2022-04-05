package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class MyBoardAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
        // 메모리에 생성되어져 있는 session 을 불러오는 것이다.
		
		if(session.getAttribute("loginuser") == null) {
			
			System.out.println("로그인 한다음에 들어오세요!!");
			
			setRedirect(false);
			setViewPage("/login/join.book");
			
		} else {
			
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			// 페이징 처리가 되어진 모든 리뷰 게시글 목록 보여주기
			
			// 페이징 처리가 되어진 모든 리뷰 게시글 목록 보여주기
			
			// 검색조건이 있을 경우 시작
			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("searchWord");
			// 검색조건이 있을 경우 끝
			
			InterBoardDAO bdao = new BoardDAO();
			// 기능을 수행할 DAO 객체화
			Map<String, String> paraMap = new HashMap<>();
			
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			String sizePerPage = request.getParameter("sizePerPage");
			
			if(currentShowPageNo == null ) {
				currentShowPageNo = "1";
			}
			
			if(sizePerPage == null || !"10".equals(sizePerPage) ) {
				sizePerPage = "10";
			}
			
			try {
				Integer.parseInt(currentShowPageNo);
			} catch(NumberFormatException e) {
				currentShowPageNo = "1";
			}
			
			paraMap.put("sizePerPage", sizePerPage);
			
			// 검색조건이 있을 경우 시작
			if(searchType != null && !"".equals(searchType) && !"re_title".equals(searchType) && !"re_writer".equals(searchType) && !"product".equals(searchType) ) {
				// 사용자가 웹브라우저 주소입력란에서 searchType 장난을 친 경우
				String message = "부적절한 검색타입입니다. 장난 그만해라.";
				String loc = request.getContextPath()+"/member/myBoard.book";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				
				return; // execute() 메소드 종료.
			}
			
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			
			// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 내게시글에 대한 페이지 알아오기
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			setRedirect(false);
			setViewPage("/WEB-INF/member/myBoard.jsp");
			
		}
		
		
		
		
		
		
	}

}

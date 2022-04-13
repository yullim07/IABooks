package board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import board.model.*;
import member.model.MemberVO;

public class ReviewBoardAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 해야 한다. == //
		HttpSession session  = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		// 페이징 처리가 되어진 모든 리뷰 게시글 목록 보여주기
		
		// 검색조건이 있을 경우 시작
		String searchType = request.getParameter("revSearchType");
		String searchWord = request.getParameter("revSearchWord");
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
			String loc = request.getContextPath()+"/board/reviewBoard.book";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			
			return; // execute() 메소드 종료.
		}
		
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 리뷰게시글에 대한 페이지 알아오기
		int totalPage = bdao.getTotalRevPage(paraMap);
		// System.out.println("~~~확인용 totalPage => " + totalPage);
		// ~~~확인용 totalPage => 21
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 토탈페이지수 보다 큰 값을 입력하여
        //     장난친 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== //
		
		if( Integer.parseInt(currentShowPageNo) > totalPage ) {
			currentShowPageNo = "1";
		}
		
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		List<ReviewBoardVO> reviewList = bdao.selectPagingRevBoard(paraMap); 
		
		request.setAttribute("reviewList", reviewList);
		request.setAttribute("sizePerPage", sizePerPage);
		
		// 게시글 수 불러오기 시작
	      TestInterBoardDAO tbdao = new TestBoardDAO();
	      ReviewBoardVO rvo = new ReviewBoardVO();
	      rvo = tbdao.getTotalReviewCnt(paraMap);
	      rvo.setCurrentShowPageNo(Integer.parseInt(currentShowPageNo));
	      rvo.setSizePerPage(Integer.parseInt(sizePerPage));
	      
	      request.setAttribute("rvo", rvo);
	      
	      // 게시글 수 불러오기 끝
		
		
		String pageBar = "";
		
		int blockSize = 10;
		
		int loop = 1;
		
		int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1 )/blockSize ) * blockSize + 1;
		
		if(searchType == null) { // 검색조건을 넣지 않았을 시 자바에서 null이기 때문에 바꿔준다.
			searchType = "";
		}
		
		if(searchWord == null) { // 검색조건을 넣지 않았을 시 자바에서 null이기 때문에 바꿔준다.
			searchWord = "";
		}
		
		// **** [맨처음][이전] 만들기 **** //
		if(pageNo != 1) {
		// if(Integer.parseInt(currentShowPageNo) >= 2) {
			pageBar += "<li class='page-item'><a class='page-link' href='reviewBoard.book?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a></li>";
			pageBar += "<li class='page-item'><a class='page-link' href='reviewBoard.book?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a></li>";
		}
		while( !(loop > blockSize || pageNo > totalPage) ) {
			// 루프가 블락사이즈(10)을 넘어가거나 || 페이지번호가 총 페이지수를 넘어가기 전까지 반복
			if( pageNo == Integer.parseInt(currentShowPageNo) ) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
				// 현재페이지 링크 제거
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='reviewBoard.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a></li>";
			}
			loop++;
			pageNo++;
		} // end of while()--------------------------
		
		// *** [다음] [마지막] 만들기 *** //
		// pageNo ==> 11
		if(pageNo <= totalPage) {
			// 마지막 페이지랑 같으면 다음 마지막이 없어져야 됨
			pageBar += "<li class='page-item'><a class='page-link' href='reviewBoard.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a></li>";
			pageBar += "<li class='page-item'><a class='page-link' href='reviewBoard.book?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[마지막]</a></li>";
		}
		
		
		request.setAttribute("pageBar", pageBar);
		
		// **** ============ 페이지바 만들기 끝 ============ //
		
		// 검색결과를 유지하려고 한다(안할시 검색결과 후 페이지 넘기면 검색조건 없는 페이지로 넘어감)
		// if 안쓰는이유 : 위에서 null이면 ""로 바꿔줘서
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchWord", searchWord);
		
		
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/reviewBoard.jsp");
		
	}

}

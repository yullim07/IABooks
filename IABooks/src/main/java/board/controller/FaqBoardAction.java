package board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;

public class FaqBoardAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 해야 한다. == //
		HttpSession session  = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		// 페이징 처리가 되어진 모든 FAQ 목록 보여주기
		
		// 검색조건이 있을 경우 시작
		String searchCate = request.getParameter("faqsearchCate");
		if( searchCate == "" || searchCate == null ) {
			searchCate = "all";
		}
		String searchType = request.getParameter("faqsearchType");
		String searchWord = request.getParameter("faqsearchWord");
		// 검색조건이 있을 경우 끝
		
		
		InterBoardDAO bdao = new BoardDAO();
		// 기능을 수행할 DAO 객체화
		Map<String, String> paraMap = new HashMap<>();
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String sizePerPage = request.getParameter("sizePerPage");
		
		if(currentShowPageNo == null ) {
			currentShowPageNo = "1";
		}
		
		if(sizePerPage == null || !( "10".equals(sizePerPage)) ) {
			sizePerPage = "10"; // 페이지별 보여줄 글의 개수 지정
		}
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
        //     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== //
		try {
			Integer.parseInt(currentShowPageNo);
		} catch(NumberFormatException e) {
			currentShowPageNo = "1";
		}
		
		paraMap.put("sizePerPage", sizePerPage);
		
		// 검색조건이 있을 경우 시작
		if(searchType != null && !"".equals(searchType) && !"faq_title".equals(searchType) && !"faq_writer".equals(searchType) ) {
			// 사용자가 웹브라우저 주소입력란에서 searchType 장난을 친 경우
			String message = "부적절한 검색타입입니다. 장난 그만해라.";
			String loc = request.getContextPath()+"/board/faqBoard.book";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			
			return; // execute() 메소드 종료.
		}
		
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("searchCate", searchCate);
		// 검색조건이 있을 경우 끝
		
		// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 리뷰게시글에 대한 페이지 알아오기
		int totalPage = bdao.getTotalfaqPage(paraMap);
		// System.out.println("~~~ 확인용 totalPage => " + totalPage);
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 토탈페이지수 보다 큰 값을 입력하여
        //     장난친 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== //
		
		if( Integer.parseInt(currentShowPageNo) > totalPage ) {
			currentShowPageNo = "1";
			
		}
		
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		// FAQ 카테고리 불러오기
		List<HashMap<String, String>> faqCateList = bdao.getFaqCateList();
		
		request.setAttribute("faqCateList", faqCateList);
		
		// FAQ 글 목록 불러오기
		List<FaqBoardVO> faqBoardList = bdao.selectPagingFaqBoard(paraMap); 
		
		request.setAttribute("faqBoardList", faqBoardList);
		
		String pageBar = "";
		
		int blockSize = 10;
		
		int loop = 1;
		
		
		// !!! 다음은 pageNo를 구하는 공식이다. !!! //
		int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1 )/blockSize ) * blockSize + 1;
		// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
		
		if(searchType == null) { // 검색조건을 넣지 않았을 시 자바에서 null이기 때문에 바꿔준다.
			searchType = "";
		}
		
		if(searchWord == null) { // 검색조건을 넣지 않았을 시 자바에서 null이기 때문에 바꿔준다.
			searchWord = "";
		}
		
		if(searchCate == null) { // 검색조건을 넣지 않았을 시 자바에서 null이기 때문에 바꿔준다.
			searchCate = "1";
		}
		
		// **** [맨처음][이전] 만들기 **** //
		if(pageNo != 1) {
		// if(Integer.parseInt(currentShowPageNo) >= 2) {
			pageBar += "<li class='page-item'><a class='page-link' href='faqBoard.book?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchCate="+searchCate+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a></li>";
			pageBar += "<li class='page-item'><a class='page-link' href='faqBoard.book?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchCate="+searchCate+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			// 루프가 블락사이즈(10)을 넘어가거나 || 페이지번호가 총 페이지수를 넘어가기 전까지 반복
			if( pageNo == Integer.parseInt(currentShowPageNo) ) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
				// 현재페이지 링크 제거
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='faqBoard.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchCate="+searchCate+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a></li>";
			}
			loop++;
			pageNo++;
		} // end of while()--------------------------
		
		// *** [다음] [마지막] 만들기 *** //
		// pageNo ==> 11
		if(pageNo <= totalPage) {
			// 마지막 페이지랑 같으면 다음 마지막이 없어져야 됨
			pageBar += "<li class='page-item'><a class='page-link' href='faqBoard.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchCate="+searchCate+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a></li>";
			pageBar += "<li class='page-item'><a class='page-link' href='faqBoard.book?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchCate="+searchCate+"&searchType="+searchType+"&searchWord="+searchWord+"'>[마지막]</a></li>";
		}
		
		request.setAttribute("pageBar", pageBar);
		
		// **** ============ 페이지바 만들기 끝 ============ //
	
		// 검색결과를 유지하려고 한다(안할시 검색결과 후 페이지 넘기면 검색조건 없는 페이지로 넘어감)
		// if 안쓰는이유 : 위에서 null이면 ""로 바꿔줘서
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchWord", searchWord);
		request.setAttribute("searchCate", searchCate);
		
		// 페이지 이동을 시킨다.
		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/board/faqBoard.jsp");
		
		
			
		
	}

}

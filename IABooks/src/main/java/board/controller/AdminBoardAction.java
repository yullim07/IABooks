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

public class AdminBoardAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
        // 메모리에 생성되어져 있는 session 을 불러오는 것이다.
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser == null || !"admin".equals(loginuser.getUserid()) ) {
			// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우
			String message = "관리자만 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		} else {
			// 관리자로 접근한 경우
			
			
			// 검색조건이 있을 경우 시작
			String searchCate = request.getParameter("mysearchCate");
			if( searchCate == "" || searchCate == null ) {
				searchCate = "all";
			}
			
			String searchType = request.getParameter("mySearchType");
			String searchWord = request.getParameter("mySearchWord");
			// 검색조건이 있을 경우 끝
			
			InterBoardDAO bdao = new BoardDAO();
			TestInterBoardDAO tbdao = new TestBoardDAO();
			// 기능을 수행할 DAO 객체화
			Map<String, String> paraMap = new HashMap<>();
			
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			String sizePerPage = request.getParameter("sizePerPage");
			String userid = loginuser.getUserid();
			
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
			paraMap.put("userid", userid);
			
			// 검색조건이 있을 경우 시작
			if(searchType != null && !"".equals(searchType) && !("my_title".equals(searchType) || "my_contents".equals(searchType)) ) {
				// 사용자가 웹브라우저 주소입력란에서 searchType 장난을 친 경우
				String message = "부적절한 검색타입입니다. 장난 그만해라.";
				String loc = request.getContextPath()+"/board/admin/adminBoard.book";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				
				return; // execute() 메소드 종료.
			}
			
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			paraMap.put("searchCate", searchCate);
			
			// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 관리자 게시글관리에 대한 페이지 알아오기
			// int totalPage = bdao.getTotalPageAdminBoard(paraMap);
			int totalPage = tbdao.getTotalAdminPage(paraMap);
			// System.out.println("~~~확인용 totalPage => " + totalPage);
			
			if( Integer.parseInt(currentShowPageNo) > totalPage ) {
				currentShowPageNo = "1";
			}
			
			paraMap.put("currentShowPageNo", currentShowPageNo);
			
			MyBoardVO myBoardVO = new MyBoardVO();
			
			// 관리자페이지 게시글관리에에 보여줄 모든 게시글 불러오기
			// List<MyBoardVO> myBoardList = bdao.selectPagingAdminBoard(paraMap); 
			List<MyBoardVO> myBoardList = tbdao.selectPagingAdminBoard(paraMap);
			
			request.setAttribute("myBoardList", myBoardList);
			
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
			
			// **** [맨처음][이전] 만들기 **** //
	         pageBar += "<li class='page-item pageicon'><a class='page-link' aria-label='Previous' href='adminBoard.book?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchCate="+searchCate+"&searchType="+searchType+"&searchWord="+searchWord+"'>"
	               + "<span aria-hidden='true'><i class='bi bi-chevron-double-left'></i></span></a></li>";
	         
	         if(pageNo != 1) {
	         // if(Integer.parseInt(currentShowPageNo) >= 2) {
	            
	            pageBar += "<li class='page-item pageicon'><a class='page-link' aria-label='Previous'  href='adminBoard.book?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchCate="+searchCate+"&searchType="+searchType+"&searchWord="+searchWord+"'>"
	                  + "<span aria-hidden='true'><i class='bi bi-chevron-left'></i></span></a></li>";
	         }
	         
	         while( !(loop > blockSize || pageNo > totalPage) ) {
	            // 루프가 블락사이즈(10)을 넘어가거나 || 페이지번호가 총 페이지수를 넘어가기 전까지 반복
	            if( pageNo == Integer.parseInt(currentShowPageNo) ) {
	               pageBar +="<li class='page-item pagenum '><a class='page-link active page-num'  href='#'>"+pageNo+"</a></li>";
	               // 현재페이지 링크 제거
	            }
	            else {
	               pageBar += "<li class='page-item pagenum'><a class='page-link page-num' href='adminBoard.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchCate="+searchCate+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a></li>";
	            }
	            loop++;
	            pageNo++;
	         } // end of while()--------------------------
	         
	         // *** [다음] [마지막] 만들기 *** //
	         // pageNo ==> 11
	         if(pageNo <= totalPage) {
	            // 마지막 페이지랑 같으면 다음 마지막이 없어져야 됨
	            pageBar += "<li class='page-item pageicon'><a class='page-link' aria-label='Next' href='adminBoard.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchCate="+searchCate+"&searchType="+searchType+"&searchWord="+searchWord+"'>"
	                   + "<span aria-hidden='true'><i class='bi bi-chevron-right'></i></span></a></li>";
	            
	         }
	         pageBar += "<li class='page-item pageicon'><a class='page-link' aria-label='Next' href='adminBoard.book?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchCate="+searchCate+"&searchType="+searchType+"&searchWord="+searchWord+"'>"
	               + "<span aria-hidden='true'><i class='bi bi-chevron-double-right'></i></span></a></li>";
	         
	         request.setAttribute("pageBar", pageBar);
	         
	         // **** ============ 페이지바 만들기 끝 ============ //

		
			// 검색결과를 유지하려고 한다(안할시 검색결과 후 페이지 넘기면 검색조건 없는 페이지로 넘어감)
			// if 안쓰는이유 : 위에서 null이면 ""로 바꿔줘서
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);
		
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/admin/adminBoard.jsp"); // 수정예정
		
		}
		
	}

}

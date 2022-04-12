package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAO;
import board.model.FaqBoardVO;
import board.model.InterBoardDAO;
import board.model.ReviewBoardVO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class ReviewDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {


		
		// == 관리자(admin)나 작성한 아이디로 로그인 했을 때만 수정 가능하도록 해야 한다. == //
		HttpSession session  = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		InterBoardDAO bdao = new BoardDAO();
		ReviewBoardVO revVO = new ReviewBoardVO();
		
		String message = "";
		String loc = "";
		
		// 이전글, 다음글을 불러오기 위한 글상세보기의 게시판번호 불러오기
		int pk_rnum = Integer.parseInt(request.getParameter("pk_rnum"));
		// System.out.println(" 삭제하기 위해 ReviewDeleteAction 에서 받아온 번호 : " + pk_rnum);
		
		revVO.setPk_rnum(pk_rnum);
		revVO = bdao.readReviewContent(pk_rnum);
		
		if( loginuser != null && ( "admin".equals(loginuser.getUserid()) || revVO.getFk_userid().equals(loginuser.getUserid()) )  ) {
			
			
			request.setAttribute("revVO", revVO);
			
			int n = bdao.deleteReviewBoard(revVO);
			
			if(n==1) {
				message = "삭제가 성공하였습니다!";
				loc = request.getContextPath()+"/board/reviewBoard.book";// 리뷰게시판 목록페이지로 이등
			}
		}
		else {
			// 수정권한이 없음(본인이나 관리자가 아님)
			message = "삭제권한이 없습니다.";
			loc = "javascript:history.back()";
			
			
		}
		
		
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/msg.jsp");
	
	
	
	}
	
}

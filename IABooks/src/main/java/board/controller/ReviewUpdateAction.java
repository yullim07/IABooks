package board.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;

public class ReviewUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// == 관리자(admin)나 작성한 아이디로 로그인 했을 때만 수정 가능하도록 해야 한다. == //
		HttpSession session  = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		InterBoardDAO bdao = new BoardDAO();
		ReviewBoardVO revVO = new ReviewBoardVO();
		
		int pk_rnum = Integer.parseInt(request.getParameter("pk_rnum")); // 프라이머리키를 JSP에서 가져온다.
		// System.out.println(" revUpdateAction 에서 받아온 번호 : " + pk_rnum);
		revVO.setPk_rnum(pk_rnum); // VO에 PK 값을 넣는다.
		
		
		revVO = bdao.readReviewContent(pk_rnum); // 프라이머리 키를 통해 내용을 싹 가져온다.
		
		if( loginuser != null && ( "admin".equals(loginuser.getUserid()) || revVO.getFk_userid().equals(loginuser.getUserid()) )  ) {
			
			
			request.setAttribute("revVO", revVO);
			
			
			
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/reviewUpdate.jsp");
			
		}
		else {
			// 수정권한이 없음(본인이나 관리자가 아님)
			String message = "접근권한이 없습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
		
	}

}

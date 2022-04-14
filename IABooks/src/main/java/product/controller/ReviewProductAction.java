package product.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;

public class ReviewProductAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session  = request.getSession();

		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String pk_pro_num = request.getParameter("pk_pro_num"); // 제품번호를 받아온다.
	
		System.out.println(" 제발 가져와 : " + pk_pro_num);
		
		
		ReviewBoardVO revVO = new ReviewBoardVO();
		revVO.setFk_pnum(pk_pro_num);
		
		
		
		
		
		
		request.setAttribute("revVO", revVO);
		request.setAttribute("pk_pro_num", pk_pro_num);
		request.setAttribute("loginuser", loginuser);
		
		if( loginuser == null  ) {
			// 로그인을 안했을 경우
			String message = "로그인이 필요합니다";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		
		}
		else {
			// 페이지 이동을 시킨다.
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/reviewWrite.jsp");
			
		 } // end of if-----------------
		
		
		
		
		
		

	}

}

package board.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class QnaWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
				// == 로그인을 했을 때만 상품문의글을 작성할 수 있게 한다. == //
				HttpSession session  = request.getSession();
				
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
				
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
					// super.setRedirect(false);
								super.setViewPage("/WEB-INF/board/qnaWrite_2.jsp");
					
				 } // end of if-----------------
	
			
			
		
	}

}

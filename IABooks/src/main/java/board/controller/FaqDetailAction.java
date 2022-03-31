package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import board.model.FaqBoardVO;
import common.controller.AbstractController;

public class FaqDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
			int pk_faq_board_num = Integer.parseInt(request.getParameter("pk_faq_board_num"));
			
			FaqBoardVO faqVO = new FaqBoardVO();
			
			InterBoardDAO bdao = new BoardDAO();
			
			faqVO = bdao.readContent(pk_faq_board_num);
			
			if(faqVO == null) {
				String message = "게시글이 없습니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
			request.setAttribute("faqVO", faqVO);
			
			
		
			// 페이지 이동을 시킨다.
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/faqDetail.jsp");
		
		
	}

}

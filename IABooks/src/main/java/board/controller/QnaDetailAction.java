package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.BoardDAO;
import board.model.FaqBoardVO;
import board.model.InterBoardDAO;
import board.model.QnABoardVO;
import common.controller.AbstractController;

public class QnaDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		int pk_qna_num = Integer.parseInt(request.getParameter("pk_qna_num"));
			
			System.out.println("나오나?");
		
			QnABoardVO qnaVO = new QnABoardVO();
			
			InterBoardDAO bdao = new BoardDAO();
			
			qnaVO = bdao.readqnaContent(pk_qna_num);
			
			if(qnaVO == null) {
				String message = "게시글이 없습니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
			request.setAttribute("qnaVO", qnaVO);
			
			
		
			// 페이지 이동을 시킨다.
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/qnaDetail.jsp");
		
			
			
	}

}

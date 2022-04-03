package board.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.QnABoardVO;
import common.controller.AbstractController;

public class QnaReadCountUp extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
		 * HttpSession session = request.getSession(false);
		 * 
		 * if(session==null||session.getAttribute("QnABoardVO")==null){
		 * super.setRedirect(false); super.setViewPage("/WEB-INF/msg.jsp"); } QnABoardVO
		 * qnaVO = (QnABoardVO) session.getAttribute("QnABoardVO"); int pk_qna_num =
		 * Integer.parseInt(request.getParameter("pk_qna_num"));
		 * 
		 * HashMap<String, Object> boardInfo=
		 * BoardDAO.getInstance().viewBoard(pk_qna_num); ClientDTO cDto =
		 * (ClientDTO)boardInfo.get("clientDTO");
		 * if(!(dto.getClientId().equals(cDto.getClientId())))
		 * BoardDAO.getInstance().updateBoardCount(boardNo);
		 * request.setAttribute("boardInfo", boardInfo); request.setAttribute("url",
		 * "/view/board/viewBoard.jsp"); return "/view/template/home.jsp";
		 */
	    }

}

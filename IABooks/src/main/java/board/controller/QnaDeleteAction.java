package board.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAO;
import board.model.InterBoardDAO;
import board.model.QnABoardVO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class QnaDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//세션을 불러온다. 암기! request.getSession();
		HttpSession session = request.getSession();
		// 메모리에 생성되어져 있는 session 을 불러오는 것이다.
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		InterBoardDAO bdao = new BoardDAO();
		QnABoardVO qnaVO = new QnABoardVO();
		String message = "";
		String loc = "";
		String password = request.getParameter("password");
		int pk_qna_num = Integer.parseInt(request.getParameter("pk_qna_num"));
	//	System.out.println(" 삭제하기 위해 QnaDeleteAction 에서 받아온 번호 : " + pk_qna_num);
		qnaVO.setPk_qna_num(pk_qna_num);
		qnaVO.setQna_passwd(password);
		
		qnaVO = bdao.getqnaContent(pk_qna_num);
		
		
	
		if( loginuser != null && ( "admin".equals(loginuser.getUserid()) || qnaVO.getFk_userid().equals(loginuser.getUserid()) )  ) {
			//로그인한 관리자이거나 , 로그인한 해당글의 작성자이거나 
			
			
			
			request.setAttribute("qnaVO", qnaVO);
			

			
			int n = bdao.deleteQnaBoard(qnaVO);
			
			if(n==1) {
				message = "삭제가 성공하였습니다!";
				loc = request.getContextPath()+"/board/qnaBoard.book"; //qna 목록페이지로 이동
			}
			
		}
		else {
			// 수정권한 x (본인이나 관리자가 아니다)
			message = "삭제권한이 없습니다.";
			loc = "javascript:history.back()";
			
		}
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/msg.jsp");
		
		
		
		
	}

}

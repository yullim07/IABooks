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

public class QnaDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
				HttpSession session  = request.getSession();
				
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		// 이전글, 다음글을 불러오기 위한 글상세보기의 게시판번호 불러오기
				int pk_qna_num = Integer.parseInt(request.getParameter("pk_qna_num"));
				String fk_userid = loginuser.getUserid();
				
				System.out.println("받아온 글번호 : " + pk_qna_num);
				String currentNum = request.getParameter("pk_qna_num");
				System.out.println("받아온 글번호2 : " + currentNum);
				
				Map<String, String> paraMap = new HashMap<>();
				
				QnABoardVO qnaVO = new QnABoardVO();
				QnABoardVO qnaPrevNext = new QnABoardVO(); // 이전글 다음글을 받아옴.
				
				InterBoardDAO bdao = new BoardDAO();
				
				qnaVO.setPk_qna_num(pk_qna_num);
				qnaVO.setFk_userid(fk_userid);
				qnaVO = bdao.readqnaContent(pk_qna_num,fk_userid);
				
			
			
			if(qnaVO ==  null){
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

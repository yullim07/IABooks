package board.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import board.model.FaqBoardVO;
import common.controller.AbstractController;

public class FaqDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		// 이전글, 다음글을 불러오기 위한 글상세보기의 게시판번호 불러오기
		int pk_faq_board_num = Integer.parseInt(request.getParameter("pk_faq_board_num"));
		// System.out.println("받아온 글번호 : " + pk_faq_board_num);
		String currentNum = request.getParameter("pk_faq_board_num");
		// System.out.println("받아온 글번호2 : " + currentNum);
		
		Map<String, String> paraMap = new HashMap<>();
		
		FaqBoardVO faqVO = new FaqBoardVO();
		FaqBoardVO faqPrevNext = new FaqBoardVO(); // 이전글 다음글을 받아옴.
		
		InterBoardDAO bdao = new BoardDAO();
		
		faqVO.setPk_faq_board_num(pk_faq_board_num);
		faqVO = bdao.readContent(pk_faq_board_num);
		
		
		if(faqVO == null) {
			String message = "게시글이 없습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		if( faqVO.getPk_faq_board_num() != 0 ) {
			paraMap.put("currentNum", currentNum);
			// System.out.println("여기까진 오니?");
			faqPrevNext = bdao.getPrevNextContent(paraMap);
			
			faqVO.setPrev_num(faqPrevNext.getPrev_num());
			faqVO.setPrev_title(faqPrevNext.getPrev_title());
			faqVO.setNext_num(faqPrevNext.getNext_num());
			faqVO.setNext_title(faqPrevNext.getNext_title());
		}

		request.setAttribute("faqVO", faqVO);
		
	
		// 페이지 이동을 시킨다.
		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/board/faqDetail.jsp");
		
		
	}

}

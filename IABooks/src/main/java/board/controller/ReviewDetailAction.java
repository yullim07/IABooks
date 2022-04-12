package board.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import board.model.ReviewBoardVO;
import common.controller.AbstractController;

public class ReviewDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		// 이전글, 다음글을 불러오기 위한 글상세보기의 게시판번호 불러오기
		int pk_rnum = Integer.parseInt(request.getParameter("pk_rnum"));
		// System.out.println("받아온 글번호 : " + pk_rnum);
		String currentNum = request.getParameter("pk_rnum");
		// System.out.println("받아온 글번호2 : " + currentNum);
		
		Map<String, String> paraMap = new HashMap<>();
		
		ReviewBoardVO revVO = new ReviewBoardVO();
		ReviewBoardVO revPrevNext = new ReviewBoardVO(); // 이전글 다음글을 받아옴.
		
		InterBoardDAO bdao = new BoardDAO();
		
		revVO.setPk_rnum(pk_rnum);
		revVO = bdao.readReviewContent(pk_rnum);
		
		
		if(revVO == null) {
			String message = "게시글이 없습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		if( revVO.getPk_rnum() != 0 ) {
			paraMap.put("currentNum", currentNum);
			// System.out.println("여기까진 오니?");
			revPrevNext = bdao.getPrevNextReviewContent(paraMap);
			
			revVO.setPrev_num(revPrevNext.getPrev_num());
			revVO.setPrev_title(revPrevNext.getPrev_title());
			revVO.setNext_num(revPrevNext.getNext_num());
			revVO.setNext_title(revPrevNext.getNext_title());
		}
		
		request.setAttribute("revVO", revVO);
		
	
		// 페이지 이동을 시킨다.
		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/board/reviewDetail.jsp");
		
		
	}

}

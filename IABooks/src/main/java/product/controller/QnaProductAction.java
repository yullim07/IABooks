package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.ProductVO;

public class QnaProductAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 해야 한다. == //
		HttpSession session  = request.getSession();
		
		// 추후 구매이력 유무로 리뷰작성 확인 예정
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String pk_pro_num = request.getParameter("pk_pro_num"); // 제품번호를 받아온다.
		System.out.println(" 피케이프로넘!? : " + pk_pro_num);
		
		QnABoardVO qnaVO = new QnABoardVO();
		qnaVO.setFk_pnum(pk_pro_num);
		
		request.setAttribute("qnaVO", qnaVO);
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
			super.setViewPage("/WEB-INF/board/qnaWrite_2.jsp");
			
		 } // end of if-----------------
		
		
	}

}

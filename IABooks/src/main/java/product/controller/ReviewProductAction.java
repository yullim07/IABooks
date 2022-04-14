package product.controller;



import java.util.*;

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
			
			// 구매이력 확인
			String userid = loginuser.getUserid();
			TestInterBoardDAO tbdao = new TestBoardDAO();
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("pk_pro_num", pk_pro_num);
			paraMap.put("userid", userid);
			int n = tbdao.checkBuyThisProduct(paraMap);
			System.out.println();
			
			if(n == 0 ) {
				// 제품을 구매하지 않은 경우
				String message = "제품후기는 제품을 구매한 분만 작성가능합니다.";
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
			}
		 } // end of if-----------------
		
		
		
		
		
		

	}

}

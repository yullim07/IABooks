package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class ReviewProductAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 해야 한다. == //
		HttpSession session  = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String test = request.getParameter("pk_pro_num");
		
		System.out.println(" 제발 가져와 : " + test);
		// 페이지 이동을 시킨다.
		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/board/reviewWrite.jsp");

	}

}

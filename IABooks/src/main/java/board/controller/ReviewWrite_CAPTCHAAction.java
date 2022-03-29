package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class ReviewWrite_CAPTCHAAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod(); // "GET" 또는 "POST"
		System.out.println("method : " + method);
		
		if("GET".equalsIgnoreCase(method)) {
			
			// 페이지 이동을 시킨다.
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/reviewWrite_CAPTCHA.jsp");
		}

	}

}

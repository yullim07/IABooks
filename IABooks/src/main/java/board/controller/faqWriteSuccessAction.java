package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class faqWriteSuccessAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/faqBoard.jsp");
		}
		
	}

}

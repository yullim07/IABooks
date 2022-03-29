package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import common.controller.AbstractController;

public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("get".equalsIgnoreCase(method)) {
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/login.jsp");
		}
	
	}
}

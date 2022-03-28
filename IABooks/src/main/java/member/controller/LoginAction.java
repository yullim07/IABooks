package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import common.controller.AbstractController;

public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		System.out.println(method); // 방법 확인
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		
		System.out.println(userid);
		System.out.println(pwd);
		
		
		if("get".equalsIgnoreCase(method)) {
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/login.jsp");
		}
	
	}
}

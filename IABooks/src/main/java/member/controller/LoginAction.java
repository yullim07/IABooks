package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

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

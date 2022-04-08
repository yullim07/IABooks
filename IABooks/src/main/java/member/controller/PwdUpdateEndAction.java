package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class PwdUpdateEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();  // 세션불러오기
		String userid = (String) session.getAttribute("userid"); // 세션에 저장된 userid 불러오기
		
		String method = request.getMethod();
		// "GET" 또는 "POST"
		
		System.out.println("여긴 어떻게 들어오나" + method);
		System.out.println("userid 는 ? " + userid);
		
		if("POST".equalsIgnoreCase(method)) {
			String pwd = request.getParameter("pwd");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("pwd", pwd);
			paraMap.put("userid", userid);
			
			InterMemberDAO mdao = new MemberDAO();
			int n = mdao.pwdUpdate(paraMap);
			
			request.setAttribute("n", n);
			
			System.out.println("n값은 ? " + n);
		}
		
		request.setAttribute("userid", userid);
		
		request.setAttribute("method", method);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/login/pwdUpdateEnd.jsp");
		
	}

}

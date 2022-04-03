package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class InterestedItemAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
        // 메모리에 생성되어져 있는 session 을 불러오는 것이다.
		
		if(session.getAttribute("loginuser") == null) {
			
			session.setAttribute("myPageLogin", "myPageLogin");
			
			setRedirect(false);
			setViewPage("/login/join.book");
			
		} else {
			
			setRedirect(false);
			setViewPage("/WEB-INF/member/InterestedItem.jsp");
			
		}
			

	}

}

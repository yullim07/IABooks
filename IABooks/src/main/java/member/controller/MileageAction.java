package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class MileageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
        // 메모리에 생성되어져 있는 session 을 불러오는 것이다.
		
		if(session.getAttribute("loginuser") == null) {
			
			session.setAttribute("myPageLogin", "myPageLogin");
			
			setRedirect(false);
			setViewPage("/login/join.book");
			
		} else { // 로그인 되었을 때
			

			InterMemberDAO mdao = new MemberDAO();
			
			Map<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("userid", (String)session.getAttribute("userid"));
			
			int result = mdao.mgCheck(paraMap);
			
			request.setAttribute("result", result);
			
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/mileage.jsp");
    	  
      }
	
}

}

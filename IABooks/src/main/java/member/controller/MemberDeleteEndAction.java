package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class MemberDeleteEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
			
			String userid = request.getParameter("userid");
			
			InterMemberDAO mdao = new MemberDAO();
			
			Map<String,String> paraMap = new HashMap<>();
			
			paraMap.put("userid", userid);
			
			int memberDelete = mdao.memberDelete(paraMap);
			
			String message = "";
			String loc = "";
			if(memberDelete == 1) {
				message = "회원탈퇴 성공 !!";
				loc = request.getContextPath() +"/login/logout.book";
			} else {
	        	message = "회원탈퇴 실패 !! [관리자에게 문의 바랍니다.]"; // 오라클에서 무언가 잘못된 것
	        	loc = request.getContextPath()+"/member/myPage.book";
	        }
			
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	        
	        super.setViewPage("/WEB-INF/msg.jsp");
			
		} else {
			// *** GET 방식으로 넘어온 것이라면 ***
			
			String message = "비정상적인 경로를 통해 들어왔습니다!!";
	        String loc = "javascript:history.back()";
	        
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	        
	        super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
	}

}

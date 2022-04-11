package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;

public class UserStatusAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
			
			String userid = request.getParameter("userid");
			String userStatus = request.getParameter("userStatus");
			
			InterMemberDAO mdao = new MemberDAO();
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("userStatus", userStatus);
			
			int n = 0;
			
			if("u_status".equals(userStatus)) {
	        	 // 휴면계정일때 기본값 0 휴면계정일 때 1  
				n = mdao.userUStatusUpdate(userid);
	        	 
	         } else if ("status".equals(userStatus)) {
	        	 // 회원탈퇴일때
	        	 n = mdao.userStatusUpdate(userid);
	         } else if ("normal".equals(userStatus)) {
	        	 // 일반회원일때
	        	 n = mdao.userNormalStatusUpdate(userid); 
	         }
			
			String message = "";
			String loc = "";
			
			
			if(n==1) {
				message = "회원 상태가 변경되었습니다.";
				loc = request.getContextPath()+"/member/memberOneDetail.book?userid="+userid;
			} else {
				message = "회원 상태 변경에 실패하였습니다.";
				loc = "javascript:history.back()";
			}
			
			request.setAttribute("message", message);
	        request.setAttribute("loc", loc);			
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			
			
		}
		
	}

}

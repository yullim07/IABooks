package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class IdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임.
		super.goBackURL(request);
		// 로그인을 하지 않은 상태에서 특정제품을 조회한 후 "장바구니 담기"나 "바로주문하기" 할때와 "제품후기쓰기" 를 할때 
	    // 로그인 하라는 메시지를 받은 후 로그인 하면 시작페이지로 가는 것이 아니라 방금 조회한 특정제품 페이지로 돌아가기 위한 것임.
		
		if("get".equalsIgnoreCase(method)) {
	        
			request.setAttribute("method", method);
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/idFind.jsp");
	         
	      } else {
	    	  
	    	// POST 방식으로 넘어온 것 이라면
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String phone = "010-" + request.getParameter("phone_one") +"-"+ request.getParameter("phone_two") ;
				String radio = request.getParameter("check");
				
				InterMemberDAO mdao = new MemberDAO();
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("name", name);
				paraMap.put("email", email);
				paraMap.put("phone", phone);
				
				String userid = mdao.findUserid(paraMap , Integer.parseInt(radio));
				
				if(userid != null) {
					request.setAttribute("userid", userid);
				} else {
					request.setAttribute("userid", "존재하지 않습니다.");
				}
				
				request.setAttribute("name", name);
				request.setAttribute("email", email); 
				request.setAttribute("phone", phone); 
				request.setAttribute("radio", radio); 
				
				request.setAttribute("method", method);
				
				
				//super.setRedirect(false);
				super.setViewPage("/WEB-INF/login/idFind.jsp");
	    	  
	      }
		
	}

}

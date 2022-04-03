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
		
		if("get".equalsIgnoreCase(method)) {
	        
			request.setAttribute("method", method);
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/login/idFind.jsp");
	         
	      } else {
	    	  
	    	// POST 방식으로 넘어온 것 이라면
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String phone = "010" + request.getParameter("phone_one") + request.getParameter("phone_two") ;
				String radio = request.getParameter("check");
				
				System.out.println(name);
				System.out.println(email);
				System.out.println(phone);
				System.out.println(radio);
				
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

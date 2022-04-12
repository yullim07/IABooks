package product.controller3.test;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;

public class WishDeleteSelectAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) {//로그인했으면 true
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {//포스트 방식이라며는 
				HttpSession session = request.getSession();;
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	
				TestInterProductDAO pdao = new TestProductDAO();
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("userid", loginuser.getUserid());
				
				int cnt = Integer.parseInt( request.getParameter("cnt"));
				String wishNoStr = request.getParameter("wishNoStr");
				String [] strArray = wishNoStr.split(",");

				int	n = 0;
	            for(int i=0; i<cnt; i++) {
	                String pk_wnum = (String)strArray[i];
	                paraMap.put("pk_wnum", pk_wnum);
	                n = pdao.wishDeleteSelect(paraMap);
	            }
	            
				JSONObject jsonObj = new JSONObject(); 
				jsonObj.put("wishDeleteSelect", n); 
				String json = jsonObj.toString();
				
				request.setAttribute("json", json);
				super.setViewPage("/WEB-INF/jsonview.jsp");
				
			}else {
				String message = "비정상적인 경로로 들어왔습니다";
				//String loc = "javascript:history.back()";
   
				request.setAttribute("message", message);
				//request.setAttribute("loc", loc);
   
				//super.setRedirect(false);   
				super.setViewPage("/WEB-INF/jsonMsg.jsp");
			}
			
		}else {//비로그인으로 관심상품 접근할 경우
			String message = "관심상품은 로그인하신후 이용가능합니다.";
			//String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			//request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonMsg.jsp");
			
		}
	}

}

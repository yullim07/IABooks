package product.controller2;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class GoMemberInfoPopupAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(super.checkLogin(request)) {//로그인했으면 true
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			String method = request.getMethod();
			
			if("admin".equalsIgnoreCase(loginuser.getUserid())) {
				
				if("POST".equalsIgnoreCase(method)) {//포스트 방식이라며는 
					
					InterProductDAO pdao = new ProductDAO();
					Map<String, String> paraMap = new HashMap<>();
					
					String fk_userid = request.getParameter("fk_userid");
				
					paraMap.put("fk_userid", fk_userid);
					
					Map<String, String> orderMemberInfo  = pdao.orderMemberInfo(paraMap);
					
					request.setAttribute("orderMemberInfo", orderMemberInfo);
					
					super.setViewPage("/WEB-INF/product/goMemberInfoPopup.jsp");
					
				}else{
					String message = "비정상적인 경로로 들어왔습니다";
					String loc = "javascript:history.back()";
	   
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					//super.setRedirect(false);   
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
			}else {
				String message = "관리자만 접근이 가능합니다.";
				String loc = "javascript:history.back()";
				//String loc = "<%= ctxPath%>/login/join.book";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				//super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}else {//비로그인으로 장바구니 추가할경우
			String message = "장바구니는 로그인하신후 이용가능합니다.";
			String loc = "javascript:history.back()";
			//String loc = "<%= ctxPath%>/login/join.book";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
				
		}
		
	}

}

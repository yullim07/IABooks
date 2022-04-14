package product.controller2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;


public class AdminOrderListAction  extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(super.checkLogin(request)) {//로그인했으면 true
			String method = request.getMethod();
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			String userid = loginuser.getUserid();
			System.out.println("확인");
			if("admin".equalsIgnoreCase(userid)) {
				System.out.println("확인11");
				if("POST".equalsIgnoreCase(method)) {//포스트 방식이라며는 
					System.out.println("확인22");
					InterProductDAO pdao = new ProductDAO();
					Map<String, String> paraMap = new HashMap<>();
					
					paraMap.put("userid", userid);
					List<HashMap<String, String>> orderList  = pdao.orderList(paraMap);
					List<HashMap<String, String>> deliverstatusList  = pdao.deliverstatusList();
					
					request.setAttribute("userid", userid);
					request.setAttribute("orderList", orderList);
					request.setAttribute("deliverstatusList", deliverstatusList);
					
					super.setViewPage("/WEB-INF/product/admin/adminOrderList.jsp");
					
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

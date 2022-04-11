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

public class PaymentEndAction extends AbstractController{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) {//로그인했으면 true
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {//포스트 방식이라며는 
				HttpSession session = request.getSession();;
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

				String userid = loginuser.getUserid();
	
				//쿠폰제거 //결제테이블 인설트 //포인트 추가 // 배송내용추가
				//카트에서 삭제
				String email = request.getParameter("email");
				String name = request.getParameter("name");
				String phone = request.getParameter("phone");
				String postcode = request.getParameter("postcode");
				String address = request.getParameter("address");
				String finalPrice = request.getParameter("finalPrice");
				String cartno = request.getParameter("cartno");
				String useCouponId = request.getParameter("useCouponId");
				
				InterProductDAO pdao = new ProductDAO();
				Map<String, String> paraMap = new HashMap<>();
				
				paraMap.put("useCouponId", useCouponId);
				/*
				  if(!("".equals(useCouponId) || useCouponId == null) ) { int n =
				  pdao.couponDelete(paraMap); }
				 */
				paraMap.put("userid", userid);
				paraMap.put("email", email);
				paraMap.put("name", name);
				paraMap.put("phone", phone);
				paraMap.put("postcode", postcode);
				paraMap.put("address", address);
				paraMap.put("finalPrice", finalPrice);
				paraMap.put("cartno", cartno);
				
				int n = pdao.orderInsert(paraMap);
				
				if(n == 1) {
					request.setAttribute("userid", userid);
					request.setAttribute("email", email);
					request.setAttribute("name", name);
					request.setAttribute("phone", phone);
					request.setAttribute("postcode", postcode);
					request.setAttribute("address", address);
					request.setAttribute("finalPrice", finalPrice);
					request.setAttribute("cartno", cartno);
					
				}
	
				//super.setRedirect(false);   
				super.setViewPage("/WEB-INF/product/paymentEnd.jsp");
				
			}else {
				String message = "비정상적인 경로로 들어왔습니다";
				String loc = "javascript:history.back()";
   
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
   
				//super.setRedirect(false);   
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}else {//비로그인으로 장바구니 추가할경우
			String message = "장바구니는 로그인하신후 이용가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		
	}
}

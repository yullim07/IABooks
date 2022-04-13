package product.controller2;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.CouponVO;
import member.model.MemberVO;
import product.model.CartVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class OrderSelectAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(super.checkLogin(request)) {//로그인했으면 true
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {//포스트 방식이라며는 
				HttpSession session = request.getSession();;
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
				String[] proCheck = request.getParameterValues("proCheck");
				String userid = loginuser.getUserid();
				
				InterProductDAO pdao = new ProductDAO();
				Map<String, String> paraMap = new HashMap<>();
				
				paraMap.put("userid", userid);
				List<CartVO> order = new ArrayList<>();
				List<CouponVO> userCoupon = pdao.userCoupon(paraMap);
				String userPoint = pdao.userPoint(paraMap);
				
				int totalPrice = 0;
				
				for(int i=0; i<proCheck.length; i++) {
					String pk_cartno = proCheck[i];
					paraMap.put("pk_cartno", pk_cartno);
					CartVO orderSelect = pdao.orderSelect(paraMap);
					totalPrice += pdao.totalPriceSelect2(paraMap);
					order.add(orderSelect);
				}
				
				
				int shippingFee = 3000;
				int finalPrice = totalPrice;
				if(totalPrice < 50000) {
					finalPrice = totalPrice + shippingFee;
				}
				
				request.setAttribute("userCoupon", userCoupon);
				request.setAttribute("order", order);
				request.setAttribute("fk_userid", userid);
				request.setAttribute("totalPrice", totalPrice);
				request.setAttribute("finalPrice", finalPrice);
				request.setAttribute("userPoint", userPoint);
		
				super.setViewPage("/WEB-INF/product/order.jsp");
				
			}else{
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
			//String loc = "<%= ctxPath%>/login/join.book";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
				
		}
		
	}

}

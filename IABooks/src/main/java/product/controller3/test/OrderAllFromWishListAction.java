package product.controller3.test;

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

public class OrderAllFromWishListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) {//로그인했으면 true
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {//포스트 방식이라며는 
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
				String userid = loginuser.getUserid();
				
				InterProductDAO pdao = new ProductDAO();
				TestInterProductDAO tpdao = new TestProductDAO();
				Map<String, String> paraMap = new HashMap<>();

				paraMap.put("userid", userid);
				
				// 관심상품으로부터 장바구니 담기
				tpdao.insertWishToCartAll(paraMap);
				
				List<CartVO> order = pdao.orderAll(paraMap);
				
				List<CouponVO> userCoupon = pdao.userCoupon(paraMap);
				
				int totalPrice = pdao.totalPriceSelect(paraMap);
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
			String message = "상품문의는 로그인하신후 이용가능합니다.";
			String loc = "javascript:history.back()";
			//String loc = "<%= ctxPath%>/login/join.book";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
				
		}
		
		
	}

}

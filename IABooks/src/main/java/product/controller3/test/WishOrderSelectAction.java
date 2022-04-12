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

public class WishOrderSelectAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) {//로그인했으면 true
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {//포스트 방식이라며는 
				HttpSession session = request.getSession();;
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
				String[] proCheck = request.getParameterValues("proCheck");
				String userid = loginuser.getUserid();
				
				TestInterProductDAO pdao = new TestProductDAO();
				Map<String, String> paraMap = new HashMap<>();
				
				List<WishListVO> order = new ArrayList<>();
				List<CouponVO> userCoupon = pdao.userCoupon(paraMap);
				int totalPrice = 0;
				paraMap.put("userid", userid);
				for(int i=0; i<proCheck.length; i++) {
					String pk_wnum = proCheck[i];
					paraMap.put("pk_wnum", pk_wnum);
					WishListVO orderSelect = pdao.orderSelect(paraMap);
					totalPrice += pdao.totalPriceSelectWishList(paraMap);
					order.add(orderSelect);
				}
				// 잠시중지!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
				
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
			
		}else {//비로그인으로 관심상품 접근할 경우
			String message = "관심상품은 로그인하신후 이용가능합니다.";
			String loc = "javascript:history.back()";
			//String loc = "<%= ctxPath%>/login/join.book";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
				
		}
		
	}

}

package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.CartVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class WishListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) {//로그인했으면 true
			String method = request.getMethod();
		
			if("POST".equalsIgnoreCase(method)) {//포스트 방식이라면 
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
				// 회원의 아이디를 받아와서 장바구니 보여주기
				String fk_userid = loginuser.getUserid();
			
				InterProductDAO pdao = new ProductDAO();
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("userid", fk_userid);
				
				List<CartVO> cartList = pdao.getCart(fk_userid);
				int totalPrice = pdao.totalPriceSelect(paraMap);
				int shippingFee = 3000;
				int finalPrice = totalPrice;
				if(totalPrice < 50000 && totalPrice != 0 ) {
					finalPrice = totalPrice + shippingFee;
				}
				
				request.setAttribute("cartList", cartList);
				request.setAttribute("fk_userid", fk_userid);
				request.setAttribute("totalPrice", totalPrice);
				request.setAttribute("finalPrice", finalPrice);
				
			
				super.setViewPage("/WEB-INF/product/wishList.jsp");
				
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
			//String loc = "IABooks/login/join.book";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
				
		}
		
	}

}

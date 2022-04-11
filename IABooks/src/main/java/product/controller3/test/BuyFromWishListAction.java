package product.controller3.test;

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

public class BuyFromWishListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
if(super.checkLogin(request)) {//로그인했으면 true
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {//포스트 방식이라며는 
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

				String userid = loginuser.getUserid();
	
				//재고량 체크
				String pk_wnum = request.getParameter("wishnoOne");
				System.out.println(" 받아온 pk_wnum : "+ pk_wnum );
				String now_pro_qty = "1";
				
				InterProductDAO pdao = new ProductDAO();
				TestInterProductDAO tpdao = new TestProductDAO();
				Map<String, String> paraMap = new HashMap<>();
				
				paraMap.put("pk_wnum", pk_wnum);
				paraMap.put("userid", userid);
				
				String fk_pnum = tpdao.getOneWishPnum(paraMap);
				
				paraMap.put("pk_pro_num", fk_pnum);
				paraMap.put("now_pro_qty", now_pro_qty);
				
				Map<String, Integer> qtyCheck = pdao.qtyCheck(paraMap);
				Map<String, Integer> cartQtyCheck = pdao.cartQtyCheck(paraMap);
				
				int ck_odr_qty = cartQtyCheck.get("ck_odr_qty");
				int pro_qty = qtyCheck.get("pro_qty");
				
				
				int n = 0;
				if(pro_qty >= (ck_odr_qty+Integer.parseInt(now_pro_qty))  && (Integer.parseInt(now_pro_qty) != 0)) {
					//재고량과 같거나 재고가 더많은경우
					
					//카드에 현재 제품이 있는지 없는지 체크 insert or update
					boolean proCartCheck  = pdao.proCartCheck(paraMap);
					
					if(proCartCheck) {//현재있는 경우 update
						n = pdao.updateAddCart(paraMap);

					}else {//없는 경우 insert
						n = pdao.insertAddCart(paraMap);
					}
					
					
					if(n == 1) {
						Map<String, String> cartNoCheck = pdao.cartNoCheck(paraMap);
						 String pk_cartno = cartNoCheck.get("pk_cartno");
						 paraMap.put("pk_cartno", pk_cartno);
						List<CartVO> order  = pdao.orderOne(paraMap);
						
						int totalPrice = pdao.totalPriceSelect2(paraMap);
						int shippingFee = 3000;
						int finalPrice = totalPrice;
						if(totalPrice < 50000) {
							finalPrice = totalPrice + shippingFee;
						}
						
						request.setAttribute("order", order);
						request.setAttribute("fk_userid", userid);
						request.setAttribute("totalPrice", totalPrice);
						request.setAttribute("finalPrice", finalPrice);
				
						super.setViewPage("/WEB-INF/product/order.jsp");
					}
					
					
				}else if(Integer.parseInt(now_pro_qty) == 0) {
					
					String message = "주문은 1개이상 가능합니다.";
					String loc = "javascript:history.back()";//
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					//super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
					
					return;
				}else {
					//재고량보다 더적은경우
					String message = "주문하신 상품은 현재재고량보다 많습니다.";
					String loc = "javascript:history.back()";//
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					//super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
					
					return;
					
				}//end of if(pro_qty >= Integer.parseInt(total_pro_qty) ) 
					

			
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

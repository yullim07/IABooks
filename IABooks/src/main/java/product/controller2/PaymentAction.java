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

public class PaymentAction extends AbstractController {
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		if(super.checkLogin(request)) {//로그인했으면 true
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {//포스트 방식이라며는 
				
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				String userid = loginuser.getUserid();
					
				String paymentPrice = request.getParameter("paymentPrice");
				String[] pk_cartnoArr = request.getParameterValues("pk_cartno");
				String[] fk_pro_numArr = request.getParameterValues("fk_pro_num");
				String[] pqtyArr = request.getParameterValues("pqty");
				String[] pointArr = request.getParameterValues("point");
				String[] partPriceArr = request.getParameterValues("partPrice");
				String useCouponId = request.getParameter("useCouponId");
				
				
				String pk_cartnoJoin =  String.join(",", pk_cartnoArr);
				String fk_pro_numJoin = String.join(",", fk_pro_numArr);
				String pqtyJoin = String.join(",", pqtyArr);
				String pointJoin = String.join(",", pointArr);
				String partPriceJoin = String.join(",", partPriceArr);
				
				InterProductDAO pdao = new ProductDAO();
				Map<String, String> paraMap = new HashMap<>();
					
				int totalPrice = 0;
				
				paraMap.put("userid", userid);
				paraMap.put("useCouponId", useCouponId);
				
				for(int i=0; i<pk_cartnoArr.length; i++) {
					String pk_cartno2 = pk_cartnoArr[i];// 변수 수정필요
					String pqty2 = pqtyArr[i];//
					
					paraMap.put("pk_cartno", pk_cartno2);
					paraMap.put("pqty", pqty2);
					totalPrice += pdao.totalPriceSelect2(paraMap);
				}
 
				int cprice = 0;
				if(! (useCouponId == null || "".equals(useCouponId)) ) {
					cprice = Integer.parseInt(pdao.cpriceCheck(paraMap) ); 
				}
				totalPrice = totalPrice-cprice;
				
				int shippingFee = 3000;
				int finalPrice = totalPrice;
				if(totalPrice < 50000) {
					finalPrice = totalPrice + shippingFee;
				}
				
				if(finalPrice == Integer.parseInt(paymentPrice) ) {
					
					//배송주소 포인트 빠짐 (차감포인 빠짐)
					String name = request.getParameter("name");
					String email = request.getParameter("email");
					String phone = request.getParameter("hp1") +"-"+ request.getParameter("hp2") +"-"+ request.getParameter("hp3");
					String postcode = request.getParameter("postcode");
					String address = request.getParameter("address") +" "+ request.getParameter("detailAddress") +" "+ request.getParameter("extraAddress");
					request.setAttribute("userid", userid);//아이디
					request.setAttribute("name", name);//이름
					request.setAttribute("email", email);//이메일
					request.setAttribute("phone", phone);//전화
					request.setAttribute("postcode", postcode);//우편번호
					request.setAttribute("address", address);//주소
					request.setAttribute("finalPrice", finalPrice);//주문금액
					request.setAttribute("useCouponId", useCouponId);//사용한 쿠폰아이디
					
					request.setAttribute("pk_cartnoJoin", pk_cartnoJoin); //join
					request.setAttribute("fk_pro_numJoin", fk_pro_numJoin);//join
					request.setAttribute("pqtyJoin", pqtyJoin);//join
					request.setAttribute("pointJoin", pointJoin);//join
					request.setAttribute("partPriceJoin", partPriceJoin);//join
					
					//super.setRedirect(false);
					super.setViewPage("/WEB-INF/product/paymentGateway.jsp");
					

				}else {
					String message = "잘못된 접근입니다.";
					String loc = "javascript:history.back()";
	   
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
	   
					//super.setRedirect(false);   
					super.setViewPage("/WEB-INF/msg.jsp");
				}
						
			}else {
				String message = "비정상적인 경로로 들어왔습니다";
				String loc = "javascript:history.back()";
   
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
   
				//super.setRedirect(false);   
				super.setViewPage("/WEB-INF/msg.jsp");
			}	
		}else {
			String message = "제품을 구해하기전에 먼저 로그인을 하세요";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
	}
}

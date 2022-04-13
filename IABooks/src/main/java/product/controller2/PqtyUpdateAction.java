package product.controller2;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class PqtyUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) {//로그인했으면 true
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {//포스트 방식이라며는 
			
				HttpSession session = request.getSession();;
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

				String pk_cartno = request.getParameter("pk_cartno");
				String pqty_update = request.getParameter("pqty_update");
				String fk_pro_num = request.getParameter("fk_pro_num");

				InterProductDAO pdao = new ProductDAO();
				Map<String, String> paraMap = new HashMap<>();
				
				paraMap.put("userid", loginuser.getUserid());
				paraMap.put("pk_cartno", pk_cartno);
				paraMap.put("pqty_update", pqty_update);
				paraMap.put("pk_pro_num", fk_pro_num); //상세페이지 DAO가져다 쓰기위해 이름 변경

				Map<String, Integer> pqtyCheck = pdao.qtyCheck(paraMap);
				
				int pro_qty = pqtyCheck.get("pro_qty");
				
				if(pro_qty >= Integer.parseInt(pqty_update) ) { //업데이트할 수량이 총재고량보다 작은경우
					
					int	n = pdao.updatePqty(paraMap);
				
					int partPrice = pdao.partPriceSelect(paraMap);
					int totalPrice = pdao.totalPriceSelect(paraMap);
					
					int shippingFee = 3000;
					int finalPrice = totalPrice;
					if(totalPrice < 50000) {
						finalPrice = totalPrice + shippingFee;
					}
					
				
					JSONObject jsonObj = new JSONObject(); 
					jsonObj.put("pqty_update", n);
					jsonObj.put("partPrice", partPrice);
					jsonObj.put("totalPrice", totalPrice);
					jsonObj.put("finalPrice", finalPrice); 
	
					String json = jsonObj.toString();
					
					request.setAttribute("json", json);
					
					super.setViewPage("/WEB-INF/jsonview.jsp");
					
				}else {
					//재고량보다 더적은경우
					String message = "변경하실 상품수량은 현재재고량보다 많습니다.";
					//String loc = "javascript:history.back()";//
					
					request.setAttribute("message", message);
					//request.setAttribute("loc", loc);
					
					//super.setRedirect(false);
					super.setViewPage("/WEB-INF/jsonMsg.jsp");
					
					return;
				}
					
			}else {
				String message = "비정상적인 경로로 들어왔습니다";
				//String loc = "javascript:history.back()";
   
				request.setAttribute("message", message);
				//request.setAttribute("loc", loc);
   
				//super.setRedirect(false);   
				super.setViewPage("/WEB-INF/jsonMsg.jsp");
			}

		}else {//비로그인으로 장바구니 추가할경우
			String message = "장바구니는 로그인하신후 이용가능합니다.";
			//String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			//request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonMsg.jsp");
			
		}

		
	}
}

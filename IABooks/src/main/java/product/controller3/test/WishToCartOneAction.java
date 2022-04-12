package product.controller3.test;

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

public class WishToCartOneAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) {//로그인했으면 true
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) { //포스트 방식이라며는 
				HttpSession session = request.getSession();;
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

					String pk_wnum = request.getParameter("pk_wnum");
					String now_pro_qty = "1";
					
					TestInterProductDAO tpdao = new TestProductDAO();
					Map<String, String> paraMap = new HashMap<>();
					
					paraMap.put("pk_wnum", pk_wnum);
					paraMap.put("userid", loginuser.getUserid());
				
					// 선택 탭에서 장바구니 담기를 클릭한 관심상품의 제품번호를 가져오기
					String fk_pnum = tpdao.getOneWishPnum(paraMap);
					int n = 0;
					
					if( !(fk_pnum.trim().isEmpty() || fk_pnum == null) ) { // 받아온 제품번호가 없거나 공백이 아니라면
						
						paraMap.put("pk_pro_num", fk_pnum); // Map에 제품번호를 넣어준다.
						paraMap.put("now_pro_qty", now_pro_qty);
						InterProductDAO pdao = new ProductDAO();
						
						Map<String, Integer> qtyCheck = pdao.qtyCheck(paraMap);
						Map<String, Integer> cartQtyCheck = pdao.cartQtyCheck(paraMap);
						
						int ck_odr_qty = cartQtyCheck.get("ck_odr_qty");
						int pro_qty = qtyCheck.get("pro_qty");
						
						if(pro_qty >= (ck_odr_qty+Integer.parseInt(now_pro_qty)) && (Integer.parseInt(now_pro_qty) != 0) )  {
							//재고량과 같거나 재고가 더많은경우
							
							//카드에 현재 제품이 있는지 없는지 체크 insert or update
							boolean proCartCheck  = pdao.proCartCheck(paraMap);
							
							if(proCartCheck) {//현재있는 경우 update
								n = pdao.updateAddCart(paraMap);

							}else {//없는 경우 insert
								n = pdao.insertAddCart(paraMap);
							}
							
						}else if(Integer.parseInt(now_pro_qty) == 0) {
							//재고량보다 더적은경우
							String message = "주문은 1개이상 가능합니다.";
							//String loc = "javascript:history.back()";//
							
							request.setAttribute("message", message);
							//request.setAttribute("loc", loc);
							
							//super.setRedirect(false);
							super.setViewPage("/WEB-INF/jsonMsg.jsp");
							
							return;
						}else {
							//재고량보다 더적은경우
							String message = "주문하신 상품은 현재재고량보다 많습니다.";
							//String loc = "javascript:history.back()";//
							
							request.setAttribute("message", message);
							//request.setAttribute("loc", loc);
							
							//super.setRedirect(false);
							super.setViewPage("/WEB-INF/jsonMsg.jsp");
							
							return;
							
						}//end of if(pro_qty >= Integer.parseInt(total_pro_qty) ) 
						
						
					}	
					
					JSONObject jsonObj = new JSONObject(); 
					jsonObj.put("wishToCartOne", n); 
					
					String json = jsonObj.toString();
					
					request.setAttribute("json", json);
					super.setViewPage("/WEB-INF/jsonview.jsp");
					
			}else {
				String message = "비정상적인 경로로 들어왔습니다";
				//String loc = "javascript:history.back()";
   
				request.setAttribute("message", message);
				//request.setAttribute("loc", loc);
   
				//super.setRedirect(false);   
				super.setViewPage("/WEB-INF/jsonMsg.jsp");
			}
			
		}else {//비로그인으로 관심상품 접근할 경우
			String message = "관심상품은 로그인하신후 이용가능합니다.";
			//String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			//request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonMsg.jsp");
			
		}
		
	}

}

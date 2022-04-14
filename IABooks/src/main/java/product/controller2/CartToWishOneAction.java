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

public class CartToWishOneAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) {//로그인했으면 true
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) { //포스트 방식이라며는 
				HttpSession session = request.getSession();;
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

					String fk_pro_num = request.getParameter("fk_pro_num");
					
					InterProductDAO pdao = new ProductDAO();
					Map<String, String> paraMap = new HashMap<>();
					
					paraMap.put("fk_pro_num", fk_pro_num);
					paraMap.put("userid", loginuser.getUserid());
				
					// 선택 탭에서 장바구니 담기를 클릭한 관심상품의 제품번호를 가져오기
					String fk_pnum = pdao.getOneCartPnum(paraMap);
					int n = 2;
					
					if( fk_pnum.trim().isEmpty() || fk_pnum == null) { // 받아온 제품번호가 없거나 공백이 이라면
						
						n = pdao.insertAddWish(paraMap);
	
					}	
					
					JSONObject jsonObj = new JSONObject(); 
					jsonObj.put("cartToWishOne", n); 
					
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

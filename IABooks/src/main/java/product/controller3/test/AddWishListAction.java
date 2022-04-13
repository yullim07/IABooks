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

public class AddWishListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		if(super.checkLogin(request)) {//로그인했으면 true
			String userid = request.getParameter("userid");//임시 테스트 아이디
			//String userid = "admin";//테스트
			
			HttpSession session = request.getSession();;
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

			if(loginuser.getUserid().equals(userid)) {//올바른경우
				
				//관심상품에 이미 등록이 되어있는지 확인
				String pk_pro_num = request.getParameter("pk_pro_num");
				
				TestInterProductDAO tpdao = new TestProductDAO();
				Map<String, String> paraMap = new HashMap<>();
				
				paraMap.put("pk_pro_num", pk_pro_num);
				paraMap.put("userid", userid);

				int n = 0;
				int result = 0;
				
				// 내 관심상품 목록에 있는지 검사
				n = tpdao.checkInWishList(paraMap);
				
				if(n == 0) { //내 관심상품 목록에 없는 경우 insert
					// 관심상품에 보고있는 상품을 insert
					result = tpdao.AddWishList(paraMap);
					
					JSONObject jsonObj = new JSONObject(); 
					jsonObj.put("addWishList", result); 
					jsonObj.put("pk_pro_num", pk_pro_num); 
					String json = jsonObj.toString();
					
					request.setAttribute("json", json);
					
					super.setViewPage("/WEB-INF/jsonview.jsp");

				}
				else { //내 관심상품 목록에 있는 경우
					
					n = 2;
					String message = "현재 관심상품 목록에 있는 상품입니다.";
					//String loc = "javascript:history.back()";//
					
					request.setAttribute("message", message);
					//request.setAttribute("loc", loc);
					
					//super.setRedirect(false);
					super.setViewPage("/WEB-INF/jsonMsg.jsp");
					
					return;
				}
				
				
				
			}else {//로그인사용자가 다른 사용자의 장바구니 추가할경우
				String message = "다른사용자의 관심상품은 사용이 불가능합니다.";
				//String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				//request.setAttribute("loc", loc);
				
				//super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonMsg.jsp");
			
			} // end of if(loginuser.getUserid().equals(userid)) {}-------------
			
		}else {//비로그인으로 장바구니 추가할경우
			String message = "관심상품은 로그인하신후 이용가능합니다.";
			//String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			//request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonMsg.jsp");
			
		}
		
		
	}

}

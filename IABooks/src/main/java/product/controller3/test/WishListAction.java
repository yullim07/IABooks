package product.controller3.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class WishListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 시험으로 링크 직접 입력해서 들어가게 하는거라  나중에 IF절 다시 풀어줘야합니다!!!!!!!
		if(super.checkLogin(request)) {//로그인했으면 true
			String method = request.getMethod();
		
			//if("POST".equalsIgnoreCase(method)) {//포스트 방식이라면 
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
				// 회원의 아이디를 받아와서 장바구니 보여주기
				String fk_userid = loginuser.getUserid();
			
				TestInterProductDAO pdao = new TestProductDAO();
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("userid", fk_userid);
				
				// 관심상품 조회하기 메소드
				List<WishListVO> wishList = pdao.getWishList(fk_userid);
				
				request.setAttribute("wishList", wishList);
				request.setAttribute("fk_userid", fk_userid);
				
			
				super.setViewPage("/WEB-INF/product/wishList.jsp");
			/*	
			}else{
				String message = "비정상적인 경로로 들어왔습니다";
				String loc = "javascript:history.back()";
   
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
   
				//super.setRedirect(false);   
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			*/
		}else {//비로그인으로 관심상품 추가할경우
			String message = "관심상품은 로그인하신후 이용가능합니다.";
			String loc = "javascript:history.back()";
			//String loc = "IABooks/login/join.book";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
				
		}
		
	}

}

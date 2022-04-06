package product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.CartVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class CartDeleteAllAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fk_userid = request.getParameter("fk_userid");
		String method = request.getMethod();
		
		String message = "";
		String loc = "";
		
		if(!"POST".equalsIgnoreCase(method)) {

			message = "잘못된 경로입니다!";
			loc = "javascript:history.back()"; // 뒤로가기
			
			request.setAttribute("message", message); // requset 영역에 넣어주기 
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return; // 종료
		}
		
		else { // 장바구니에서 삭제하기 버튼을 누른 경우(제대로 된 경로?)

			InterProductDAO pdao = new ProductDAO();
				
			// 로그인한 사용자가 자신의 카트를 삭제하는 경우
			int n = pdao.deleteCartAll(fk_userid);
				
		    if(n > 0) { // 장바구니 삭제 성공
				message = "장바구니에서 삭제했습니다.";
				loc = request.getContextPath()+"/product/cart.book";
			}
				
			else {
				message = "장바구니에서 삭제하기 실패!";
				loc = "javascript:history.back()";
			}
				
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
				
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}
	
}

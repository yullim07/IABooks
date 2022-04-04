package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.CartVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class CartDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		InterProductDAO pdao = new ProductDAO();
		CartVO cvo = new CartVO();
		
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {

			String message = "잘못된 경로입니다!";
			String loc = "javascript:history.back()"; // 뒤로가기
			
			request.setAttribute("message", message); // requset 영역에 넣어주기 
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return; // 종료
		}
		
		else { // 장바구니에서 삭제하기 버튼을 누른 경우(제대로 된 경로?)
		
			int n = pdao.deleteCart(cvo.getPk_cartno());
			
			if(n==1) { // 장바구니 삭제 성공
				request.setAttribute("message", "장바구니에서 삭제했습니다.");
				request.setAttribute("loc", "cart.book");
			}
			else {
				request.setAttribute("message", "장바구니에서 삭제하기 실패!");
				request.setAttribute("loc", "javascript:history.back()");
			}
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
			
		
	}

}

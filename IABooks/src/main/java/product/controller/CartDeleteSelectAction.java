package product.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import product.model.CartVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class CartDeleteSelectAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod(); // "GET" 또는 "POST"
		
		String fk_userid = request.getParameter("fk_userid"); 
		int pk_cartno = Integer.parseInt(request.getParameter("pk_cartno"));
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
		
		else {	// 장바구니에서 선택삭제하기 버튼을 누른 경우
			
			InterProductDAO pdao = new ProductDAO();
			CartVO cvo = new CartVO();
			
			// 장바구니 번호를 받아와서 삭제하기
			request.setAttribute("cvo", cvo);
			
			int n = pdao.deleteCartSelect(cvo); // 올바르게 작동하면 1이므로 return type이 int
			
			request.setAttribute("n", n);
			request.setAttribute("pk_cartno", pk_cartno);			
		}
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/cart.jsp");
		
	}

}

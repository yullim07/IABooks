package product.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class CartDeleteSelectAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String fk_userid = request.getParameter("fk_userid"); 
		String method = request.getMethod(); // "GET" 또는 "POST"		
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
			
			String pk_cartno = request.getParameter("pk_cartno");
			request.setAttribute("pk_cartno", pk_cartno);
			// 이건 뷰단으로 보내주는 거니까 필요가 없다?
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("fk_userid", fk_userid);
			paraMap.put("pk_cartno", pk_cartno);
			
			
			InterMemberDAO mdao = new MemberDAO();
			int n = mdao.pwdUpdate(paraMap); // 올바르게 작동하면 1이므로 return type이 int
			
			request.setAttribute("n", n);
			
		}
		
//		loc = request.getContextPath()+"/product/cart.book";
		
		request.setAttribute("fk_userid", fk_userid);
		request.setAttribute("method", method);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/cart.jsp");
		
	}

}

package product.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class CartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/cart.jsp");
	}
		
	/*
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			String message = "비회원은 장바구니 기능을 사용하실 수 없습니다!";
			String loc = "javascript:history.back()"; // [암기!] 이전 페이지
			
			request.setAttribute("message", message); // requset 영역에 넣어주기 
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else { // POST 방식으로 넘어온 경우
			
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			String pk_pro_num = request.getParameter("pk_pro_num");
			
			// Map에 넣어주기
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("pwd", pwd);
			paraMap.put("pk_pro_num", pk_pro_num);
			
			InterProductDAO pdao = new ProductDAO();
			ProductVO productInfo = pdao.showBookDetail(pk_pro_num);
			InterMemberDAO mdao = new MemberDAO();
			MemberVO loginuser = mdao.selectOneMember(paraMap);
			
			if(loginuser != null) { // 로그인 유저의 정보가 존재하는 경우
				HttpSession session = request.getSession();
				// [암기] 메모리에 생성되어있는 session을 불러오는 것이다.
				
				session.setAttribute("loginuser", loginuser);
				// session(세션)에 로그인된 사용자 정보인 loginuser 를 키이름을 "loginuser"로 저장시키는 것이다.
				
				// 페이지 이동
				super.setRedirect(true); // true면 페이지 이동
				
				// 로그인을 하면 시작페이지(index.up)로 가는 것이 아니라 로그인을 시도하려고 머물렀던 그 페이지로 가기 위한 것이다.
				// 네이버처럼! 예를 들어 자바스크립트를 검색하다 로그인하면 로그인 상태로 변경되고 보고있던 페이지에 계속 머무는 것
				// 나증에 할 것이다!
				
				super.setViewPage(request.getContextPath()+"/index.up");
				
			}
			else { // 로그인 유저의 정보가 존재하지 않는 경우
				
				String message = "비회원은 장바구니 기능을 사용하실 수 없습니다!";
				String loc = "javascript:history.back()"; // [암기!] 이전 페이지
				
				request.setAttribute("message", message); // requset 영역에 넣어주기 
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage(request.getContextPath()+"/index.up");
			}
		}
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/cart.jsp");
	}*/

}

package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;
import product.model.*;

public class CartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 로그인을 한 사용자만 장바구니 기능을 사용할 수 있도록 한다. 
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 로그인을 하지 않은 경우
		if( loginuser == null ) {
			
			String message = "비회원은 장바구니를 사용할 수 없습니다!";
			String loc = "javascript:history.back()"; 
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		// 로그인을 한 경우 => cartList를 cart.jsp로 보내고, 거기서 정보를 받아서 null이면 비었다고 보여주는 거? request 영역에 저장된 건가?
		else {
			
			// 회원의 아이디를 받아와서 장바구니 보여주기
			String fk_userid = loginuser.getUserid();
		
			InterProductDAO pdao = new ProductDAO();
			List<CartVO> cartList = pdao.getCart(fk_userid);
			
			request.setAttribute("cartList", cartList);
			request.setAttribute("fk_userid", fk_userid);
			
			// 현재 페이지를 돌아갈 페이지로 지정하기 <= ??? //
		//	String goBackURL = request.getParameter("goBackURL");
		//	System.out.println("~~~ 확인용 goBackURL => " + goBackURL);
			// ~~~ 확인용 goBackURL => null
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/product/cart.jsp");
		}
	}
}
	
	/////////////////////////////////////
	
	
	
	/*
	 
	 
	 
			// 장바구니에 담긴 물건의 개수 가져와야 하나?
		//	int totalCount = pdao.getTotalCountCart(fk_userid);
			
			currentshowPageNo= Integer.parseInt(str_currentshowPageNo);
			
			if (currentshowPage No < 1 || currentshowPageNo > totalPage) { 
				currentshowPageNo= 1;
			}
			try {
				
			} catch (Number FormatException e) {
				currentshowPageNo= 1;	
			}
			
		// -- 로그인 되어진 사용자의 페이징 처리한 장바구니 데이터조회 결과물 가져오기 List<Cartvo> cartList=pdao.getProductCart(userid, currentshowPageNo, sizePerPage);
	//	List<CartVO> cartList = pdao.getCartList(String pk_userid);
			
	//	HashMap<String, Integer> sumMap = pdao.getSumCartPricePoint(fk_userid);
		
	//	request.setAttribute("cartList", cartList);
	//	request.setAttribute("sumMap", sumMap);
	//	request.setAttribute("goBackURL", goBackURL);

	*/
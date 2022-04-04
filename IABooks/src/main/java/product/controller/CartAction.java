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
		
		/*
		 * 카테고리 목록 조회 페이징 추가해야 하나? 없는데
		 * super.getCategoryList(request);
		 */
		
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// 로그인 안 한 경우
		if( loginuser == null ) {
			
			String message = "비회원은 장바구니를 사용할 수 없습니다!";
			String loc = "javascript:history.back()"; 
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		// 로그인을 한 경우	
		else {
			
			// 장바구니 목록 보여주기
			InterProductDAO pdao = new ProductDAO();
			
			// 장바구니에 들어있는 제품의 총갯수 구하기
		//	HttpSession session = request.getSession();
		//	MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			String fk_userid = loginuser.getUserid();
		//	int totalCount = pdao.getTotalCountCart(fk_userid);
			
			/*
			currentshowPageNo= Integer.parseInt(str_currentshowPageNo);
			
			if (currentshowPage No < 1 || currentshowPageNo > totalPage) { 
				currentshowPageNo= 1;
			}
			*/
			
			/*try {
				
			} catch (Number FormatException e) {
				currentshowPageNo= 1;	
			}*/
		}
			
		// -- 로그인 되어진 사용자의 페이징 처리한 장바구니 데이터조회 결과물 가져오기 List<Cartvo> cartList=pdao.getProductCart(userid, currentshowPageNo, sizePerPage);
	//	List<CartVO> cartList = pdao.getCartList(String pk_userid);
			
	//	HashMap<String, Integer> sumMap = pdao.getSumCartPricePoint(fk_userid);
		
	//	request.setAttribute("cartList", cartList);
	//	request.setAttribute("sumMap", sumMap);
	//	request.setAttribute("goBackURL", goBackURL);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/cart.jsp");
		return;
		}
}

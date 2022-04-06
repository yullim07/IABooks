package product.controller;

import java.sql.SQLException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.*;

public class CartAddAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
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
		
		else { // 장바구니에 등록하기 버튼을 누른 경우
	
			// 로그인 여부
			boolean isLogin = super.checkLogin(request);
			
			// 로그인하지 않은 회원(비회원의 경우 구매불가)
			if(!isLogin) {
				// 비회원이 장바구니 기능 사용 => 로그인하면 다시 원래대로 돌아가야
				
			//	String goBackURL = request.getParameter("goBackURL");
				
			//	session.setAttribute("goBackURL", goBackURL);
				
				request.setAttribute("message", "장바구니에 담으려면 로그인하세요!");
				request.setAttribute("loc", "javascript:history.back()");
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return; // 종료
			}
			
			// 로그인을 한 경우
			else {
				String fk_pro_num = request.getParameter("fk_pro_num");
				String ck_odr_qty = request.getParameter("ck_odr_qty");
				
				InterProductDAO pdao = new ProductDAO();
				
				int n = pdao.addCart( loginuser.getUserid(), fk_pro_num, ck_odr_qty);
				
				if(n==1) { // 장바구니 추가 성공
					request.setAttribute("message", "장바구니에 담았습니다.");
					request.setAttribute("loc", "cart.book");
				}
				else {
					request.setAttribute("message", "장바구니 담기에 실패했습니다.");
					request.setAttribute("loc", "javascript:history.back()");
				}
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
			/*
			ArrayList<CartVO> cartList = new ArrayList<>();
			
			String pk_odrcode = request.getParameter("pk_odrcode");
			
			CartVO cvo = new CartVO();
			
			String fk_userid = request.getParameter("fk_userid");
			int odr_totalprice = Integer.parseInt(request.getParameter("odr_totalprice"));
			int odr_totalpoint = Integer.parseInt(request.getParameter("odr_totalpoint"));
			// Date odr_date = sysdate;
			String rv_name = request.getParameter("rv_name");
			String rv_zipcode = request.getParameter("rv_zipcode");
			String rv_addr1 = request.getParameter("rv_addr1");
			String rv_addr2 = request.getParameter("rv_addr2");
			int rv_phone = Integer.parseInt(request.getParameter("rv_phone"));
			String rv_email = request.getParameter("rv_email");
			String del_msg = request.getParameter("del_msg");
			
			HttpSession session = request.getSession();
								
			ArrayList<CartVO> cart_list = (ArrayList<CartVO>) session.getAttribute("cart-list");
            if (cart_list == null) {
                cartList.add(cvo);
                session.setAttribute("cart-list", cartList);
                response.sendRedirect("index.jsp");
            } else {
                cartList = cart_list;

                boolean exist = false;
                for (CartVO c : cart_list) {
                    if (c.getPk_pro_num() == id) {
                        exist = true;
                        /*("<h3 style='color:crimson; text-align: center'>Item Already in Cart. <a href='cart.jsp'>GO to Cart Page</a></h3>");*/
          /*          }
                }

                if (!exist) {
                    cartList.add(cvo);
                    response.sendRedirect("index.jsp");
                }
            }
		*/
        }
	}
}

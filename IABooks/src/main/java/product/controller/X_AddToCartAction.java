package product.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import product.model.*;

public class X_AddToCartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) { // 비회원구매기능이 없으니 GET 으로 들어오는 것을 막아준다.

			String message = "도서를 구매하기 위해서는 로그인을 해주세요!";
			String loc = "javascript:history.back()"; // 뒤로가기
			
			request.setAttribute("message", message); // requset 영역에 넣어주기 
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/product/showBookDetail.jsp");
		}
		
		else { // 장바구니에 등록하기 버튼을 누른 경우
	
			String userid = request.getParameter("userid");
			String pk_pro_num = request.getParameter("pk_pro_num");
			
			// Map 에 넣어주기
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("userid", userid);
			paraMap.put("pk_pro_num", pk_pro_num);
			
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

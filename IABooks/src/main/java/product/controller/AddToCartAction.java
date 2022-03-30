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

public class AddToCartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/product/addtocart.jsp");
		}
		
		else { // 장바구니에 등록하기 버튼을 누른 경우
			
			ArrayList<CartVO> cartList = new ArrayList<>();
			
			String pk_odrcode = request.getParameter("pk_odrcode");
			
			CartVO cvo = new CartVO();
			
			String fk_userid = request.getParameter("fk_userid");
			int odr_totalprice = Integer.parseInt(request.getParameter("odr_totalprice"));
			int odr_totalpoint = Integer.parseInt(request.getParameter("odr_totalpoint"));
			Date odr_date = sysdate;
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
                    }
                }

                if (!exist) {
                    cartList.add(cvo);
                    response.sendRedirect("index.jsp");
                }
            }
        }

}

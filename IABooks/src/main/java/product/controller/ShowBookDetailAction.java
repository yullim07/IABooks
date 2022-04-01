package product.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import product.model.InterProductDAO;
import product.model.ProductDAO_lyr;
import product.model.ProductVO;

public class ShowBookDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // 빠른 속도를 위해 GET 방식으로
		
		if("GET".equalsIgnoreCase(method)) {
			
			String pk_pro_num = request.getParameter("pk_pro_num");
			InterProductDAO pdao = new ProductDAO_lyr();
			ProductVO pvo = pdao.showProductDetail(pk_pro_num);
		
			
		//	super.setRedirect(false);
		//	super.setViewPage("/WEB-INF/product/product_detail.jsp");
			super.setViewPage("/main/product/product_detail.jsp");
			
		}
		else {
//			super.setRedirect(false);
		//	super.setViewPage("/WEB-INF/product/product_detail.jsp");
			super.setViewPage("/main/product/product_detail.jsp");
		}

	}

}

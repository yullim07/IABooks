package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class ShowBookDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pk_pro_num = request.getParameter("pronum");

		InterProductDAO pdao = new ProductDAO();
		ProductVO pvo = pdao.showBookDetail(pk_pro_num);
			
		request.setAttribute("pvo", pvo);
		
		//super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/showBookDetail.jsp");
						
	}

}

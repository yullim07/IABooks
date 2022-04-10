package product.controller2;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class ShowBest20Action extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		InterProductDAO mdao = new ProductDAO();
		
		List<ProductVO> productList = mdao.selectCategoryBest20();
		request.setAttribute("productList", productList);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/category_best20.jsp");
			
	}

}

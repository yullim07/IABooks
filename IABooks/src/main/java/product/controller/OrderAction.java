package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class OrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) { // POST 방식으로 들어온 것이 아닌 경우
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/product/order.jsp");
		} 
		
		else { // POST 방식으로 들어온 경우
			
		}
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/order.jsp");		
	}
}
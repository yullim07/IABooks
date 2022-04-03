package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class ShowBookDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		System.out.println("확인용 method : " + method);
		
		/*
		 * String pk_pro_num = request.getParameter("pk_pro_num");
		 * System.out.println("확인용 pk_pro_num : " + pk_pro_num);
		 */
		
		
		/////////////////////////////////////////////////////
		
		
		// String pk_pro_num = "9791196045999";
		String pk_pro_num = request.getParameter("pk_pro_num");
		System.out.println("확인용 pk_pro_num : " + pk_pro_num);
		
		InterProductDAO pdao = new ProductDAO();
		ProductVO pvo = pdao.showBookDetail(pk_pro_num);		// 하나의 상세정보에 대한 정보니까 ProductVO
		
		// ProductDAO_lyr에서 편집하고 난 뒤 돌아와서 하는 곳
		request.setAttribute("pvo", pvo);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/showBookDetail.jsp");
						
		
		/*
		 * if(pvo == null) { String message = "존재하지 않는 상품입니다."; String loc =
		 * "javascript:history.back()";
		 * 
		 * request.setAttribute("message", message); request.setAttribute("loc", loc);
		 * 
		 * super.setRedirect(false);
		 * super.setViewPage("/WEB-INF/product/showBookList.jsp"); }
		 * 
		 * else { // ProductDAO_lyr에서 편집하고 난 뒤 돌아와서 하는 곳 //
		 * request.setAttribute("pk_pro_num", pk_pro_num); request.setAttribute("pvo",
		 * pvo);
		 * 
		 * // super.setRedirect(false);
		 * super.setViewPage("/WEB-INF/product/showBookDetail.jsp"); }
		 */
		
	}

}

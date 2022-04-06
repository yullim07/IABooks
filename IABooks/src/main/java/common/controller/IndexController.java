package common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;


public class IndexController extends AbstractController {

	@Override
	public String toString() {
		return "확인용 IndexController 클래스의 인스턴스 메소드인 toString호출";
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		String slidesCnt = "8";
		InterProductDAO pdao = new ProductDAO();
		 
	    Map<String,String> paraMap = new HashMap<>();
	    paraMap.put("slidesCnt", slidesCnt); 
	     
	    List<ProductVO> prodList = pdao.selectSlides(paraMap);
	    request.setAttribute("prodList", prodList);
	    
		super.setRedirect(false);//false 생략가능
		super.setViewPage("/WEB-INF/index.jsp");
	}

}

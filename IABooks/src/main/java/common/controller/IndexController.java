package common.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import myshop.model.ImageVO;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;

public class IndexController extends AbstractController {

	@Override
	public String toString() {
		return "=== 확인용 IndexController 클래스의 인스턴스 메소드인 toString() 호출함 === ";
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductDAO pdao = new ProductDAO();
		List<ImageVO> imgList = pdao.imageSelectAll();
		
		request.setAttribute("imgList", imgList);
		
		/*
			super.setRedirect(false);
			this.setRedirect(false);
			setRedirect(false);
		*/
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/index.jsp");
		
	}

}

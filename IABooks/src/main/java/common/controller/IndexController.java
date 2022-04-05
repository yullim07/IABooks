package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class IndexController extends AbstractController {

	@Override
	public String toString() {
		return "확인용 IndexController 클래스의 인스턴스 메소드인 toString호출";
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		//super.setRedirect(false);//false 생략가능
		//this.setRedirect(false); 다같다.
		//setRedirect(false);
		
		super.setViewPage("/WEB-INF/index.jsp");
	}

}

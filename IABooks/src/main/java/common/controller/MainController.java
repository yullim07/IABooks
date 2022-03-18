package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends AbstractController {

	@Override
	public String toString() {
		return "=== 확인용 클래스 MainController 클래스의 인스턴스 메소드인 toString() 호출함 ===";
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
	//	System.out.println("=== HeHeHe 메인컨트롤러 ===");
		
		/*  
			super.setRedirect(true); ==> sendRedirect 해준다. 
			this.setRedirect(true);
			setRedirect(true);
		 */
	//	super.setRedirect(true);	// 생략가능, 실제로는 서블릿의 action.execute이 해준다.
		super.setViewPage("index.up"); // /MyMVC/index.up 페이지(상대경로)로 이동한다는 뜻이다.
		
	}
}

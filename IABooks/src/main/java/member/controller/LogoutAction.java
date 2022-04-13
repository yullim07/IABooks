package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class LogoutAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 로그아웃 처리하기
		HttpSession session = request.getSession(); // 세션불러오기
		
		///////////////////////////////////////////////////////////////////////////////////////////
		// 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것이다.
		
		String goBackURL = (String) session.getAttribute("goBackURL");
		
		if(goBackURL != null) {
			goBackURL = request.getContextPath() + goBackURL;
		}
		
		// 첫번째 방법 : 세션을 그대로 존재하게 끔 해두고 세션에 처장되어진 어떤 값(지금은 로그인되어진 회원객체)을 삭제하기
		//session.removeAttribute("loginuser");
		
		// 두번째 방법 : WAS 메모리 상에서 세션을 이예 삭제해버리기
		session.invalidate();
		
		////////////////////////////////////////////////////////////////////
		super.setRedirect(true);
		
		if(goBackURL != null) {
			super.setViewPage(goBackURL);
		} else {
			super.setViewPage(request.getContextPath()+"/index.book");
		}
		
		
		
	}

}

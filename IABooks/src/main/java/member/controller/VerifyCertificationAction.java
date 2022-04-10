package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class VerifyCertificationAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userCertificationCode = request.getParameter("userCertificationCode");
		//		사용자가 보내어준 인증코드
		String userid= request.getParameter("userid");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = "010-" + request.getParameter("phone_one") +"-"+ request.getParameter("phone_two") ;
		String phone2 = "010" + request.getParameter("phone_one") + request.getParameter("phone_two") ;
		String radio = request.getParameter("check");
		
		HttpSession session = request.getSession();  // 세션불러오기
		String certificationCode = (String) session.getAttribute("certificationCode"); // 세션에 저장된 인증코드 가져오기
		
		//		랜덤하게 발생된 인증코드
		
		String message = "";
		String loc = "";
		
		if( certificationCode.equals(userCertificationCode) ) {
			message = "인증성공 되었습니다";
			loc = request.getContextPath() + "/login/pwdUpdateEnd.book";
		}
		else {
			message = "발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요!!";
			loc = request.getContextPath() + "/login/pwdFind.book"; 
		}
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			// !! 중요 !!
			// !! 세션에 저장된 인증코드 삭제하기 !! //
			session.removeAttribute("certificationCode");
	}

}

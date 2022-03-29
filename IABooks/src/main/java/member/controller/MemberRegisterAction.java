package member.controller;


import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;

public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.setViewPage("/WEB-INF/member/memberRegister.jsp");
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			// super.setRedirect(false); // 디폴트가 false이기 때문에 생략가능
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
		} else { // 가입하기 버튼을 클릭했을 경우
			String name = request.getParameter("name");
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			String email = request.getParameter("email");
			String num1 = request.getParameter("num1");
			String num2 = request.getParameter("num2");
			String num3 = request.getParameter("num3");
			String hp1 = request.getParameter("hp1");
			String hp2 = request.getParameter("hp2");
			String hp3 = request.getParameter("hp3");
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailaddress = request.getParameter("detailAddress");
			String extraaddress = request.getParameter("extraAddress");
			String gender = request.getParameter("gender");
			String birthday = request.getParameter("birthday");
			
			
			String number = num1+num2+num3;
			String phone = hp1+hp2+hp3;
			
			MemberVO member = new MemberVO(userid, pwd, name, email, postcode, address, detailaddress, extraaddress, gender, birthday, number, phone);
			
			String message = "";
			String loc = "";
			try {
				InterMemberDAO mdao = new MemberDAO();
				int n = mdao.registerMember(member);
				
				if(n==1) {
					message = "회원가입 성공";
					loc =  request.getContextPath()+"/member/registerSuccess.jsp";// 가입성공페이지로 이등
				}
			
			} catch (SQLException e) {
				message = "SQL 구문 에러발생";
				loc = "javascript:history.back()";// 자바스크립트를 이용한 이전페이지로 이동한다.
				e.printStackTrace();
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		
			/////////////////////////////////////////////////////
			
			
			
		}
		
			
	}

	
}

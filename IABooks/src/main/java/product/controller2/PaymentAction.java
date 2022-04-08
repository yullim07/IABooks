package product.controller2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class PaymentAction extends AbstractController {
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//아임포트 결제창을 사용하기 위한 로그인이 되어져야하며 다른사람 아이디는 불가능하다.
		if(super.checkLogin(request)) {//로그인했으면 true
			String userid = request.getParameter("userid");//임시 테스트 아이디
			//String userid = "admin";//테스트
			
			HttpSession session = request.getSession();;
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			if(loginuser.getUserid().equals(userid)) {//올바른경우
				
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String phone = request.getParameter("hp1") +"-"+ request.getParameter("hp2") +"-"+ request.getParameter("hp3");
				String postcode = request.getParameter("postcode");
				String address = request.getParameter("address") +" "+ request.getParameter("detailAddress") +" "+ request.getParameter("extraAddress");
				String totalprice = request.getParameter("totalprice");//임시 테스트 가격
				
				//출력테스트
				System.out.println("userid"+userid+" "+"name"+name+" "+"email"+email+" "+"phone"+phone+" "+"postcode"+postcode+" "+"address"+address+" "+"totalprice"+totalprice);
				
				request.setAttribute("userid", userid);//아이디
				request.setAttribute("name", name);//이름
				request.setAttribute("email", email);//이메일
				request.setAttribute("phone", phone);//전화
				request.setAttribute("postcode", postcode);//우편번호
				request.setAttribute("address", address);//주소
				request.setAttribute("totalprice", totalprice);
				
				//super.setRedirect(false);
				super.setViewPage("/WEB-INF/product/paymentGateway.jsp");
				
			}else {//로그인사용자가 다른 사용자의  아임포트 결제 할경우
				String message = "다른사용자의 구매할제품은 결제가 불가능합니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				//super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}else {
			String message = "제품을 구해하기전에 먼저 로그인을 하세요";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
	}
}

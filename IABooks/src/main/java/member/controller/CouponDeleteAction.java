package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class CouponDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
			
			String couponid = request.getParameter("couponid");
			String userid = request.getParameter("userid");
			
			InterMemberDAO mdao = new MemberDAO();
		/*	
			int n = mdao.couponDelete(couponid,userid);
			
			String message = "";
			String loc = "";
			
			if(n>0) {
				message = "쿠폰이 삭제되었습니다.";
				loc = request.getContextPath()+"/member/coupon.book";
			} else {
				message = "쿠폰삭제에 실패했습니다.";
				loc = "javascript:history.back()";
			}
			
			request.setAttribute("message", message);
	        request.setAttribute("loc", loc);			
		//	super.setRedirect(false);
		//	super.setViewPage("/WEB-INF/msg.jsp");
		 */	
			
		}
		
	}

}

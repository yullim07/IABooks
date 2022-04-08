package member.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class UserCouponRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

			
			String userid = request.getParameter("userid");
			String coupon_id = request.getParameter("userCoupon");
			
			UserCouponStatusVO UserCouponStatus = new UserCouponStatusVO(userid, coupon_id);
			MemberVO member = new MemberVO(userid);
			
			
			try {
				InterMemberDAO mdao = new MemberDAO();
				int n = mdao.UserCouponStatus(UserCouponStatus);
				
				
				if(n==1) {
					
					request.setAttribute("cuserid", userid);
					request.setAttribute("coupon_id", coupon_id);
					
					HttpSession session = request.getSession();
	                // 메모리에 생성되어져 있는 session 을 불러오는 것이다.
	                
					session.setAttribute("UserCouponStatus", UserCouponStatus);
	                // session(세션)에 사용자 정보인 UserCouponStatus 을 키이름을 "UserCouponStatus" 으로 저장시켜두는 것이다. 
					
					super.setRedirect(true);
					super.setViewPage(request.getContextPath()+"/member/coupon.book");
				}
			
			
			} catch (SQLException e) {
				e.printStackTrace();
				
				String message = "SQL구문 에러발생";
				String loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는것.
            
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
               
            //  super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
				
					
	}

}

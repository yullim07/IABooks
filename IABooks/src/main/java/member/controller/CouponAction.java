package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class CouponAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if("get".equalsIgnoreCase(method)) {
			
			setRedirect(false);
			setViewPage("/WEB-INF/member/coupon.jsp");
			
		}
	}

}

package member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;


public class MyPageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
        // 메모리에 생성되어져 있는 session 을 불러오는 것이다.
		
		if(session.getAttribute("loginuser") == null) {
			
			session.setAttribute("myPageLogin", "myPageLogin");
			
			setRedirect(false);
			setViewPage("/login/join.book");
			
		} else {
			
			String userid = (String)session.getAttribute("userid");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			
			InterMemberDAO mdao = new MemberDAO();
			//////////////////////////////////////////////////////////////
			// 쿠폰의 개수 알아오기 
			int couponNum = mdao.CouponNum(paraMap);
/*			
			Map<String,String> result  = mdao.mgInfo(paraMap);
			
			request.setAttribute("all_mg", result.get("all_mg"));
			request.setAttribute("used_mg", result.get("used_mg"));
			request.setAttribute("available_mg", result.get("available_mg"));
			request.setAttribute("refund_mg", result.get("refund_mg"));
			request.setAttribute("unsecured_mg", result.get("unsecured_mg"));
 */			
			
			// 배송단계 조회 하는 메소드
			int step1 = mdao.deliverStep1(userid);
			int step2 = mdao.deliverStep2(userid);
			int step3 = mdao.deliverStep3(userid);
			int step4 = mdao.deliverStep4(userid);
			int step5 = mdao.deliverStep5(userid);
			
			// 이제까지 구매한 주문 금액 조회
			int allPrice = mdao.allPrice(userid);
			
			// 이제까지 주문한 구매 회수 조회
			int ordcount = mdao.allOdrCount(userid);
			
			// 적립금 조회
			int mileage = mdao.useMileage(userid);
			
			request.setAttribute("couponNum", couponNum);
			request.setAttribute("step1", step1);
			request.setAttribute("step2", step2);
			request.setAttribute("step3", step3);
			request.setAttribute("step4", step4);
			request.setAttribute("step5", step5);
			request.setAttribute("allPrice", allPrice);
			request.setAttribute("ordcount", ordcount);
			request.setAttribute("mileage", mileage);

			setRedirect(false);
			setViewPage("/WEB-INF/member/myPage.jsp");
			
		}

	}

}

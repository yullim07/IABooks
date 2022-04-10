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
			//////////////////////////////////////////////////////////////리스트가져오기
			
			List<CouponVO> couponList = mdao.selectCouponList(paraMap);
			int couponNum = mdao.CouponNum(paraMap);
			
			request.setAttribute("couponList", couponList);
			request.setAttribute("couponNum", couponNum);
			
			setRedirect(false);
			setViewPage("/WEB-INF/member/myPage.jsp");
			
		}

	}

}

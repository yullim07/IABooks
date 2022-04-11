package member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MileageVO;

public class MileageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
        // 메모리에 생성되어져 있는 session 을 불러오는 것이다.
		
		if(session.getAttribute("loginuser") == null) {
			
			session.setAttribute("myPageLogin", "myPageLogin");
			
			setRedirect(false);
			setViewPage("/login/join.book");
			
		} else { // 로그인 되었을 때
			

			InterMemberDAO mdao = new MemberDAO(); // mdao 라는 새로운 dao 객체 생성
			
			Map<String, String> paraMap = new HashMap<String, String>(); // paraMap 이라는 Map 객체 생성 (파라미터값으로 String)
			paraMap.put("userid", (String)session.getAttribute("userid")); // 세션에서 userid 값을 받아와서 파라맵에 넣어줌
			
/*			Map<String,String> result  = mdao.mgInfo(paraMap); // sql에서 셀렉된것들이 맵에 담겨서 mgInfo 메소드를 써서 mdao로 가져온 후 그걸 result 라는 맵에 담음
			
			request.setAttribute("all_mg", result.get("all_mg")); 
			request.setAttribute("used_mg", result.get("used_mg"));
			request.setAttribute("available_mg", result.get("available_mg"));
			request.setAttribute("refund_mg", result.get("refund_mg"));
			request.setAttribute("unsecured_mg", result.get("unsecured_mg"));
			
			
			List<MileageVO> orderMileageInfo = mdao.orderMileageInfo(paraMap);
*/			
			
			
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/mileage.jsp");
    	  
      }
		
			
	
}

}

package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class CouponDuplicateCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod(); // "GET" 아니면 "POST" 
		HttpSession session = request.getSession();
		
		if("POST".equalsIgnoreCase(method)) {
			
			String userid = (String)session.getAttribute("userid");
			String userCoupon = request.getParameter("userCoupon"); 
		//	System.out.println(">>> 확인용 userid =>"+ userid );	// 내가 입력한 아이디 값
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("userCoupon", userCoupon);
			
			
			InterMemberDAO mdao = new MemberDAO();
			boolean isExist = mdao.couponDuplicateCheck(paraMap);
			
			boolean isCoupon = mdao.CPDuplicateCheck(paraMap);
			
			JSONObject jsonObj = new JSONObject(); 	// {}
			jsonObj.put("isExist", isExist);			// {"isExist":true} 또는 {"isExist":false} 으로 만들어준다. 
			jsonObj.put("isCoupon", isCoupon);			// {"isExist":true} 또는 {"isExist":false} 으로 만들어준다. 
			
			
			String json = jsonObj.toString();	// 문자열 형태인 "{"isExist":true}" 또는 "{"isExist":false}" 으로 만들어준다.
		//	System.out.println(">>> 확인용 json =>"+ json );	
		//	>>> 확인용 json =>{"isExist":false}
		//	또는	
		//	>>> 확인용 json =>{"isExist":true}
			
			request.setAttribute("json",json);
			
		//	super.setRedirect(false); // 디폴트가 false
			super.setViewPage("/WEB-INF/member/jsonview.jsp");
		}
	}

}

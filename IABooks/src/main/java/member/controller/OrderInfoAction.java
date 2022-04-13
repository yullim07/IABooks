package member.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class OrderInfoAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		 HttpSession session = request.getSession();
		
		String method = request.getMethod();
		
		//if (데이터 픽커값이 있으면) {
			
		
		
		//	}(픽커값 없으면)
			LocalDate today = LocalDate.now();
			today = today.plusDays(1);
			LocalDate lastmonth_three = today.minusMonths(3);
			
			int status = 1;
			
		String userid = "";
		
		userid = (String) session.getAttribute("userid");
		
		InterMemberDAO mdao = new MemberDAO();
		
		Map<String , Object> paraMap = new HashMap<>();
		
		paraMap.put("userid", userid);
		paraMap.put("today", today);
		paraMap.put("lastmonth_three", lastmonth_three);
		paraMap.put("status", status);
		
		List<Map<String,String>> orderInfoList =  mdao.orderInfo(paraMap);
		
		request.setAttribute("orderInfoList", orderInfoList);
		
		if("get".equalsIgnoreCase(method)) {
			
			setRedirect(false);
			setViewPage("/WEB-INF/member/orderInfo.jsp");
			
		}

	}

}

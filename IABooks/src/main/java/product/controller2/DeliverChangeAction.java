package product.controller2;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class DeliverChangeAction extends AbstractController  {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(super.checkLogin(request)) {//로그인했으면 true
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {//포스트 방식이라며는 
				HttpSession session = request.getSession();;
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
				//String delivername = request.getParameter("delivername");
				String deliverstatus = request.getParameter("deliverstatus");
				String pk_odr_seqnum = request.getParameter("pk_odr_seqnum");
				InterProductDAO pdao = new ProductDAO();
				Map<String, String> paraMap = new HashMap<>();

				paraMap.put("userid", loginuser.getUserid());
				paraMap.put("deliverstatus", deliverstatus);
				paraMap.put("pk_odr_seqnum", pk_odr_seqnum);
				//paraMap.put("delivername", delivername);
				
				 int n = pdao.deliverChange(paraMap); 
				
				
				 if(n==1 && Integer.parseInt(deliverstatus) == 4) {
					 n = pdao.deliverdateInsert(paraMap);
					 
				  }
					
				
				
				JSONObject jsonObj = new JSONObject(); 
				jsonObj.put("n", n); 

				String json = jsonObj.toString();
				
				request.setAttribute("json", json);
				super.setViewPage("/WEB-INF/jsonview.jsp");
				
			}else {
				String message = "비정상적인 경로로 들어왔습니다";
				//String loc = "javascript:history.back()";
   
				request.setAttribute("message", message);
				//request.setAttribute("loc", loc);
   
				//super.setRedirect(false);   
				super.setViewPage("/WEB-INF/jsonMsg.jsp");
			}
			
		}else {//비로그인으로 장바구니 추가할경우
			String message = "장바구니는 로그인하신후 이용가능합니다.";
			//String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			//request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonMsg.jsp");
			
		}
		
	}

}

package product.controller2;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.InterProductDAO;
import product.model.ProductDAO;

public class PaymentEndAction extends AbstractController{
	
	private String getOdrcode() throws SQLException {
		
		// 전표(주문코드) 형식 : s+날짜+sequence ==> s20220411-1
		
		// 날짜 생성
		Date now = new Date();
		SimpleDateFormat smdatefm = new SimpleDateFormat("yyyyMMdd"); 
		String today = smdatefm.format(now);
		
		InterProductDAO pdao = new ProductDAO();
		
		int seq = pdao.getSeq_tbl_order();
		// pdao.getSeq_tbl_order(); 는 시퀀스 seq_tbl_order 값을 채번해오는 것.
		
		return "s"+today+"-"+seq;
		
	}// end of private String getOdrcode()---------------
	
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) {//로그인했으면 true
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {//포스트 방식이라며는 
				HttpSession session = request.getSession();;
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

				String userid = loginuser.getUserid();
	
				//배송내용추가, 사용한 포인트 차감
				
				String email = request.getParameter("email");
				String name = request.getParameter("name");
				String phone = request.getParameter("phone");
				String postcode = request.getParameter("postcode");
				String address = request.getParameter("address");
				String finalPrice = request.getParameter("finalPrice");
				String useCouponId = request.getParameter("useCouponId");
				
				String pk_cartnoJoin = request.getParameter("pk_cartnoJoin");
				String fk_pro_numJoin = request.getParameter("fk_pro_numJoin");
				String pqtyJoin = request.getParameter("pqtyJoin");
				String pointJoin = request.getParameter("pointJoin");
				String partPriceJoin = request.getParameter("partPriceJoin");
				
				String[] pk_cartnoArr = pk_cartnoJoin.split(",");
				String[] fk_pro_numArr = fk_pro_numJoin.split(",");
				String[] pqtyArr = pqtyJoin.split(",");
				String[] pointArr = pointJoin.split(",");
				String[] partPriceArr = partPriceJoin.split(",");
				
				InterProductDAO pdao = new ProductDAO();
				Map<String, Object> paraMap = new HashMap<>();
				
				String odrcode = getOdrcode();

				paraMap.put("odrcode", odrcode);
				paraMap.put("userid", userid);
				paraMap.put("email", email);
				paraMap.put("name", name);
				paraMap.put("phone", phone);
				paraMap.put("postcode", postcode);
				paraMap.put("address", address);
				paraMap.put("finalPrice", finalPrice);
				
				paraMap.put("pk_cartnoArr", pk_cartnoArr); //카트삭제
				paraMap.put("fk_pro_numArr", fk_pro_numArr); //오덭이블 추가 
				paraMap.put("pqtyArr", pqtyArr); //오더테이블 추가
				paraMap.put("partPriceArr", partPriceArr); //개당총가격
				
				paraMap.put("pointArr", pointArr); //포인트 추가
				paraMap.put("useCouponId", useCouponId); //쿠폰
				
				int totalPoint = 0;
				for(int i=0; i<pointArr.length; i++) {
					totalPoint += Integer.parseInt(pointArr[i]);
				}
				paraMap.put("totalPoint", totalPoint); 
				
				int n  =  pdao.paymentEnd(paraMap);

				/*
				if(n == 1) {
					request.setAttribute("userid", userid);
					request.setAttribute("email", email);
					request.setAttribute("name", name);
					request.setAttribute("phone", phone);
					request.setAttribute("postcode", postcode);
					request.setAttribute("address", address);
					request.setAttribute("finalPrice", finalPrice);
					request.setAttribute("cartno", cartno);	
				}
				*/
				//super.setRedirect(false);   
				super.setViewPage("/WEB-INF/product/paymentEnd.jsp");
				
			}else {
				String message = "비정상적인 경로로 들어왔습니다";
				String loc = "javascript:history.back()";
   
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
   
				//super.setRedirect(false);   
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}else {//비로그인으로 장바구니 추가할경우
			String message = "장바구니는 로그인하신후 이용가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		
	}
}

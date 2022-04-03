package member.controller;

import java.sql.SQLException;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class GenerateCouponAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod();

		if ("post".equalsIgnoreCase(method)) {

			Random rnd = new Random();

			String couponNumber = "";

			int randnum = 0;
			for (int i = 0; i < 15; i++) {
				randnum = rnd.nextInt(9 - 0 + 1) + 0;
				couponNumber += randnum;

			} // end of for

			String cname = request.getParameter("couponName");
			String cprice = request.getParameter("couponDiscount");
			String cminprice = request.getParameter("minDiscount");
			String cstartdate = request.getParameter("coupondateStart");
			String cenddate = request.getParameter("coupondateEnd");
			String couponid = couponNumber;

			CouponVO coupon = new CouponVO(cname, cprice, cminprice, cstartdate, cenddate, couponid);

			try {
				InterCouponDAO cdao = new CouponDAO();
				int n = cdao.couponRegister(coupon);
				
				if (n == 1) {
					request.setAttribute("couponid", couponNumber);
					request.setAttribute("cname", cname);
					request.setAttribute("cprice", cprice);
					request.setAttribute("cminprice", cminprice);
					request.setAttribute("cstartdate", cstartdate);
					request.setAttribute("cenddate", cenddate);

					String message = " 쿠폰이 발급되었습니다. 쿠폰번호 : " + couponNumber;
					String loc = "javascript:self.close()";

					request.setAttribute("message", message);
					request.setAttribute("loc", loc);

					// super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}

			} catch (SQLException e) {
				e.printStackTrace();

				String message = "SQL구문 에러발생";
				String loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는것.

				request.setAttribute("message", message);
				request.setAttribute("loc", loc);

				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}

		} else {

			if (super.checkLogin(request)) { // 로그인을 한 경우

				String userid = request.getParameter("userid");

				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

				if (loginuser.getUserid().equals(userid)) { // 관리자가 들어와서 발급하는 경우

					// super.setRedirect(false);
					super.setViewPage("/WEB-INF/member/generateCoupon.jsp");

				} else { // 관리자가 아닌 일반유저가 로그인하고 쿠폰발급하는 경우

					String message = "관리자로 로그인 해주세요 ";
					String loc = "javascript:history.back()";

					request.setAttribute("message", message);
					request.setAttribute("loc", loc);

					// super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}

			} else { // 로그인을 안한 경우
				String message = "관리자로 로그인 해주세요";
				String loc = "javascript:history.back()";

				request.setAttribute("message", message);
				request.setAttribute("loc", loc);

				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}

		}

	}

}

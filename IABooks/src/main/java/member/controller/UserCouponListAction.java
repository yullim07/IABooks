package member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;
import my.Util.MyUtil;

public class UserCouponListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 해야 한다. == //
				HttpSession session = request.getSession();
				
				// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임.
				super.goBackURL(request);
				
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
				if( loginuser == null || !"admin".equals(loginuser.getUserid()) ) {
					// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우
					String message = "관리자만 접근이 가능합니다.";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
				else {
					// 관리자(admin)로 로그인 했을 경우 
				
					String userid = request.getParameter("userid");
					
					String sizePerPage = "5";
					String currentShowPageNo = request.getParameter("currentShowPageNo");
					
					Map<String, String> paraMap = new HashMap<>();
					paraMap.put("userid", userid);
					paraMap.put("sizePerPage", sizePerPage);
					
					
					InterMemberDAO mdao = new MemberDAO();
					
					int n = mdao.deleteCouponList(paraMap);
					if(n == 1) {
						request.setAttribute("deleteCouponList", n);
					}
					
					int couponNum = mdao.CouponNum(paraMap);
					
					if(currentShowPageNo == null) {
						currentShowPageNo = "1";
					}
					
					
					try {
						Integer.parseInt(currentShowPageNo);
					} catch(NumberFormatException e) {
						currentShowPageNo = "1";
					}

					
					int totalPage = mdao.getTotalPage(paraMap);
					
					if( Integer.parseInt(currentShowPageNo) > totalPage ) {
						currentShowPageNo = "1";
					}
					
					paraMap.put("currentShowPageNo", currentShowPageNo);
					List<CouponVO> couponListP = mdao.selectPagingCouponList(paraMap);
					
					
					request.setAttribute("sizePerPage", sizePerPage);
					
					String pageBar = "";
					
					int blockSize = 5; 
					
					int loop = 1;
					int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
					
					if( pageNo != 1 ) {
						
						pageBar += "<li class='page-item'><a class='page-link' href='coupon.book?currentShowPageNo=1&sizePerPage="+sizePerPage+"'><i class='fal fa-angle-double-left'></i></a></li>"; 
						pageBar += "<li class='page-item'><a class='page-link' href='coupon.book?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'><i class='fal fa-angle-left'></i></a></li>";  
					}
								
					while( !(loop > blockSize || pageNo > totalPage) ) { 
					
						if( pageNo == Integer.parseInt(currentShowPageNo) ) {
							pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
						}
						else {
							pageBar += "<li class='page-item'><a class='page-link' href='coupon.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a></li>";   
						}
						
						loop++;
						pageNo++;
						
					}// end of while---------------------------------
					
					if( pageNo <= totalPage ) {
						pageBar += "<li class='page-item'><a class='page-link' href='coupon.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'><i class='fal fa-angle-right'></i></a></li>";  
						pageBar += "<li class='page-item'><a class='page-link' href='coupon.book?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"'><i class='fal fa-angle-double-right'></i></a></li>"; 
					}
					
					String currentURL = MyUtil.getCurrentURL(request);
				
					currentURL = currentURL.replaceAll("&", " ");
					
					request.setAttribute("couponListP", couponListP);
					request.setAttribute("pageBar", pageBar);
					request.setAttribute("couponNum", couponNum);
					request.setAttribute("goBackURL", currentURL);

					
					setRedirect(false);
					setViewPage("/WEB-INF/member/userCouponList.jsp");

					
					
				}	
		
	}

}

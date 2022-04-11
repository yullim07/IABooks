package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;


public class MemberOneDetailAction extends AbstractController {

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
			InterMemberDAO mdao = new MemberDAO();
			MemberVO mvo = mdao.memberOneDetail(userid);
			
			request.setAttribute("mvo", mvo);

			// 현재페이지를 돌아갈 페이지(goBackURL)로 주소 시정하기
			String goBackURL = request.getParameter("goBackURL");
	//		System.out.println("확인용 goBackURL =>"+ goBackURL);
			// 확인용 goBackURL =>/member/memberList.up?currentShowPageNo=6
			// 확인용 goBackURL =>/member/memberList.up?currentShowPageNo=5 sizePerPage=10 searchType=name searchWord=%EC%9C%A0
			
			request.setAttribute("goBackURL", goBackURL);
			
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberOneDetail.jsp");
		}
		
	}

}

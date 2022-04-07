package product.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAO;
import board.model.InterBoardDAO;
import board.model.ReviewBoardVO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class ReviewSubmitAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// == 관리자(admin)로 로그인 했을 때만 접근이 가능하도록 해야 한다. == //
		HttpSession session  = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		// if( loginuser == null || !"admin".equals(loginuser.getUserid()) ) {
		if( loginuser == null ) {
			// 로그인을 안했거나 일반사용자로 로그인 한 경우
			String message = " 로그인 후 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		
		}
		else {
		
			// 글쓰기 버튼을 클릭했을 경우
			
			//String cda = (String)session.getAttribute("pk_pro_num");
			//System.out.println(" 제발 가져와 : " + cda);
			
			String fk_pnum = request.getParameter("fk_pnum"); // 제품번호를 받아온다.
			System.out.println(" 제발 가져와 : " + fk_pnum);
			
			
			String userid = loginuser.getUserid();
			String title = request.getParameter("reviewBoardTitle");
			String writer = request.getParameter("reviewBoardWriter");
			String grade = request.getParameter("grade");
			String content = request.getParameter("reviewBoardContent");
			String passwd = request.getParameter("reviewBoardPasswd");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("fk_pnum", fk_pnum);
			paraMap.put("title", title);
			paraMap.put("writer", writer);
			paraMap.put("grade", grade);
			paraMap.put("content", content);
			paraMap.put("passwd", passwd);
			
			String message = "";
			String loc = "";
			
			try {
				InterBoardDAO bdao = new BoardDAO();
				int n = bdao.writeRevBoard(paraMap);
				
				if(n==1) {
					message = "글쓰기 성공!!!";
					loc =  request.getContextPath()+"/board/reviewBoard.book";// 리뷰게시판목록페이지로 이등
				}
				
			} catch(SQLException e) {
				message = "SQL구문 에러발생";
                loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는것.
	            
                e.printStackTrace();
			}
			
			request.setAttribute("message", message);
            request.setAttribute("loc", loc); 
           
            // super.setRedirect(false);  
            super.setViewPage("/WEB-INF/msg.jsp");
		
		} // end of if~else
		
		
		
		
	}

	

}

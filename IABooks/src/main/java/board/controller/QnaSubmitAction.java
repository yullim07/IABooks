package board.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class QnaSubmitAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("되나?");
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 해야 한다. == //
		HttpSession session  = request.getSession();
				
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
		if( loginuser == null   ) {
		
			String message = "로그인한 회원만 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
	//	String userid = request.getParameter("userid");
		
	//	HttpSession session = request.getSession();
		
		else {
			
		
			// 글쓰기 버튼을 클릭했을 경우
			String userid = loginuser.getUserid();
			String subject = request.getParameter("qnaSubject");
			String content = request.getParameter("qnaContent");
			String passwd = request.getParameter("qnaPasswd");
			String issecret = request.getParameter("qnaIssecret");
			
			
			
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("subject",subject);
			
			paraMap.put("content", content);
			paraMap.put("passwd", passwd);
			paraMap.put("issecret", issecret);
			
			
			String message = "";
			String loc = "";
			
			try {
				InterBoardDAO bdao = new BoardDAO();
				int n = bdao.writeQnaBoard(paraMap);
				
				
				if(n==1) {
					message = "글쓰기 성공!!!";
					loc =  request.getContextPath()+"/board/qnaBoard.book";// qna목록페이지로 이동
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
			
			
		 } // end of if~-----------------
		
			
			
		
	}

}

package board.controller;

import java.sql.SQLException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAO;
import board.model.FaqBoardVO;
import board.model.InterBoardDAO;
import board.model.ReviewBoardVO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class ReviewUpdateEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 해야 한다. == //
		HttpSession session  = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String method = request.getMethod();
		
		String message = "";
		String loc = "";
		
		if("POST".equalsIgnoreCase(method) ) {
			// *** POST 방식으로 넘어온 것 이라면 *** //
			
			InterBoardDAO bdao = new BoardDAO();
			ReviewBoardVO revVO = new ReviewBoardVO();
			
			String pk_rnum = request.getParameter("pk_rnum");
			// System.out.println("좀 가져와봐 : " + pk_rnum);
			String userid = loginuser.getUserid();
			String title = request.getParameter("revBoardTitle");
			String writer = request.getParameter("revBoardWriter");
			String content = request.getParameter("faqBoardContent");
			
			// System.out.println(" 받아온 번호 : " + pk_rnum);
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("pk_rnum", pk_rnum);
			paraMap.put("userid", userid);
			paraMap.put("title", title);
			paraMap.put("writer", writer);
			paraMap.put("content", content);
			
			try {
				int n = bdao.UpdateReviewBoard(paraMap);
				
				if(n==1) {
					revVO.setPk_rnum(Integer.parseInt(paraMap.get("pk_rnum")));
					revVO.setFk_userid(userid);
					revVO.setRe_title(title);
					revVO.setRe_contents(content);
					revVO.setRe_writer(writer);
					
					message = "글 수정하기 성공!!!";
					loc = request.getContextPath()+"/board/reviewBoard.book";// 리뷰게시판 목록페이지로 이등
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
			
		}
	}

}

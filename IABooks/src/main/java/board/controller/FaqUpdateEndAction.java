package board.controller;

import java.sql.SQLException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAO;
import board.model.FaqBoardVO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class FaqUpdateEndAction extends AbstractController {

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
			FaqBoardVO faqVO = new FaqBoardVO();
			
			String pk_faq_board_num = request.getParameter("pk_faq_board_num");
			System.out.println("좀 가져와봐 : " + pk_faq_board_num);
			String userid = loginuser.getUserid();
			String title = request.getParameter("faqBoardTitle");
			String writer = request.getParameter("faqBoardWriter");
			String content = request.getParameter("faqBoardContent");
			String category = request.getParameter("faqBoardCate");
			
			System.out.println(" 받아온 번호 : " + pk_faq_board_num);
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("pk_faq_board_num", pk_faq_board_num);
			paraMap.put("userid", userid);
			paraMap.put("title", title);
			paraMap.put("writer", writer);
			paraMap.put("content", content);
			paraMap.put("category", category);
			
			try {
				int n = bdao.UpdateFaqBoard(paraMap);
				
				if(n==1) {
					faqVO.setPk_faq_board_num(Integer.parseInt(paraMap.get("pk_faq_board_num")));
					faqVO.setFk_faq_c_num(Integer.parseInt(paraMap.get("category")));
					faqVO.setFk_userid(userid);
					faqVO.setFaq_title(title);
					faqVO.setFaq_contents(content);
					faqVO.setFaq_writer(writer);
					
					message = "글쓰기 성공!!!";
					loc = request.getContextPath()+"/board/faqBoard.book";// faq목록페이지로 이등
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

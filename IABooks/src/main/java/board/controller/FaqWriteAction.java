package board.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.*;
import common.controller.AbstractController;

public class FaqWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			// jsp 파일로 보내줘야하기 때문에 forward 사용 => setRedirect(false)
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/faqWrite.jsp");
		}
		else {
			// 글쓰기 버튼을 클릭했을 경우
			String subject = request.getParameter("faqBoardSubject");
			String writer = request.getParameter("faqBoardWriter");
			String content = request.getParameter("faqBoardContent");
			String category = request.getParameter("faqBoardCate");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("subject", subject);
			paraMap.put("writer", writer);
			paraMap.put("content", content);
			paraMap.put("category", category);
			
			String message = "";
			String loc = "";
			
			try {
				InterBoardDAO bdao = new BoardDAO();
				int n = bdao.writeFaqBoard(paraMap);
				
				if(n==1) {
					message = "글쓰기 성공!!!";
					loc =  request.getContextPath()+"/board/faqWriteSuccess.jsp";// 가입성공페이지로 이등
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
			
			
		 } // end of if-----------------
		
		
			
		
		
	}

}

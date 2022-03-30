package board.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.BoardDAO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;

public class QnaWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		System.out.println("method : " + method);
		
		
		if("GET".equalsIgnoreCase(method)) {
			// jsp 파일로 보내줘야하기 때문에 forward 사용 => setRedirect(false)
			// super.setRedirect(false);
			// 페이지 이동을 시킨다.
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/qnaWrite_2.jsp");
		}
		else {
			// 글쓰기 버튼을 클릭했을 경우
			String subject = request.getParameter("qnaBoardSubject");
			String writer = request.getParameter("qnaBoardWriter");
			String content = request.getParameter("qnaBoardContent");
			String passwd = request.getParameter("qnaBoardPasswd");
			String issecret = request.getParameter("qnaBoardIssecret");
			
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("subject", subject);
			paraMap.put("writer", writer);
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
					loc =  request.getContextPath()+"/board/qnaWriteSuccess.jsp";// 가입성공페이지로 이등
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

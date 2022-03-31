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

public class QnaWriteEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		System.out.println("ㅇㄴㄹmethod : " + method);
		
		
	//	String userid = request.getParameter("userid");
		
	//	HttpSession session = request.getSession();
		
		if("get".equalsIgnoreCase(method)||"post".equalsIgnoreCase(method)) {
			// jsp 파일로 보내줘야하기 때문에 forward 사용 => setRedirect(false)
			// super.setRedirect(false);
			// 페이지 이동을 시킨다.
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/qnaWrite_2.jsp");
		
			// 글쓰기 버튼을 클릭했을 경우
			String qnaBoarduserid = request.getParameter("qnaBoarduserid");
			String qnaBoardSubject = request.getParameter("qnaBoardSubject");
			String qnaBoardContent = request.getParameter("qnaBoardContent");
			String qnaBoardPasswd = request.getParameter("qnaBoardPasswd");
			String qnaBoardIssecret = request.getParameter("qnaBoardIssecret");
			
			
			
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("qnaBoarduserid", qnaBoarduserid);
			paraMap.put("qnaBoardSubject",qnaBoardSubject);
			
			paraMap.put("qnaBoardContent", qnaBoardContent);
			paraMap.put("qnaBoardPasswd", qnaBoardPasswd);
			paraMap.put("qnaBoardIssecret", qnaBoardIssecret);
			
			
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
               
           
		}
		else { 
			String message = "비정상적인 경로를 통해 들어왔습니다.!!";
			String loc = "javascript:history.back()";
			
               request.setAttribute("message", message);
               request.setAttribute("loc", loc); 
              
               // super.setRedirect(false);  
               super.setViewPage("/WEB-INF/msg.jsp");
			
			
		 } // end of if-----------------
		
			
			
		
	}

}

package board.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.ResponseWrapper;

import org.json.JSONArray;
import org.json.JSONObject;



import board.model.BoardDAO;
import board.model.CommentVO;
import board.model.InterBoardDAO;
import board.model.QnABoardVO;
import common.controller.AbstractController;
import member.model.MemberVO;


public class CommentSubmitAction extends AbstractController {

	
	
	

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(super.checkLogin(request)) {//로그인했으면 true
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {//포스트 방식이라며는 
				InterBoardDAO bdao = new BoardDAO();
				
				String fk_userid = loginuser.getUserid(); 
				String cmtContent  = request.getParameter("commenttext"); 
				String cmtPasswd =request.getParameter("comment_pwd"); 
				/* String cmtWriter =request.getParameter("cmtWriter"); */
				String fk_qna_num = (String) request.getParameter("pk_qna_num");
				  
				  

				
				CommentVO cVO = new CommentVO();
					  
				/* Map<String, String> paraMap = new HashMap<>(); */
					  

				cVO.setFk_userid(fk_userid);
				cVO.setCmt_contents(cmtContent);
				cVO.setCmt_passwd(cmtPasswd);
				cVO.setFk_qna_num(Integer.parseInt(fk_qna_num));
					  

				String message = "";
				String loc = "";
					  
						
				try {
					
					int n = bdao.writeCmtBoard(cVO);
					
					JSONObject jsonObj = new JSONObject(); 
					jsonObj.put("n", n);
					jsonObj.put("fk_userid", fk_userid);
					jsonObj.put("cmtContent", cmtContent);
					jsonObj.put("cmtPasswd", cmtPasswd);
					jsonObj.put("fk_qna_num", fk_qna_num); 
	
					String json = jsonObj.toString();
					
					request.setAttribute("json", json);
					
					message = "글쓰기 성공!!!";
				//	loc =  request.getContextPath()+"/board/qnaBoard.book";// qna목록페이지로 이동
				//	response.getWriter().append("success"); // c페이지로 이동 
					super.setViewPage("/WEB-INF/jsonview.jsp"); 
						
				} catch(SQLException e) {
					e.printStackTrace();
					
					message = "SQL구문 에러발생";
					loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는것.
				}
					
				    
			}else {
				String message = "비정상적인 경로로 들어왔습니다";
				//String loc = "javascript:history.back()";
   
				request.setAttribute("message", message);
				//request.setAttribute("loc", loc);
   
				//super.setRedirect(false);   
				super.setViewPage("/WEB-INF/jsonMsg.jsp");
				return;
			}
			
		}else {//비로그인으로 댓글 추가할경우
			String message = "댓글작성은 로그인하신후 이용가능합니다.";
			//String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			//request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonMsg.jsp");
			
		}
		
		
}	
}


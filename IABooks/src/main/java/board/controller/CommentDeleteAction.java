package board.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import board.model.BoardDAO;
import board.model.CommentVO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class CommentDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(super.checkLogin(request)) {//로그인했으면 true
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {//포스트 방식이라며는 
				InterBoardDAO bdao = new BoardDAO();
			
				
				
		
				String pk_cmt_num = (String)request.getParameter("pk_cmt_num");
				
				CommentVO cVO = new CommentVO();
				
				cVO.setPk_cmt_num(Integer.parseInt(pk_cmt_num));
				
				
				//cVO = bdao.getCmtContent(pk_cmt_num);
		
		
				System.out.println("pk_cmt_num: "+pk_cmt_num);
				String message = "";
				String loc = "";
		
		
			
				//request.setAttribute("cVO", cVO);
				
				try {
					int n = bdao.deleteComment(cVO);
					
					JSONObject jsonObj = new JSONObject(); 
					jsonObj.put("n", n);
					jsonObj.put("pk_qna_num", cVO.getPk_cmt_num());
					
					String json = jsonObj.toString();
					
					request.setAttribute("json", json);
					
					
					 if(n==1) { 
						 message = "삭제가 성공하였습니다!"; 
						// loc =request.getContextPath()+"/board/commentList.book"; //qna 목록페이지로 이동 }
						 super.setViewPage("/WEB-INF/jsonview.jsp"); 
					 }
					 
					 
					
					
						
							
				}catch(SQLException e) {
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
		}else{
			// 수정권한 x (본인이나 관리자가 아니다)
			String message = "삭제권한이 없습니다.";
			//loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			//request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
}
}

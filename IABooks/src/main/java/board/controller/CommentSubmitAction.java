package board.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAO;
import board.model.InterBoardDAO;
import board.model.QnABoardVO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class CommentSubmitAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session  = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		System.out.println("ㅇㄴㅇㄹ?");
		// 확인 버튼을 클릭했을 경우
			String userid = loginuser.getUserid();
			String cmtContent = request.getParameter("commnet_content");
			String cmtPasswd = request.getParameter("comment_pwd");
			String cmtWriter = request.getParameter("cmtWriter");
			String pk_qna_num = (String) request.getParameter("pk_qna_num");
			
			System.out.println("와이?");
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			
			paraMap.put("cmtContent", cmtContent);
			paraMap.put("cmtPasswd", cmtPasswd);
			paraMap.put("cmtWriter", cmtWriter);
			paraMap.put("pk_qna_num", pk_qna_num);
			
			String message = "";
			String loc = "";
			
			try {
				InterBoardDAO bdao = new BoardDAO();
				int n = bdao.writeCmtBoard(paraMap);
				
				
				if(n==1) {
					message = "글쓰기 성공!!!";
					loc =  request.getContextPath()+"/board/qnaDetail.book"; // c페이지로 이동
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

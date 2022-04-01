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

public class QnaUpdateEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 해야 한다. == //
		HttpSession session  = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		

		String method = request.getMethod();

		String message = "";
		String loc = "";
		
		if("POST".equalsIgnoreCase(method) ) {
			// *** POST 방식으로 넘어온 것 이라면 *** //
			
			InterBoardDAO bdao = new BoardDAO();
			QnABoardVO qnaVO = new QnABoardVO();
			
			String pk_qna_num = request.getParameter("pk_qna_num");
			System.out.println("좀 가져와봐 : " + pk_qna_num);
			String userid = loginuser.getUserid();
			String title = request.getParameter("qnaSubject");
			String content = request.getParameter("qnaContent");
			String issecret = request.getParameter("qnaIssecret");
			
			System.out.println(" 받아온 번호 : " + pk_qna_num);
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("pk_qna_num", pk_qna_num);
			paraMap.put("userid", userid);
			paraMap.put("title", title);
			paraMap.put("content", content);
			paraMap.put("issecret", issecret);
			
			try {
				int n = bdao.UpdateQnaBoard(paraMap);
				
				if(n==1) {
					qnaVO.setPk_qna_num(Integer.parseInt(paraMap.get("pk_qna_num")));
					qnaVO.setFk_userid(userid);
					qnaVO.setQna_title(title);
					qnaVO.setQna_contents(content);
					qnaVO.setQna_issecret(Integer.parseInt(paraMap.get("issecret")));
					
					message = "글 수정하기 성공!!!";
					loc = request.getContextPath()+"/board/qnaBoard.book";// qna목록페이지로 이등
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

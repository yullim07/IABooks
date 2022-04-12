package board.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.model.BoardDAO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class QnaSubmitAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("제품에서 글쓰기?");
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 해야 한다. == //
		HttpSession session  = request.getSession();
				
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String method = request.getMethod();
		System.out.println("메소드는?"+method);
		
		if( loginuser == null  ) {
		
			String message = "로그인한 회원만 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
	//	String userid = request.getParameter("userid");
		
	//	HttpSession session = request.getSession();
		
		else {// 로그인 했을 경우
			//** 폼태그에 넣어주는 파일첨부 때문에 post값이어야 한다.  제품등록 버튼을 누르는 순간부터는 post만 !
		
			MultipartRequest mtrequest = null;
			
			// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다.
			ServletContext svlCtx = session.getServletContext();
			String uploadFileDir = svlCtx.getRealPath("/images");
			System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> " + uploadFileDir);
			
			

			// === 파일을 업로드 해준다. 시작 === //
			try {
				mtrequest = new MultipartRequest( request, uploadFileDir, 10*1024*1024 ,  "UTF-8",  new DefaultFileRenamePolicy() );
				//IOException
			}catch(IOException e) {
				e.printStackTrace();
				
				request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
	            request.setAttribute("loc", request.getContextPath()+"/product/qnaSubmit.book"); 
	              
	            super.setViewPage("/WEB-INF/msg.jsp");
	            return; // 종료
			}
			
			// === 파일을 업로드 해준다. 끝 === //
			
			
			// 글쓰기 버튼을 클릭했을 경우
			String fk_pnum = request.getParameter("pk_pro_num"); // 제품번호를 받아온다.
			System.out.println(" @@제발 가져와 : " + fk_pnum);
			
			String userid = loginuser.getUserid();
			String subject = mtrequest.getParameter("qnaSubject");
			
			String content = mtrequest.getParameter("qnaContent");
			content = content.replaceAll("<", "&lt;");		
			content = content.replaceAll(">", "&gt;");
			content = content.replaceAll("\r\n", "<br>");
			
			String passwd = mtrequest.getParameter("qnaPasswd");
			String issecret = mtrequest.getParameter("qnaIssecret");
			
			
			String  qna_file1 = mtrequest.getFilesystemName("qna_file1");
			// qna_file1는 보여만 주지 파일을 다운받을 일은 없다.
			//그래서 오리진이 필요없다.
			
			String qna_file1_systemFileName = mtrequest.getFilesystemName("qna_file1");
			
			String qna_file1_originFileName = mtrequest.getOriginalFileName("qna_file1");
			
			
			
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("subject",subject);
			paraMap.put("fk_pnum", fk_pnum);
			paraMap.put("content", content);
			paraMap.put("passwd", passwd);
			paraMap.put("issecret", issecret);
			paraMap.put("qna_file1", qna_file1);
			paraMap.put("qna_file1_originFileName",qna_file1_originFileName);
			paraMap.put("qna_file1_systemFileName", qna_file1_systemFileName);
			
			
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

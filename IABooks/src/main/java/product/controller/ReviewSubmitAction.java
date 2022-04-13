package product.controller;

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

public class ReviewSubmitAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// == 관리자(admin)로 로그인 했을 때만 접근이 가능하도록 해야 한다. == //
		HttpSession session  = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		

		if( loginuser == null ) {
			// 로그인을 안했거나 일반사용자로 로그인 한 경우
			String message = " 로그인 후 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		
		}
		else {
			
			MultipartRequest mtrequest = null;
			
			// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다.
			ServletContext svlCtx = session.getServletContext();
			String uploadFileDir = svlCtx.getRealPath("/images");
			//	System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 uploadFileDir ==> " + uploadFileDir);
			
			// === 파일을 업로드 해준다. 시작 === //
			try {
				mtrequest = new MultipartRequest( request, uploadFileDir, 10*1024*1024 ,  "UTF-8",  new DefaultFileRenamePolicy() );
				//IOException
			}catch(IOException e) {
				e.printStackTrace();
				
				request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
	            request.setAttribute("loc", request.getContextPath()+"/product/reviewSubmit.book"); 
	              
	            super.setViewPage("/WEB-INF/msg.jsp");
	            return; // 종료
			}
			// === 파일을 업로드 해준다. 끝 === //
			
			// 글쓰기 버튼을 클릭했을 경우
			
			//String cda = (String)session.getAttribute("pk_pro_num");
			//System.out.println(" 제발 가져와 : " + cda);
			
			String fk_pnum = mtrequest.getParameter("pk_pro_num"); // 제품번호를 받아온다.
			// System.out.println(" 제발 가져와 : " + fk_pnum);
			
			
			String userid = loginuser.getUserid();
			String title = mtrequest.getParameter("reviewBoardTitle");
			String writer = mtrequest.getParameter("reviewBoardWriter");
			String grade = mtrequest.getParameter("grade");
			String content = mtrequest.getParameter("reviewBoardContent");
			/*
			content = content.replaceAll("<", "&lt;");		
			content = content.replaceAll(">", "&gt;");
			content = content.replaceAll("\r\n", "<br>");
			*/
			String passwd = mtrequest.getParameter("reviewBoardPasswd");
			
			String rev_file_system_name = mtrequest.getFilesystemName("rev_file");
			String rev_file_original_name = mtrequest.getOriginalFileName("rev_file");
			
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("fk_pnum", fk_pnum);
			paraMap.put("title", title);
			paraMap.put("writer", writer);
			paraMap.put("grade", grade);
			paraMap.put("content", content);
			paraMap.put("passwd", passwd);
			paraMap.put("rev_file_system_name", rev_file_system_name);
			paraMap.put("rev_file_original_name", rev_file_original_name);
			
			String message = "";
			String loc = "";
			
			try {
				InterBoardDAO bdao = new BoardDAO();
				int n = bdao.writeRevBoard(paraMap);
				
				if(n==1) {
					message = "글쓰기 성공!!!";
					loc =  request.getContextPath()+"/board/reviewBoard.book";// 리뷰게시판목록페이지로 이등
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
		
		} // end of if~else
		
		
		
		
	}

	

}
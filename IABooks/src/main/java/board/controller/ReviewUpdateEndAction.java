package board.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.model.BoardDAO;

import board.model.InterBoardDAO;
import board.model.ReviewBoardVO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class ReviewUpdateEndAction extends AbstractController {

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
			ReviewBoardVO revVO = new ReviewBoardVO();
			
			
			
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
			
			
			String pk_rnum = mtrequest.getParameter("pk_rnum");
			// System.out.println("좀 가져와봐 : " + pk_rnum);
			String userid = loginuser.getUserid();
			String title = mtrequest.getParameter("revBoardTitle");
			String writer = mtrequest.getParameter("revBoardWriter");
			String content = mtrequest.getParameter("faqBoardContent");
			
			String rev_file_system_name = mtrequest.getFilesystemName("rev_file");
			String rev_file_original_name = mtrequest.getOriginalFileName("rev_file");
			
			
			// System.out.println(" 받아온 번호 : " + pk_rnum);
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("pk_rnum", pk_rnum);
			paraMap.put("userid", userid);
			paraMap.put("title", title);
			paraMap.put("writer", writer);
			paraMap.put("content", content);
			paraMap.put("rev_file_system_name", rev_file_system_name);
			paraMap.put("rev_file_original_name", rev_file_original_name);
			
			try {
				int n = bdao.UpdateReviewBoard(paraMap);
				
				if(n==1) {
					revVO.setPk_rnum(Integer.parseInt(paraMap.get("pk_rnum")));
					revVO.setFk_userid(userid);
					revVO.setRe_title(title);
					revVO.setRe_contents(content);
					revVO.setRe_writer(writer);
					
					message = "글 수정하기 성공!!!";
					loc = request.getContextPath()+"/board/reviewBoard.book";// 리뷰게시판 목록페이지로 이등
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

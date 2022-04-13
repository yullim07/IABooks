package board.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import board.model.TestBoardDAO;
import board.model.TestInterBoardDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class AdminBoardDisplaySelectAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) { //로그인했으면 true
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {//포스트 방식이라며는 
				HttpSession session = request.getSession();;
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	
				TestInterBoardDAO tbdao = new TestBoardDAO();
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("userid", loginuser.getUserid());
				
				int qnaCnt = Integer.parseInt( request.getParameter("qnaCnt"));
				String qnaNoStr = request.getParameter("qnaNoStr");
				String [] qnaStrArray = qnaNoStr.split(",");
				
				int revCnt = Integer.parseInt( request.getParameter("revCnt"));
				String revNoStr = request.getParameter("revNoStr");
				String [] revStrArray = revNoStr.split(",");
				
				int	n = 0;
				int m = 0;
				int result = 0;
				
				// 받아온 pk값으로 리뷰게시판 게시글 게시상태 변경
	            for(int i=0; i<revCnt; i++) {
	                String pk_rnum = (String)revStrArray[i];
	                paraMap.put("pk_rnum", pk_rnum);
	                m = tbdao.revDisplaySelect(paraMap);
	            }
				
				// 받아온 pk값으로 qna게시판 게시상태 변경
	            for(int i=0; i<qnaCnt; i++) {
	                String pk_qna_num = (String)qnaStrArray[i];
	                paraMap.put("pk_qna_num", pk_qna_num);
	                n = tbdao.qnaDisplaySelect(paraMap);
	            }
	            
	            if( "".equalsIgnoreCase(qnaNoStr) && !"".equalsIgnoreCase(revNoStr)) {
	            	// 상품문의 게시판글은 선택하지 않고, 리뷰게시판 글만 선택하였을 경우
	            	if( m == 1) {
	            		// 리뷰게시판 게시상태가 변경 되었다면
	            		result = 1;
	            	}
	            }
	            else if( !"".equalsIgnoreCase(qnaNoStr) && "".equalsIgnoreCase(revNoStr)) {
	            	// 상품문의 게시판글만  선택하였고, 리뷰게시판 글은 선택하지 않은 경우
	            	if( n == 1) {
	            		// 상품문의게시판 게시상태가 변경 되었다면
	            		result = 1;
	            	}
	            }
	            else if( n == 1 && m == 1) {
	            	// 두 게시판 모두 선택하였고 게시상태가 변경 되었다면
	            	result = 1;
	            }
	            
				JSONObject jsonObj = new JSONObject(); 
				jsonObj.put("adminBoardDisplaySelect", result); 
				String json = jsonObj.toString();
				
				request.setAttribute("json", json);
				super.setViewPage("/WEB-INF/jsonview.jsp");
				
			}else {
				String message = "비정상적인 경로로 들어왔습니다";
				//String loc = "javascript:history.back()";
   
				request.setAttribute("message", message);
				//request.setAttribute("loc", loc);
   
				//super.setRedirect(false);   
				super.setViewPage("/WEB-INF/jsonMsg.jsp");
			}
			
		}else {//비로그인으로 관심상품 접근할 경우
			String message = "관심상품은 로그인하신후 이용가능합니다.";
			//String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			//request.setAttribute("loc", loc);
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonMsg.jsp");
			
		}
		
	}

}

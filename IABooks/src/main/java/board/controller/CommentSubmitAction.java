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
		System.out.println("ㅇㄴㅇㄹ?");

		 
		 // 확인 버튼을 클릭했을 경우 
		if( loginuser == null) {
			String message = "관리자만 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		else {
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {
			
		//	InterBoardDAO bdao = new BoardDAO();
			
			  String fk_userid = loginuser.getUserid(); 
			  String cmtContent  = request.getParameter("commenttext"); 
			  String cmtPasswd =request.getParameter("comment_pwd"); 
				/* String cmtWriter =request.getParameter("cmtWriter"); */
			  String fk_qna_num = (String) request.getParameter("pk_qna_num");
			  
			  System.out.println("와이?");
			  
			  
				InterBoardDAO bdao = new BoardDAO();
				  CommentVO cmtVO = new CommentVO();
				  
					/* Map<String, String> paraMap = new HashMap<>(); */
				  
				  
				  
				  cmtVO.setFk_userid(fk_userid);
				  cmtVO.setCmt_contents(cmtContent);
				  cmtVO.setCmt_passwd(cmtPasswd);
				  cmtVO.setFk_qna_num(Integer.parseInt(fk_qna_num));
				  
				  
				  
				  String message = "";
				  String loc = "";
				  
				  
					
					try {
						
						 bdao.writeCmtBoard(cmtVO);
						
						
						
							message = "글쓰기 성공!!!";
						//	loc =  request.getContextPath()+"/board/qnaBoard.book";// qna목록페이지로 이동
							response.getWriter().append("success"); // c페이지로 이동 
							super.setViewPage("/WEB-INF/board/qnaDetail.jsp"); 
						
						
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
			else {
				// GET 방식이라면
				
				  String message = "비정상적인 경로로 들어왔습니다";
	              String loc = "javascript:history.back()";
	               
	              request.setAttribute("message", message);
	              request.setAttribute("loc", loc);
	              
	          //  super.setRedirect(false);   
	              super.setViewPage("/WEB-INF/msg.jsp");
			}        
				
		}
		 
		
		  
	
		  
		  
		  
            
            ////////////////
            
            
          
            
            
            
            
            
            
            
            
            
            //결과물이 복수개이니 jsonArray 가 필요하다.
		  /*
		  JSONArray jsonArr = new JSONArray(); // []
		  
		  if( cmtList.size() > 0 ) {
		  
		  for( CommentVO cvo : cmtList ) {
		  
		  JSONObject jsonObj = new JSONObject(); 
		  // {} {} {} {} {} {} {} {} 
		  // {} {} {} {} {} {} {} {} 
		  // {} {} {} {} {} {} {} {} 
		  // {} {} {} {} {} {} {} {} 
		  // {} {} {} {} 
		  
		  jsonObj.put("pnum", pvo.getPnum()); 
		  jsonObj.put("pname",pvo.getPname()); 
		  jsonObj.put("code", pvo.getCategvo().getCode());
		  jsonObj.put("pcompany", pvo.getPcompany()); 
		  jsonObj.put("pimage1",pvo.getPimage1()); 
		  jsonObj.put("pimage2", pvo.getPimage2());
		  
		  jsonObj.put("pqty", pvo.getPqty()); 
		  jsonObj.put("price", pvo.getPrice());
		  jsonObj.put("saleprice", pvo.getSaleprice()); 
		  jsonObj.put("snum",pvo.getSpvo().getSname()); //Spvo 의 sname 
		  jsonObj.put("pcontent",pvo.getPcontent()); 
		  jsonObj.put("point", pvo.getPoint());
		  jsonObj.put("pinputdate", pvo.getPinputdate());
		  jsonObj.put("discountPercente", pvo.getDiscountPercent());
		  
		  // jsonObj ==> {"pnum":1, "pname":"스마트TV", "code":"100000","pcompany":"삼성",....... "pinputdate":"2021-04-23", "discoutPercent": 15} //
		  jsonObj ==> {"pnum":2, "pname":"노트북", "code":"100000",
		  "pcompany":"엘지",....... "pinputdate":"2021-04-23", "discoutPercent": 10}
		  
		  jsonArr.put(jsonObj); //json object에 담아온다. /* [ {"pnum":1, "pname":"스마트TV",
		  "code":"100000", "pcompany":"삼성",....... "pinputdate":"2021-04-23",
		  "discoutPercent":15} ,{"pnum":2, "pname":"노트북", "code":"100000",
		  "pcompany":"엘지",....... "pinputdate":"2021-04-23", "discoutPercent":10}
		  ,{....} ,{....} , ..... ,{....} ]
		  
		  }//end of for------
		  
		  String json = jsonArr.toString(); // 문자열로 변환
		  
		  
		  System.out.println(); String message = ""; String loc = "";
		  */
		  
		  
		  /*
		 int result=dao.insert(vo);
		 System.out.println(result); 
		 if(result==1) {
		  response.getWriter().append("success"); }
		  
		  
		  
		  
		  
		  
		  
		  try { 
			  InterBoardDAO bdao = new BoardDAO(); 
			  int n =bdao.writeCmtBoard(paraMap);
		  
		  
		  if(n==1) {
			  message = "글쓰기 성공!!!"; 
			  response.getWriter().append("success"); // c페이지로 이동 
			  super.setViewPage("/WEB-INF/board/comment.jsp"); }
		  
		  } catch(SQLException e) { 
			  message = "SQL구문 에러발생"; 
			  loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는것.
		  
			  e.printStackTrace(); 
		  }
		  
		  request.setAttribute("message", message); request.setAttribute("loc", loc);
		  
		  // super.setRedirect(false); super.setViewPage("/WEB-INF/msg.jsp");
		 */
	}

}

package board.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import board.model.BoardDAO;
import board.model.CommentVO;
import board.model.InterBoardDAO;
import board.model.QnABoardVO;
import common.controller.AbstractController;
import member.model.MemberVO;


public class CommentListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		 
		HttpSession session  = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String fk_qna_num = request.getParameter("fk_qna_num"); 
	//	System.out.println("말해봐"+ fk_qna_num);
		InterBoardDAO bdao = new BoardDAO();
	 
		List<CommentVO> cmtList = bdao.readCmtContent(fk_qna_num);
		
		JSONArray jsonArr = new JSONArray();
		
		if( cmtList.size() > 0) {
			
			for(CommentVO cmtVO : cmtList) {
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("pk_cmt_num", cmtVO.getPk_cmt_num());
				jsonObj.put("fk_userid", cmtVO.getFk_userid());
				jsonObj.put("cmt_contents", cmtVO.getCmt_contents());
				jsonObj.put("cmt_passwd", cmtVO.getCmt_passwd());
				jsonObj.put("cmt_date", cmtVO.getCmt_date());
				jsonObj.put("fk_qna_num", cmtVO.getFk_qna_num());
				
				jsonArr.put(jsonObj);
				
			}//end of for------
			
			String json = jsonArr.toString(); // 문자열로 변환
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
		else {
			//DB에서 조회된 것이 없다라면
			
			String json = jsonArr.toString();
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
		
	}

}

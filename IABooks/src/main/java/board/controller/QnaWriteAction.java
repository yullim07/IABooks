package board.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;

public class QnaWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	//	String userid = request.getParameter("userid");
		
	//	HttpSession session = request.getSession();
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		System.out.println("method : " + method);
		System.out.println("뜨니?" + method);
		if("GET".equalsIgnoreCase(method)) {
			
			// 페이지 이동을 시킨다.
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/qnaWrite_2.jsp");
		}

		
			
			
		
	}

}

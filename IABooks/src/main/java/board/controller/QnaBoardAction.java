package board.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.*;
import common.controller.AbstractController;
import member.model.*;

public class QnaBoardAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod(); // "GET" 또는 "POST"
		System.out.println("method : " + method);
		
		
			// 페이지 이동을 시킨다.
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/qnaBoard.jsp");
		
			
		
		
		//페이징처리
			HttpSession session = request.getSession();
			
			MemberVO userid = (MemberVO) session.getAttribute("loginuser");//세션에 가서 있는지 없는지 알아온다.
			
			
			
			InterBoardDAO bdao = new BoardDAO();
			
			
			//db에 뭔가 실어서 보낸다 Map으로
		
		Map<String, String> paraMap = new HashMap<>();
		
		String currentShowPageNo =  request.getParameter("currentShowPageNo"); // 현재 내가 보고자 하는 페이지가 무엇입니까
		// currentShowPageNo 은 사용자가 보고자 하는 페이지바의 페이지번호이다.
		// 메뉴에서 회원목록 만을 클릭했을 경우에는 몇페이지 보겠다는 클릭이 없으므로 currentShowPageNo 은 null 이 된다.
		// currentShowPageNo 이 null 이라면 currentShowPageNo 을 1 페이지로 바꾸어야 한다.
		
		String sizePerPage =  request.getParameter("sizePerPage");
		// 한 페이지당 화면상에 보여줄 회원의 개수
		// 메뉴에서 회원목록 만을 클릭했을 경우에는 sizePerPage 은 null 이 된다.
		// sizePerPage 가 null 이라면 sizePerPage 를 10 으로 바꾸어야 한다.
		// "10" 또는 "5" 또는 "3"
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		if( sizePerPage == null ||
			!("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage))  ) {
			sizePerPage = "10";
		}
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
        //     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== //
		
		try{  //장난쳐도 막는거야
			Integer.parseInt(currentShowPageNo); // NumberFormatException 
		}catch(NumberFormatException e) {
			//유저가 get방식에 문자입력하는  장난 치는 경우에도 , int 범위를 초과한 숫자를 입력한 경우에도
			currentShowPageNo = "1";
		}
		
		
		
		
		paraMap.put("currentShowPageNo", currentShowPageNo); //위에서 예외처리 다 해줌
		paraMap.put("sizePerPage", sizePerPage); 
		
		
		List<QnABoardVO> qnaboardList = bdao.selectPagingQnaBoard(paraMap); //메소드를 만든다  // 리턴타입이 MemberVO 가 복수개
		
		request.setAttribute("qnaboardList", qnaboardList);
			
		

	}

}

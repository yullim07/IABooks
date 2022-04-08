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

        
      
      
      //페이징처리
      HttpSession session = request.getSession();
      
      MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
      
      
   //   int qna_issecret  = Integer.parseInt(request.getParameter("issecret"));
      
      
     
      
      
      //검색이 있을 경우 시작 //
      // 검색조건이 있을 경우 시작
   		
  
		String searchContent = request.getParameter("searchContent"); 
		String searchWord = request.getParameter("searchWord");
		//검색이 있을 경우 끝 //
      
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
      if( sizePerPage == null || !(  "10".equals(sizePerPage))  ) {
         sizePerPage = "10";
      }
     
      
      try{  //장난쳐도 막는거야
         Integer.parseInt(currentShowPageNo); // NumberFormatException 
      }catch(NumberFormatException e) {
         //유저가 get방식에 문자입력하는  장난 치는 경우에도 , int 범위를 초과한 숫자를 입력한 경우에도
         currentShowPageNo = "1";
         System.out.println("오류");
      }
      
      paraMap.put("sizePerPage", sizePerPage);
      //== 검색이 있을 경우 시작 == //
      
      if( searchContent != null && !"".equals(searchContent) && !"qna_title".equals(searchContent) 
          && !"qna_contents".equals(searchContent)
    	  && !"mname".equals(searchContent) 
    	  && !"fk_userid".equals(searchContent)
    		  ) { //select 의 value
			
    	  // 사용자가 웹브라우저 주소입력란에서 장난친 경우
			String message = "부적절한 검색 입니다. 장난치지 마세요~~";
			String loc = request.getContextPath()+"/board/qnaBoard.book";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return; //execute() 메소드를 종료시킨다.
			
		}
      
      
      
      
      
      
      paraMap.put("searchContent", searchContent);
      paraMap.put("searchWord", searchWord);
      //== 검색이 있을 경우 끝 == //
      
      
 //// 여기로 옮겨옴			
 			
      // 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 리뷰게시글에 대한 페이지 알아오기
      int totalPage = bdao.getTotalqnaPage(paraMap);
      System.out.println("~~~확인용 totalPage => " + totalPage);
      // ~~~확인용 totalPage => 21
      
      
      // === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 토탈페이지수 보다 큰 값을 입력하여
      //     장난친 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== //
		
      if( Integer.parseInt(currentShowPageNo) > totalPage ) {
    	  currentShowPageNo = "1"; //너무 큰 값도 1페이지로 가게 한다. 
		
      }
      
      paraMap.put("currentShowPageNo", currentShowPageNo); //위에서 예외처리 다 해줌
      
      
      List<QnABoardVO> qnaboardList = bdao.selectPagingQnaBoard(paraMap); //메소드를 만든다  // 리턴타입이 MemberVO 가 복수개
      
      request.setAttribute("qnaboardList", qnaboardList);
      request.setAttribute("sizePerPage", sizePerPage);
      
      
      // *** ======== 페이지바 만들기 시작 ========= *** //
      String pageBar = "";
      
      int blockSize = 10;
      // blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
      
      int loop = 1;
      // loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(blockSize 지금은 10개) 까지만 증가하는 용도이다.
      
      // !!! 다음은 pageNo를 구하는 공식이다. !!! //
      
      
      int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1 )/blockSize ) * blockSize + 1;
      // pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
      
      
		if(searchContent == null) {
			searchContent = "";
		}
		if(searchWord == null) {
			searchWord = "";
		}
		
      
   // **** [맨처음][이전] 만들기 **** //
   		if(pageNo != 1) {
   		// if(Integer.parseInt(currentShowPageNo) >= 2) {
   			pageBar += "<li class='page-item'><a class='page-link' href='qnaBoard.book?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchContent="+searchContent+"&searchWord="+searchWord+"'>&lt;&lt;</a></li>";
   			pageBar += "<li class='page-item'><a class='page-link' href='qnaBoard.book?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchContent="+searchContent+"&searchWord="+searchWord+"'>&lt;</a></li>";
   		}
   		
   		while( !(loop > blockSize || pageNo > totalPage) ) {
   			// 루프가 블락사이즈(3,5,10)을 넘어가거나 || 페이지번호가 총 페이지수를 넘어가기 전까지 반복
   			if( pageNo == Integer.parseInt(currentShowPageNo) ) {
   				//내가 보고자하는 페이지
   				pageBar += "<li class='page-item active'><a class='page-link' href='#"+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a></li>";
   				// 현재페이지 링크 제거
   			}
   			else {
   				pageBar += "<li class='page-item'><a class='page-link' href='qnaBoard.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchContent="+searchContent+"&searchWord="+searchWord+"'>"+pageNo+"</a></li>";
   			}
   			loop++;
   			pageNo++;
   		} // end of while()--------------------------
   		
   		// *** [다음] [마지막] 만들기 *** //
   		// pageNo ==> 11
   		if(pageNo <= totalPage) {
   			// 마지막 페이지랑 같으면 다음 마지막이 없어져야 됨
   			pageBar += "<li class='page-item'><a class='page-link' href='qnaBoard.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&sizePerPage="+sizePerPage+"&searchContent="+searchContent+"&searchWord="+searchWord+"'>&gt;</a></li>";
   			pageBar += "<li class='page-item'><a class='page-link' href='qnaBoard.book?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&sizePerPage="+sizePerPage+"&searchContent="+searchContent+"&searchWord="+searchWord+"'>&gt;&gt;</a></li>";
   		}
   		
   		request.setAttribute("pageBar", pageBar);
   		
   		// **** ============ 페이지바 만들기 끝 ============ //
      	
   		// 검색결과를 유지하려고 한다(안할시 검색결과 후 페이지 넘기면 검색조건 없는 페이지로 넘어감)
		// if 안쓰는이유 : 위에서 null이면 ""로 바꿔줘서
		request.setAttribute("searchContent", searchContent);
		request.setAttribute("searchWord", searchWord);
		
   		
   		
   		
      //   super.setRedirect(false);
         super.setViewPage("/WEB-INF/board/qnaBoard.jsp");
      

   }

}
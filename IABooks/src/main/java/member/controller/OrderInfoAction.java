package member.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import my.Util.MyUtil;

public class OrderInfoAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      HttpSession session = request.getSession();
      
		// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임.
		super.goBackURL(request);
		// 로그인을 하지 않은 상태에서 특정제품을 조회한 후 "장바구니 담기"나 "바로주문하기" 할때와 "제품후기쓰기" 를 할때 
	    // 로그인 하라는 메시지를 받은 후 로그인 하면 시작페이지로 가는 것이 아니라 방금 조회한 특정제품 페이지로 돌아가기 위한 것임.

      
      if(session.getAttribute("loginuser") == null) {
         
         session.setAttribute("myPageLogin", "myPageLogin");
         
         setRedirect(false);
         setViewPage("/login/join.book");
         
      } else { // 로그인을 한 상태에서 들어왔을 때
      
    	  
      InterMemberDAO mdao = new MemberDAO();
      
      Map<String , Object> paraMap = new HashMap<>();
      
      LocalDate today = LocalDate.now();
      today = today.plusDays(1);
      LocalDate lastMonth_three = today.minusMonths(3);
      
      String method = request.getMethod();
      
      String userid = (String) session.getAttribute("userid");
      String status =  request.getParameter("orderstatus");   // 주문처리상태 select
      String fromDate = request.getParameter("fromDate");
      String toDate = request.getParameter("toDate");
      
      
      
         paraMap.put("today", today);
         paraMap.put("lastMonth_three", lastMonth_three);
         paraMap.put("fromDate", fromDate);
         paraMap.put("toDate", toDate);
         paraMap.put("userid", userid);
         
         
         request.setAttribute("today", today);
         request.setAttribute("lastMonth_three", lastMonth_three);
         request.setAttribute("fromDate", String.valueOf(fromDate));
         request.setAttribute("toDate", String.valueOf(toDate));
         
         
      if( !("1".equals(status) || "2".equals(status) || "3".equals(status) || "4".equals(status) || "5".equals(status) ) )  {
         status = "0";
      }
      
      paraMap.put("status", status);
      
      List<Map<String,String>> orderInfoList =  mdao.orderInfo(paraMap);
      
      request.setAttribute("orderInfoList", orderInfoList);
      
      ////////////////////////////////////////////////////////////////////////////////
      ////////////////////////////////////////////////////////////////////////////////
      // 페이징 처리 //
      
      
      String currentShowPageNo = request.getParameter("currentShowPageNo");
      
      String sizePerPage = "10";
      
      if(currentShowPageNo == null) {
         currentShowPageNo = "1";
      }
      
      try {
         Integer.parseInt(currentShowPageNo);
      } catch(NumberFormatException e) {
         currentShowPageNo = "1";
      }
      
      paraMap.put("sizePerPage", sizePerPage);
      
      int totalPage = mdao.getOrderInfoTotalPage(paraMap);
      
      if( Integer.parseInt(currentShowPageNo) > totalPage ) {
         currentShowPageNo = "1";
      }
      
      paraMap.put("currentShowPageNo", currentShowPageNo);
      
      List<Map<String, String>> orderInfoPageList = mdao.selectPagingOrderInfo(paraMap);
      
      request.setAttribute("orderInfoPageList", orderInfoPageList);
      request.setAttribute("sizePerPage", sizePerPage);
      
      
      String pageBar = "";
      
      int blockSize = 10;
      // blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다. 
      
      int loop = 1;
      // loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(blockSize 지금은 10개) 까지만 증가하는 용도이다. 
      
      // !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //
      int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
      // pageNo 는 페이지바에서 보여지는 첫번째 번호이다. 
      
      
      // **** [맨처음][이전] 만들기 **** //
      
      if( pageNo != 1 ) {
            pageBar += "<li class='page-item pageicon'><a class='page-link' aria-label='Previous' href='orderInfo.book?currentShowPageNo=1&sizePerPage="+sizePerPage+"&orderstatus="+status+"&fromDate="+fromDate+"&toDate="+toDate+"'>[맨처음]</a></li>"; 
            pageBar += "<li class='page-item pageicon'><a class='page-link' aria-label='Previous' href='orderInfo.book?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&orderstatus="+status+"&fromDate="+fromDate+"&toDate="+toDate+"'>[이전]</a></li>";  
         }
                  
         while( !(loop > blockSize || pageNo > totalPage) ) {
         
            if( pageNo == Integer.parseInt(currentShowPageNo) ) {
               pageBar += "<li class='page-item active pageicon'><a class='page-link' aria-label='Previous' href='#'>"+pageNo+"</a></li>"; 
            }
            else {
               pageBar += "<li class='page-item pageicon'><a class='page-link' aria-label='Previous' href='orderInfo.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&orderstatus="+status+"&fromDate="+fromDate+"&toDate="+toDate+"'>"+pageNo+"</a></li>";   
            }
            
            loop++;
            pageNo++;
         }// end of while---------------------------------
         
         // **** [다음][마지막] 만들기 **** //
         // pageNo ==> 11
         if( pageNo <= totalPage ) {
            pageBar += "<li class='page-item pageicon'><a class='page-link' aria-label='Previous' href='orderInfo.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&orderstatus="+status+"&fromDate="+fromDate+"&toDate="+toDate+"'>[다음]</a></li>";  
            pageBar += "<li class='page-item pageicon'><a class='page-link' aria-label='Previous' href='orderInfo.book?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&orderstatus="+status+"&fromDate="+fromDate+"&toDate="+toDate+"'>[마지막]</a></li>"; 
         }
         

         
         
         request.setAttribute("pageBar", pageBar); 
      // **** ============ 페이지바 만들기 끝 ============ **** //
      
      // **** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 ****
      
      String currentURL = MyUtil.getCurrentURL(request);
      // 회원조회를 했을 시 현재 그 페이지로 그대로 되돌아가기 위한 용도로 쓰인다.
      
//      System.out.println("확인용 currentURL =>"+currentURL);
      /*
          확인용 currentURL =>/member/memberList.up?searchType=name&searchWord=%EC%9C%A0&sizePerPage=10
         확인용 currentURL =>/member/memberList.up?currentShowPageNo=5&sizePerPage=10&searchType=name&searchWord=%EC%9C%A0
       */
      
      // &이 구분자이기 때문에 &을 " "으로 바꾼다.
      currentURL = currentURL.replaceAll("&", " ");
      // 확인용 currentURL =>/member/memberList.up?currentShowPageNo=5 sizePerPage=10 searchType=name searchWord=%EC%9C%A0
      
      request.setAttribute("goBackURL", currentURL);


      
      
      if("get".equalsIgnoreCase(method)) {
         
         setRedirect(false);
         setViewPage("/WEB-INF/member/orderInfo.jsp");
         
         }

      }
   }
}
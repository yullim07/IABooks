package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class ShowBookListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//HttpSession session = request.getSession();
		
		//페이징 처리가 되어진  모든 회원 또는 검색한 회원
		InterProductDAO mdao = new ProductDAO();
		
		Map<String, String> paraMap = new HashMap<>();
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		//사용자가 보고자하는 페이지 번호이다
		//메뉴에서 회원목록 만을 클릭했을 경우 currentShowPageNo은 null이되어진다.
		//currentShowPageNo이 null이라면 currentShowPageNo을 1페이지로 바꿔야한다.
		String sizePerPage = request.getParameter("sizePerPage");
		//한페이지당 화면상 보여줄 회원 개수
		//메뉴에서 회원목록 만을 클릭했을 경우 sizePerPage은 null이되어진다.
		//sizePerPage이 null이라면 sizePerPage은 10으로 바꿔야한다.
		if(currentShowPageNo == null) {
			currentShowPageNo ="1";
		}
		if(sizePerPage == null || !("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage)) )  {
			sizePerPage = "10";
		}
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
        //     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== //
		try {
			Integer.parseInt(currentShowPageNo);
		} catch (NumberFormatException e) {
			currentShowPageNo = "1";
		}

		paraMap.put("currentShowPageNo", currentShowPageNo);
		paraMap.put("sizePerPage", sizePerPage);

		List<ProductVO> productList = mdao.selectPagingProduct(paraMap);
		request.setAttribute("productList", productList);
		//페이지 바 만들기 시작
		
	

		/*
		String pageBar = "";
		int blockSize = 10;
		//blockSize 바에 보여주는 페이지 개수  1 2 3 4 5 6 7 8 9 10 [다음]
		
		int loop = 1;
		//loop는 1부터 증가하여 1개 블럭을 이루는 페이지 번호의 개수(blockSize 지금은 10개) 까지만 증가하는 용도이다
		
		//pageNo 구하는공식
		int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
		//pageNo 페이지 보여지는  첫넘버
		
		//페이징 처리를 위한 검책이 있는 또는 검색이 없는 전체회원에 대한 총페이지 알아오기
		int totalPage= mdao.getTotalPage(paraMap);
		System.out.println("확인용 totalPage : "+totalPage);
		
		//토탈페이지수보다 큰값을 입력방지 1페이지로 넘겨준다 숙제
		
		 //if(Integer.parseInt(currentShowPageNo) > totalPage) { pageNo = 1; }
		 
		
		
		//**** [맨처음][이전]만들기
		if( pageNo != 1 ) {
			pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?currentShowPageNo=1&sizePerPage="+sizePerPage+"'>[맨처음]</a></li>";
			pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'>[이전]</a></li>";
		}
		
		
		while (!(loop > blockSize || pageNo > totalPage) ) {
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
				//"<li class='page-item'><a class='page-link' href='memberList.up?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a></li>"

			}else {
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a></li>";
			}
			loop++;
			pageNo++;
		}//end of while (!(loop > blockSize))
		
		//**** [다음][마지막]만들기
		if( pageNo <= totalPage ) {
			pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>[다음]</a></li>";
			pageBar += "<li class='page-item'><a class='page-link' href='memberList.up?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"'>[마지막]</a></li>";
		}
		
		
		request.setAttribute("pageBar", pageBar);//memberList로넘겨주기
		//페이지바 만들기 끝
	
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/member/memberList.jsp");
		
		*/
	
		
	}

}

package product.controller2;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO;
import product.model.ProductDAO;
import product.model.ProductVO;

public class SearchAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		String sort = request.getParameter("sort");
		
		if(sort == null) {
			sort = "new";
		}
	
		if(!("new".equals(sort) || "popularity".equals(sort) || "name".equals(sort)) ) {
			sort = "new";
		}
		
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
		
		//currentShowPageNo, sizePerPage 변조방지
		if(currentShowPageNo == null) {
			currentShowPageNo ="1";
		}
		if(sizePerPage == null || !"12".equals(sizePerPage))  {
			sizePerPage = "12";
		}

		try {
			Integer.parseInt(currentShowPageNo);
		} catch (NumberFormatException e) {
			currentShowPageNo = "1";
		}
		
		try {
			Integer.parseInt(sizePerPage);
		} catch (NumberFormatException e) {
			sizePerPage = "12";
		}
		
		paraMap.put("sizePerPage", sizePerPage);
		//paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("sort", sort);
		//페이징 처리를 위한 검책이 있는 또는 검색이 없는 전체회원에 대한 총페이지 알아오기
		Map<String, Integer> paraMap2= mdao.getSearchPage(paraMap);
		
		int totalPage = paraMap2.get("totalPage");
		int totalPro = paraMap2.get("totalPro");
		
		if(Integer.parseInt(currentShowPageNo) > totalPage) { 
			currentShowPageNo = "1";
		}

		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		List<ProductVO> productList = mdao.selectPagingSearch(paraMap);
		request.setAttribute("productList", productList);
		request.setAttribute("sizePerPage", sizePerPage);
		
		String pageBar = "";
		int blockSize = 10; //blockSize 바에 보여주는 페이지 개수  1 2 3 4 5 6 7 8 9 10 [다음]
		
		int loop = 1;//loop는 1부터 증가하여 1개 블럭을 이루는 페이지 번호의 개수(blockSize 지금은 10개) 까지만 증가하는 용도이다
		
		//pageNo 구하는공식 pageNo 페이지 보여지는  첫넘버
		int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
	
		pageBar += "<li class='page-item pageicon'><a class='page-link' aria-label='Previous' href='showBookList.book?searchWord="+searchWord+"&sort="+sort+"&currentShowPageNo=1&sizePerPage="+sizePerPage+"'>"
				+ "<span aria-hidden='true'><i class='bi bi-chevron-double-left'></i></span></a></li>";
		
		if( pageNo != 1 ) {
			pageBar += "<li class='page-item pageicon'><a class='page-link' aria-label='Previous' href='showBookList.book?searchWord="+searchWord+"&sort="+sort+"&currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"' >"
					+ "<span aria-hidden='true'><i class='bi bi-chevron-left'></i></span></a></li>";
		}

		while (!(loop > blockSize || pageNo > totalPage) ) {
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "<li class='page-item pagenum '><a class='page-link active' href='#'>"+pageNo+"</a></li>";
			
			}else {
				pageBar +="<li class='page-item pagenum'><a class='page-link' href='showBookList.book?searchWord="+searchWord+"&sort="+sort+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a></li>";
			}
			loop++;
			pageNo++;
		}//end of while (!(loop > blockSize))
		
		if( pageNo <= totalPage ) {
			pageBar += "<li class='page-item pageicon'><a class='page-link' aria-label='Next' href='showBookList.book?searchWord="+searchWord+"&sort="+sort+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"' >"
					+ "<span aria-hidden='true'><i class='bi bi-chevron-right'></i></span></a></li>";
		}
		
		pageBar +=  "<li class='page-item pageicon'><a class='page-link' aria-label='Next' href='showBookList.book?searchWord="+searchWord+"&sort="+sort+"&currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"' >"
				+ "<span aria-hidden='true'><i class='bi bi-chevron-double-right'></i></span></a></li>";
		
		request.setAttribute("totalPro", totalPro);
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("searchWord", searchWord);
		request.setAttribute("sort", sort);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/search.jsp");
	}

}

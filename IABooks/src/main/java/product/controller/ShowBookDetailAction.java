package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.BoardDAO;
import board.model.InterBoardDAO;
import board.model.ReviewBoardVO;
import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.*;

public class ShowBookDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pk_pro_num = request.getParameter("pronum");

		InterProductDAO pdao = new ProductDAO();
		ProductVO pvo = pdao.showBookDetail(pk_pro_num);
			
		request.setAttribute("pvo", pvo);
		
		// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 해야 한다. == //
		HttpSession session  = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		ReviewBoardVO revVO = new ReviewBoardVO();
		
		InterBoardDAO bdao = new BoardDAO();
		// 기능을 수행할 DAO 객체화
		Map<String, String> paraMap = new HashMap<>();
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String sizePerPage = request.getParameter("sizePerPage");
		
		if(currentShowPageNo == null ) {
			currentShowPageNo = "1";
		}
		
		if(sizePerPage == null || !"5".equals(sizePerPage) ) {
			sizePerPage = "5";
		}
		
		try {
			Integer.parseInt(currentShowPageNo);
		} catch(NumberFormatException e) {
			currentShowPageNo = "1";
		}
		
		paraMap.put("sizePerPage", sizePerPage);
		paraMap.put("pk_pro_num", pk_pro_num); // 제품번호 넣기
		
		// 페이징 처리를 위한 하나의 상품에 대한 리뷰게시글 페이지 알아오기
		int totalPage = bdao.getProductRevPage(paraMap);
		
		if( Integer.parseInt(currentShowPageNo) > totalPage ) {
			currentShowPageNo = "1";
		}
		
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		// 제품상세페이지에 보여줄 한 제품에 대한 게시글 불러오기
		List<ReviewBoardVO> productRevList = bdao.selectPagingProductRev(paraMap);
		
		request.setAttribute("productRevList", productRevList);
		
		String pageBar = "";
		
		int blockSize = 10;
		
		int loop = 1;
		
		int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1 )/blockSize ) * blockSize + 1;
		
		// **** [맨처음][이전] 만들기 **** //
		if(pageNo != 1) {
		// if(Integer.parseInt(currentShowPageNo) >= 2) {
			pageBar += "<li class='page-item'><a class='page-link' href='reviewBoard.book?currentShowPageNo=1&sizePerPage="+sizePerPage+"'>[맨처음]</a></li>";
			pageBar += "<li class='page-item'><a class='page-link' href='reviewBoard.book?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'>[이전]</a></li>";
		}
		while( !(loop > blockSize || pageNo > totalPage) ) {
			// 루프가 블락사이즈(10)을 넘어가거나 || 페이지번호가 총 페이지수를 넘어가기 전까지 반복
			if( pageNo == Integer.parseInt(currentShowPageNo) ) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
				// 현재페이지 링크 제거
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='reviewBoard.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a></li>";
			}
			loop++;
			pageNo++;
		} // end of while()--------------------------
		
		// *** [다음] [마지막] 만들기 *** //
		// pageNo ==> 11
		if(pageNo <= totalPage) {
			// 마지막 페이지랑 같으면 다음 마지막이 없어져야 됨
			pageBar += "<li class='page-item'><a class='page-link' href='reviewBoard.book?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>[다음]</a></li>";
			pageBar += "<li class='page-item'><a class='page-link' href='reviewBoard.book?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"'>[마지막]</a></li>";
		}
		
		
		request.setAttribute("pageBar", pageBar);
		
		// **** ============ 페이지바 만들기 끝 ============ //
		
		
		
		
		
		
		//super.setRedirect(false);
		super.setViewPage("/WEB-INF/product/showBookDetail.jsp");
						
	}

}

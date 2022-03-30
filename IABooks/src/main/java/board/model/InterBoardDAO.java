package board.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterBoardDAO {
	
	// QnA 글목록보기
	List<QnABoardVO> qnaboardList();// 글목록보기
    
	// Review 글목록보기
	List<ReviewBoardVO> reviewList() throws SQLException; //리뷰글목록보기
   
	// FAQ 글목록보기
	List<FaqBoardVO> faqBoardList() throws SQLException;

	// FAQ 게시판에 글 작성하기
	int writeFaqBoard(Map<String, String> paraMap) throws SQLException;

	
	
	
	// 페이징 처리가 되어진 모든 리뷰 게시판 게시글 목록 보여주기
	List<ReviewBoardVO> selectPagingRevBord(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 리뷰게시글에 대한 페이지 알아오기
	int getTotalRevPage(Map<String, String> paraMap) throws SQLException;

   

}


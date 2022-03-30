package board.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterBoardDAO {
	
	// QnA 글목록보기
	List<QnABoardVO> qnaboardList();// 글목록보기
    
	// Review 글목록보기
	List<ReviewBoardVO> reviewList() throws SQLException; //리뷰글목록보기

	
	
	
	
	
	
	//////////////////////////////////////////////////////////////////////////////
	//////////////////정환모 작업 (안겹치도록 방파제) //////////////////////////////////

	   
	// FAQ 글목록보기
	List<FaqBoardVO> selectPagingFaqBord(Map<String, String> paraMap) throws SQLException;	
	
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 FAQ게시판에 대한 페이지 알아오기
	int getTotalfaqPage(Map<String, String> paraMap) throws SQLException;
	
	// FAQ 게시판에 글 작성하기
	int writeFaqBoard(Map<String, String> paraMap) throws SQLException;	
	
	// 리뷰게시판 글 목록보기
	List<ReviewBoardVO> selectPagingRevBord(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 리뷰게시글에 대한 페이지 알아오기
	int getTotalRevPage(Map<String, String> paraMap) throws SQLException;

	

	

	

   

}


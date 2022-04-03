package board.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterBoardDAO {
	
	// 페이징 처리가 되어진 모든 QnA 게시판 게시글 목록 보여주기
	List<QnABoardVO> selectPagingQnaBoard(Map<String, String> paraMap) throws SQLException;
    
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 qna상품문의게시글에 대한 페이지 알아오기
	int getTotalqnaPage(Map<String, String> paraMap) throws SQLException;
	
	//Qna 게시판에 글 작성하기
	int writeQnaBoard(Map<String, String> paraMap) throws SQLException;
	
	
	
	
	
	//////////////////////////////////////////////////////////////////////////////
	//////////////////정환모 작업 (안겹치도록 방파제) //////////////////////////////////

	   
	// FAQ 글목록보기
	List<FaqBoardVO> selectPagingFaqBord(Map<String, String> paraMap) throws SQLException;	
	
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 FAQ게시판에 대한 페이지 알아오기
	int getTotalfaqPage(Map<String, String> paraMap) throws SQLException;
	
	// FAQ 게시판에 글 작성하기
	int writeFaqBoard(Map<String, String> paraMap) throws SQLException;	
	
	// 리뷰게시판 글 목록보기
	List<ReviewBoardVO> selectPagingRevBoard(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 리뷰게시글에 대한 페이지 알아오기
	int getTotalRevPage(Map<String, String> paraMap) throws SQLException;

	// FAQ 상세글 읽어오기 
	FaqBoardVO readContent(int pk_faq_board_num) throws SQLException;

	// 번호 하나를 받아 FAQ글 정보 받아오기 
	FaqBoardVO selectContent(int pk_faq_board_num) throws SQLException;

	// FAQ 게시판 값을 수정이나 삭제하기 위해 정보 받아오기
	FaqBoardVO getContent(int pk_faq_board_num) throws SQLException;

	// FAQ 게시판 값을 수정해주기
	int UpdateFaqBoard(Map<String, String> paraMap) throws SQLException;
	
	// FAQ 게시판 값을 삭제하기
	int deleteFaqBoard(FaqBoardVO faqVO) throws SQLException;

	// FAQ 게시판 이전글, 다음글 정보를 가져오기
	FaqBoardVO getPrevNextContent(Map<String, String> paraMap) throws SQLException;

	// 리뷰게시판 상세글 읽어오기 
	ReviewBoardVO readReviewContent(int pk_rnum) throws SQLException;
	
	// 번호 하나를 받아 리뷰게시판 정보 받아오기 
	ReviewBoardVO selectReviewContent(int pk_rnum) throws SQLException;

	// 리뷰게시판 이전글, 다음글 정보를 가져오기
	ReviewBoardVO getPrevNextReviewContent(Map<String, String> paraMap) throws SQLException;
	

	

   

}

	
	
	
	

   


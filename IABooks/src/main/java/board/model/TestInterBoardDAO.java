package board.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface TestInterBoardDAO {

	// 받아온 pk값으로 qna게시판 게시글 삭제
	int qnaDeleteSelect(Map<String, String> paraMap) throws SQLException;

	// 받아온 pk값으로 리뷰게시판 게시글 삭제
	int revDeleteSelect(Map<String, String> paraMap) throws SQLException;

	// 받아온 pk값으로 qna게시판 게시상태 변경
	int qnaDisplaySelect(Map<String, String> paraMap) throws SQLException;

	// 받아온 pk값으로 리뷰게시판 게시글 게시상태 변경
	int revDisplaySelect(Map<String, String> paraMap) throws SQLException;

	// 게시글 번호 표시를 위한 검색이 있는 또는 검색이 없는 전체 Qna게시판에 대한 페이지 알아오기
	QnABoardVO getTotalQnaCnt(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 FAQ게시판에 대한 페이지 알아오기
	int getTotalMyPage(Map<String, String> paraMap) throws SQLException;
	
	// 게시글 번호 표시를 위한 검색이 있는 또는 검색이 없는 전체 리뷰 게시판에 대한 페이지 알아오기
	ReviewBoardVO getTotalReviewCnt(Map<String, String> paraMap) throws SQLException;

	// 마이페이지에 보여줄 내가 쓴 게시글 불러오기
	List<MyBoardVO> selectPagingMyBoard(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체게시판에 대한 페이지 알아오기(관리자 전용)
	int getTotalAdminPage(Map<String, String> paraMap) throws SQLException;

	// 관리자페이지 게시글관리에에 보여줄 모든 게시글 불러오기
	List<MyBoardVO> selectPagingAdminBoard(Map<String, String> paraMap) throws SQLException;

	// 구매이력 확인
	int checkBuyThisProduct(Map<String, String> paraMap) throws SQLException;
	
	
}

package board.model;

import java.sql.SQLException;
import java.util.Map;

public interface TestInterBoardDAO {

	// 받아온 pk값으로 qna게시판 게시글 삭제
	int qnaDeleteSelect(Map<String, String> paraMap) throws SQLException;

	// 받아온 pk값으로 리뷰게시판 게시글 삭제
	int revDeleteSelect(Map<String, String> paraMap) throws SQLException;

}

package board.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterBoardDAO {

   List<QnABoardVO> boardList();// 글목록보기
   
   List<ReviewBoardVO> reviewList() throws SQLException; //리뷰글목록보기
   
   // FAQ 글목록보기
   List<FaqBoardVO> faqBoardList() throws SQLException;

   // FAQ 게시판에 글 작성하기
   int writeFaqBoard(Map<String, String> paraMap) throws SQLException;

}


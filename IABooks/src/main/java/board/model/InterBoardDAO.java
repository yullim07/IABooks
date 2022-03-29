package board.model;

import java.sql.SQLException;
import java.util.List;

public interface InterBoardDAO {

   List<QnABoardVO> boardList();// 글목록보기
   
   List<ReviewBoardVO> reviewList() throws SQLException; //리뷰글목록보기
   
   // FAQ 글목록보기
   List<FaqBoardVO> faqBoardList() throws SQLException;

}
package board.model;

import java.util.List;

public interface InterBoardDAO {

	List<QnABoardVO> boardList();// QnA 글목록보기

	List<ReviewBoardVO> reviewList(); //리뷰글목록보기

}

package board.model;

import member.model.MemberVO;

public class MyBoardVO {

	private QnABoardVO qnaBoard;
	
	private ReviewBoardVO revBoard;
	
	private MemberVO mvo;

	public MemberVO getMvo() {
		return mvo;
	}

	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}

	public QnABoardVO getQnaBoard() {
		return qnaBoard;
	}

	public void setQnaBoard(QnABoardVO qnaBoard) {
		this.qnaBoard = qnaBoard;
	}

	public ReviewBoardVO getRevBoard() {
		return revBoard;
	}

	public void setRevBoard(ReviewBoardVO revBoard) {
		this.revBoard = revBoard;
	}
	
	
}

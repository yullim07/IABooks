package board.model;

import member.model.MemberVO;

public class CommentVO {
	
	private int pk_cmt_num; 		// 댓글번호
	private String fk_userid; 		// 회원아이디
	private int fk_qna_num; 		// 문의번호

	private String cmt_passwd; 		// 댓글비밀번호
	private String cmt_contents; 	// 댓글내용
	private String cmt_date; 		// 작성일자
	private int isdelete; 			// 삭제유무(0:삭제안함, 1:삭제함)
    
    private MemberVO member;
    
    private QnABoardVO qnaBoard;

	public int getPk_cmt_num() {
		return pk_cmt_num;
	}

	public void setPk_cmt_num(int pk_cmt_num) {
		this.pk_cmt_num = pk_cmt_num;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public int getFk_qna_num() {
		return fk_qna_num;
	}

	public void setFk_qna_num(int fk_qna_num) {
		this.fk_qna_num = fk_qna_num;
	}


	public String getCmt_passwd() {
		return cmt_passwd;
	}

	public void setCmt_passwd(String cmt_passwd) {
		this.cmt_passwd = cmt_passwd;
	}

	public String getCmt_contents() {
		return cmt_contents;
	}

	public void setCmt_contents(String cmt_contents) {
		this.cmt_contents = cmt_contents;
	}

	public String getCmt_date() {
		return cmt_date;
	}

	public void setCmt_date(String cmt_date) {
		this.cmt_date = cmt_date;
	}

	public int getIsdelete() {
		return isdelete;
	}

	public void setIsdelete(int isdelete) {
		this.isdelete = isdelete;
	}

	public MemberVO getMember() {
		return member;
	}

	public void setMember(MemberVO member) {
		this.member = member;
	}

	public QnABoardVO getQnaBoard() {
		return qnaBoard;
	}

	public void setQnaBoard(QnABoardVO qnaBoard) {
		this.qnaBoard = qnaBoard;
	}
	
}

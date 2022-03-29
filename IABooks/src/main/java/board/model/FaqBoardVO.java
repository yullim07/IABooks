package board.model;

import member.model.MemberVO;

public class FaqBoardVO {

	private int pk_faq_board_num;	// 문의번호
	private String fk_userid;		// 회원아이디
	private int fk_faq_c_num;	// FAQ 번호
	private String fk_faq_c_name;	// FAQ 제목
	private String faq_title;		// 제목
	private String faq_writer;		// 작성자
	private String faq_contents;	// 게시글 내용
	private int isdelete; 			// 삭제유무(0:삭제안함, 1:삭제함)
	
	private MemberVO member;

	public int getPk_faq_board_num() {
		return pk_faq_board_num;
	}

	public void setPk_faq_board_num(int pk_faq_board_num) {
		this.pk_faq_board_num = pk_faq_board_num;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public int getFk_faq_c_num() {
		return fk_faq_c_num;
	}

	public void setFk_faq_c_num(int fk_faq_c_num) {
		this.fk_faq_c_num = fk_faq_c_num;
	}

	public String getFk_faq_c_name() {
		return fk_faq_c_name;
	}

	public void setFk_faq_c_name(String fk_faq_c_name) {
		this.fk_faq_c_name = fk_faq_c_name;
	}
	
	public String getFaq_title() {
		return faq_title;
	}

	public void setFaq_title(String faq_title) {
		this.faq_title = faq_title;
	}

	public String getFaq_writer() {
		return faq_writer;
	}

	public void setFaq_writer(String faq_writer) {
		this.faq_writer = faq_writer;
	}

	public String getFaq_contents() {
		return faq_contents;
	}

	public void setFaq_contents(String faq_contents) {
		this.faq_contents = faq_contents;
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
	
	
	
}

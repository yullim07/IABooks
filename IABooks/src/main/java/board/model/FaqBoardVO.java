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
	private int currentNum;			// 현재글 번호
	private String currentTitle;	// 현재글 내용
	private int prev_num;			// 이전글 번호
	private String prev_title;	// 이전글 내용
	private int next_num;			// 다음글 번호
	private String next_title;	// 다음글 내용	
	
	private MemberVO member;
	
	private FAQcategoryBoardVO faqCate;

	public int getPk_faq_board_num() {
		return pk_faq_board_num;
	}

	public FAQcategoryBoardVO getFaqCate() {
		return faqCate;
	}

	public void setFaqCate(FAQcategoryBoardVO faqCate) {
		this.faqCate = faqCate;
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
	
	public int getPrev_num() {
		return prev_num;
	}

	public void setPrev_num(int prev_num) {
		this.prev_num = prev_num;
	}

	public int getNext_num() {
		return next_num;
	}

	public void setNext_num(int next_num) {
		this.next_num = next_num;
	}

	public int getCurrentNum() {
		return currentNum;
	}

	public void setCurrentNum(int currentNum) {
		this.currentNum = currentNum;
	}

	public String getCurrentTitle() {
		return currentTitle;
	}

	public void setCurrentTitle(String currentTitle) {
		this.currentTitle = currentTitle;
	}

	public String getPrev_title() {
		return prev_title;
	}

	public void setPrev_title(String prev_title) {
		this.prev_title = prev_title;
	}

	public String getNext_title() {
		return next_title;
	}

	public void setNext_title(String next_title) {
		this.next_title = next_title;
	}


}

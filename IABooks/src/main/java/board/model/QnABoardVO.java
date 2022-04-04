package board.model;

import member.model.MemberVO;
import product.model.ProductVO;

public class QnABoardVO {

	private int pk_qna_num;			// 문의번호
	private String fk_userid;		// 회원아이디
	private String fk_pnum;			// 국제표준도서번호
	private String qna_title;		// 제목
	private int qna_isanswer;		// 답변유무
	private int qna_readcount;		// 조회수
	private String qna_date;		// 작성일자
	private String qna_contents;	// 게시글 내용
	private String qna_passwd;		// 글비밀번호
	private int qna_issecret;		// 비밀유무(0:공개글 1:비밀글)
	private int isdelete;			// 삭제유무(0:삭제안함, 1:삭제함)
	
	
	
	
	// 1. 게시판마다 DAO, VO를 나눠야 하는지? 아니면 하나에 다 몰아넣어도 되는지?

	private MemberVO member;
	// private MemberDTO member; // @@@  부모  ,,   // 초기치 null
	//오라클의 jdbc_board 테이블과 jdbc_member 테이블을 join하여 select 하는 용도
	
	private ProductVO product; // @@@  부모  ,,   // 초기치 null
	//오라클의 jdbc_board 테이블과 jdbc_member 테이블을 join하여 select 하는 용도

	// private int commentcnt;  //필드 추가. 
	//오라클의 jdbc_board 테이블과 jdbc_comment 테이블을 join하여 select 하는 용도
	
	public int getPk_qna_num() {
		return pk_qna_num;
	}
	public void setPk_qna_num(int pk_qna_num) {
		this.pk_qna_num = pk_qna_num;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getFk_pnum() {
		return fk_pnum;
	}
	public void setFk_pnum(String fk_pnum) {
		this.fk_pnum = fk_pnum;
	}
	public String getQna_title() {
		return qna_title;
	}
	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}
	public int getQna_isanswer() {
		return qna_isanswer;
	}
	public void setQna_isanswer(int qna_isanswer) {
		this.qna_isanswer = qna_isanswer;
	}
	public int getQna_readcount() {
		return qna_readcount;
	}
	public void setQna_readcount(int qna_readcount) {
		this.qna_readcount = qna_readcount;
	}
	public String getQna_date() {
		return qna_date;
	}
	public void setQna_date(String qna_date) {
		this.qna_date = qna_date;
	}
	public String getQna_contents() {
		return qna_contents;
	}
	public void setQna_contents(String qna_contents) {
		this.qna_contents = qna_contents;
	}
	public String getQna_passwd() {
		return qna_passwd;
	}
	public void setQna_passwd(String qna_passwd) {
		this.qna_passwd = qna_passwd;
	}
	public int getQna_issecret() {
		return qna_issecret;
	}
	public void setQna_issecret(int qna_issecret) {
		this.qna_issecret = qna_issecret;
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
	
	public ProductVO getProduct() {
		return product;
	}
	
	public void setProduct(ProductVO product) {
		this.product = product;
	}
	
	private int currentNum;			// 현재글 번호
	private String currentTitle;	// 현재글 내용
	private int prev_num;			// 이전글 번호
	private String prev_title;	// 이전글 내용
	private int next_num;			// 다음글 번호
	private String next_title;	// 다음글 내용	

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
	
	public int getPrev_num() {
		return prev_num;
	}
	
	public void setPrev_num(int prev_num) {
		this.prev_num = prev_num;
	}
	
	public String getPrev_title() {
		return prev_title;
	}
	
	public void setPrev_title(String prev_title) {
		this.prev_title = prev_title;
	}
	
	public int getNext_num() {
		return next_num;
	}
	
	public void setNext_num(int next_num) {
		this.next_num = next_num;
	}
	
	public String getNext_title() {
		return next_title;
	}
	
	public void setNext_title(String next_title) {
		this.next_title = next_title;
	}
	public void setFk_userid(MemberVO loginuser) {
		// TODO Auto-generated method stub
		
	}
	
	
	
	
}
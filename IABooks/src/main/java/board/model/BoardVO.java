package board.model;

public class BoardVO {

	private int pk_qna_num;
	private String fk_userid;
	private int fk_pnum;
	private String qna_title;
	private int qna_isanswer;
	private int qna_readcount;
	private String qna_date;
	private String qna_contents;
	private String qna_passwd;
	private int qna_issecret;
	
	// 1. 게시판마다 DAO, VO를 나눠야 하는지? 아니면 하나에 다 몰아넣어도 되는지?

	// private MemberDTO member; // @@@  부모  ,,   // 초기치 null
	//오라클의 jdbc_board 테이블과 jdbc_member 테이블을 join하여 select 하는 용도
	
	//private ProductDTO product; // @@@  부모  ,,   // 초기치 null
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
	public int getFk_pnum() {
		return fk_pnum;
	}
	public void setFk_pnum(int fk_pnum) {
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
	
	
	
}



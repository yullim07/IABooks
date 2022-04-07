package board.model;

public class FAQcategoryBoardVO {
	
	//테이블을 만들면 자동적으로 DTO도 만들어둬라 
	
//	-----------------------------------------
//	오라클의  tbl_faq_category 테이블에 insert 및 select 하는 용도
	

	private int pk_faq_c_num;       // FAQ 번호
	private String faq_c_name;      //FAQ 이름
	private String faq_c_ename;      //FAQ 영어 이름

	private int isdelete; // 삭제유무
	
//	-----------------------------------------	
	
	public int getPk_faq_c_num() {
		return pk_faq_c_num;
	}
	
	public void setPk_faq_c_num(int pk_faq_c_num) {
		this.pk_faq_c_num = pk_faq_c_num;
	}
	
	public String getFaq_c_name() {
		return faq_c_name;
	}
	
	public void setFaq_c_name(String faq_c_name) {
		this.faq_c_name = faq_c_name;
	}
	
	public int getIsdelete() {
		return isdelete;
	}
	
	public void setIsdelete(int isdelete) {
		this.isdelete = isdelete;
	}
	
	
	public String getFaq_c_ename() {
		return faq_c_ename;
	}

	public void setFaq_c_ename(String faq_c_ename) {
		this.faq_c_ename = faq_c_ename;
	}

	
	
}

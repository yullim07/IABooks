package product.model;

public class WriterVO {
	
	int pk_wr_code;
	String wr_name;
//	Clob wr_info; String buffer 사용
	
	// 기본생성자
	public WriterVO() {}

	public WriterVO(int pk_wr_code, String wr_name) {
	//	super();
		this.pk_wr_code = pk_wr_code;
		this.wr_name = wr_name;
	}

	public int getPk_wr_code() {
		return pk_wr_code;
	}

	public void setPk_wr_code(int pk_wr_code) {
		this.pk_wr_code = pk_wr_code;
	}

	public String getWr_name() {
		return wr_name;
	}

	public void setWr_name(String wr_name) {
		this.wr_name = wr_name;
	}
	
} 


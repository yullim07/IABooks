package product.model;

public class WriterVO {
	
	int pk_wr_code;
	String wr_name;
	String wr_info;
	
	// 기본생성자
	public WriterVO() {}

	public WriterVO(int pk_wr_code, String wr_name, String wr_info) {
		super();
		this.pk_wr_code = pk_wr_code;
		this.wr_name = wr_name;
		this.wr_info = wr_info;
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
	
	public String getWr_info() {
		return wr_info;
	}

	public void setWr_info(String wr_info) {
		this.wr_info = wr_info;
	}
	
} 


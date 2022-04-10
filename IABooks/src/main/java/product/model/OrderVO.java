package product.model;

import java.util.Date;

public class OrderVO extends ProductVO {
	
	private String pk_odrcode;		// 주문코드
	private String fk_userid;		// 회원 아이디
	private int odr_totalprice;		
	private Date odr_date;			
	private String rv_name;			
	private String rv_zipcode;			
	private String rv_addr1;		
	private String rv_addr2;		
	private String rv_phone;		
	private String rv_email;		
	private String del_msg;
	
	///////////////////////////////////////////////
	
	
	// 기본 생성자
	public OrderVO() {}
	
	// 생성자2
	public OrderVO(String pk_odrcode, String fk_userid, int odr_totalprice, Date odr_date, String rv_name,
			String rv_zipcode, String rv_addr1, String rv_addr2, String rv_phone, String rv_email, String del_msg) {
		super();
		this.pk_odrcode = pk_odrcode;
		this.fk_userid = fk_userid;
		this.odr_totalprice = odr_totalprice;
		this.odr_date = odr_date;
		this.rv_name = rv_name;
		this.rv_zipcode = rv_zipcode;
		this.rv_addr1 = rv_addr1;
		this.rv_addr2 = rv_addr2;
		this.rv_phone = rv_phone;
		this.rv_email = rv_email;
		this.del_msg = del_msg;
	}
	
	
	// 기본생성자 3
	public OrderVO(String fk_userid, int odr_totalprice, Date odr_date, String rv_name, String rv_zipcode,
			String rv_addr1, String rv_addr2, String rv_phone, String rv_email, String del_msg) {
		super();
		this.fk_userid = fk_userid;
		this.odr_totalprice = odr_totalprice;
		this.odr_date = odr_date;
		this.rv_name = rv_name;
		this.rv_zipcode = rv_zipcode;
		this.rv_addr1 = rv_addr1;
		this.rv_addr2 = rv_addr2;
		this.rv_phone = rv_phone;
		this.rv_email = rv_email;
		this.del_msg = del_msg;
	}

	public String getPk_odrcode() {
		return pk_odrcode;
	}
	public void setPk_odrcode(String pk_odrcode) {
		this.pk_odrcode = pk_odrcode;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public int getOdr_totalprice() {
		return odr_totalprice;
	}
	public void setOdr_totalprice(int odr_totalprice) {
		this.odr_totalprice = odr_totalprice;
	}
	public Date getOdr_date() {
		return odr_date;
	}
	public void setOdr_date(Date odr_date) {
		this.odr_date = odr_date;
	}
	public String getRv_name() {
		return rv_name;
	}
	public void setRv_name(String rv_name) {
		this.rv_name = rv_name;
	}
	public String getRv_zipcode() {
		return rv_zipcode;
	}
	public void setRv_zipcode(String rv_zipcode) {
		this.rv_zipcode = rv_zipcode;
	}
	public String getRv_addr1() {
		return rv_addr1;
	}
	public void setRv_addr1(String rv_addr1) {
		this.rv_addr1 = rv_addr1;
	}
	public String getRv_addr2() {
		return rv_addr2;
	}
	public void setRv_addr2(String rv_addr2) {
		this.rv_addr2 = rv_addr2;
	}
	public String getRv_phone() {
		return rv_phone;
	}
	public void setRv_phone(String rv_phone) {
		this.rv_phone = rv_phone;
	}
	public String getRv_email() {
		return rv_email;
	}
	public void setRv_email(String rv_email) {
		this.rv_email = rv_email;
	}
	public String getDel_msg() {
		return del_msg;
	}
	public void setDel_msg(String del_msg) {
		this.del_msg = del_msg;
	}			
	
	
	
	
	
	
	

}

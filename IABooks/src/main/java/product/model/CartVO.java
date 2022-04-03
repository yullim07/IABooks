package product.model;

import java.util.Date;

public class CartVO extends ProductVO {
	
	private int pk_pro_num; 			//국제표준도서번호
	private int pro_price;   			//도서정가 디폴트 0
	private int saleprice;   			//도서판매가 디폴트 0
	private int point_rate;   			//포인트적립률 디폴트 0.01
	private int pro_qty;   				//도서재고량 디폴트 100
	private String pro_imgfile_name;	//이미지파일명	
	
	private String pk_cartno; 		// 주문코드
	private String fk_userid; 		// 회원아이디
	private int odr_totalprice; 	// 주문총액
	private int odr_totalpoint;		// 주문총포인트
	private Date odr_date;			// 주문일자 --------------------------- > > >> ??
	private String rv_name;			//이름
	private String rv_zipcode;   	// 우편번호
	private String rv_addr1; 		// 기본주소
	private String rv_addr2; 		// 상세주소
	private int rv_phone; 			// 휴대전화
	private String rv_email; 		// 이메일
	private String del_msg; 		// 배송메시지
	
	
	///////////////////////////////////////////////
	
	// 기본생성자
	public CartVO() {}
	
	public CartVO(String pk_odrcode, String fk_userid, int odr_totalprice, int odr_totalpoint, Date odr_date,
			String rv_name, String rv_zipcode, String rv_addr1, String rv_addr2, int rv_phone, String rv_email,
			String del_msg) {
		
		this.pk_odrcode = pk_odrcode;
		this.fk_userid = fk_userid;
		this.odr_totalprice = odr_totalprice;
		this.odr_totalpoint = odr_totalpoint;
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

	public int getOdr_totalpoint() {
		return odr_totalpoint;
	}

	public void setOdr_totalpoint(int odr_totalpoint) {
		this.odr_totalpoint = odr_totalpoint;
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

	public int getRv_phone() {
		return rv_phone;
	}

	public void setRv_phone(int rv_phone) {
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

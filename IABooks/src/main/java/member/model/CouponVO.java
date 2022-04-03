package member.model;

public class CouponVO {
	
	private String couponid;		// 쿠폰아이디
	private String cname;			// 쿠폰명
	private String cprice;		// 쿠폰아이디
	private String cdate;		// 쿠폰아이디
	private String cstartdate;		// 쿠폰아이디
	private String cenddate;		// 쿠폰아이디
	private String cminprice;
	
	// 기본생성자
	CouponVO() {}
	
	
	public CouponVO(String couponid, String cname, String cprice, String cminprice, String cstartdate, String cenddate) {
		super();
		this.couponid = couponid;
		this.cname = cname;
		this.cprice = cprice;
		this.cminprice = cminprice;
		this.cstartdate = cstartdate;
		this.cenddate = cenddate;
	}






	public String getCouponid() {
		return couponid;
	}
	public void setCouponid(String couponid) {
		this.couponid = couponid;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getCprice() {
		return cprice;
	}
	public void setCprice(String cprice) {
		this.cprice = cprice;
	}
	public String getCdate() {
		return cdate;
	}
	public void setCdate(String cdate) {
		this.cdate = cdate;
	}
	public String getCstartdate() {
		return cstartdate;
	}
	public void setCstartdate(String cstartdate) {
		this.cstartdate = cstartdate;
	}
	public String getCenddate() {
		return cenddate;
	}
	public void setCenddate(String cenddate) {
		this.cenddate = cenddate;
	}

	public String getCminprice() {
		return cminprice;
	}

	public void setCminprice(String cminprice) {
		this.cminprice = cminprice;
	}



	
}

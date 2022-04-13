package member.model;

public class CouponVO {
	
	private String rno;				// 쿠폰로우넘버
	private String couponid;		// 쿠폰아이디
	private String cname;			// 쿠폰명
	private String cprice;			// 할인가격
	private String cdate;			// 쿠폰발급일
	private String cstartdate;		// 혜택시작일
	private String cenddate;		// 혜택끝일
	private String cminprice;		// 혜택 최소구매금액
	private String cpstatus;		// 쿠폰유효여부
	private UserCouponStatusVO ucvo;			// 쿠폰브이오
	private MemberVO mvo; 			// 멤버VO
	
	
	private boolean userCouponCheck;
	





	// 기본생성자
	public CouponVO() {}
	
	
	public CouponVO(String rno, String couponid, String cname, String cprice, String cminprice, String cstartdate,
			String cenddate, String cpstatus, UserCouponStatusVO ucvo, MemberVO mvo ) {
		super();
		this.rno = rno;
		this.couponid = couponid;
		this.cname = cname;
		this.cprice = cprice;
		this.cminprice = cminprice;
		this.cstartdate = cstartdate;
		this.cenddate = cenddate;
		this.cpstatus = cpstatus;
		this.ucvo = ucvo;
		this.mvo = mvo;
	
	}


	

	public CouponVO(String couponid, String cname, String cprice, String cminprice, String cstartdate,
			String cenddate) {
		this.couponid = couponid;
		this.cname = cname;
		this.cprice = cprice;
		this.cminprice = cminprice;
		this.cstartdate = cstartdate;
		this.cenddate = cenddate;
	}


	
	public String getRno() {
		return rno;
	}
	public void setRno(String rno) {
		this.rno = rno;
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
	public String getCpstatus() {
		return cpstatus;
	}
	public void setCpstatus(String cpstatus) {
		this.cpstatus = cpstatus;
	}
	public UserCouponStatusVO getUcvo() {
		return ucvo;
	}
	public void setUcvo(UserCouponStatusVO ucvo) {
		this.ucvo = ucvo;
	}
	public MemberVO getMvo() {
		return mvo;
	}
	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}

	public boolean isUserCouponCheck() {
		return userCouponCheck;
	}
	public void setUserCouponCheck(boolean userCouponCheck) {
		this.userCouponCheck = userCouponCheck;
	}




	
}

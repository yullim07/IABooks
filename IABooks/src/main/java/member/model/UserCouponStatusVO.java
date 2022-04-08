package member.model;

public class UserCouponStatusVO {

	private String userid;
	private String coupon_id;
	private String user_cp_status;
	private String couponListNum;
	private CouponVO cvo;
	
	

	// 기본생성자
	public UserCouponStatusVO() {};
	
	public UserCouponStatusVO(String userid, String coupon_id, String user_cp_status, String couponListNum, CouponVO cvo ) {
		super();
		this.userid = userid;
		this.coupon_id = coupon_id;
		this.user_cp_status = user_cp_status;
		this.couponListNum = couponListNum;
		this.cvo=cvo;
	};
	
	
	public UserCouponStatusVO(String userid, String coupon_id) {
		this.userid = userid;
		this.coupon_id = coupon_id;
	}

	

	public UserCouponStatusVO(String userid) {
		this.userid = userid;
	}

	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getCoupon_id() {
		return coupon_id;
	}
	public void setCoupon_id(String coupon_id) {
		this.coupon_id = coupon_id;
	}
	public String getUser_cp_status() {
		return user_cp_status;
	}
	public void setUser_cp_status(String user_cp_status) {
		this.user_cp_status = user_cp_status;
	}
	public String getCouponListNum() {
		return couponListNum;
	}
	public void setCouponListNum(String couponListNum) {
		this.couponListNum = couponListNum;
	}
	public CouponVO getCvo() {
		return cvo;
	}
	public void setCvo(CouponVO cvo) {
		this.cvo = cvo;
	}
	
}

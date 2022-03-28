package member.model;

public class MemberVO {
	
	private String userid; 				// 회원아이디
	private String pwd; 				// 비밀번호 (SHA-256 암호화 대상) 
	private String name; 				// 회원명
	private String postcode;			// 우편번호
	private String address;				// 주소
	private String detailaddress; 		// 상세주소
	private String extraaddress;  		// 참고항목
	private String number;				// 일반전화
	private String phone;				// 연락처(휴대전화) (AES-256 암호화/복호화 대상) 
	private String email;   			// 이메일 (AES-256 암호화/복호화 대상)
	private int point;         			// 포인트 
	private int coupon;					// 쿠폰
	private String registerday; 		// 가입일자 
	private String lastpwdchangedate;  	// 마지막으로 암호를 변경한 날짜  
	private String birthday;      		// 생년월일   
	private String gender;        		// 성별   남자:1  / 여자:2
	private int status;          		// 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴) 
	private int u_status;            	// 휴면유무      0 : 활동중  /  1 : 휴면중 
										// 마지막으로 로그인한 날짜 시간이 현재시각으로 부터 1년이 (초과)지났으면 휴면으로 지정	

	/////////////////////////////////////////////////////////////////////
		   
	private boolean requirePwdChange = false;
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false

	
	/////////////////////////////////////////////////////////////////////	

	// 기본생성자 
	public MemberVO() {}
	
	public MemberVO(String userid, String pwd, String name, String email, String phone, String postcode,
			String address, String detailaddress, String extraaddress, String gender, String birthday, String number) {
		super();
		this.userid = userid;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.number = number;
		this.phone = phone;
		this.postcode = postcode;
		this.address = address;
		this.detailaddress = detailaddress;
		this.extraaddress = extraaddress;
		this.gender = gender;
		this.birthday = birthday;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDetailaddress() {
		return detailaddress;
	}

	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}

	public String getExtraaddress() {
		return extraaddress;
	}

	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getCoupon() {
		return coupon;
	}

	public void setCoupon(int coupon) {
		this.coupon = coupon;
	}

	public String getRegisterday() {
		return registerday;
	}

	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}

	public String getLastpwdchangedate() {
		return lastpwdchangedate;
	}

	public void setLastpwdchangedate(String lastpwdchangedate) {
		this.lastpwdchangedate = lastpwdchangedate;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getU_status() {
		return u_status;
	}

	public void setU_status(int u_status) {
		this.u_status = u_status;
	}

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}

	

	



}

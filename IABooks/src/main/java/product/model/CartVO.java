package product.model;

import java.util.Date;

import member.model.MemberVO;

public class CartVO {

	/*
	PK_CARTNO        NOT NULL NUMBER       
	FK_USERID        NOT NULL VARCHAR2(20) 
	PK_PRO_NUM                NUMBER
	CK_ODR_QTY                NUMBER(4)    
	CK_CART_REGISTER          DATE    
	*/
	
	private int pk_cartno;			// 장바구니 번호
	private String FK_USERID;		// 회원아이디
	private int pk_pro_num; 		// 국제표준도서번호
	private int ck_odr_qty;			// 총 주문량
	private Date ck_cart_register;	// 장바구니 등록일자
	
	private ProductVO product;
	private MemberVO member;
	
	///////////////////////////////////////////////
	
	// 기본생성자
	public CartVO() {}

	public CartVO(int pk_cartno, String fK_USERID, int pk_pro_num, int ck_odr_qty, Date ck_cart_register,
			ProductVO product, MemberVO member) {
		super();
		this.pk_cartno = pk_cartno;
		FK_USERID = fK_USERID;
		this.pk_pro_num = pk_pro_num;
		this.ck_odr_qty = ck_odr_qty;
		this.ck_cart_register = ck_cart_register;
		this.product = product;
		this.member = member;
	}

	public CartVO(int pk_cartno, String fK_USERID, int pk_pro_num, int ck_odr_qty, Date ck_cart_register) {
		super();
		this.pk_cartno = pk_cartno;
		FK_USERID = fK_USERID;
		this.pk_pro_num = pk_pro_num;
		this.ck_odr_qty = ck_odr_qty;
		this.ck_cart_register = ck_cart_register;
	}

	public int getPk_cartno() {
		return pk_cartno;
	}

	public void setPk_cartno(int pk_cartno) {
		this.pk_cartno = pk_cartno;
	}

	public String getFK_USERID() {
		return FK_USERID;
	}

	public void setFK_USERID(String fK_USERID) {
		FK_USERID = fK_USERID;
	}

	public int getPk_pro_num() {
		return pk_pro_num;
	}

	public void setPk_pro_num(int pk_pro_num) {
		this.pk_pro_num = pk_pro_num;
	}

	public int getCk_odr_qty() {
		return ck_odr_qty;
	}

	public void setCk_odr_qty(int ck_odr_qty) {
		this.ck_odr_qty = ck_odr_qty;
	}

	public Date getCk_cart_register() {
		return ck_cart_register;
	}

	public void setCk_cart_register(Date ck_cart_register) {
		this.ck_cart_register = ck_cart_register;
	}

	public ProductVO getProduct() {
		return product;
	}

	public void setProduct(ProductVO product) {
		this.product = product;
	}

	public MemberVO getMember() {
		return member;
	}

	public void setMember(MemberVO member) {
		this.member = member;
	}
	
	
	
}
	
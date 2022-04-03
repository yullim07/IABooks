package product.model;

import java.util.Date;

import member.model.MemberVO;

public class CartVO {
	
	private int pk_cartno;			// 장바구니 번호
	private String fk_userid;		// 회원아이디
	private String pk_pro_num; 		// 국제표준도서번호
	private int ck_odr_qty;			// 총 주문량
	private String ck_cart_register;	// 장바구니 등록일자
	
	private ProductVO product;
	
	// Product? 
	private String pro_name;		// 도서명
	private int pro_saleprice;	// 판매가 
	
	// 추가
	private int totalPrice;
	
	///////////////////////////////////////////////
	
	// 기본생성자
	public CartVO() {}

	public CartVO(int pk_cartno, String fk_userid, String pk_pro_num, int ck_odr_qty, String ck_cart_register,
			ProductVO product, String pro_name, int pro_saleprice, int totalPrice) {
		super();
		this.pk_cartno = pk_cartno;
		this.fk_userid = fk_userid;
		this.pk_pro_num = pk_pro_num;
		this.ck_odr_qty = ck_odr_qty;
		this.ck_cart_register = ck_cart_register;
		this.product = product;
		this.pro_name = pro_name;
		this.pro_saleprice = pro_saleprice;
		this.totalPrice = totalPrice;
	}

	public int getPk_cartno() {
		return pk_cartno;
	}

	public void setPk_cartno(int pk_cartno) {
		this.pk_cartno = pk_cartno;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public String getPk_pro_num() {
		return pk_pro_num;
	}

	public void setPk_pro_num(String pk_pro_num) {
		this.pk_pro_num = pk_pro_num;
	}

	public int getCk_odr_qty() {
		return ck_odr_qty;
	}

	public void setCk_odr_qty(int ck_odr_qty) {
		this.ck_odr_qty = ck_odr_qty;
	}

	public String getCk_cart_register() {
		return ck_cart_register;
	}

	public void setCk_cart_register(String ck_cart_register) {
		this.ck_cart_register = ck_cart_register;
	}

	public ProductVO getProduct() {
		return product;
	}

	public void setProduct(ProductVO product) {
		this.product = product;
	}

	public String getPro_name() {
		return pro_name;
	}

	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}

	public int getPro_saleprice() {
		return pro_saleprice;
	}

	public void setPro_saleprice(int pro_saleprice) {
		this.pro_saleprice = pro_saleprice;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	// 총 합계를 구해주는 ?
	public void initSaleTotal() {
		this.totalPrice = this.pro_saleprice*this.ck_odr_qty;
	}
	
	@Override
	public String toString() {
		return "CartVO [pk_cartno=" + pk_cartno + ", fk_userid=" + fk_userid + ", pk_pro_num=" + pk_pro_num
				+ ", ck_odr_qty=" + ck_odr_qty + ", ck_cart_register=" + ck_cart_register + ", pro_name=" + pro_name
				+ ", pro_saleprice=" + pro_saleprice + ", totalPrice=" + totalPrice + "]";
	}
	
	
	
}
package product.model;

import java.util.Date;

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
	
	/*
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
	*/
	
	///////////////////////////////////////////////
	
	// 기본생성자
	public CartVO() {}
	
}
	
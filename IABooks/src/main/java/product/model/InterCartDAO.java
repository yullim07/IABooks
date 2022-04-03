package product.model;

import java.util.List;

public interface InterCartDAO {
	
	// ?  
	List<CartVO> cartMoney();
	
	// 장바구니 추가하기 메소드 
	void cartInsert(CartVO dto); 
	
	// 장바구니 목록 보여주기 메소드
	List<CartVO> cartList(String userid);
	
	// 장바구니 개별삭제 메소드
	void cartDeleteOne(String pk_cartno);
	
	// 장바구니 전체삭제(장바구니 비우기) 메소드
	void cartDeleteAll(String userid);
	
	// ?
	void cartUpdate(String pk_cartno);
	
	// 장바구니 금액 합계 메소드
	int cartTotalPrice(String userid);
	
	// 장바구니 상품 개수 메소드
	int cartTotalQty(String userid, String pk_pro_num);
	
	// 장바구니 수정 메소드
	void cartUpdate(CartVO cvo);
	
	// 장바구니 수량변경 메소드
	void cartModify(CartVO cvo);
	
	
	
	// 장바구니의 목록을 관심상품으로 등록하기 메소드
	
}

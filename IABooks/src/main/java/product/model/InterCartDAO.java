package product.model;

import java.sql.SQLException;
import java.util.List;

public interface InterCartDAO {
	
	
	// 카트 추가하기 메소드 완료
	public int addCart(CartVO cart) throws SQLException;
	
	// 카트 삭제하기 메소드 완료
	public int deleteCart(String pk_cartno) throws SQLException;
	
	// 카트 수량 수정하기 메소드 완료
	public int modifyCount(CartVO cart) throws SQLException;
	
	// 카트 목록 확인하기 메소드 완료
	public List<CartVO> getCart(String fk_userid) throws SQLException;
	
	// 카트 확인하기 메소드 완료
	public CartVO checkCart(CartVO cart) throws SQLException;
	
	
	/*
	
	// 장바구니 전체삭제(장바구니 비우기) 메소드
	void cartDeleteAll(String userid);
	
	// 장바구니 금액 합계 메소드
	int cartTotalPrice(String userid);
	
	// 장바구니 상품 개수 메소드
	int cartTotalQty(String userid, String pk_pro_num);
	
	// 장바구니 수정 메소드
	void cartUpdate(CartVO cvo);
		
	// 장바구니의 목록을 관심상품으로 등록하기 메소드

	 */
	
}

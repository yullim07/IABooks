package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterCartDAO {
	
	// 장바구니 목록 보여주기 메소드
	List<CartVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException;
	
	// 장바구니에서 상품의 수량을 변경하는 메소드
	
	// 장바구니에 상품을 추가하는 메소드
	
	// 장바구니에서 상품을 삭제하는 메소드 (전체삭제와 선택삭제 각각 구현?)
	
	// 장바구니의 목록을 관심상품 등록
	
}

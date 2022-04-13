package product.controller3.test;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import member.model.CouponVO;

public interface TestInterProductDAO {

	// 관심상품 조회하기 메소드
	List<WishListVO> getWishList(String fk_userid) throws SQLException;

	// 관심상품 선택 제품 삭제 버튼 클릭시 삭제
	int wishDeleteOne(Map<String, String> paraMap) throws SQLException;

	// 관심상품에서 체크박스 선택 후 삭제하기
	int wishDeleteSelect(Map<String, String> paraMap) throws SQLException;

	// 관심상품 모두 비우기
	int deleteWishAll(Map<String, String> paraMap) throws SQLException;
	
	//관심상품에서 로그인한 유저가 사용가능한 쿠폰 
	List<CouponVO> userCoupon(Map<String, String> paraMap) throws SQLException;

	// 관심상품 선택상품 주문하기(미사용)
	WishListVO orderSelect(Map<String, String> paraMap) throws SQLException;

	// 관심상품에서 선택한 totalPrice조회
	int totalPriceSelectWishList(Map<String, String> paraMap) throws SQLException;

	// 선택 탭에서 장바구니 담기를 클릭한 관심상품의 값을 장바구니 테이블로 넘기기
	String getOneWishPnum(Map<String, String> paraMap) throws SQLException;

	//장바구니에 추가할 상품개수랑 재고량비교(테스트용)
	Map<String, Integer> qtyCheck(Map<String, String> paraMap) throws SQLException;

	//현재 유저가 장바구니에 가지고있는 제품수(테스트용)
	Map<String, Integer> cartQtyCheck(Map<String, String> paraMap) throws SQLException;

	// 관심상품에 있는 목록의 제품번호 모두 담기
	void insertWishToCartAll(Map<String, String> paraMap) throws SQLException;

	// 내 관심상품 목록에 있는지 검사
	int checkInWishList(Map<String, String> paraMap) throws SQLException;

	// 관심상품에 보고있는 상품을 insert
	int AddWishList(Map<String, String> paraMap) throws SQLException;
		
	

}

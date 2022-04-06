package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import member.model.MemberVO;

public interface InterProductDAO {
	
	// 카테고리(종합,인문,사회,과학) select 
	List<ProductVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException;
	// 카테고리(best20) select 
	List<ProductVO> selectCategoryBest20() throws SQLException;
	// 카테고리(newbook) select 
	List<ProductVO> selectCategoryNewBook() throws SQLException;
	// 카테고리(restock) select 
	List<ProductVO> selectCategoryRestock() throws SQLException;
	// 카테고리(oldbook) select 
	List<ProductVO> selectCategoryOldBook() throws SQLException;
	//페이징 처리를 위한 제품에 대한 총페이지 알아오기
	Map<String, Integer> getTotalPage(Map<String, String> paraMap) throws SQLException;
	//페이징 처리를 위한 검색한 제품에 대한 총페이지 알아오기
	Map<String, Integer> getSearchPage(Map<String, String> paraMap) throws SQLException;
	//페이징 처리를 위한 검색한 제품 select
	List<ProductVO> selectPagingSearch(Map<String, String> paraMap) throws SQLException;
	//주문할 회원 아이디 정보 불러오기 ? 삭제예정
	MemberVO oderUserInfo(String userid) throws SQLException;
	//인덱스에서 slidesList 띄우기
	List<ProductVO> selectSlides(Map<String, String> paraMap)throws SQLException;
	//인덱스에서 best책띄우기
	List<ProductVO> selectIndexBest(Map<String, String> paraMap)throws SQLException;
	//인덱스에서 화제의책 띄우기
	List<ProductVO> selectIndexHot()throws SQLException;
	//인덱스에서 이책어때요 띄우기
	List<ProductVO> selectIndexRandom()throws SQLException;
	// 제품번호를 입력받아서 제품의 상세정보를 출력해주는 메소드 구현하기
	ProductVO showBookDetail(String pk_pro_num) throws SQLException;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	////////////////////////////////////////////////////////////
		
	// 장바구니 조회하기 메소드
	List<CartVO> getCart(String fk_userid) throws SQLException;
	
	// 장바구니에 담긴 특정 사용자의 제품 총개수 조회하기
	int getTotalCountCart(String fk_userid) throws SQLException;	
	
	// 장바구니에 상품 추가하기 메소드 (insert)
	int addCart(String fk_userid, String fk_pro_num, String ck_odr_qty) throws SQLException;
	
	// 장바구니 수량 수정하기 메소드 (update)
	int updateCart(CartVO cart) throws SQLException;
	
	// 장바구니 삭제하기 메소드 (delete)
	int deleteCartAll(String fk_userid) throws SQLException;
	
	// 장바구니 선택삭제하기 메소드
	int deleteCartSelect(int pk_cartno) throws SQLException;
	
	// 제품 조회수 증가 메소드
	int plusViewCnt(String pk_pro_num);
	
	// 로그인 된 사용자의 장바구니에 담긴 주문총액합계 및 총포인트합계 가져오기 
	// HashMap<String, Integer> getSumCartPricePoint(String userid) throws SQLException;
	
	// 카트 확인하기
	// CartVO checkCart(CartVO cart) throws SQLException;
	
	// 장바구니 금액 합계 메소드
	// int cartTotalPrice(String userid) throws SQLException;
	
	// 장바구니의 목록을 관심상품으로 등록하기 메소드







	
	
	
	
	
	
	
}

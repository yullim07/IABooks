package product.model;

import java.sql.SQLException;
import java.util.*;
//import java.util.Map;

import member.model.CouponVO;
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
	List<ProductVO> selectSlides(Map<String, String> paraMap) throws SQLException;
	//인덱스에서 best책띄우기
	List<ProductVO> selectIndexBest(Map<String, String> paraMap) throws SQLException;
	//인덱스에서 화제의책 띄우기
	List<ProductVO> selectIndexHot() throws SQLException;
	//인덱스에서 이책어때요 띄우기
	List<ProductVO> selectIndexRandom() throws SQLException;
	// 제품번호를 입력받아서 제품의 상세정보를 출력해주는 메소드 구현하기
	ProductVO showBookDetail(String pk_pro_num) throws SQLException;
	//장바구니에 추가할 상품개수랑 재고량비교
	Map<String, Integer> qtyCheck(Map<String, String> paraMap) throws SQLException;
	//현재 장바구니에 추가할 제품이 장바구니에 있는지 중복체크
	boolean proCartCheck(Map<String, String> paraMap) throws SQLException;
	//장바구니에 중복된 제품이 있어서 수량 update
	int updateAddCart(Map<String, String> paraMap) throws SQLException;
	//장바구니에 제품 추가 insert
	int insertAddCart(Map<String, String> paraMap) throws SQLException;
	//현재 유저가 장바구니에 가지고있는 제품수
	Map<String, Integer> cartQtyCheck(Map<String, String> paraMap) throws SQLException;
	//현재 유저의 장바구니 수량 변경
	int updatePqty(Map<String, String> paraMap) throws SQLException;
	//삭제하기 버튼 클릭시 선택 제품 삭제
	int proDeleteSelect(Map<String, String> paraMap) throws SQLException;
	//partPrice값조회
	int partPriceSelect(Map<String, String> paraMap) throws SQLException;
	//totalPrice조회
	int totalPriceSelect(Map<String, String> paraMap) throws SQLException;
	//장바구니 모두 비우기
	int deleteCartAll(Map<String, String> paraMap) throws SQLException;
	//선택상품 주문하기
	CartVO orderSelect(Map<String, String> paraMap) throws SQLException;
	//전체 상품 주문하기
	List<CartVO> orderAll(Map<String, String> paraMap) throws SQLException;
	//한개 상품 주문하기
	List<CartVO> orderOne(Map<String, String> paraMap) throws SQLException;
	//로그인한 유저가 사용가능한 쿠폰 
	List<CouponVO> userCoupon(Map<String, String> paraMap)throws SQLException;
	// 장바구니 조회하기 메소드
	List<CartVO> getCart(String fk_userid) throws SQLException;
	//선택한 totalPrice조회
	int totalPriceSelect2(Map<String, String> paraMap) throws SQLException;
	//선택한 cartNoCheck 조회
	Map<String, String> cartNoCheck(Map<String, String> paraMap) throws SQLException;
	//선택한 cartNoCheck 조회
	String cpriceCheck(Map<String, String> paraMap) throws SQLException;
	//오더테이블에 결제 정보추가
	int orderInsert(Map<String, String> paraMap) throws SQLException;
	
	// 카테고리 목록 가져오기
		// tbl_category 테이블에서 카테고리 대분류 번호(cnum), 카테고리코드(code), 카테고리명(cname)을 조회해오기 
		// VO 를 사용하지 않고 Map 으로 처리
		List<HashMap<String, String>> getCategoryList() throws SQLException;

		// spec 목록을 보여주고자 한다. 
		// List<SpecVO> selectSpecList() throws SQLException;

		// 제품번호 채번 해오기
		// int getPnumOfProduct() throws SQLException;

		// tbl_product 테이블에 제품정보 insert 하기 
		int productInsert(ProductVO pvo) throws SQLException;

		// tbl_product_imagefile 테이블에 insert 하기 << 추가이미지 테이블
//		int product_imagefile_Insert(Map<String, String> paraMap) throws SQLException;

		// 제품번호를 가지고서 해당 제품의 정보를 조회해오기 
		ProductVO selectOneProductByPnum(String pk_pro_num) throws SQLException;

		// 제품번호를 가지고서 해당 제품의 추가된 이미지 정보를 조회해오기 
		List<String> getImagesByPnum(String pk_pro_num) throws SQLException;
		
		
		
		
		
		

		// 장바구니 테이블에 해당 제품이 존재하지 않는 경우에는 tbl_cart 테이블에 insert를 해야 하고,
		// 장바구니 테이블에 해당 제품이 존재하는 경우에는 또 그 제품을 추가해서 장바구니 담기를 한다면 tbl_cart 테이블에 update를 한다.
//		int addCart(Map<String, String> paraMap) throws SQLException;

		// 로그인한 사용자의 장바구니 목록을 조회하기
//		List<CartVO> selectProductCart(String userid) throws SQLException;
		
		// 매뉴얼 이름 가져오는 건데 필요없음 
//		Map<String, String> getPrdmanualFileName(String pk_pro_num) throws SQLException;
			
	

	

	
	
	
	
	
	
	
}

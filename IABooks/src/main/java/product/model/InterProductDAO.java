package product.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import member.model.MemberVO;
import product.model.CartVO;
import product.model.ProductVO;
// import product.model.SpecVO;

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
	int deleteCartSelect(CartVO cart) throws SQLException;
	
	// 제품 조회수 증가 메소드
	int plusViewCnt(String pk_pro_num);
	
	// 로그인 된 사용자의 장바구니에 담긴 주문총액합계 및 총포인트합계 가져오기 
	// HashMap<String, Integer> getSumCartPricePoint(String userid) throws SQLException;
	
	// 카트 확인하기
	// CartVO checkCart(CartVO cart) throws SQLException;
	
	// 장바구니 금액 합계 메소드
	// int cartTotalPrice(String userid) throws SQLException;
	
	// 장바구니의 목록을 관심상품으로 등록하기 메소드

	// 제품등록하기 메소드
	
	// 제품정가와 판매가가 같도록 만들어주는 메소드? 여기에?
	


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

	// tbl_product_imagefile 테이블에 insert 하기 
	int product_imagefile_Insert(Map<String, String> paraMap) throws SQLException;

	// 제품번호를 가지고서 해당 제품의 정보를 조회해오기 
	ProductVO selectOneProductByPnum(String pnum) throws SQLException;

	// 제품번호를 가지고서 해당 제품의 추가된 이미지 정보를 조회해오기 
	List<String> getImagesByPnum(String pnum) throws SQLException;

	// 제품번호를 가지고서 해당 제품의 제품설명서 텀부파일의 서버에 업로드 된 파일명과 오리지널 파일명 알아오기
	Map<String, String> getPrdmanualFileName(String pnum) throws SQLException;
	
	// 장바구니 테이블에 해당 제품이 존재하지 않는 경우에는 tbl_cart 테이블에 insert를 해야 하고,
	// 장바구니 테이블에 해당 제품이 존재하는 경우에는 또 그 제품을 추가해서 장바구니 담기를 한다면 tbl_cart 테이블에 update를 한다.
	int addCart(Map<String, String> paraMap) throws SQLException;

	// 로그인한 사용자의 장바구니 목록을 조회하기
	List<CartVO> selectProductCart(String userid) throws SQLException;
		
}
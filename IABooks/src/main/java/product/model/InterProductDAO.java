package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//팀장님////////////////////////////////////////////
	
	// 제품번호를 입력받아서 제품의 상세정보를 출력해주는 메소드 구현하기 (select) <= 단일VO가 아니므로 리턴타입은 List로? => wvo를 pvo에 추가해서 단일 vo로 사용가능, 나중에 insert하려면 vo 쓰는 게 좋다?
	ProductVO showBookDetail(String pk_pro_num) throws SQLException;
		
	// 상품 조회수 증가시키기 제품번호를 받아서 상세보기 한 번 클릭할 때마다 조회수 증가시키기 메소드
	int plusViewCnt(String pk_pro_num) throws SQLException;

	// 장바구니에 상품 정보 넘기기 메소드
	List<CartVO> getCartList(String userid);
	
	// 상품 삭제하기 delete
	//	public int deleteProduct() throws SQLException;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//////////////////////////////////////////////
	
	// 제품코드를 받아와서 상품 상세보기 select 메소드 <= 단일VO가 아니므로 리턴타입은 List로, 파라미터는 String으로? 아니면 Map으로?
	// 
	// ProductVO showProductDetail(String pk_pro_num) throws SQLException;
	// ProductVO showProductDetail(Map<String, String> paraMap) throws SQLException;
	// List<ProductVO> showProductDetail(Map<String, String> paraMap) throws SQLException;
	List<ProductVO> showProductDetail(String pk_pro_num) throws SQLException;
	
	// 상품 조회수 증가시키기 제품번호를 받아서 상세보기 한 번 클릭할 때마다 조회수 증가시키기 메소드 <= String 제품번호, int 클릭수
	int plusViewCnt(Map<String, String> paraMap) throws SQLException;
	// int coinUpdate(Map<String, String> paraMap) throws SQLException;
	
	
	

	
	








































	
	// 상품 삭제하기 delete
	//	public int deleteProduct() throws SQLException;







































	
	
	
	
	
	
	
}

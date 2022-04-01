package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {
	
	// 카테고리(종합,인문,사회,과학) select 
	List<ProductVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException;

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
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

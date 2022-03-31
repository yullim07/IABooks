package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {
	
	// 카테고리(종합,인문,사회,과학) select 
	List<ProductVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException;

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//////////////////////////////////////////////
	
	// 상품 상세보기 select
	ProductVO showProductDetail(Map<String, String> paraMap) throws SQLException;
	
	// 상품 삭제하기 delete
	//	public int deleteProduct() throws SQLException;







































	
	
	
	
	
	
	
}

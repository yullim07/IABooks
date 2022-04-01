package product.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import member.model.MemberVO;

public interface InterProductDAO {
	
	// 카테고리(종합,인문,사회,과학) select 
	List<ProductVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException;

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//////////////////////////////////////////////
	
	// 제품번호를 입력받아서 제품의 상세정보를 출력해주는 메소드 구현하기 (select) <= 단일VO가 아니므로 리턴타입은 List로? => wvo를 pvo에 추가해서 단일 vo로 사용가능, 나중에 insert하려면 vo 쓰는 게 좋다?
	ProductVO showBookDetail(String pk_pro_num) throws SQLException;
		
	// 상품 조회수 증가시키기 제품번호를 받아서 상세보기 한 번 클릭할 때마다 조회수 증가시키기 메소드 <= String 제품번호, int 클릭수
	int plusViewCnt(Map<String, String> paraMap) throws SQLException;
	// int coinUpdate(Map<String, String> paraMap) throws SQLException; 참조
	
	// 상품 삭제하기 delete
	//	public int deleteProduct() throws SQLException;







































	
	
	
	
	
	
	
}

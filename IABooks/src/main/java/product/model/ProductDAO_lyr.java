package product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class ProductDAO_lyr implements InterProductDAO {

	private DataSource ds;    // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 기본생성자
	public ProductDAO_lyr() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semiorauser3");
		    
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	// 자원반납 해주는 메소드
	private void close() {
		
		try {
			if(rs != null)    {rs.close();	  rs = null;}
			if(pstmt != null) {pstmt.close(); pstmt = null;}
			if(conn != null)  {conn.close();  conn = null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
	} // end of private void close()-------------------------------------

	
	@Override
	public List<ProductVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	
	// 상품 상세보기 select
	@Override
	public ProductVO showProductDetail(Map<String, String> paraMap) throws SQLException {
		
		ProductVO pvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " select * "
						+ "	from tbl_product "
						+ " where pk_pro_num = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("pk_pro_num"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 1개의 행만 나오니까 if문 사용

				pvo = new ProductVO();
				
				pvo.setPk_pro_num(rs.getString(1));
				pvo.setFk_cate_num(rs.getInt(2));
				pvo.setPro_name(rs.getString(3));
				pvo.setPro_publish_date(rs.getString(4));
				pvo.setPublisher(rs.getString(5));
				pvo.setPro_price(rs.getInt(6));
				pvo.setPro_saleprice(rs.getInt(8));
				pvo.setPro_index(rs.getString(9));
				pvo.setPoint_rate(rs.getInt(10));
				pvo.setPro_inputdate(rs.getString(11));
				pvo.setPro_qty(rs.getInt(12));
				pvo.setPro_sales(rs.getInt(13));
				pvo.setPro_viewcnt(rs.getInt(14));
				pvo.setPro_size(rs.getString(15));
				pvo.setPro_bindtype(rs.getString(16));
				pvo.setPro_pages(rs.getInt(17));
				pvo.setPro_imgfile_name(rs.getString(18));
				pvo.setFk_wr_code(rs.getInt(19));
				pvo.setPro_content(rs.getString(20));
				
				/*
					if(rs.getInt(12) == rs.getInt(13)) { // 판매량과 재고량이 같아지면 품절 
					}
				*/
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return pvo;		
	}

	
	
	
	// 상품 조회수 증가시키기 제품번호를 받아서 상세보기 한 번 클릭할 때마다 조회수 증가시키기 메소드
	@Override
	public int plusViewCnt(Map<String, String> paraMap) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_product set pro_viewcnt = pro_viewcnt + 1 "
					   + " where pk_pro_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("pk_pro_num"));
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return result;
	}

	/*
	 * @Override public ProductVO getProNum(ResultSet rs) throws SQLException { //
	 * TODO Auto-generated method stub return null; }
	 */
	
	
	
}
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

	
	// pk_pro_num값을 받아서 상품 상세정보를 보여주는 상품 상세보기 메소드 구현하기
	// 여러 개의 테이블을 조인해야 하므로 VO를 각각 만들어주거나, Map을 사용해주는 것이다!
	/*
	@Override
	public ProductVO showProductDetail(String pk_pro_num) throws SQLException {
		
		ProductVO pvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " SELECT "
						+ " A.pro_name, A.pro_imgfile_name, A.pro_price, "
						+ " A.fk_wr_code, B.wr_name, A.publisher, A.pro_publish_date, "
						+ " A.fk_cate_num, C.cate_name, A.pk_pro_num, A.pro_saleprice, "
						+ " A.pro_index, A.pro_content, B.wr_info, "
						+ " A.pro_inputdate, A.pro_qty, A.pro_sales, A.pro_viewcnt "
						+ " FROM tbl_product A "
						+ " LEFT OUTER JOIN tbl_writer B ON A.fk_wr_code = B.pk_wr_code "
						+ " LEFT OUTER JOIN tbl_category C ON A.fk_cate_num = C.pk_cate_num "
						+ " WHERE pk_pro_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pk_pro_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 1개의 행만 나오니까 if문 사용

				pvo = new ProductVO();
				
				// 이거 다시!
				pvo.setPro_name(rs.getString(1));
				pvo.setPro_imgfile_name(rs.getString(1));
				pvo.setPro_price(rs.getInt(6));
				pvo.setFk_wr_code(rs.getInt(19));
				pvo.setFk_wr_code(0);
				
				pvo.setFk_wr_code(0);
				
				A.publisher, A.pro_publish_date, "
						+ " A.fk_cate_num, C.cate_name, A.pk_pro_num, A.pro_saleprice, "
						+ " A.pro_index, A.pro_content, B.wr_info, "
						+ " A.pro_inputdate, A.pro_qty, A.pro_sales, A.pro_viewcnt "
						
				
				pvo.
				
				
				
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
				
				pvo.setPro_content(rs.getString(20));
				
				
				//	if(rs.getInt(12) == rs.getInt(13)) { // 판매량과 재고량이 같아지면 품절 
				//	}
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return pvo;		
	}

	*/
	
	// 상품의 상세정보를 출력해주는 메소드 구현하기
	
/*	@Override
	// public List<ProductVO> showProductDetail(Map<String, String> paraMap) throws SQLException {
	
	public List<ProductVO> showProductDetail(String pk_) throws SQLException {
		
		// JOIN을 사용하면 단일 VO 클래스가 아니기 때문에 vo를 만들거나 map을 사용해야 한다.
		List<ProductVO> p_list = new ArrayList<>(); 
		
	//	ProductVO pvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " SELECT "
						+ " A.pro_name, A.pro_imgfile_name, A.pro_price, "
						+ " A.fk_wr_code, B.wr_name, A.publisher, A.pro_publish_date, "
						+ " A.fk_cate_num, C.cate_name, A.pk_pro_num, A.pro_saleprice, "
						+ " A.pro_index, A.pro_content, B.wr_info, "
						+ " A.pro_inputdate, A.pro_qty, A.pro_sales, A.pro_viewcnt "
						+ " FROM tbl_product A "
						+ " LEFT OUTER JOIN tbl_writer B ON A.fk_wr_code = B.pk_wr_code "
						+ " LEFT OUTER JOIN tbl_category C ON A.fk_cate_num = C.pk_cate_num "
						+ " WHERE pk_pro_num = ? ";
			
		//	String pk_pro_num = paraMap.get("pk_pro_num");
			
			pstmt = conn.prepareStatement(sql);
			
			  */ 
			
	
			
			/*
				pstmt.setString(1, pk_pro_num);
				pstmt.setString(1, paraMap.get("pro_name"));
				pstmt.setString(2, paraMap.get("pro_imgfile_name"));
				pstmt.setString(3, paraMap.get("pro_price"));
				pstmt.setString(4, paraMap.get("fk_wr_code"));
				pstmt.setString(5, paraMap.get("wr_name"));
				pstmt.setString(6, paraMap.get("publisher"));
				pstmt.setString(7, paraMap.get("pro_publish_date"));
				pstmt.setString(8, paraMap.get("fk_cate_num"));
				pstmt.setString(9, paraMap.get("cate_name"));
				pstmt.setString(10, paraMap.get("pk_pro_num"));
				pstmt.setString(11, paraMap.get("pro_saleprice"));
				pstmt.setString(12, paraMap.get("pro_index"));
				pstmt.setString(13, paraMap.get("pro_content"));
				pstmt.setString(14, paraMap.get("wr_info"));
				pstmt.setString(15, paraMap.get("pro_inputdate"));
				pstmt.setString(16, paraMap.get("pro_qty"));
				pstmt.setString(17, paraMap.get("pro_sales"));
				pstmt.setString(18, paraMap.get("pro_viewcnt"));
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 1개의 행만 나오니까 if문 사용

				pvo = new ProductVO();
				
				
				//pstmt.setString(1, paraMap.get("pro_name"));
				//pstmt.setString(2, paraMap.get("pro_imgfile_name"));
				//pstmt.setString(3, paraMap.get("pro_price"));
				//pstmt.setString(4, paraMap.get("fk_wr_code"));
				pstmt.setString(5, paraMap.get("wr_name"));
				pstmt.setString(6, paraMap.get("publisher"));
				pstmt.setString(7, paraMap.get("pro_publish_date"));
				pstmt.setString(8, paraMap.get("fk_cate_num"));
				pstmt.setString(9, paraMap.get("cate_name"));
				pstmt.setString(10, paraMap.get("pk_pro_num"));
				pstmt.setString(11, paraMap.get("pro_saleprice"));
				pstmt.setString(12, paraMap.get("pro_index"));
				pstmt.setString(13, paraMap.get("pro_content"));
				pstmt.setString(14, paraMap.get("wr_info"));
				pstmt.setString(15, paraMap.get("pro_inputdate"));
				pstmt.setString(16, paraMap.get("pro_qty"));
				pstmt.setString(17, paraMap.get("pro_sales"));
				pstmt.setString(18, paraMap.get("pro_viewcnt"));
				
				List<ProductVO>
				
				
				pvo.setPro_name(rs.getString(1));
				pvo.setPro_imgfile_name(rs.getString(1));
				pvo.setPro_price(rs.getInt(6));
				pvo.setFk_wr_code(rs.getInt(19));
				// 작가이름
				pvo.setPublisher(rs.getString(5));
				pvo.setPro_publish_date(rs.getString(4));
				pvo.setFk_cate_num(rs.getInt(2));
				pvo.setPro_content(rs.getString(20));
				pvo.setPro_inputdate(rs.getString(11));
				pvo.setPro_qty(rs.getInt(12));
				pvo.setPro_sales(rs.getInt(13));
				pvo.setPro_viewcnt(rs.getInt(14));
				
				pvo.setFk_wr_code(0);
				pvo.setFk_wr_code(0);
				pvo.setFk_cate_num(rs.getInt(2));
				pvo.setPro_name(rs.getString(3));
				
				
				pvo.setPro_price(rs.getInt(6));
				pvo.setPro_saleprice(rs.getInt(8));
				pvo.setPro_index(rs.getString(9));
				pvo.setPoint_rate(rs.getInt(10));
				
				
				pvo.setPro_size(rs.getString(15));
				pvo.setPro_bindtype(rs.getString(16));
				pvo.setPro_pages(rs.getInt(17));
				pvo.setPro_imgfile_name(rs.getString(18));
				
				
				
				
				//	if(rs.getInt(12) == rs.getInt(13)) { // 판매량과 재고량이 같아지면 품절 
				//	}
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return pvo;
	}
	*/
	
	
	
	
	// ============================================================================================================
	// ============================================================================================================
	// ============================================================================================================
	
	@Override
	public List<ProductVO> showProductDetail(String pk_pro_num) throws SQLException {
		
		// List<ProductVO> list = new ArrayList<>();
		
		List<ProductVO> list = null;
		ProductVO pvo = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql =  " SELECT "
						+ " A.pro_name, A.pro_imgfile_name, A.pro_price, "
						+ " A.fk_wr_code, B.wr_name, A.publisher, A.pro_publish_date, "
						+ " A.fk_cate_num, C.cate_name, A.pk_pro_num, A.pro_saleprice, "
						+ " A.pro_index, A.pro_content, B.wr_info, "
						+ " A.pro_inputdate, A.pro_qty, A.pro_sales, A.pro_viewcnt "
						+ " FROM tbl_product A "
						+ " LEFT OUTER JOIN tbl_writer B ON A.fk_wr_code = B.pk_wr_code "
						+ " LEFT OUTER JOIN tbl_category C ON A.fk_cate_num = C.pk_cate_num "
						+ " WHERE pk_pro_num = ? ";
			
		//	String pk_pro_num = paraMap.get("pk_pro_num");
			
			pstmt = conn.prepareStatement(sql);
			rs= pstmt.executeQuery();
			
			if(rs.next()) { // 쿼리를 실행하면 1개의 행만이 출력된다! 
				
				pvo = new ProductVO();
				pvo.setPro_name(rs.getString(1));
				pvo.setPro_name(rs.getString(1));
				pvo.setPro_imgfile_name(rs.getString(1));
				pvo.setPro_price(rs.getInt(6));
				pvo.setFk_wr_code(rs.getInt(19));
				// 작가이름
				pvo.setPublisher(rs.getString(5));
				pvo.setPro_publish_date(rs.getString(4));
				pvo.setFk_cate_num(rs.getInt(2));
				pvo.setPro_content(rs.getString(20));
				pvo.setPro_inputdate(rs.getString(11));
				pvo.setPro_qty(rs.getInt(12));
				pvo.setPro_sales(rs.getInt(13));
				pvo.setPro_viewcnt(rs.getInt(14));
				
				pvo.setFk_wr_code(0);
				pvo.setFk_wr_code(0);
				pvo.setFk_cate_num(rs.getInt(2));
				pvo.setPro_name(rs.getString(3));
				
				
				pvo.setPro_price(rs.getInt(6));
				pvo.setPro_saleprice(rs.getInt(8));
				pvo.setPro_index(rs.getString(9));
				pvo.setPoint_rate(rs.getInt(10));
				
				
				pvo.setPro_size(rs.getString(15));
				pvo.setPro_bindtype(rs.getString(16));
				pvo.setPro_pages(rs.getInt(17));
				pvo.setPro_imgfile_name(rs.getString(18));
				
				list.add(pvo);
				
			}
			return list;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
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

	



	


}
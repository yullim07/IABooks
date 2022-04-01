package product.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import member.model.MemberVO;


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

	// 페이지 ~~
	@Override
	public List<ProductVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException {
		
		return null;
		
	}

	// 제품번호를 입력받아서 제품의 상세정보를 출력해주는 메소드 구현하기
	@Override
	public ProductVO showBookDetail(String pk_pro_num) throws SQLException {
		
		ProductVO pvo = null;
		CategoryVO cvo = null;	// new CategoryVO();
		WriterVO wvo = null;	// new WriterVO();
		
		try {
			conn = ds.getConnection();			
					
			String sql =  " SELECT "					
						+ " A.pro_name, A.pro_imgfile_name, A.pro_saleprice, "
						+ " A.fk_wr_code, B.wr_name, A.publisher, A.pro_publish_date, "
						+ " A.fk_cate_num, C.cate_name, A.pro_bindtype, A.pro_pages, A.pro_size, "
						+ "	A.pk_pro_num, A.pro_price, "
						+ "	A.pro_index, A.pro_content, B.wr_info, "
						+ "	A.pro_inputdate, A.pro_qty, A.pro_sales, A.pro_viewcnt "
						+ "	FROM "
						+ " tbl_product A "
						+ "	LEFT OUTER JOIN tbl_writer B ON A.fk_wr_code = B.pk_wr_code "
						+ " LEFT OUTER JOIN tbl_category C ON A.fk_cate_num = C.pk_cate_num "
						+ " WHERE "
						+ " pk_pro_num = ? ";
			/*
			 * 도서정보 (도서명, 판매가, 이미지파일명)
			 * 품목정보 (도서명, 저자명, 출판사, 출간일, 카테고리명, 제본, 쪽수, 크기, 상품코드, 정가)
			 * 책소개 / 저자소개 / 목차
			 */
			// LEFT OUTER JOIN을 사용했다.

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pk_pro_num);
			
			rs = pstmt.executeQuery(); // 결과값은 1개의 행이 나온다!
			
			if(rs.next()) { // 결과값이 1개만 나오기 때문에 while문을 사용할 필요가 없다!
				
				pvo = new ProductVO();
				cvo = new CategoryVO();
				wvo = new WriterVO();
				
				/*
					pro_name
					pro_imgfile_name
					pro_saleprice			int
					fk_wr_code				int
					wr_name
					publisher
					pro_publish_date
					fk_cate_num				int
					cate_name
					pro_bindtype
					pro_pages				int
					pro_size
					pk_pro_num
					pro_price				int
					pro_index
					pro_content
					wr_info
					pro_inputdate
					pro_qty					int
					pro_sales				int
					pro_viewcnt				int
				*/
				
				pvo.setPro_name(rs.getString(1));
				pvo.setPro_imgfile_name(rs.getString(2));
				pvo.setPro_saleprice(Integer.parseInt(rs.getString(3)));	
				pvo.setFk_wr_code(Integer.parseInt(rs.getString(4)));				
				wvo.setWr_name(rs.getString(5));			// 작가이름
				pvo.setPublisher(rs.getString(6));
				pvo.setPro_publish_date(rs.getString(7));
				pvo.setFk_cate_num(Integer.parseInt(rs.getString(8)));
				cvo.setCate_name(rs.getString(9));
				pvo.setPro_bindtype(rs.getString(10));
				pvo.setPro_pages(Integer.parseInt(rs.getString(11)));		
				pvo.setPro_size(rs.getString(12));
				pvo.setPk_pro_num(rs.getString(13));
				pvo.setPro_price(Integer.parseInt(rs.getString(14)));			
				pvo.setPro_index(rs.getString(15));
				pvo.setPro_content(rs.getString(16));
				
				pvo.setPro_inputdate(rs.getString(17));
				pvo.setPro_qty(Integer.parseInt(rs.getString(18)));	
				pvo.setPro_sales(Integer.parseInt(rs.getString(19)));			
				pvo.setPro_viewcnt(Integer.parseInt(rs.getString(20)));
				
				/*
				wvo.setWr_info(rs.getString(17));						// CLOB 선언 방법을 모르겠음
				pvo.setPro_inputdate(rs.getString(18));
				pvo.setPro_qty(Integer.parseInt(rs.getString(19)));	
				pvo.setPro_sales(Integer.parseInt(rs.getString(20)));			
				pvo.setPro_viewcnt(Integer.parseInt(rs.getString(21)));
				*/
			}
			
		} finally {
			close();
		}
		return pvo;
	}
	
	
	
	
	@Override
	public int plusViewCnt(Map<String, String> paraMap) throws SQLException {
		
		return 0;
	}

	

	
	
	


}
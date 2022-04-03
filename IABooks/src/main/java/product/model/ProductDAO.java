package product.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class ProductDAO implements InterProductDAO {
	
	private DataSource ds;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	//생성자
	public ProductDAO() {
		try {
			//DB Connection Pool
	         Context initContext = new InitialContext();
	         Context envContext  = (Context)initContext.lookup("java:/comp/env");
	         ds = (DataSource)envContext.lookup("jdbc/semiorauser3");
		    //lookup"jdbc/myoracle" 이름은 web.xml이름과 같아야한다.
		   
			//aes = new AES256(SecretMyKey.KEY); //SecretMyKey.KEY우리가만든 비밀키
		     
		}catch (NamingException e) {
			e.printStackTrace();
		}
	}//end of public PersonDAO_04()
	
	//자원반납 해주는 메소드
	private void close() {
		try {
			if(rs != null) {rs.close(); rs = null;}
			if(pstmt != null) {pstmt.close(); pstmt = null;}
			if(conn != null) {conn.close(); conn = null;}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//end of private void close()

	//카테고리(종합,인문,사회,과학) select 
	@Override
	public List<ProductVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException {
		List<ProductVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo") );//숫자타입으로 변환
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage") );
			String category = paraMap.get("category");
			
			String sql =" select pro_name, pro_saleprice, pro_imgfile_name, cate_name "
						+ " from "
						+ " ( "
							+ " select rownum as rno, pro_name, pro_saleprice, pro_imgfile_name, cate_name "
							+ " from "
							+ " ( "
								+ " select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales "
								+ " from tbl_product "
								+ " order by pro_name "
							+ " )A "
							+ " JOIN "
							+ " TBL_CATEGORY B "
							+ " on fk_cate_num = pk_cate_num ";
							
			if("total".equalsIgnoreCase(category)) {
				sql += " )V "
					+ " where rno between ? and  ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) );
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) );
			}else {
				sql += " where cate_name = ? "
					+ " )V "
					+ " where rno between ? and  ? ";
				
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, category);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) );
				pstmt.setInt(3, (currentShowPageNo * sizePerPage) );
			}
							
					
					
					
					
					/*" select pro_name, pro_saleprice, pro_imgfile_name, cate_name "
					+ " from"
					+ " ( "
						+ " select rno, pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales "
						+ " from "
						+ " ( "
							+ " select rownum as rno, pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales "
							+ " from "
							+ " ( "
								+ " select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales "
								+ " from tbl_product "
								+ " order by pro_name "
							+ " )V "
						+ " )T "
						+ " where rno between ? and ? "
					+ " )A "
					+ " JOIN "
					+ " TBL_CATEGORY B "
					+ " on fk_cate_num = pk_cate_num ";*/
					
					


					/*
					 * pstmt = conn.prepareStatement(sql);
					 * 
					 * pstmt.setInt(1,1); pstmt.setInt(2,10); pstmt.setInt(1, (currentShowPageNo *
					 * sizePerPage) - (sizePerPage - 1) ); pstmt.setInt(2, (currentShowPageNo *
					 * sizePerPage) );
					 * 
					 */
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO pvo = new ProductVO();
				CategoryVO cvo = new CategoryVO();
				
				pvo.setPro_name(rs.getString(1));
				pvo.setPro_saleprice(rs.getInt(2));
				pvo.setPro_imgfile_name(rs.getString(3));
				
				cvo.setCate_name(rs.getString(4));
				pvo.setCategory(cvo);

				productList.add(pvo);
			}
			
		} finally  {
			close();
		}
		
		return productList;
	}//end of public List<ProductVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException

	

	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
// ============================================================================================

	// 제품번호를 입력받아서 제품의 상세정보를 출력해주는 메소드 구현하기
	@Override
	public ProductVO showBookDetail(String pk_pro_num) throws SQLException {
		
		ProductVO pvo = new ProductVO(); 
		CategoryVO cvo = new CategoryVO();
		WriterVO wvo = new WriterVO();
		
		try {
			conn = ds.getConnection();			
						
			String sql =  " SELECT "					
						+ " A.pro_name, A.pro_imgfile_name, A.pro_saleprice, "
						+ " A.fk_wr_code, B.wr_name, A.publisher, A.pro_publish_date, "
						+ " A.fk_cate_num, C.cate_name, A.pro_bindtype, A.pro_pages, A.pro_size, "
						+ "	A.pk_pro_num, A.pro_price, "
						+ "	A.pro_index, "
					//	CLOB으로 선언된 책소개, 작가소개 생략 후 진행	
					//	+ " A.pro_content, B.wr_info, "
						+ " A.pro_inputdate, A.pro_qty, A.pro_sales, A.pro_viewcnt "
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
					pro_publish_date		date(String)
					fk_cate_num				int
					cate_name
					pro_bindtype
					pro_pages				int
					pro_size
					pk_pro_num
					pro_price				int
					pro_index
					pro_content				CLOB
					wr_info					CLOB
					pro_inputdate			date(String)
					pro_qty					int
					pro_sales				int
					pro_viewcnt				int
				*/
				
				pvo.setPro_name(rs.getString(1));
				pvo.setPro_imgfile_name(rs.getString(2));
				pvo.setPro_saleprice(rs.getInt(3));	
				pvo.setFk_wr_code(rs.getInt(4));				
				wvo.setWr_name(rs.getString(5));			// 작가이름
				pvo.setPublisher(rs.getString(6));
				pvo.setPro_publish_date(rs.getString(7));
				pvo.setFk_cate_num(rs.getInt(8));
				cvo.setCate_name(rs.getString(9));			// 카텍고리명
				pvo.setPro_bindtype(rs.getString(10));
				pvo.setPro_pages(rs.getInt(11));		
				pvo.setPro_size(rs.getString(12));
				pvo.setPk_pro_num(rs.getString(13));
				pvo.setPro_price(rs.getInt(14));			
				pvo.setPro_index(rs.getString(15));
			//	CLOB 사용법 모르겠음
			//	pvo.setPro_content(rs.getString(16));
			//	wvo.setWr_info(rs.getString(17));
				pvo.setPro_inputdate(rs.getString(16));
				pvo.setPro_qty(rs.getInt(17));
				pvo.setPro_sales(rs.getInt(18));			
				
				int pro_viewcnt = rs.getInt(19);
				pvo.setPro_viewcnt(pro_viewcnt);
				pro_viewcnt++;
				
				plusViewCnt(pk_pro_num);
				
			}
			
		} finally {
			close();
		}
		return pvo;
	}

	@Override
	public int plusViewCnt(String pk_pro_num) throws SQLException {

		try {
			
			conn = ds.getConnection();
			
			String sql =  " update tbl_product "
						+ " set pro_viewcnt = pro_viewcnt + 1 "
						+ " where pk_pro_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pk_pro_num);
			
			int result = pstmt.executeUpdate();
			return result;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return -1; // 데이터베이스 오류
	}

	@Override
	public List<CartVO> getCartList(String fk_userid) {
		
		List<CartVO> cartList = null;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " SELECT * "
						+ " FROM tbl_cart "
						+ " WHERE fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_userid);
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			
			while (rs.next()) { // 결과값이 1개 이상일 수도 있으니까 
				cnt++;
				
				if(cnt == 1) {
					cartList = new ArrayList<CartVO>();
				}
				
				CartVO cvo = new CartVO();
				
				cvo.setPk_cartno(rs.getInt("pk_cartno"));
				cvo.setFK_USERID(rs.getString("fk_userid"));
				cvo.setPk_pro_num(rs.getInt("pk_pro_num"));
				cvo.setCk_odr_qty(rs.getInt("ck_odr_qty"));
				cvo.setCk_cart_register(rs.getDate("ck_cart_register"));			
			}
	
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return cartList;
	}	
}
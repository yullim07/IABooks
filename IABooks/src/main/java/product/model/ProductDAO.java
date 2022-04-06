package product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.security.auth.message.callback.PrivateKeyCallback.Request;
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
	
	//자원반압 해주는 메소드
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
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo") );
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage") );
			String category = paraMap.get("category");
			String sort = paraMap.get("sort");
			
			if("new".equals(sort)) {
				sort = "pro_inputdate desc";
			}else if("name".equals(sort)) {
				sort = "pro_name";
			}else if ("popularity".equals(sort)) {
				sort = "pro_sales desc";
			}
			
			String sql = " select pro_name, pro_saleprice, pro_imgfile_name, cate_name, pk_pro_num "
						+ " from "
						+ " ( "
							+ " select rownum as rno, A.* "
							+ " from "
							+ " ( "
								+ " select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales, pro_soldout, pk_pro_num, cate_name "
								+ " from tbl_product "
								+ " join "
								+ " tbl_category V "
								+ " on fk_cate_num = pk_cate_num ";
															
			if("total".equalsIgnoreCase(category)) {
				sql += " order by "+ sort
					+ " )A "
					+ " )B "
					+ " where rno between ? and  ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) );
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) );
			}else {
				sql += " where cate_name = ? "
						+ " order by "+ sort
						+ " )A "
						+ " )B "
						+ " where rno between ? and  ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, category);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) );
				pstmt.setInt(3, (currentShowPageNo * sizePerPage) );
			}
							
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO pvo = new ProductVO();
				CategoryVO cvo = new CategoryVO();
				
				pvo.setPro_name(rs.getString(1));
				pvo.setPro_saleprice(rs.getInt(2));
				pvo.setPro_imgfile_name(rs.getString(3));
				
				cvo.setCate_name(rs.getString(4));
				pvo.setCategory(cvo);

				pvo.setPk_pro_num(rs.getString(5));
				
				productList.add(pvo);
			}
			
		} finally  {
			close();
		}
		
		return productList;
	}//end of public List<ProductVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException
	
	// 카테고리(best20) select 
	@Override
	public List<ProductVO> selectCategoryBest20() throws SQLException {
		List<ProductVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
					
			String sql =" select pro_name, pro_saleprice, pro_imgfile_name, cate_name, pk_pro_num "
						+ " from "
						+ " ( "
							+ " select rownum as rno, A.* "
							+ " from\r\n"
							+ " ( "
								+ " select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales, pk_pro_num, cate_name "
								+ " from tbl_product "
								+ " join "
								+ " tbl_category V "
								+ " on fk_cate_num = pk_cate_num "
								+ " order by pro_sales desc, pro_name "
							+ " )A "
						+ " )B "
						+ " where rno between 1 and  20 ";
					
			pstmt = conn.prepareStatement(sql);		
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO pvo = new ProductVO();
				CategoryVO cvo = new CategoryVO();
				
				pvo.setPro_name(rs.getString(1));
				pvo.setPro_saleprice(rs.getInt(2));
				pvo.setPro_imgfile_name(rs.getString(3));
				
				cvo.setCate_name(rs.getString(4));
				pvo.setCategory(cvo);
				
				pvo.setPk_pro_num(rs.getString(5));

				productList.add(pvo);
			}
		} finally  {
			close();
		}
		return productList;	
	}//end of public List<ProductVO> selectCategoryBest20() throws SQLException
	
	// 카테고리(newbook) select 
	@Override
	public List<ProductVO> selectCategoryNewBook() throws SQLException {
		List<ProductVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
					
			String sql =" select pro_name, pro_saleprice, pro_imgfile_name, cate_name, pk_pro_num "
						+ " from "
						+ " ( "
						+ " select rownum as rno, A.* "
						+ " from "
						+ " ( "
						+ " select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales, pk_pro_num, cate_name "
						+ " from tbl_product "
						+ " join "
						+ " tbl_category V "
						+ " on fk_cate_num = pk_cate_num "
						+ " where pro_inputdate > add_months(sysdate, -12) "
						+ " order by pro_inputdate desc, pro_name "
						+ " )A "
						+ " )B "
						+ " where rno between 1 and  20";
					
			pstmt = conn.prepareStatement(sql);		
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO pvo = new ProductVO();
				CategoryVO cvo = new CategoryVO();
				
				pvo.setPro_name(rs.getString(1));
				pvo.setPro_saleprice(rs.getInt(2));
				pvo.setPro_imgfile_name(rs.getString(3));
				
				cvo.setCate_name(rs.getString(4));
				pvo.setCategory(cvo);
				
				pvo.setPk_pro_num(rs.getString(5));

				productList.add(pvo);
			}
		} finally  {
			close();
		}
		return productList;	
	
	}//end of public List<ProductVO> selectCategoryNewBook() throws SQLException

	// 카테고리(restock) select 
	@Override
	public List<ProductVO> selectCategoryRestock() throws SQLException {
		List<ProductVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
					
			String sql =" select pro_name, pro_saleprice, pro_imgfile_name, cate_name, pk_pro_num "
						+ " from "
						+ " ( "
							+ " select rownum as rno, A.* "
							+ " from "
							+ " ( "
								+ " select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales, pro_restock, pro_soldout, pk_pro_num, cate_name "
								+ " from tbl_product "
								+ " join "
								+ " tbl_category V "
								+ " on fk_cate_num = pk_cate_num "
								+ " where pro_restock = 1 and pro_soldout = 0 "
								+ " order by pro_inputdate desc, pro_name "
							+ " )A "
						+ " )B "
						+ " where rno between 1 and  20 ";
					
			pstmt = conn.prepareStatement(sql);		
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO pvo = new ProductVO();
				CategoryVO cvo = new CategoryVO();
				
				pvo.setPro_name(rs.getString(1));
				pvo.setPro_saleprice(rs.getInt(2));
				pvo.setPro_imgfile_name(rs.getString(3));
				
				cvo.setCate_name(rs.getString(4));
				pvo.setCategory(cvo);
				
				pvo.setPk_pro_num(rs.getString(5));

				productList.add(pvo);
			}
		} finally  {
			close();
		}
		return productList;	
	}//end of public List<ProductVO> selectCategoryRestock() throws SQLException
	
	// 카테고리(restock) select 
	@Override
	public List<ProductVO> selectCategoryOldBook() throws SQLException {
		List<ProductVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
					
			String sql =" select pro_name, pro_saleprice, pro_imgfile_name, cate_name, pk_pro_num "
						+ " from "
						+ " ( "
							+ " select rownum as rno, A.* "
							+ " from "
							+ " ( "
								+ " select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pro_sales, pro_soldout, pk_pro_num, cate_name "
								+ " from tbl_product "
								+ " join "
								+ " tbl_category V "
								+ " on fk_cate_num = pk_cate_num "
								+ " where pro_soldout = 0 and pro_inputdate < add_months(sysdate, -36) "
								+ " order by dbms_random.random "
							+ " )A "
						+ " )B "
						+ " where rno between 1 and  20 ";
					
			pstmt = conn.prepareStatement(sql);		
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO pvo = new ProductVO();
				CategoryVO cvo = new CategoryVO();
				
				pvo.setPro_name(rs.getString(1));
				pvo.setPro_saleprice(rs.getInt(2));
				pvo.setPro_imgfile_name(rs.getString(3));
				
				cvo.setCate_name(rs.getString(4));
				pvo.setCategory(cvo);
				
				pvo.setPk_pro_num(rs.getString(5));

				productList.add(pvo);
			}
		} finally  {
			close();
		}
		return productList;	
	}//end of public List<ProductVO> selectCategoryRestock() throws SQLException

	//페이징 처리를 위한 제품에 대한 총페이지 알아오기
	@Override
	public Map<String, Integer> getTotalPage(Map<String, String> paraMap) throws SQLException {
		Map<String, Integer> resultMap = new HashMap<String, Integer>();
		
		try {
			conn = ds.getConnection();
			String sql = " select ceil(count(*)/?), count(*) "
						+ " from tbl_product "
						+ " join "
						+ " tbl_category "
						+ " on fk_cate_num = pk_cate_num ";
						
			String category = paraMap.get("category");
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));

			if("total".equalsIgnoreCase(category)) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, sizePerPage);
				
			}else {
				sql += " where cate_name = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, sizePerPage);
				pstmt.setString(2, category);
			}
					
			rs = pstmt.executeQuery();
			rs.next();
			
			resultMap.put("totalPage", rs.getInt(1));
			resultMap.put("totalPro", rs.getInt(2));
			
		} finally {
			close();
		}
		
		return resultMap;
	}//end of public int getTotalPage(Map<String, String> paraMap) throws SQLException
	
	//페이징 처리를 위한 검색한 제품에 대한 총페이지 알아오기
	@Override
	public Map<String, Integer> getSearchPage(Map<String, String> paraMap) throws SQLException {
		Map<String, Integer> resultMap = new HashMap<String, Integer>();
		
		try {
			conn = ds.getConnection();
			String sql = " select ceil(count(*)/?), count(*) "
						+ " from "
						+ " ( "
							+ " select * "
							+ " from tbl_product "
							+ " join "
							+ " tbl_category V "
							+ " on fk_cate_num = pk_cate_num "
						+ " ) "
						+ " join "
						+ " tbl_writer V2 "
						+ " on fk_wr_code = pk_wr_code "
						+ " where pro_name like '%'|| ? ||'%' or publisher like '%'|| ? ||'%' or pk_pro_num like '%'|| ? ||'%' or wr_name like '%'|| ? ||'%'";
		
			String searchWord = paraMap.get("searchWord");
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sizePerPage);
			pstmt.setString(2, searchWord);
			pstmt.setString(3, searchWord);
			pstmt.setString(4, searchWord);
			pstmt.setString(5, searchWord);
			
			rs = pstmt.executeQuery();
			rs.next();
			
			resultMap.put("totalPage", rs.getInt(1));
			resultMap.put("totalPro", rs.getInt(2));
			
		} finally {
			close();
		}
		
		return resultMap;
	}//end of public Map<String, Integer> getSearchPage(Map<String, String> paraMap) throws SQLException

	//페이징 처리를 위한 검색한 제품 select
	@Override
	public List<ProductVO> selectPagingSearch(Map<String, String> paraMap) throws SQLException {
		List<ProductVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo") );
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage") );
			
			String searchWord = paraMap.get("searchWord");
			String sort = paraMap.get("sort");
			
			if("new".equals(sort)) {
				sort = "pro_inputdate desc";
			}else if("name".equals(sort)) {
				sort = "pro_name";
			}else if ("popularity".equals(sort)) {
				sort = "pro_sales desc";
			}
			
			String sql = " select pro_name, pro_saleprice, pro_imgfile_name, cate_name, pk_pro_num "
						+ " from "
						+ " ( "
							+ " select rownum as rno, A.* "
							+ " from "
							+ " ( "
								+ " select * "
								+ " from "
								+ " ( "
									+ " select * "
									+ " from tbl_product "
									+ " join "
									+ " tbl_category V "
									+ " on fk_cate_num = pk_cate_num "
								+ " ) "
								+ " join "
								+ " tbl_writer V2 "
								+ " on fk_wr_code = pk_wr_code "
								+ " where pro_name like '%'|| ? ||'%' or publisher like '%'|| ? ||'%' or pk_pro_num like '%'|| ? ||'%' or wr_name like '%'|| ? ||'%' "
								+ " order by "+sort
							+ " )A "
						+ " )B "
						+ " where rno between ? and ? ";
									
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, searchWord);
			pstmt.setString(2, searchWord);
			pstmt.setString(3, searchWord);
			pstmt.setString(4, searchWord);
			pstmt.setInt(5, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) );
			pstmt.setInt(6, (currentShowPageNo * sizePerPage) );
		
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO pvo = new ProductVO();
				CategoryVO cvo = new CategoryVO();
				
				pvo.setPro_name(rs.getString(1));
				pvo.setPro_saleprice(rs.getInt(2));
				pvo.setPro_imgfile_name(rs.getString(3));
				
				cvo.setCate_name(rs.getString(4));
				pvo.setCategory(cvo);

				pvo.setPk_pro_num(rs.getString(5));
				
				productList.add(pvo);
			}
			
		} finally  {
			close();
		}
		
		return productList;
	}//end of public List<ProductVO> selectPagingSearch(Map<String, String> paraMap) throws SQLException
















	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
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

	// 로그인 된 사용자의 장바구니 데이터 조회결과물 가져오기
	@Override
	public List<CartVO> getCart(String fk_userid) throws SQLException {
		
		List<CartVO> cartList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql =  " SELECT A.pk_cartno, A.fk_userid, A.fk_pro_num "
						+ "      , B.pro_name, B.fk_cate_num, C.cate_name "
						+ "      , B.pro_imgfile_name, B.pro_price, B.pro_saleprice "
						+ "      , A.ck_odr_qty, A.c_status, A.ck_odr_qty*B.pro_saleprice AS totalPrice "
					//	+ "      , A.ck_odr_qty, A.c_status "
						+ "	FROM tbl_cart A LEFT OUTER JOIN tbl_product B "
						+ "	ON A.fk_pro_num = B.pk_pro_num "
		                + "	LEFT OUTER JOIN tbl_category C "
		                + "	ON B.fk_cate_num = C.pk_cate_num "
	                	+ "	WHERE A.c_status = 1 AND A.fk_userid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_userid);
			
			rs = pstmt.executeQuery();
			
			int cnt = 0; // 1이라면 결과값이 null이 아니라는 뜻인가? 아니면
			
			while (rs.next()) { // 결과값이 1개 이상일 수도 있으니까
				
				cnt++;
				
				if(cnt == 1) {
					cartList = new ArrayList<CartVO>();
				}
				
				CartVO cvo = new CartVO();
				ProductVO pvo = new ProductVO();
				CategoryVO catevo = new CategoryVO();
				
				int pk_cartno = rs.getInt("pk_cartno");
				fk_userid = rs.getString("fk_userid");
			//	String pk_pro_num = rs.getString("pk_pro_num");
				String fk_pro_num = rs.getString("fk_pro_num");
				String pro_name = rs.getString("pro_name");
				int fk_cate_num = rs.getInt("fk_cate_num");
				String cate_name = rs.getString("cate_name");
				String pro_imgfile_name = rs.getString("pro_imgfile_name");
				int pro_price = rs.getInt("pro_price");
				int pro_saleprice = rs.getInt("pro_saleprice");
				int ck_odr_qty = rs.getInt("ck_odr_qty");
				int c_status = rs.getInt("c_status");
				int totalPrice = rs.getInt("totalPrice");
				
			//	pvo.setPk_pro_num(pk_pro_num);
				pvo.setPro_name(pro_name);
				pvo.setFk_cate_num(fk_cate_num);
				pvo.setPro_imgfile_name(pro_imgfile_name);
				pvo.setPro_price(pro_price);
				pvo.setPro_saleprice(pro_saleprice);
				
				cvo.setPk_cartno(pk_cartno);
				cvo.setFk_userid(fk_userid);
				cvo.setFk_pro_num(fk_pro_num);
				cvo.setCk_odr_qty(ck_odr_qty);
				cvo.setC_status(c_status);
				cvo.setTotalPrice(totalPrice);
				
				catevo.setCate_name(cate_name);
				
				cvo.setProduct(pvo);
				cvo.setCategory(catevo);
				
				cartList.add(cvo);
			}
	
		} finally {
			close();
		}
		
		return cartList;
	}

	// 장바구니에 들어있는 특정 사용자의 제품의 총 개수 구해오기
	@Override
	public int getTotalCountCart(String fk_userid) throws SQLException {

		int totalCountCart = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql =  " SELCT count(*) AS CNT "
						+ " FROM tbl_cart "
						+ " WHERE fk_userid = ? ";
			// c_status = 1 내용 있음 / 0 없음 (기존제품이 있는지 여부)
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_userid);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalCountCart = rs.getInt("CNT");
			
			
		} finally {
			close();
		}
		return totalCountCart;
	}

	// 장바구니에 추가하기 메소드 + 이미 담은 제품의 경우 수량 추가하기
	@Override
	public int addCart(String fk_userid, String fk_pro_num, String ck_odr_qty) throws SQLException {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " SELECT pk_cartno "
						+ " FROM tbl_cart "
						+ " WHERE "
						+ " c_status = 1 AND fk_userid = ? AND fk_pro_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_userid);
			pstmt.setString(2, fk_pro_num);
			
			rs = pstmt.executeQuery();
			
			// 어떤 제품을 "추가로" 장바구니에 넣고자 하는 경우
			if(rs.next()) {
				
				int pk_cartno = rs.getInt("pk_cartno");
				
				sql = " UPDATE tbl_cart "
					+ " SET ck_odr_qty = ck_odr_qty + ? "
					+ " WHERE c_status = 1 AND pk_cartno = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(ck_odr_qty));
				pstmt.setInt(2, pk_cartno);
				
				result = pstmt.executeUpdate();
			}
			
			// 장바구니에 존재하지 않은 새로운 제품을 넣고자 하는 경우
			sql = " INSERT INTO tbl_cart(pk_cartno, fk_userid, fk_pro_num, ck_odr_qty, c_status) "
				+ " VALUES(seq_cartno.nextval, ?, ?, ?, DEFAULT) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_userid);
			pstmt.setString(2, fk_pro_num);
			pstmt.setInt(3, Integer.parseInt(ck_odr_qty));
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		return result;
	}

		
	// 장바구니에서 특정 물건의 수량 변경하기
	@Override
	public int updateCart(CartVO cart) throws SQLException {
		
		int result = 0;
		CartVO cvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " update tbl_cart "
						+ " set ck_odr_qty = ? "
						+ " where c_status = 1 AND pk_cartno = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cvo.getCk_odr_qty());
			pstmt.setInt(2, cvo.getPk_cartno());
			
			result = pstmt.executeUpdate();
			
			if(result == 1) {
				System.out.println("장바구니 수량변경에 성공했습니다.");
			}
			
			else {
				System.out.println("장바구니 수량변경에 실패했습니다.");
			}
			
		} finally {
			close();
		}
		return result;
	}

	// 장바구니에서 모두 삭제하기 메소드 구현하기
	@Override
	public int deleteCartAll(String fk_userid) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " delete tbl_cart "
						+ " where fk_userid = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, fk_userid);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return result;
	}

	// 장바구니 선택삭제하기 메소드
	@Override
	public int deleteCartSelect(int pk_cartno) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}
}

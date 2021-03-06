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
import javax.sql.DataSource;

import member.model.MemberVO;


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
							+ " from "
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


	// 제품번호를 입력받아서 제품의 상세정보를 출력해주는 메소드 구현하기
	@Override
	public ProductVO showBookDetail(String pk_pro_num) throws SQLException {
		
		ProductVO pvo = new ProductVO(); 
		CategoryVO cvo = new CategoryVO();
		WriterVO wvo = new WriterVO();
		try {
			conn = ds.getConnection();			
						
			String sql = " select pro_name, publisher, pro_publish_date, pro_saleprice, pro_viewcnt, pro_size, nvl(pro_bindtype, ' '), pro_pages, pro_imgfile_name, "
						+ " pk_pro_num, pro_soldout, pro_restock, pro_price, cate_name, wr_name "
					/* + " --nvl(wr_info, ' '), nvl(pro_index, ' '), nvl(pro_content, ' ') " */
						+ " from "
						+ " tbl_product "
						+ " join "
						+ " tbl_writer "
						+ " on fk_wr_code = pk_wr_code "
						+ " join "
						+ " tbl_category "
						+ " on fk_cate_num = pk_cate_num "
						+ " where pk_pro_num = ? ";
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pk_pro_num);
			
			rs = pstmt.executeQuery(); // 결과값은 1개의 행이 나온다!
			
			if(rs.next()) { // 결과값이 1개만 나오기 때문에 while문을 사용할 필요가 없다!
				
				pvo.setPro_name(rs.getString(1));
				pvo.setPublisher(rs.getString(2));
				pvo.setPro_publish_date(rs.getString(3));
				pvo.setPro_saleprice(rs.getInt(4));	
				pvo.setPro_viewcnt(rs.getInt(5));
				pvo.setPro_size(rs.getString(6));
				pvo.setPro_bindtype(rs.getString(7));
				pvo.setPro_pages(rs.getInt(8));		
				pvo.setPro_imgfile_name(rs.getString(9));
				pvo.setPk_pro_num(rs.getString(10));
				pvo.setPro_soldout(rs.getInt(11));
				pvo.setPro_restock(rs.getInt(12));
				pvo.setPro_price(rs.getInt(13));
				
				cvo.setCate_name(rs.getString(14));
				pvo.setCategory(cvo);
				
				wvo.setWr_name(rs.getString(15));
				//wvo.setWr_info(rs.getString(17));
				pvo.setWriter(wvo);
				
				//pvo.setPro_index(rs.getString(15));
				//pvo.setPro_content(rs.getString(16));
				
				viewCount(rs.getString(10));

			}
			
		} finally {
			close();
		}
		return pvo;
	}//end of public ProductVO showBookDetail(String pk_pro_num) throws SQLException 

	//조회수(update)메소드
	public int viewCount(String pk_pro_num) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			String sql = "update tbl_product set pro_viewcnt = pro_viewcnt+1 "
						+ " where pk_pro_num = ? ";
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pk_pro_num);
			
			result = pstmt.executeUpdate();
	
		} finally {
			close();
		}
		
		return result;	
	}//end of public int viewCount(String pk_pro_num) throws SQLException

	
	@Override
	public MemberVO oderUserInfo(String userid) throws SQLException {
		MemberVO mvo = new MemberVO();
		try {
			conn = ds.getConnection();			
						
			String sql = "select mname, postcode, address, detailaddress, extraaddress, uq_phone, uq_email, mileage, coupon "
						+ " from tbl_member "
						+ " where pk_userid = ? ";
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery(); // 결과값은 1개의 행이 나온다!
			
			if(rs.next()) { // 결과값이 1개만 나오기 때문에 while문을 사용할 필요가 없다!
				
				mvo.setName(rs.getString(1));
				mvo.setPostcode(rs.getString(2));
				mvo.setAddress(rs.getString(3));
				mvo.setDetailaddress(rs.getString(4));
				mvo.setExtraaddress(rs.getString(5));
				mvo.setPhone(rs.getString(6));
				mvo.setEmail(rs.getString(7));
				//mvo.setCoupon(rs.getInt(8));
				//mvo.setMileage(rs.getInt(9));	
			}
			
		} finally {
			close();
		}
		
		return mvo;
	}//end of public MemberVO oderUserInfo(String userid) throws SQLException

	public List<ProductVO> selectSlides(Map<String, String> paraMap) throws SQLException {
		List<ProductVO> prodList = new ArrayList<>();
			
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select pro_name, pro_imgfile_name, pk_pro_num, pro_saleprice, cate_name "
						+ " from "
						+ " ( "
							+ " select rownum as rno, A.* "
							+ " from "
							+ " ( "
								+ " select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pk_pro_num, cate_name "
								+ " from tbl_product "
								+ " join "
								+ " tbl_category "
								+ " on fk_cate_num = pk_cate_num "
								+ " order by pro_inputdate desc "
							+ " )A "
						+ " )B "
						+ " where rno between 1 and  ? ";
			 
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, paraMap.get("slidesCnt"));

			 rs = pstmt.executeQuery();
			
			 while(rs.next()) {
	
				 ProductVO pvo = new ProductVO();
				 CategoryVO cvo = new CategoryVO();
				 
				 pvo.setPro_name(rs.getString(1));
				 pvo.setPro_imgfile_name(rs.getString(2));
				 pvo.setPk_pro_num(rs.getString(3));
				 pvo.setPro_saleprice(rs.getInt(4));
				 
				 cvo.setCate_name(rs.getString(5));
				 pvo.setCategory(cvo);
				 
				 prodList.add(pvo);
			 }
			 
		} finally {
			close();
		}
		
		return prodList;
	}//end of public List<ProductVO> selectSlides(Map<String, String> paraMap) throws SQLException

	//인덱스에서 best책띄우기
	@Override
	public List<ProductVO> selectIndexBest(Map<String, String> paraMap) throws SQLException {
		List<ProductVO> prodList = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			 
			 String cate_name = paraMap.get("cate_name");
			 

			 
			 String sql = " select pro_name, pro_imgfile_name, pk_pro_num, pro_saleprice, cate_name "
						+ " from "
						+ " ( "
							+ " select rownum as rno, A.* "
							+ " from "
							+ " ( "
								+ " select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pk_pro_num, cate_name "
								+ " from tbl_product "
								+ " join "
								+ " tbl_category "
								+ " on fk_cate_num = pk_cate_num ";
								
			 if("total".equalsIgnoreCase(cate_name)) {
				sql +=  " order by pro_sales desc, pro_viewcnt desc "
						+ " )A "
						+ " )B "
						+ " where rno between 1 and  7 ";
				
				 pstmt = conn.prepareStatement(sql);
				
			 }else if("other".equalsIgnoreCase(cate_name)) {
				sql += " where cate_name in (?,'science') "
						+ " order by pro_sales desc, pro_viewcnt desc "
						+ " )A "
						+ " )B "
						+ " where rno between 1 and  7 ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, cate_name);
			
			 }else {
				sql += " where cate_name = ? "
						+ " order by pro_sales desc, pro_viewcnt desc "
						+ " )A "
						+ " )B "
						+ " where rno between 1 and  7 "; 
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, cate_name);
			 }
			 
			 rs = pstmt.executeQuery();
			
			 while(rs.next()) {
	
				 ProductVO pvo = new ProductVO();
				 CategoryVO cvo = new CategoryVO();
				 
				 pvo.setPro_name(rs.getString(1));
				 pvo.setPro_imgfile_name(rs.getString(2));
				 pvo.setPk_pro_num(rs.getString(3));
				 pvo.setPro_saleprice(rs.getInt(4));
				 
				 cvo.setCate_name(rs.getString(5));
				 pvo.setCategory(cvo);
				 
				 prodList.add(pvo);
			 }
			 
		} finally {
			close();
		}
		
		return prodList;
	}//end of public List<ProductVO> selectIndexBest(Map<String, String> paraMap) throws SQLException

	//인덱스에서 화제의책 띄우기
	@Override
	public List<ProductVO> selectIndexHot() throws SQLException {
		List<ProductVO> prodList = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			
			 String sql = " select pro_name, pro_imgfile_name, pk_pro_num, pro_saleprice, cate_name "
						+ " from "
						+ " ( "
							+ " select rownum as rno, A.* "
							+ " from "
							+ " ( "
								+ " select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pk_pro_num, cate_name "
								+ " from tbl_product "
								+ " join "
								+ " tbl_category "
								+ " on fk_cate_num = pk_cate_num "
			 					+ " order by pro_viewcnt desc "
			 				+ " )A "
			 			+ " )B "
			 			+ " where rno between 1 and  8 ";

				
			 pstmt = conn.prepareStatement(sql);

			 rs = pstmt.executeQuery();
			
			 while(rs.next()) {
	
				 ProductVO pvo = new ProductVO();
				 CategoryVO cvo = new CategoryVO();
				 
				 pvo.setPro_name(rs.getString(1));
				 pvo.setPro_imgfile_name(rs.getString(2));
				 pvo.setPk_pro_num(rs.getString(3));
				 pvo.setPro_saleprice(rs.getInt(4));
				 
				 cvo.setCate_name(rs.getString(5));
				 pvo.setCategory(cvo);
				 
				 prodList.add(pvo);
			 }
			 
		} finally {
			close();
		}
		
		return prodList;
	}//end of public List<ProductVO> selectIndexHot() throws SQLException

	//인덱스에서 이책어때요 띄우기
	@Override
	public List<ProductVO> selectIndexRandom() throws SQLException {
		List<ProductVO> prodList = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			
			 String sql = " select pro_name, pro_imgfile_name, pk_pro_num, pro_saleprice, cate_name "
						+ " from "
						+ " ( "
							+ " select rownum as rno, A.* "
							+ " from "
							+ " ( "
								+ " select pro_name, pro_saleprice, pro_imgfile_name, fk_cate_num, pro_inputdate, pk_pro_num, cate_name "
								+ " from tbl_product "
								+ " join "
								+ " tbl_category "
								+ " on fk_cate_num = pk_cate_num "
			 					+ " order by dbms_random.random "
			 				+ " )A "
			 			+ " )B "
			 			+ " where rno between 1 and  8 ";

				
			 pstmt = conn.prepareStatement(sql);

			 rs = pstmt.executeQuery();
			
			 while(rs.next()) {
	
				 ProductVO pvo = new ProductVO();
				 CategoryVO cvo = new CategoryVO();
				 
				 pvo.setPro_name(rs.getString(1));
				 pvo.setPro_imgfile_name(rs.getString(2));
				 pvo.setPk_pro_num(rs.getString(3));
				 pvo.setPro_saleprice(rs.getInt(4));
				 
				 cvo.setCate_name(rs.getString(5));
				 pvo.setCategory(cvo);
				 
				 prodList.add(pvo);
			 }
			 
		} finally {
			close();
		}
		
		return prodList;
	}//end of public List<ProductVO> selectIndexRandom() throws SQLException

	//장바구니에 추가할 상품개수랑 재고량비교
	@Override
	public Map<String, Integer> qtyCheck(Map<String, String> paraMap) throws SQLException {
		
		Map<String, Integer> qtyCheck = new HashMap<String, Integer>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pro_qty "
						+ " from tbl_product "
						+ " where pk_pro_num = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("pk_pro_num"));
			
			rs = pstmt.executeQuery();
			rs.next();
			
			qtyCheck.put("pro_qty", rs.getInt(1));
			
			
		} finally {
			close();
		}
		return qtyCheck;
	}//end of public boolean qtyCheck(Map<String, String> paraMap) throws SQLException 
	
	//현재 장바구니에 추가할 제품이 장바구니에 있는지 중복체크
	@Override
	public boolean proCartCheck(Map<String, String> paraMap) throws SQLException {
		boolean proCartCheck = false;
		
		try {
			conn = ds.getConnection();
			String sql = " select pk_cartno "
						+ " from tbl_cart "
						+ " JOIN "
						+ " tbl_member "
						+ " on fk_userid = pk_userid "
						+ " where fk_pro_num = ? and fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("pk_pro_num"));
			pstmt.setString(2, paraMap.get("userid"));
			
			rs = pstmt.executeQuery();
			
			proCartCheck = rs.next();
			
		} finally {
			close();
		}
		return proCartCheck;
	}//end of public boolean proCartCheck(Map<String, String> paraMap) throws SQLException
	
	//장바구니에 중복된 제품이 있어서 수량 update
	@Override
	public int updateAddCart(Map<String, String> paraMap) throws SQLException {
		int result = 0;
		try {
			conn = ds.getConnection();
			String sql = " update tbl_cart "
						+ " set ck_odr_qty = ck_odr_qty + ? "
						+ " where fk_pro_num = ? and fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(paraMap.get("now_pro_qty")) );
			pstmt.setString(2, paraMap.get("pk_pro_num"));
			pstmt.setString(3, paraMap.get("userid"));
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		return result;
	}//end of public int updateAddCart(Map<String, String> paraMap) throws SQLException 
	
	//장바구니에 제품 추가 insert
	@Override
	public int insertAddCart(Map<String, String> paraMap) throws SQLException {
		int result = 0;
		try {
			conn = ds.getConnection();
			String sql = " insert into "
						+ " tbl_cart(pk_cartno, fk_userid, fk_pro_num, ck_odr_qty) "
						+ " values (seq_cartno.nextval, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("pk_pro_num"));
			pstmt.setInt(3, Integer.parseInt(paraMap.get("now_pro_qty")) );
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		return result;
	}//end of public int insertAddCart(Map<String, String> paraMap)

	//현재 유저가 장바구니에 가지고있는 제품수(상세페이지)
	@Override
	public Map<String, Integer> cartQtyCheck(Map<String, String> paraMap) throws SQLException {
		Map<String, Integer> cartQtyCheck = new HashMap<String, Integer>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ck_odr_qty "
						+ " from tbl_cart "
						+ " where fk_pro_num = ? and fk_userid = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("pk_pro_num"));
			pstmt.setString(2, paraMap.get("userid"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {		
				cartQtyCheck.put("ck_odr_qty", rs.getInt(1));	
			}else {
				cartQtyCheck.put("ck_odr_qty", 0);
			}
			
		} finally {
			close();
		}
		return cartQtyCheck;
	}//end of public Map<String, Integer> cartQtyCheck(Map<String, String> paraMap) throws SQLException

	//현재 유저의 장바구니 수량 변경
	@Override
	public int updatePqty(Map<String, String> paraMap) throws SQLException {
		int result = 0;
		try {
			conn = ds.getConnection();
			String sql = " update tbl_cart "
						+ " set ck_odr_qty = ? "
						+ " where pk_cartno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(paraMap.get("pqty_update")) );
			pstmt.setInt(2, Integer.parseInt(paraMap.get("pk_cartno")) );
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		return result;
	}//end of public int updatePqty(Map<String, String> paraMap) throws SQLException

	//삭제하기 버튼 클릭시 선택 제품 삭제
	@Override
	public int proDeleteSelect(Map<String, String> paraMap) throws SQLException {
		int result = 0;
		try {
			conn = ds.getConnection();
			String sql = " delete from tbl_cart where pk_cartno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(paraMap.get("pk_cartno")) );
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		return result;
	}//end of public int proDeleteSelect(Map<String, Integer> paraMap) throws SQLException 

	//partPrice값조회
	@Override
	public int partPriceSelect(Map<String, String> paraMap) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ck_odr_qty*pro_saleprice as pro_saleprice "
						+ " from tbl_cart join tbl_product "
						+ " on fk_pro_num = pk_pro_num "
						+ " where pk_cartno = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("pk_cartno"));
		
			rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt(1);

		} finally {
			close();
		}
		
		return result;
	}//end of public int proDeleteSelect(Map<String, Integer> paraMap) throws SQLException  
	
	//totalPrice조회
	@Override
	public int totalPriceSelect(Map<String, String> paraMap) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select sum(ck_odr_qty*pro_saleprice) "
						+ "	from tbl_cart join tbl_product "
						+ "	on fk_pro_num = pk_pro_num "
						+ "	where fk_userid = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
		
			rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt(1);

		} finally {
			close();
		}
		
		return result;
	}//end of public int totalPriceSelect(Map<String, String> paraMap) throws SQLException

	//장바구니 모두비우기
	@Override
	public int deleteCartAll(Map<String, String> paraMap) throws SQLException {
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " delete tbl_cart "
						+ " where fk_userid = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return result;
	}//end of public int deleteCartAll(Map<String, String> paraMap) throws SQLException

	//선택상품 주문하기
	@Override
	public CartVO orderSelect(Map<String, String> paraMap) throws SQLException {
		
		CartVO cvo = new CartVO();

		try {
			conn = ds.getConnection();
			
			String sql =  " SELECT A.pk_cartno, A.fk_userid, A.fk_pro_num, B.point_rate*A.ck_odr_qty*B.pro_saleprice AS totalPoint "
						+ "      , B.pro_name, B.fk_cate_num, C.cate_name "
						+ "      , B.pro_imgfile_name, B.pro_price, B.pro_saleprice "
						+ "      , A.ck_odr_qty, A.c_status, A.ck_odr_qty*B.pro_saleprice AS partPrice "
					//	+ "      , A.ck_odr_qty, A.c_status "
						+ "	FROM tbl_cart A LEFT OUTER JOIN tbl_product B "
						+ "	ON A.fk_pro_num = B.pk_pro_num "
		                + "	LEFT OUTER JOIN tbl_category C "
		                + "	ON B.fk_cate_num = C.pk_cate_num "
	                	+ "	WHERE A.c_status = 1 AND A.fk_userid = ? AND A.pk_cartno = ? " ;
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("pk_cartno"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 결과값이 1개 이상일 수도 있으니까
			
				ProductVO pvo = new ProductVO();
				CategoryVO catevo = new CategoryVO();
				
				int pk_cartno = rs.getInt("pk_cartno");
				String fk_userid = rs.getString("fk_userid");
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
				int partPrice = rs.getInt("partPrice");
				int totalPoint = rs.getInt("totalPoint");
				System.out.println("totalPoint "+totalPoint);
				
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
				cvo.setPartPrice(partPrice);
				cvo.setTotalPoint(totalPoint);
				catevo.setCate_name(cate_name);
				
				cvo.setProduct(pvo);
				cvo.setCategory(catevo);
			}
	
		} finally {
			close();
		}
		
		return cvo;
	}//end of public CartVO orderSelect(Map<String, String> paraMap) throws SQLException 
	
	//전체상품 주문
	@Override
	public List<CartVO> orderAll(Map<String, String> paraMap) throws SQLException {
		List<CartVO> orderList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql =  " SELECT A.pk_cartno, A.fk_userid, A.fk_pro_num, B.point_rate*A.ck_odr_qty*B.pro_saleprice AS totalPoint "
						+ "      , B.pro_name, B.fk_cate_num, C.cate_name "
						+ "      , B.pro_imgfile_name, B.pro_price, B.pro_saleprice "
						+ "      , A.ck_odr_qty, A.c_status, A.ck_odr_qty*B.pro_saleprice AS partPrice "
					//	+ "      , A.ck_odr_qty, A.c_status "
						+ "	FROM tbl_cart A LEFT OUTER JOIN tbl_product B "
						+ "	ON A.fk_pro_num = B.pk_pro_num "
		                + "	LEFT OUTER JOIN tbl_category C "
		                + "	ON B.fk_cate_num = C.pk_cate_num "
	                	+ "	WHERE A.c_status = 1 AND A.fk_userid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) { // 결과값이 1개 이상일 수도 있으니까
			
				CartVO cvo = new CartVO();
				ProductVO pvo = new ProductVO();
				CategoryVO catevo = new CategoryVO();
				
				int pk_cartno = rs.getInt("pk_cartno");
				String fk_userid = rs.getString("fk_userid");
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
				int partPrice = rs.getInt("partPrice");
				int totalPoint = rs.getInt("totalPoint");
				System.out.println("totalPoint "+totalPoint);
				
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
				cvo.setPartPrice(partPrice);
				cvo.setTotalPoint(totalPoint);
				catevo.setCate_name(cate_name);
				
				cvo.setProduct(pvo);
				cvo.setCategory(catevo);
				
				orderList.add(cvo);
			}
	
		} finally {
			close();
		}
		
		return orderList;
	}//end of public List<CartVO> orderAll(Map<String, String> paraMap) throws SQLException

	//한개 상품 주문
	@Override
	public List<CartVO> orderOne(Map<String, String> paraMap) throws SQLException {
		List<CartVO> orderList = new ArrayList<>();

		try {
			conn = ds.getConnection();
			
			String sql =  " SELECT A.pk_cartno, A.fk_userid, A.fk_pro_num, B.point_rate*A.ck_odr_qty*B.pro_saleprice AS totalPoint "
						+ "      , B.pro_name, B.fk_cate_num, C.cate_name "
						+ "      , B.pro_imgfile_name, B.pro_price, B.pro_saleprice "
						+ "      , A.ck_odr_qty, A.c_status, A.ck_odr_qty*B.pro_saleprice AS partPrice "
					//	+ "      , A.ck_odr_qty, A.c_status "
						+ "	FROM tbl_cart A LEFT OUTER JOIN tbl_product B "
						+ "	ON A.fk_pro_num = B.pk_pro_num "
		                + "	LEFT OUTER JOIN tbl_category C "
		                + "	ON B.fk_cate_num = C.pk_cate_num "
	                	+ "	WHERE A.c_status = 1 AND A.fk_userid = ? AND A.pk_cartno = ? " ;
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("pk_cartno"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 결과값이 1개 이상일 수도 있으니까
				CartVO cvo = new CartVO();
				ProductVO pvo = new ProductVO();
				CategoryVO catevo = new CategoryVO();
				
				int pk_cartno = rs.getInt("pk_cartno");
				String fk_userid = rs.getString("fk_userid");
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
				int partPrice = rs.getInt("partPrice");
				int totalPoint = rs.getInt("totalPoint");
				System.out.println("totalPoint "+totalPoint);
				
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
				cvo.setPartPrice(partPrice);
				cvo.setTotalPoint(totalPoint);
				catevo.setCate_name(cate_name);
				
				cvo.setProduct(pvo);
				cvo.setCategory(catevo);
				
				orderList.add(cvo);
			}
	
		} finally {
			close();
		}
		
		return orderList;
	}//end of public List<CartVO> orderAll(Map<String, String> paraMap) throws SQLException
	
	
	
	

	
	

	// ============================================================================================


	// 로그인 된 사용자의 장바구니 데이터 조회결과물 가져오기
	@Override
	public List<CartVO> getCart(String fk_userid) throws SQLException {
		
		List<CartVO> cartList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql =  " SELECT A.pk_cartno, A.fk_userid, A.fk_pro_num "
						+ "      , B.pro_name, B.fk_cate_num, C.cate_name "
						+ "      , B.pro_imgfile_name, B.pro_price, B.pro_saleprice "
						+ "      , A.ck_odr_qty, A.c_status, A.ck_odr_qty*B.pro_saleprice AS partPrice "
					//	+ "      , A.ck_odr_qty, A.c_status "
						+ "	FROM tbl_cart A LEFT OUTER JOIN tbl_product B "
						+ "	ON A.fk_pro_num = B.pk_pro_num "
		                + "	LEFT OUTER JOIN tbl_category C "
		                + "	ON B.fk_cate_num = C.pk_cate_num "
	                	+ "	WHERE A.c_status = 1 AND A.fk_userid = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_userid);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) { // 결과값이 1개 이상일 수도 있으니까
			
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
				int partPrice = rs.getInt("partPrice");
				
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
				cvo.setPartPrice(partPrice);
				
				catevo.setCate_name(cate_name);
				
				cvo.setProduct(pvo);
				cvo.setCategory(catevo);
				
				cartList.add(cvo);
			}
	
		} finally {
			close();
		}
		
		return cartList;
	}//end of public List<CartVO> getCart(String fk_userid) throws SQLException



















	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
	
	
	
	
	
	

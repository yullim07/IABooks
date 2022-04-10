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
/*import product.model.SpecVO;*/
import product.model.*;
/*import product.model.SpecVO;*/


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
<<<<<<< HEAD
				mvo.setCoupon(rs.getInt(8));
				mvo.setMileage(rs.getInt(9));
=======
				//mvo.setCoupon(rs.getInt(8));
				//mvo.setMileage(rs.getInt(9));	
>>>>>>> refs/remotes/origin/sub_main
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
	
	
	
	

	
	
<<<<<<< HEAD
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
=======
>>>>>>> refs/remotes/origin/sub_main

	// ============================================================================================
<<<<<<< HEAD


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
		CartVO cvo = new CartVO();
		
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
	// public int deleteCartSelect(Map<String, String> paraMap) throws SQLException {
	public int deleteCartSelect(CartVO cart) throws SQLException {
		
		CartVO cvo = new CartVO();
		
		int pk_cartno = cvo.getPk_cartno();
		System.out.println("삭제할 카트번호 => " + pk_cartno);
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " DELETE from tbl_cart "
						+ " WHERE pk_cartno = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, pk_cartno);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return result;
	}

	// 제품 조회수 증가시키기 메소드
	@Override
	public int plusViewCnt(String pk_pro_num) {
		try {
			
			conn = ds.getConnection();
			
			String sql =  " UPDATE tbl_product "
						+ " SET pro_viewcnt = pro_viewcnt + 1 "
						+ " WHERE pk_pro_num = ? ";
			
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

	// 카테고리 목록 보여주기
	@Override
	public List<HashMap<String, String>> getCategoryList() throws SQLException {
		
		List<HashMap<String, String>> categoryList = new ArrayList<>();
		
		try {
			 
			conn = ds.getConnection();
			
			String sql =  " SELECT pk_cate_num, cate_name "
						+ " FROM tbl_category ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, String> map = new HashMap<>();
				
				map.put("pk_cate_num", rs.getString(1)); // 숫자!
				map.put("cate_name", rs.getString(2));
				
				categoryList.add(map);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return categoryList;
	}


	// Spec 목록 보여주기 === 주석처리
	/*
		
		@Override
	public List<SpecVO> selectSpecList() throws SQLException {
		
		List<SpecVO> specList = new ArrayList<>();
		
		try {
			 
						 
		} finally {
			close();
		}
		
		return specList;
	}	
			
			
	 */
	
	
	// tbl_product 테이블에 제품정보 insert 하기 
	@Override
	public int productInsert(ProductVO pvo) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			 
			String sql =  " INSERT INTO "
						+ " tbl_product(fk_cate_num, pro_name, publisher, pro_publish_date, pro_price, pro_saleprice, "
			 			+ "	pro_index, pro_inputdate, pro_qty, pro_sales, pro_viewcnt, pro_size, pro_bindtype, pro_pages, "
			 			+ " pro_imgfile_name, fk_wr_code, pro_content, pk_pro_num, pro_soldout, pro_restock, pro_restock, "
			 			+ " point_rate) " 
			 			+ " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			 
			pstmt = conn.prepareStatement(sql);
			 
			pstmt.setInt(1, pvo.getFk_cate_num());
			pstmt.setString(2, pvo.getPro_name());
			pstmt.setString(3, pvo.getPublisher());
			pstmt.setString(4, pvo.getPro_publish_date());
			pstmt.setInt(5, pvo.getPro_price());
			pstmt.setInt(6, pvo.getPro_saleprice());     
			pstmt.setString(7, pvo.getPro_index()); // CLOB
			pstmt.setString(8, pvo.getPro_inputdate());
			pstmt.setInt(9, pvo.getPro_qty());
			pstmt.setInt(10, pvo.getPro_sales());
			pstmt.setInt(11, pvo.getPro_viewcnt());
			pstmt.setString(12, pvo.getPro_size());
			pstmt.setString(13, pvo.getPro_bindtype());
			pstmt.setInt(14, pvo.getPro_pages());
			pstmt.setString(15, pvo.getPro_imgfile_name());
			// pstmt.setInt(16, wvo.getFk_wr_code());
			pstmt.setString(17, pvo.getPro_content()); // CLOB
			pstmt.setInt(18, pvo.getPro_soldout());
			pstmt.setInt(19, pvo.getPro_restock());
			pstmt.setInt(20, pvo.getPro_pages());
			pstmt.setInt(21, pvo.getPoint_rate());
			
			result = pstmt.executeUpdate();
			
			/*
			 fk_cate_num      not null number(5)     
			 
			 pro_name         not null varchar2(200) 
			 publisher        not null varchar2(50)  
			 pro_publish_date not null varchar2(12) 
			  
			 pro_price                 number(8)     
			 pro_saleprice             number(8)   
			   
			 pro_index                 clob          
			 pro_inputdate             date          
			 pro_qty                   number(20)    
			 pro_sales                 number(20)    
			 pro_viewcnt               number(10)    
			 
			 pro_size                  varchar2(20)  
			 pro_bindtype              varchar2(15)  
			 
			 pro_pages                 number(5)     
			 
			 pro_imgfile_name not null varchar2(30)  
			 
			 fk_wr_code                number(10)   
			  
			 pro_content               clob         
			  
			 pk_pro_num       not null varchar2(20)  
			 
			 pro_soldout               number(1)     
			 pro_restock               number(1)     
			 point_rate                number(8,2)
			*/		 
=======
>>>>>>> refs/remotes/origin/sub_main

<<<<<<< HEAD
		} finally {
			close();
		}
		
		return result;
	}
	
	// tbl_product_imagefile 테이블에 insert 하기 << 추가이미지 테이블이니까 주석처리
	/*
	@Override
	public int product_imagefile_Insert(Map<String, String> paraMap) throws SQLException {
=======
>>>>>>> refs/remotes/origin/sub_main

<<<<<<< HEAD
		int result = 0;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " INSERT INTO tbl_product_imagefile(imgfileno, fk_pnum, imgfilename) "+ 
				          " VALUES(seqImgfileno.nextval, ?, ?) ";
			 
			 pstmt = conn.prepareStatement(sql);
			 
			 pstmt.setInt(1, Integer.parseInt(paraMap.get("pnum")));
			 pstmt.setString(2, paraMap.get("attachFileName"));
			 
			 result = pstmt.executeUpdate();
			 
=======
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
	
>>>>>>> refs/remotes/origin/sub_main
		} finally {
			close();
		}
		
<<<<<<< HEAD
		return result;
	}
	*/
=======
		return cartList;
	}//end of public List<CartVO> getCart(String fk_userid) throws SQLException



















>>>>>>> refs/remotes/origin/sub_main
	
<<<<<<< HEAD


	// 제품번호를 가지고서 해당 제품의 정보를 조회해오기  
	/*
	@Override
	public ProductVO selectOneProductByPnum(String pnum) throws SQLException {
		
		ProductVO pvo = null;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = "select S.sname, pnum, pname, pcompany, price, saleprice, point, pqty, pcontent, pimage1, pimage2, prdmanual_systemFileName, nvl(prdmanual_orginFileName, '없음') AS prdmanual_orginFileName "
			 		+ " from "
			 		+ " ( "
			 		+ " select fk_snum, pnum, pname, pcompany, price, saleprice, point, pqty, pcontent, pimage1, pimage2, prdmanual_systemFileName, prdmanual_orginFileName "
			 		+ " from tbl_product "
			 		+ " where pnum = ? "
			 		+ " ) P JOIN tbl_spec S "
			 		+ " ON P.fk_snum = S.snum ";
			 
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, pnum);
			 
			 rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
				 
				 String sname = rs.getString(1);     // "HIT", "NEW", "BEST" 값을 가짐 
	             int    npnum = rs.getInt(2);        // 제품번호
	             String pname = rs.getString(3);     // 제품명
	             String pcompany = rs.getString(4);  // 제조회사명
	             int    price = rs.getInt(5);        // 제품 정가
	             int    saleprice = rs.getInt(6);    // 제품 판매가
	             int    point = rs.getInt(7);        // 포인트 점수
	             int    pqty = rs.getInt(8);         // 제품 재고량
	             String pcontent = rs.getString(9);  // 제품설명
	             String pimage1 = rs.getString(10);  // 제품이미지1
	             String pimage2 = rs.getString(11);  // 제품이미지2
	             String prdmanual_systemFileName = rs.getString(12); // 파일서버에 업로드되어지는 실제 제품설명서 파일명
	             String prdmanual_orginFileName = rs.getString(13);  // 웹클라이언트의 웹브라우저에서 파일을 업로드 할때 올리는 제품설명서 파일명
	             
	             pvo = new ProductVO();
	             
	             SpecVO spvo = new SpecVO();
	             spvo.setSname(sname);
	             
	             pvo.setPnum(npnum);
	             pvo.setPname(pname);
	             pvo.setPcompany(pcompany);
	             pvo.setPrice(price);
	             pvo.setSaleprice(saleprice);
	             pvo.setPoint(point);
	             pvo.setPqty(pqty);
	             pvo.setPcontent(pcontent);
	             pvo.setPimage1(pimage1);
	             pvo.setPimage2(pimage2);
	             pvo.setPrdmanual_systemFileName(prdmanual_systemFileName);
	             pvo.setPrdmanual_orginFileName(prdmanual_orginFileName);
	             
	             
			 }
		} finally {
			close();
		}
		
		return pvo;
	}
*/

	// 제품번호를 가지고서 해당 제품의 추가된 이미지 정보를 조회해오기 ==> 추가이미지테이블은 우선 주석처리해놓기
	/*
	@Override
	public List<String> getImagesByPnum(String pk_pro_num) throws SQLException {
		
		List<String> imgList = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " SELECT pro_imgfile_name2 "
			 			+ " FROM tbl_product_imagefile "
			 			+ " WHERE fk_pro_num = ? ";

			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, pnum);
			 
			 rs = pstmt.executeQuery();
			 
			 while(rs.next()) {
				 String imgfilename = rs.getString(1); // 이미지파일명
				 imgList.add(imgfilename);
			 }
			 
		} finally {
			close();
		}
		
		return imgList;
	}
	*/
=======
>>>>>>> refs/remotes/origin/sub_main
	
<<<<<<< HEAD
	// 제품번호를 가지고서 해당 제품의 제품설명서 텀부파일의 서버에 업로드 된 파일명과 오리지널 파일명 알아오기 메소드 구현하기
	/*
	@Override
	public Map<String, String> getPrdmanualFileName(String pnum) throws SQLException {

		// 1. Map 선언
		Map<String, String> map = new HashMap<>();
		
		// 2. select문 복사 및 편집
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select prdmanual_systemFilename, prdmanual_orginFilename "
			 			+ " from tbl_product "
			 			+ " where pnum = ? ";

			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, pnum);
			 
			 rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
				 map.put("prdmanual_systemFileName", rs.getString(1));
				 System.out.println("확인용 prdmanual_systemFileName => " + rs.getString(1));
				 // 파일서버에 업로드되는 실제 제품설명서 파일명
				 map.put("prdmanual_orginFileName", rs.getString(2));
				 System.out.println("확인용 prdmanual_orginFileName => " + rs.getString(2));
				 // 웹클라이언트의 웹브라우저에서 파일을 업로드할 때 올리는 제품설명서 파일명
			 } // end of if
			 
		} finally {
			close();
		}
		
		return map;
	}
	 */
	
	
	/*
	 * @Override public int addCart(Map<String, String> paraMap) throws SQLException
	 * { // TODO Auto-generated method stub return 0; }
	 * 
	 * @Override public List<CartVO> selectProductCart(String userid) throws
	 * SQLException { // TODO Auto-generated method stub return null; }
	 */
	
}
=======
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
	
	
	
	
	
	
>>>>>>> refs/remotes/origin/sub_main

package product.controller3.test;

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

import member.model.CouponVO;
import product.model.CartVO;
import product.model.CategoryVO;
import product.model.ProductVO;

public class TestProductDAO implements TestInterProductDAO {

	private DataSource ds;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	//생성자
	public TestProductDAO() {
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
	
	
	// 관심상품 조회하기 메소드
	@Override
	public List<WishListVO> getWishList(String fk_userid) throws SQLException {
		
		List<WishListVO> wishList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT A.PK_WNUM, A.FK_USERID, A.FK_PNUM "+
						 "     , B.pro_name, B.fk_cate_num, C.cate_name "+
						 "     , B.pro_imgfile_name, B.pro_price, B.pro_saleprice, A.w_status "+
						 " FROM tbl_wishlist A LEFT OUTER JOIN tbl_product B  "+
						 " ON A.fk_pnum = B.pk_pro_num  "+
						 " LEFT OUTER JOIN tbl_category C  "+
						 " ON B.fk_cate_num = C.pk_cate_num  "+
						 " WHERE A.w_status = 1 AND A.fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_userid);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) { // 결과값이 1개 이상일 수도 있으니까
			
				WishListVO wvo = new WishListVO();
				ProductVO pvo = new ProductVO();
				CategoryVO catevo = new CategoryVO();
				
				wvo.setPk_wnum(rs.getInt(1));
				wvo.setFk_userid(rs.getString(2));
				wvo.setFk_pnum(rs.getString(3));
				wvo.setW_status(rs.getInt(10));
				
				pvo.setPro_name(rs.getString(4));
				pvo.setFk_cate_num(rs.getInt(5));
				pvo.setPro_imgfile_name(rs.getString(7));
				pvo.setPro_price(rs.getInt(8));
				pvo.setPro_saleprice(rs.getInt(9));
				
				catevo.setCate_name(rs.getString(6));
				
				
				wvo.setProduct(pvo);
				wvo.setCategory(catevo);
				
				wishList.add(wvo);
			}
	
		} finally {
			close();
		}
		
		return wishList;
		
		
	} // end of public List<CartVO> getWishList(String fk_userid) throws SQLException----------

	// 관심상품 선택 제품 삭제 버튼 클릭시 삭제
	@Override
	public int wishDeleteOne(Map<String, String> paraMap) throws SQLException {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " delete from tbl_wishlist where pk_wnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(paraMap.get("pk_wnum")) );
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		return result;
		
	} // end of public int wishDeleteOne(Map<String, String> paraMap) throws SQLException-------
	
	
	// 관심상품에서 체크박스 선택 후 삭제하기
	@Override
	public int wishDeleteSelect(Map<String, String> paraMap) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " delete from tbl_wishlist where pk_wnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(paraMap.get("pk_wnum")) );
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	} // end of public int wishDeleteSelect(Map<String, String> paraMap) throws SQLException-------

	
	// 관심상품 모두 비우기
	@Override
	public int deleteWishAll(Map<String, String> paraMap) throws SQLException {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " delete tbl_wishlist "
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
		
	} // public int deleteCartAll(Map<String, String> paraMap) throws SQLException------

	//관심상품에서 로그인한 유저가 사용가능한 쿠폰 
	@Override
	public List<CouponVO> userCoupon(Map<String, String> paraMap) throws SQLException {
		List<CouponVO> couponList = new ArrayList<>();

		try {
			conn = ds.getConnection();
			
			String sql =  " select cname, cprice, cminprice, pk_coupon_id "
						+ " from "
						+ " tbl_user_coupon_status "
						+ " join tbl_coupon "
						+ " on coupon_id = pk_coupon_id "
						+ " where fk_userid = ? and user_cp_status = 1 and cenddate >= sysdate ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				CouponVO cpvo = new CouponVO();
				cpvo.setCname(rs.getString(1));
				cpvo.setCprice(rs.getString(2));
				cpvo.setCminprice(rs.getString(3));
				cpvo.setCouponid(rs.getString(4));
				couponList.add(cpvo);
			}
	
		} finally {
			close();
		}
		return couponList;
	}//end of public List<CouponVO> userCoupon(Map<String, String> paraMap) throws SQLException

	
	// 관심상품 선택상품 주문하기(미사용)
	@Override
	public WishListVO orderSelect(Map<String, String> paraMap) throws SQLException {

		WishListVO wvo = new WishListVO();

		try {
			conn = ds.getConnection();
			
			String sql = " SELECT A.PK_WNUM, A.FK_USERID, A.FK_PNUM "+
					 "     , B.pro_name, B.fk_cate_num, C.cate_name "+
					 "     , B.pro_imgfile_name, B.pro_price, B.pro_saleprice, A.w_status" +
					 " FROM tbl_wishlist A LEFT OUTER JOIN tbl_product B  "+
					 " ON A.fk_pnum = B.pk_pro_num  "+
					 " LEFT OUTER JOIN tbl_category C  "+
					 " ON B.fk_cate_num = C.pk_cate_num  "+
					 " WHERE A.w_status = 1 AND A.fk_userid = ? AND A.pk_wnum = ?";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("pk_wnum"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { 
				
				ProductVO pvo = new ProductVO();
				CategoryVO catevo = new CategoryVO();
				
				wvo.setPk_wnum(rs.getInt(1));
				wvo.setFk_userid(rs.getString(2));
				wvo.setFk_pnum(rs.getString(3));
				wvo.setW_status(rs.getInt(10));
				
				pvo.setPro_name(rs.getString(4));
				pvo.setFk_cate_num(rs.getInt(5));
				pvo.setPro_imgfile_name(rs.getString(7));
				pvo.setPro_price(rs.getInt(8));
				pvo.setPro_saleprice(rs.getInt(9));
				
				catevo.setCate_name(rs.getString(6));
				
				
				wvo.setProduct(pvo);
				wvo.setCategory(catevo);
			}
	
		} finally {
			close();
		}
		
		return wvo;
		
	} //end of public CartVO orderSelect(Map<String, String> paraMap) throws SQLException 

	
	
	// 관심상품에서 선택한 totalPrice조회
	@Override
	public int totalPriceSelectWishList(Map<String, String> paraMap) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select sum(pro_saleprice) "+
						 " from tbl_wishlist join tbl_product "+
						 " on fk_pnum = pk_pro_num "+
						 " where fk_userid = ? and pk_wnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("pk_wnum"));
	
			rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt(1);

		} finally {
			close();
		}
		
		return result;
		
	} // end of public int totalPriceSelectWishList(Map<String, String> paraMap) throws SQLException---------

	
	// 선택 탭에서 장바구니 담기를 클릭한 관심상품의 값을 장바구니 테이블로 넘기기
	@Override
	public String getOneWishPnum(Map<String, String> paraMap) throws SQLException {
		
		String fk_pnum = "";
		
		try {
			conn = ds.getConnection();
			
			String sql = " select fk_pnum "+
						 " from tbl_wishlist join tbl_product "+
						 " on fk_pnum = pk_pro_num "+
						 " where fk_userid = ? and pk_wnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("pk_wnum"));
	
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				fk_pnum = rs.getString(1);
			}
			
		} finally {
			close();
		}
		
		return fk_pnum;
		
	} // end of public String getOneWishPnum(Map<String, String> paraMap) throws SQLException--------

	// 장바구니에 추가할 상품개수랑 재고량비교(테스트용)
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
			
			if(rs.next()) {	
				qtyCheck.put("pro_qty", rs.getInt(1));
			}
			
		} finally {
			close();
		}
		return qtyCheck;
	} // end of public Map<String, Integer> qtyCheck(Map<String, String> paraMap) throws SQLException

	// 장바구니에 추가할 상품개수랑 재고량비교(테스트용)
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
	} // public Map<String, Integer> cartQtyCheck(Map<String, String> paraMap) throws SQLException

	
	// 관심상품에 있는 목록의 제품번호 모두 담기
	@Override
	public void insertWishToCartAll(Map<String, String> paraMap) throws SQLException {

		List<String> fk_pro_num = new ArrayList<>();
		int i = 0;
		int n = 0;
		int isExist = 0;
		
		try {
			conn = ds.getConnection();
			

			String sql = " select fk_pnum "+
						 " from tbl_wishlist "+
						 " where fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				fk_pro_num.add(rs.getString(1));
				i++;
			}
			
			System.out.println(" 몇개 들어감? : " + i);
			
			for(int j=0; j<fk_pro_num.size(); j++) {
				
				System.out.println("반복문실행" + j);
				
				sql = " select pk_cartno " +
					  " from tbl_cart "+
					  " where fk_userid = ? and fk_pro_num = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, fk_pro_num.get(j).toString());
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					System.out.println(" 업데이트 실행");
					sql = " update tbl_cart set ck_odr_qty = ck_odr_qty + 1 "
							+ " where fk_userid = ? and fk_pro_num = ?  ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, paraMap.get("userid"));
					pstmt.setString(2, fk_pro_num.get(j).toString());
				}
				else {
					sql = " insert into "
							+ " tbl_cart(pk_cartno, fk_userid, fk_pro_num, ck_odr_qty) "
							+ " values (seq_cartno.nextval, ?, ?, 1) ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, paraMap.get("userid"));
					pstmt.setString(2, fk_pro_num.get(j).toString());
					
					n = pstmt.executeUpdate();
					System.out.println(" 성공? : " + n);
				}
				
			} // end of for-------------
			
		} finally {
			close();
		}
		
	} // end of public List<String> insertWishToCartAll(Map<String, String> paraMap) throws SQLException 
	
	


	
	
	
	
	
	
	
	
}

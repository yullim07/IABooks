package product.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;

public class CartDAO implements InterCartDAO {

	private DataSource ds;    // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자
	public CartDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/mymvc_oracle");
		    
		    aes = new AES256(SecretMyKey.KEY);
		    // SecretMyKey.KEY 은 우리가 만든 비밀키이다.
		    
		} catch(NamingException e) {
			e.printStackTrace();
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	
	// 자원반납 해주는 메소드 구현하기
	private void close() {
		
		try {
			if(rs != null)    {rs.close();	  rs = null;}
			if(pstmt != null) {pstmt.close(); pstmt = null;}
			if(conn != null)  {conn.close();  conn = null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
	}// end of private void close()-------------------------------------
	
	
	
	
	// 카트에 상품 추가하기 메소드
	@Override
	public int addCart(CartVO cart) throws SQLException {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_cart(pk_cartno, fk_userid, pk_pro_num, ck_odr_qty, ck_cart_register) "
					   + " values(?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cart.getPk_cartno());
			pstmt.setString(2, cart.getFk_userid());
			pstmt.setString(3, cart.getPk_pro_num());
			pstmt.setInt(4, cart.getCk_odr_qty());
			pstmt.setString(5, cart.getCk_cart_register());
						
			result = pstmt.executeUpdate(); // 0 또는 1만 나온다

		} finally {
			close();
		}
		
		return result;
	}

	// 카트 1개의 행만 삭제하기 메소드
	@Override
	public int deleteCart(String pk_cartno) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " delete from tbl_cart "
						+ " where pk_cartno = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pk_cartno);
						
			result = pstmt.executeUpdate(); // 0 또는 1만 나온다

		} finally {
			close();
		}
		return result;
	}

	// 카트 수량 수정하기 메소드
	@Override
	public int modifyCount(CartVO cart) throws SQLException {
		
		int result = 0;
		
		CartVO cvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql =  " update tbl_cart "
						+ " set ck_odr_qty = ? "
						+ " where pk_cartno = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cvo.getCk_odr_qty());
			pstmt.setInt(2, cvo.getPk_cartno());
						
			result = pstmt.executeUpdate(); // 0 또는 1만 나온다

		} finally {
			close();
		}
		return result;
	}

	// 회원아이디를 받아와서 카트 목록 확인하기 메소드
	@Override
	public List<CartVO> getCart(String fk_userid) throws SQLException {
		
		List<CartVO> cartList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql =  " SELECT "
						+ " A.pk_cartno, A.fk_userid, A.pk_pro_num, A.ck_odr_qty, A.ck_cart_register, "
						+ " B.pro_name, B.pro_saleprice, "
						+ " nvl(C.pro_imgfile_name2, A.pk_pro_num) "
						+ " FROM "
						+ " tbl_cart A "
						+ " LEFT OUTER JOIN tbl_product B ON A.pk_pro_num = B.pk_pro_num "
						+ " LEFT OUTER JOIN tbl_product_imagefile C ON A.pk_pro_num = C.fk_pro_num "
						+ " where pk_cartno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, fk_userid);
						
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				CartVO cvo = new CartVO();
				cvo.setPk_cartno(rs.getInt(1));
				
				cartList.add(cvo);
			}
		} finally {
			close();
		}
		
		return cartList;
	}

	// 카트 확인하기 메소드
	@Override
	public CartVO checkCart(CartVO cart) throws SQLException {
		
		return null;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	 * @Override public List<CartVO> cartMoney() { // TODO Auto-generated method
	 * stub return null; }
	 * 
	 * @Override public void cartInsert(CartVO dto) { String sql = " update ";
	 * 
	 * }
	 * 
	 * @Override public List<CartVO> cartList(String userid) { // TODO
	 * Auto-generated method stub return null; }
	 * 
	 * @Override public void cartDeleteOne(String pk_cartno) { // TODO
	 * Auto-generated method stub
	 * 
	 * }
	 * 
	 * @Override public void cartDeleteAll(String userid) { // TODO Auto-generated
	 * method stub
	 * 
	 * }
	 * 
	 * @Override public void cartUpdate(String pk_cartno) { // TODO Auto-generated
	 * method stub
	 * 
	 * }
	 * 
	 * @Override public int cartTotalPrice(String userid) { // TODO Auto-generated
	 * method stub return 0; }
	 * 
	 * @Override public int cartTotalQty(String userid, String pk_pro_num) { // TODO
	 * Auto-generated method stub return 0; }
	 * 
	 * @Override public void cartUpdate(CartVO cvo) { // TODO Auto-generated method
	 * stub
	 * 
	 * }
	 * 
	 * @Override public void cartModify(CartVO cvo) { // TODO Auto-generated method
	 * stub
	 * 
	 * }
	 */

}

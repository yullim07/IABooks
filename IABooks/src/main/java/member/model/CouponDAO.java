package member.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class CouponDAO implements InterCouponDAO {
	   
	private DataSource ds;   // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs; 
	   
	   
	// 기본생성자
	   public CouponDAO() {
	      
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
	      
	      if(rs != null) { rs.close(); rs=null; }
	      if(pstmt != null) { pstmt.close(); pstmt=null; }
	      if(conn != null) { conn.close(); conn=null; }
	      
	      } catch(SQLException e) {
	         e.printStackTrace();
	      }
	      
	   } // end of void close()    
	
	
	
	// 쿠폰등록을 해주는 메소드
	@Override
	public int couponRegister(CouponVO coupon) throws SQLException {
		
		int result = 0;
		
		try {
	         conn =ds.getConnection();
	         
	         String sql = " insert into tbl_coupon(PK_COUPON_ID, CNAME, CPRICE, CDATE, CSTARTDATE, CENDDATE, CMINPRICE, CPSTATUS) "
	                  +" values(?, ?, ?, sysdate , ?, ?, ?, '1') ";
	         
	         pstmt = conn.prepareStatement(sql);
	        
	         
	         pstmt.setString(1, coupon.getCouponid());
	         pstmt.setString(2, coupon.getCname());
	         pstmt.setString(3, coupon.getCprice());
	         pstmt.setString(4, coupon.getCstartdate());
	         pstmt.setString(5, coupon.getCenddate());
	         pstmt.setString(6, coupon.getCminprice());
	         
	         result = pstmt.executeUpdate();
	       
	      } catch(Exception e) {
	         e.printStackTrace();   
	      } finally {
	         close();
	      }
		
		
		return result;
	}

	
	
	
}

package product.model;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;

public class OrderDAO implements InterOrderDAO {

	private DataSource ds;    // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 기본생성자
	public OrderDAO() {
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
	}// end of private void close()-------------------------------------
		
	
	
	// 장바구니로 상품 추가 메소드 구현하기
	public boolean insertOrder(Order model) {
		
		boolean result = false;
		try {
			String sql =  " insert into tbl_order (pro_num, ... ) "
						+ "	values( ?, ?, ?, ... ) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, odao.getId());
			
			,,,
			
			pstmt.executeUpdate();
			
			result = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	// ?
	public List<Order> userOrder(int id) {
		 List<Order> list = new ArrayList<>();
	        try {
	            query = "select * from orders where u_id=? order by orders.o_id desc";
	            pst = this.con.prepareStatement(query);
	            pst.setInt(1, id);
	            rs = pst.executeQuery();
	            while (rs.next()) {
	                Order order = new Order();
	                ProductDao productDao = new ProductDao(this.con);
	                int pId = rs.getInt("p_id");
	                Product product = productDao.getSingleProduct(pId);
	                order.setOrderId(rs.getInt("o_id"));
	                order.setId(pId);
	                order.setName(product.getName());
	                order.setCategory(product.getCategory());
	                order.setPrice(product.getPrice()*rs.getInt("o_quantity"));
	                order.setQunatity(rs.getInt("o_quantity"));
	                order.setDate(rs.getString("o_date"));
	                list.add(order);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            System.out.println(e.getMessage());
	        }
	        return list;
	}
	
	// 장바구니에서 상품 삭제 메소드 구현하기
	
	// 장바구니에서 수량 변경 메소드 구현하기
	
	// 장바구니에 있는 것을 관심상품으로 이동 메소드 구현하기
	
	// 장바구니에 이미 담은 상품 확인하는 메소드 구현하기
	
	// 결제 취소하기 메소드 구현하기
	 public void cancelOrder(int id) {
	        //boolean result = false;
	        try {
	            query = "delete from orders where o_id=?";
	            pst = this.con.prepareStatement(query);
	            pst.setInt(1, id);
	            pst.execute();
	            //result = true;
	        } catch (SQLException e) {
	            e.printStackTrace();
	            System.out.print(e.getMessage());
	        }
	        //return result;
	    }
	 
	
}

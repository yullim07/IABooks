package product.model;

import java.io.UnsupportedEncodingException;
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
		    ds = (DataSource)envContext.lookup("jdbc/mymvc_oracle");
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
	public List<ProductVO> selectPagingProduct(Map<String, String> paraMap) thpdaos SQLException {
		
		return null;
	}//end of public List<ProductVO> selectPagingProduct(Map<String, String> paraMap) thpdaos SQLException
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/////////////////////////////////////////////////////////////////////
	
	
	public List<ProductDAO> getAllProducts() {
		
		List<ProductDAO> prolist = new ArrayList<>();
        
		try {
			String sql = " select * from tbl_product ";
            pstmt = conn.prepareStatement(sql);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
            	ProductDAO pdao = new ProductDAO();
            	pdao.setId(rs.getInt("PK_PRO_NUM"));
                pdao.setName(rs.getString("name"));
                pdao.setCategory(rs.getString("category"));
                pdao.setPrice(rs.getDouble("price"));
                pdao.setImage(rs.getString("image"));

                prolist.add(pdao);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return prolist;
    }
	
	
	
	public ProductDAO getDetailProduct(int pk_pro_num) {
		ProductDAO pdao = null;
	        try {
	            String sql = " select * from tbl_product where id=? ";

	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, id);
	            ResultSet rs = pstmt.executesql();

	            while (rs.next()) {
	            	pdao = new ProductDAO();
	                pdao.setId(rs.getInt("id"));
	                pdao.setName(rs.getString("name"));
	                pdao.setCategory(rs.getString("category"));
	                pdao.setPrice(rs.getDouble("price"));
	                pdao.setImage(rs.getString("image"));
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            System.out.println(e.getMessage());
	        }

	        return pdao;
	    }
	
	public double getTotalCartPrice(ArrayList<Cart> cartList) {
        double sum = 0;
        try {
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                    String sql = "select price from tbl_product where id=?";
                    pstmt = this.conn.prepareStatement(sql);
                    pstmt.setInt(1, item.getId());
                    rs = pstmt.executeQuery();
                    while (rs.next()) {
                        sum+=rs.getDouble("price")*item.getQuantity();
                    }

                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return sum;
    }

    
    public List<Cart> getCartProducts(ArrayList<Cart> cartList) {
        List<Cart> book = new ArrayList<>();
        try {
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                    String sql = "select * from tbl_product where id=?";
                    pstmt = this.conn.prepareStatement(sql);
                    pstmt.setInt(1, item.getId());
                    
                    rs = pstmt.executeQuery();
                    
                    while (rs.next()) {
                        Cart pdao = new Cart();
                        pdao.setId(rs.getInt("id"));
                        pdao.setName(rs.getString("name"));
                        pdao.setCategory(rs.getString("category"));
                        pdao.setPrice(rs.getDouble("price")*item.getQuantity());
                        pdao.setQuantity(item.getQuantity());
                        book.add(pdao);
                    }

                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return book;
    }
}
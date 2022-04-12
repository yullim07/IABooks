package board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class TestBoardDAO implements TestInterBoardDAO {

	private DataSource ds;
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	//생성자
	public TestBoardDAO() {
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
	
	// 받아온 pk값으로 qna게시판 게시글 삭제
	@Override
	public int qnaDeleteSelect(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " delete from tbl_qna_board where pk_qna_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(paraMap.get("pk_qna_num")) );
			
			n = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return n;
	
	} // public int qnaDeleteSelect(Map<String, String> paraMap) throws SQLException--------

	
	// 받아온 pk값으로 리뷰게시판 게시글 삭제
	@Override
	public int revDeleteSelect(Map<String, String> paraMap) throws SQLException {
		
		int m = 0;
		
		try {
			conn = ds.getConnection();
			String sql = " delete from tbl_review_board where pk_rnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(paraMap.get("pk_rnum")) );
			
			m = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return m;
		
	} // public int revDeleteSelect(Map<String, String> paraMap) throws SQLException-------

}

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

	
	// 받아온 pk값으로 qna게시판 게시상태 변경
		@Override
		public int qnaDisplaySelect(Map<String, String> paraMap) throws SQLException {
			
			int n = 0;
			
			try {
				conn = ds.getConnection();
				String sql = "update tbl_qna_board set isdelete = decode(isdelete, 1, 0, "+
						"                                                        	  0, 1) "+
						" where pk_qna_num = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(paraMap.get("pk_qna_num")) );
				
				n = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return n;
			
		} // end of public int revDisplaySelect(Map<String, String> paraMap) throws SQLException

	
	
		// 받아온 pk값으로 리뷰게시판 게시글 게시상태 변경
		@Override
		public int revDisplaySelect(Map<String, String> paraMap) throws SQLException {
			
			int m = 0;
			
			try {
				conn = ds.getConnection();
				String sql = "update tbl_review_board set isdelete = decode(isdelete, 1, 0, "+
						"                                                        	  0, 1) "+
						" where pk_rnum = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(paraMap.get("pk_rnum")) );
				
				m = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return m;
			
		} // end of public int revDisplaySelect(Map<String, String> paraMap) throws SQLException

		
		// 게시글 번호 표시를 위한 검색이 있는 또는 검색이 없는 전체 Qna게시판에 대한 페이지 알아오기
		@Override
		public QnABoardVO getTotalQnaCnt(Map<String, String> paraMap) throws SQLException {
			
			QnABoardVO qvo = new QnABoardVO();
			
			try {
				conn = ds.getConnection();
				
				String sql = " select count(*) "
						   + " from tbl_qna_board"
						   + " where isdelete = 0 ";
				
				String colname = paraMap.get("searchContent");
				String searchWord = paraMap.get("searchWord");	
			//	System.out.println(" 확인용 colname : " + colname);
			//	System.out.println(" 확인용 searchWord : " + searchWord);
				
				if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
					sql += " and " + colname + " like '%'|| ? ||'%' ";
					// 위치홀더에 들어오는 값은 데이터값만 들어올 수 있지
					// 위치홀더에는 컬럼명이나 테이블 명은 들어올 수 없다 => 변수처리로 넣어준다.(중요)
				}
				
				
				pstmt = conn.prepareStatement(sql);
				
				if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
					// 검색종류와 검색어가 있으면	
					pstmt.setString(1, searchWord);
				}
				
				rs = pstmt.executeQuery();
				
				rs.next();
				
				qvo.setTotalCnt(rs.getInt(1));
				
			} finally {
				close();
			}
			
			return qvo;
		}

		// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 FAQ게시판에 대한 페이지 알아오기
		@Override
		public int getTotalMyPage(Map<String, String> paraMap) throws SQLException {

			int totalPage = 0;
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			String searchCate = paraMap.get("searchCate");	
			String re_option = "";
			String qna_option = "";
			
			try {
				conn = ds.getConnection();
				
				String sql = " select ceil( (revCnt + qnaCnt) / ? ) AS myCnt ";
				
				if( "my_title".equalsIgnoreCase(colname) ) { // 검색조건이 제목일 때
					re_option = "re_title";
					qna_option = "qna_title";
					sql +=  " from ( select COUNT(CASE WHEN fk_userid= ? THEN 1 END) AS revCnt, re_title, re_contents from tbl_review_board " +
						    " where "+re_option+" like '%'|| ? ||'%' ) R "+
						    " , ( select COUNT(CASE WHEN fk_userid= ? THEN 1 END) AS qnaCnt, qna_title, qna_contents from tbl_qna_board " +
						    " where "+qna_option+" like '%'|| ? ||'%' ) Q ";
				}
				else if( "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 내용일 때
					re_option = "re_contents";
					qna_option = "qna_contents";
					sql +=  " from ( select COUNT(CASE WHEN fk_userid= ? THEN 1 END) AS revCnt, re_title, re_contents from tbl_review_board " +
						    " where "+re_option+" like '%'|| ? ||'%' ) R "+
						    " , ( select COUNT(CASE WHEN fk_userid= ? THEN 1 END) AS qnaCnt, qna_title, qna_contents from tbl_qna_board " +
						    " where "+qna_option+" like '%'|| ? ||'%' ) Q ";
				}
				else { // 검색조건이 없을 때
					sql += " from ( select COUNT(CASE WHEN fk_userid= ? THEN 1 END) AS revCnt, re_title, re_contents from tbl_review_board " +
						   " ) R "+
						   " , ( select COUNT(CASE WHEN fk_userid= ? THEN 1 END) AS qnaCnt, qna_title, qna_contents from tbl_qna_board " +
						   " ) Q ";
				}
				// System.out.println(" 확인용 colname : " + colname);
				// System.out.println(" 확인용 searchWord : " + searchWord);
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("sizePerPage"));
				
				if( "my_title".equalsIgnoreCase(colname) ) { // 검색조건이 제목일 때
					pstmt.setString(2, paraMap.get("userid"));
					pstmt.setString(3, searchWord);
					pstmt.setString(4, paraMap.get("userid"));
					pstmt.setString(5, searchWord);
				}
				else if( "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 내용일 때
					pstmt.setString(2, paraMap.get("userid"));
					pstmt.setString(3, searchWord);
					pstmt.setString(4, paraMap.get("userid"));
					pstmt.setString(5, searchWord);
					
				}
				else { // 검색조건이 없을 때
					pstmt.setString(2, paraMap.get("userid"));
					pstmt.setString(3, paraMap.get("userid"));
				}
				
				rs = pstmt.executeQuery();
				
				rs.next();
				
				totalPage = rs.getInt(1);
			
			} finally {
			close();
			}
			
			return totalPage;
			
		} // public int getTotalfaqPage(Map<String, String> paraMap) throws SQLException 

	
	
}

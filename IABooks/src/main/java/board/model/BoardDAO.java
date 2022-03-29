package board.model;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import member.model.MemberVO;
import util.security.AES256;
import util.security.SecretMyKey;

public class BoardDAO implements InterBoardDAO {

	
	
	private DataSource ds; // // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes;
	
	// 기본생성자 
	public BoardDAO() {
		
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/mymvc_oracle");
		    // ds에 있는 jdbc/mymvc_oracle은 web.xml에 있는 것이다.
		    
		    aes = new AES256(SecretMyKey.KEY);
		    // SecretMyKey.KEY 은 우리가 만든 비밀키이다.
		    
		} catch(NamingException e) {
			e.printStackTrace();
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
	    
	}
	
	// 자원 반납해주는 메소드
	private void close() {
		
		try {
			if(rs != null) { rs.close(); rs = null;}
			if(pstmt != null) { pstmt.close(); pstmt = null;}
			if(conn != null) { conn.close(); conn = null;}
			// 최근 순으로 닫아라
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
	} // end of private void close() 
	
	
	
	// *** 글목록보기 메소드를 구현하기 *** //
		@Override
		public List<QnABoardVO> boardList() {  
			
			List<QnABoardVO> boardList = new ArrayList<>(); //BoardDTO 속에는 MemberDTO가 들어와야 한다.
			
			try {
				
				Class.forName("oracle.jdbc.driver.OracleDriver");
				
				conn = DriverManager.getConnection("jdbc:oracle:thin:@211.238.142.70:1521:xe", "semiorauser3", "cclass" );
				
				/* 처음에 한거
				String sql = " select boardno,  subject, name, to_char(writeday,'yyyy-mm-dd hh24:mi:ss'), viewcount\n"+
							 " from jdbc_board B JOIN jdbc_member M\n"+
							 " ON B.fk_userid = M.userid\n"+
							 " order by boardno desc";
				*/
				
				String sql = " select pk_qna_num,  qna_title, fk_userid, to_char(qna_date,'yyyy-mm-dd hh24:mi:ss'), qna_readcount\n"+
							 " from tbl_qna_board B JOIN tbl_member M\n"+
							 " ON B.fk_userid = M.pk_userid\n"+
							 " order by pk_qna_num desc" ;
					//BoardDTO는 회원이 존재해야만 그 회원이 글을 쓴다. 회원이 없는데 어뜨캐 글을 쓰냐 회원테이블이 먼저 존재한다. 
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					QnABoardVO board = new QnABoardVO();
					
					board.setPk_qna_num(rs.getInt(1));
					board.setQna_title(rs.getString(2));
					/* board.setFk_userid(rs.getString(3)); */
					
							//**중요한 부분
					MemberVO member = new MemberVO();
					member.setName(rs.getString(3));
					board.setMember(member); // 보드에 멤버를 넣어줌. 
				
					board.setQna_date(rs.getString(4));
					board.setQna_readcount(rs.getInt(5));
					
					
					boardList.add(board);
				
				}//end of while(rs.next()) ------------ 
				
			} catch (ClassNotFoundException e) {
				System.out.println(">> ojdbc6.jar 파일이 없습니다. <<");
			}catch(SQLException e){  
				e.printStackTrace();
			}finally {
				close();
			}
			
			
			return boardList;
		}//end of public List<BoardDTO> boardList() -----

	
	
}

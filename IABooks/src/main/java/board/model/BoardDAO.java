package board.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.DriverManager;
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

import member.model.MemberVO;
import product.model.ProductVO;
import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

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
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			ds = (DataSource) envContext.lookup("jdbc/semiorauser3");
			// ds에 있는 jdbc/mymvc_oracle은 web.xml에 있는 것이다.

			aes = new AES256(SecretMyKey.KEY);
			// SecretMyKey.KEY 은 우리가 만든 비밀키이다.

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

	}

	// 자원 반납해주는 메소드
	private void close() {

		try {
			if (rs != null) {
				rs.close();
				rs = null;
			}
			if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			if (conn != null) {
				conn.close();
				conn = null;
			}
			// 최근 순으로 닫아라
		} catch (SQLException e) {
			e.printStackTrace();
		}

	} // end of private void close()

	
	// *** QnA 글목록보기 메소드를 구현하기 *** //
	@Override
	public List<QnABoardVO> selectPagingQnaBoard(Map<String, String> paraMap) throws SQLException {

		List<QnABoardVO> qnaboardList = new ArrayList<>(); // BoardDTO 속에는 MemberDTO가 들어와야 한다.
		QnABoardVO board = null;
		try {

			conn = ds.getConnection();
			/*
			 * 처음에 한거 String sql =
			 * " select boardno,  subject, name, to_char(writeday,'yyyy-mm-dd hh24:mi:ss'), viewcount\n"
			 * + " from jdbc_board B JOIN jdbc_member M\n"+ " ON B.fk_userid = M.userid\n"+
			 * " order by boardno desc";
			 */

			String sql = "select  pk_qna_num, P.pro_name, P.pro_imgfile_name, qna_title, M.mname, to_char(qna_date,'yyyy-mm-dd hh24:mi:ss'), qna_readcount , fk_userid , qna_issecret\n"+
					"from tbl_member M\n"+
					"JOIN tbl_qna_board Q  ON M.pk_userid = Q.fk_userid\n"+
					"JOIN tbl_product P ON Q.fk_pnum = P.pk_pro_num\n"+
					"where isdelete = 0\n"+
					"order by pk_qna_num desc";
			/*
			String sql = "\n"
					+ " select pk_rnum, re_title, to_char(re_date,'yyyy-mm-dd hh24:mi:ss'), re_readcount, re_grade\r\n"
					+ " from tbl_review_board";
			*/
			
			// BoardDTO는 회원이 존재해야만 그 회원이 글을 쓴다. 회원이 없는데 어뜨캐 글을 쓰냐 회원테이블이 먼저 존재한다.
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
/*
				board = new QnABoardVO();
				
				board.setPk_qna_num(rs.getInt(1));
				
				qnaboardList.add(board);
				
				System.out.println(" 넣어진 것 : " + board.getPk_qna_num());
*/				
				
				board = new QnABoardVO();
				
				board.setPk_qna_num(rs.getInt(1));
				
				ProductVO product = new ProductVO(); 
				product.setPro_name(rs.getString(2));
				product.setPro_imgfile_name(rs.getString(3)); 
				board.setProduct(product);
				
				board.setQna_title(rs.getString(4)); 
				board.setFk_userid(rs.getString(3));
				
				// **중요한 부분 
				MemberVO member = new MemberVO();
				member.setName(rs.getString(5)); 
				board.setMember(member); // 보드에 멤버를 넣어줌.
				
				board.setQna_date(rs.getString(4)); 
				board.setQna_readcount(rs.getInt(5));
				
				qnaboardList.add(board);
				
				System.out.println(" 넣어진 제목 : " + board.getQna_title());
				
			} // end of while(rs.next()) ------------

		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return qnaboardList;
	}// end of public List<BoardDTO> boardList() -----

	
	
	
	
	// FAQ 글목록보기 메소드를 구현하기 //
	@Override
	public List<FaqBoardVO> faqBoardList() throws SQLException {

		List<FaqBoardVO> faqBoardList = new ArrayList<>(); // 글목록 불러올 리스트 객체화

		FaqBoardVO board = null;

		int faq_board_num;
		String fk_faq_c_name = "";
		String faq_title = "";
		String faq_writer = "";

		conn = ds.getConnection();

		try {

			String sql = " select A.pk_faq_board_num, B.faq_c_name, A.faq_title, A.faq_writer "
					+ " from tbl_faq_board A LEFT JOIN tbl_faq_category B " + " ON A.fk_faq_c_num = B.pk_faq_c_num "
					+ " where isdelete = 0 " + " order by pk_faq_board_num desc ";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				faq_board_num = rs.getInt(1);
				fk_faq_c_name = rs.getString(2);
				faq_title = rs.getString(3);
				faq_writer = rs.getString(4);

				board = new FaqBoardVO();
				board.setPk_faq_board_num(faq_board_num);
				board.setFk_faq_c_name(fk_faq_c_name);
				board.setFaq_title(faq_title);
				board.setFaq_writer(faq_writer);

				MemberVO member = new MemberVO();
				member.setName(fk_faq_c_name);
				board.setMember(member); // 보드에 멤버를 넣어줌.

				faqBoardList.add(board);

				// System.out.println(" 넣어진 제목 : " + board.getFaq_title());

			} // end of while(rs.next()) ------------

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return faqBoardList;

	}

	// *** 리뷰글목록보기 메소드를 구현하기 *** //
	@Override
	public List<ReviewBoardVO> reviewList() throws SQLException {

		List<ReviewBoardVO> reviewList = new ArrayList<>(); // ReviewBoardVO 속에는 MemberDTO가 들어와야 한다.

		ReviewBoardVO board = null;

		conn = ds.getConnection();
		try {

			String sql = "select pk_rnum,  fk_pnum, re_title, re_writer, to_char(re_date,'yyyy-mm-dd hh24:mi:ss'), re_grade , M.mname\n"
					+ "from tbl_review_board B \n" + "JOIN tbl_member M \n" + "ON B.fk_userid = M.pk_userid \n"
					+ "where isdelete = 0\n" + "order by pk_rnum desc ";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				board = new ReviewBoardVO();

				board.setPk_rnum(rs.getInt(1));

				ProductVO product = new ProductVO();
				board.setFk_pnum(rs.getInt(2));
				board.setRe_title(rs.getString(3));
				board.setRe_writer(rs.getString(4));
				board.setRe_date(rs.getString(5));
				board.setRe_grade(rs.getInt(6));

				MemberVO member = new MemberVO();
				member.setName(rs.getString(7));
				board.setMember(member);
				/*
				 * MemberVO member = new MemberVO(); member.set(fk_faq_c_name);
				 * 
				 * board.setMember(member); // 보드에 멤버를 넣어줌.
				 */
				System.out.println(" 넣어진 제목 : " + board.getRe_title());

				reviewList.add(board);

			} // end of while(rs.next()) ------------

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return reviewList;
	}// end of public List<BoardDTO> boardList() -----

	// FAQ 게시판에 글 작성하기
	@Override
	public int writeFaqBoard(Map<String, String> paraMap) throws SQLException {

		int result = 0;
		int category = Integer.parseInt(paraMap.get("category"));
		System.out.println("category : " + category);

		try {
			conn = ds.getConnection();

			String sql = " insert into tbl_faq_board (pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents) "
					+ " values(SEQ_FAQ_BOARD.nextval, 'indiepub', ?, ?, ?, ?) ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, category);
			pstmt.setString(2, paraMap.get("subject"));
			pstmt.setString(3, paraMap.get("writer"));
			pstmt.setString(4, paraMap.get("content"));

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return result;
	}

	

	/*
	 * // 페이징 처리가 되어진 모든 글 또는 검색 한 글 목록 보여주기 public List<QnABoardVO>
	 * selectPagingqnaBoard(Map<String, String> paraMap) throws SQLException {
	 * List<QnABoardVO> qnaboardList = new ArrayList<>(); try { conn =
	 * ds.getConnection();
	 * 
	 * String sql = " select userid, name, email, gender " + " from " + " (  " +
	 * "		select rownum AS rno, userid, name, email, gender " + "		from " +
	 * "    	( " + "    		select userid, name, email, gender " +
	 * "    		from tbl_member " + "    		where userid !='admin' " +
	 * "    		order by registerday desc " + "    	) V " + " ) T " +
	 * " where rno between ? and ? " ;
	 * 
	 * pstmt = conn.prepareStatement(sql);
	 * 
	 * int currentShowPageNo = Integer.parseInt( paraMap.get("currentShowPageNo") );
	 * 
	 * int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage") );
	 * 
	 * 
	 * 
	 * >>> where rno between A and B A 와 B 를 구하는 공식 <<<
	 * 
	 * currentShowPageNo 은 보고자 하는 페이지 번호이다. 즉, 1페이지, 2페이지, 3페이지... 를 말한다.
	 * sizePerPage 는 한페이지당 보여줄 행의 개수를 말한다. 즉, 3개, 5개, 10개를 보여줄떄의 개수를 말한다.
	 * 
	 * A 는 (currentShowPageNo * sizePerPage) - (sizePerPage - 1) 이다.
	 * 
	 * B 는 (currentShowPageNo * sizePerPage) 이다.
	 * 
	 * 
	 * 
	 * pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
	 * pstmt.setInt(2, (currentShowPageNo * sizePerPage));
	 * 
	 * rs = pstmt.executeQuery();
	 * 
	 * while(rs.next()) { //셀렉되어진 개수만큼 나온다
	 * 
	 * BoardVO board = new BoardVO(); board.setUserid(rs.getString(1));
	 * board.setName(rs.getString(2)); board.setEmail( aes.decrypt( rs.getString(3)
	 * ));//복호화 필요 board.setGender(rs.getString(4)); //db에는 이메일이 암호화되어진 것을 웹상에 뿌릴 떄는
	 * 복호화 해준다.
	 * 
	 * qnaboardList.add(board);
	 * 
	 * }// end of while----
	 * 
	 * }catch(GeneralSecurityException | UnsupportedEncodingException e) {
	 * e.printStackTrace();
	 * 
	 * } finally { close(); }
	 * 
	 * return qnaboardList; }
	 */

}
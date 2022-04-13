package board.model;

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
			String userid = "";
			
			try {
				conn = ds.getConnection();
				
				String sql = " select count(*) "
						   + " from tbl_qna_board"
						   + " where isdelete = 0 ";
				
				if( "myboard".equalsIgnoreCase(paraMap.get("needid")) ) {
					sql += " and fk_userid = ? ";
					userid = paraMap.get("userid");
				}
				
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
				
				if( "myboard".equalsIgnoreCase(paraMap.get("needid")) ) { // 내 게시물 보기에서 접근했을 때
					
					pstmt.setString(1, userid);
				
					if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
						// 검색종류와 검색어가 있으면	
						pstmt.setString(2, searchWord);
					}
				}
				else if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ){ // 내 게시물 보기가 아니며
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
				String sql = "";
				
				if("review".equalsIgnoreCase(searchCate)) { // 카테고리가 리뷰일 때
					
					sql = " select ceil( revCnt / ? ) AS myCnt ";
					
					if( "my_title".equalsIgnoreCase(colname) ) { // 검색조건이 제목일 때
						re_option = "re_title";
						sql +=  " from ( select COUNT(CASE WHEN fk_userid= ? THEN 1 END) AS revCnt, re_title, re_contents from tbl_review_board " +
							    " where "+re_option+" like '%'|| ? ||'%' ) R ";
					}
					else if( "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 내용일 때
						re_option = "re_contents";
						sql +=  " from ( select COUNT(CASE WHEN fk_userid= ? THEN 1 END) AS revCnt, re_title, re_contents from tbl_review_board " +
							    " where "+re_option+" like '%'|| ? ||'%' ) R ";
					}
					else { // 검색조건이 없을 때
						sql += " from ( select COUNT(CASE WHEN fk_userid= ? THEN 1 END) AS revCnt, re_title, re_contents from tbl_review_board " +
							   " ) R ";
					}
					
				}
				else if("qna".equalsIgnoreCase(searchCate)) { // 카테고리가 문의일 때
					
					sql = " select ceil( qnaCnt / ? ) AS myCnt ";
					
					if( "my_title".equalsIgnoreCase(colname) ) { // 검색조건이 제목일 때
						qna_option = "qna_title";
						sql +=  " from ( select COUNT(CASE WHEN fk_userid= ? THEN 1 END) AS qnaCnt, qna_title, qna_contents from tbl_qna_board " +
							    " where "+qna_option+" like '%'|| ? ||'%' ) Q ";
					}
					else if( "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 내용일 때
						qna_option = "qna_contents";
						sql +=  " from ( select COUNT(CASE WHEN fk_userid= ? THEN 1 END) AS qnaCnt, qna_title, qna_contents from tbl_qna_board " +
							    " where "+qna_option+" like '%'|| ? ||'%' ) Q ";
					}
					else { // 검색조건이 없을 때
						sql += " from ( select COUNT(CASE WHEN fk_userid= ? THEN 1 END) AS qnaCnt, qna_title, qna_contents from tbl_qna_board " +
							   " ) Q ";
					}
					
					
				}
				else { // 카테고리가 전체 혹은 없을 때
					sql = " select ceil( (revCnt + qnaCnt) / ? ) AS myCnt ";
					
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
				}
				// System.out.println(" 확인용 colname : " + colname);
				// System.out.println(" 확인용 searchWord : " + searchWord);
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("sizePerPage"));
				
				
				if( "review".equalsIgnoreCase(searchCate) || "qna".equalsIgnoreCase(searchCate) ) { // 카테고리가 있고
					if( "my_title".equalsIgnoreCase(colname) || "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 있을 때
						pstmt.setString(2, paraMap.get("userid"));
						pstmt.setString(3, searchWord);
					}
					else { // 검색조건이 없을 때
						pstmt.setString(2, paraMap.get("userid"));
					}
				}
				else { // 카테고리가 없고
					if( "my_title".equalsIgnoreCase(colname) || "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 있을 때
						pstmt.setString(2, paraMap.get("userid"));
						pstmt.setString(3, searchWord);
						pstmt.setString(4, paraMap.get("userid"));
						pstmt.setString(5, searchWord);
					}
					else { // 검색조건이 없을 때
						pstmt.setString(2, paraMap.get("userid"));
						pstmt.setString(3, paraMap.get("userid"));
					}
				}
				rs = pstmt.executeQuery();
				
				rs.next();
				
				totalPage = rs.getInt(1);
			
			} finally {
			close();
			}
			
			return totalPage;
			
		} // public int getTotalfaqPage(Map<String, String> paraMap) throws SQLException 
		
		
		// 게시글 번호 표시를 위한 검색이 있는 또는 검색이 없는 전체 리뷰 게시판에 대한 페이지 알아오기
		@Override
		public ReviewBoardVO getTotalReviewCnt(Map<String, String> paraMap) throws SQLException {
			ReviewBoardVO rvo = new ReviewBoardVO();
			String userid = "";
			try {
				conn = ds.getConnection();
				
				String sql = " select count(*) "
						   + " from tbl_review_board"
						   + " where isdelete = 0 ";
				
				if( "myboard".equalsIgnoreCase(paraMap.get("needid")) ) {
					sql += " and fk_userid = ? ";
					userid = paraMap.get("userid");
				}
				
				
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
				
				if( "myboard".equalsIgnoreCase(paraMap.get("needid")) ) { // 내 게시물 보기에서 접근했을 때
					
					pstmt.setString(1, userid);
				
					if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
						// 검색종류와 검색어가 있으면	
						pstmt.setString(2, searchWord);
					}
				}
				else if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ){ // 내 게시물 보기가 아니며
					// 검색종류와 검색어가 있으면	
					pstmt.setString(1, searchWord);
				}
				
				rs = pstmt.executeQuery();
				
				rs.next();
				
				rvo.setTotalCnt(rs.getInt(1));
				
			} finally {
				close();
			}
			
			return rvo;
		}

		
		// 마이페이지에 보여줄 내가 쓴 게시글 불러오기
		@Override
		public List<MyBoardVO> selectPagingMyBoard(Map<String, String> paraMap) throws SQLException {

			MyBoardVO myBoardVO = null;
			
			List<MyBoardVO> myBoardList = new ArrayList<>();
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			// System.out.println("currentShowPageNo : " + currentShowPageNo);
			// System.out.println("sizePerPage : " + sizePerPage);
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");	
			String searchCate = paraMap.get("searchCate");
			String re_option = "";
			String qna_option = "";
			// System.out.println(" 잘와진 카테고리 : " + searchCate);
			
			try {
			
				
				conn = ds.getConnection();
				String sql = "";
				/*
				sql = "SELECT nvl(pk_qna_num, -999) AS pk_qna_num, nvl(qna_title, -999) AS qna_title, nvl(qna_date, -999) AS qna_date, " +
						" nvl(pk_rnum, -999) AS pk_rnum, nvl(re_title, -999) AS re_title, nvl(re_date, -999) AS re_date, nvl(re_grade, -999) AS re_grade," +
					    " nvl(re_contents, -999) AS re_contents, nvl(qna_contents, -999) AS qna_contents, rownum "+
				*/
				sql = " SELECT pk_qna_num, qna_title, qna_date, pk_rnum, re_title, re_date, re_grade, re_contents, qna_contents "+
							" FROM "+
							" ( "+
							"    select rownum AS rno, pk_qna_num, qna_title, qna_date, pk_rnum, re_title, re_date, re_grade, re_contents, qna_contents "+
							"    from  "+
							"        ( "+
							"        select A.pk_qna_num AS pk_qna_num, A.qna_title AS qna_title, TO_CHAR(A.qna_date, 'yyyy-mm-dd') AS qna_date, A.qna_contents AS qna_contents "+
							"        from tbl_qna_board A "+
							"        FULL OUTER JOIN tbl_review_board B "+
							"        ON A.qna_title = B.re_title "+
							"        where A.fk_userid = ? and A.isdelete = 0 order by qna_date desc "+
							"        ) Q\n"+
							"    FULL OUTER JOIN\n"+
							"        (\n"+
							"        select B.pk_rnum AS pk_rnum, B.re_title AS re_title, TO_CHAR(B.re_date, 'yyyy-mm-dd') AS re_date, B.re_grade AS re_grade, B.re_contents AS re_contents "+
							"        from tbl_qna_board A "+
							"        FULL OUTER JOIN tbl_review_board B "+
							"        ON A.qna_title = B.re_title "+
							"        where B.fk_userid = ? and B.isdelete = 0 order by re_date desc "+
							"        ) R "+
							"    ON Q.qna_title = R.re_title " +
							"    ) V "+
							" where rno between ? and ?";		
					
				if("review".equalsIgnoreCase(searchCate)) { // 카테고리가 후기이면서
					sql += " and pk_rnum is not null and pk_qna_num is null ";
					
					if( "my_title".equalsIgnoreCase(colname) ) { // 검색조건이 제목일 때
						re_option = "re_title";
						sql += " and "+re_option+" like '%'|| ? ||'%' ";
					}
					
					if( "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 내용일 때
						re_option = "re_contents";
						sql += " and "+re_option+" like '%'|| ? ||'%' ";
					}
					
				}
				else if("qna".equalsIgnoreCase(searchCate)) { // 카테고리가 문의이면서
					sql += " and pk_qna_num is not null and pk_rnum is null ";
					
					if( "my_title".equalsIgnoreCase(colname) ) { // 검색조건이 제목일 때
						qna_option = "qna_title";
						sql += " and "+qna_option+" like '%'|| ? ||'%' ";
					}
					
					if( "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 내용일 때
						qna_option = "qna_contents";
						sql += " and "+qna_option+" like '%'|| ? ||'%' ";
					}
				}
				else { // 카테고리가 전체 혹은 없으면서
					
					if( "my_title".equalsIgnoreCase(colname) ) { // 검색조건이 제목일 때
						re_option = "re_title";
						qna_option = "qna_title";
						sql += " and "+re_option+" like '%'|| ? ||'%' or "+qna_option+" like '%'|| ? ||'%' ";
					}
					
					if( "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 내용일 때
						re_option = "re_contents";
						qna_option = "qna_contents";
						sql += " and "+re_option+" like '%'|| ? ||'%' or "+qna_option+" like '%'|| ? ||'%' ";
					}
				}
					
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, paraMap.get("userid"));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(4, (currentShowPageNo * sizePerPage));
				
				if("review".equalsIgnoreCase(searchCate) && ( "my_title".equalsIgnoreCase(colname) || "my_contents".equalsIgnoreCase(colname) ) ) { // 카테고리가 후기면
					pstmt.setString(5, searchWord);
				}
				else if("qna".equalsIgnoreCase(searchCate) && ( "my_title".equalsIgnoreCase(colname) || "my_contents".equalsIgnoreCase(colname) ) ) { // 카테고리가 문의면
					pstmt.setString(5, searchWord);
				}
				else {
					if( "my_title".equalsIgnoreCase(colname) || "my_contents".equalsIgnoreCase(colname) ) {
						pstmt.setString(5, searchWord);
						pstmt.setString(6, searchWord);
					}
				}	
				
				rs = pstmt.executeQuery();
				
				QnABoardVO qna = null;
				ReviewBoardVO review = null;
				
				while(rs.next()) {
				
					if("qna".equalsIgnoreCase(searchCate)) {
						myBoardVO = new MyBoardVO();
						
						qna = new QnABoardVO();
						qna.setPk_qna_num(rs.getInt(1));
						qna.setQna_title(rs.getString(2));
						qna.setQna_date(rs.getString(3));
						qna.setQna_contents(rs.getString(9));
						myBoardVO.setQnaBoard(qna);
					}
					else if("review".equalsIgnoreCase(searchCate)) {
						myBoardVO = new MyBoardVO();
						
						review = new ReviewBoardVO();
						review.setPk_rnum(rs.getInt(4));
						review.setRe_title(rs.getString(5));
						review.setRe_date(rs.getString(6));
						review.setRe_grade(rs.getInt(7));
						review.setRe_contents(rs.getString(8));
						myBoardVO.setRevBoard(review);
					}
					else {
						myBoardVO = new MyBoardVO();
						
						qna = new QnABoardVO();
						qna.setPk_qna_num(rs.getInt(1));
						qna.setQna_title(rs.getString(2));
						qna.setQna_date(rs.getString(3));
						qna.setQna_contents(rs.getString(9));
						myBoardVO.setQnaBoard(qna);
						
						review = new ReviewBoardVO();
						review.setPk_rnum(rs.getInt(4));
						review.setRe_title(rs.getString(5));
						review.setRe_date(rs.getString(6));
						review.setRe_grade(rs.getInt(7));
						review.setRe_contents(rs.getString(8));
						myBoardVO.setRevBoard(review);
						
						// System.out.println("잘들어감? => " + myBoardVO.getRevBoard().getRe_title());
						// System.out.println("잘들어감? => " + myBoardVO.getQnaBoard().getQna_title());
						
					}
					myBoardList.add(myBoardVO);
					
				}//end of while(rs.next()) ------------ 
			
			
			} catch(SQLException e){  
				e.printStackTrace();
			} catch(NumberFormatException e) { 
				e.printStackTrace();
			} finally {
				close();
			}
			
			
			return myBoardList;
			
		} // public List<MyBoardVO> selectPagingMyBoard(Map<String, String> paraMap) throws SQLException-------

		
		// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체게시판에 대한 페이지 알아오기(관리자 전용)
		@Override
		public int getTotalAdminPage(Map<String, String> paraMap) throws SQLException {
			
			int totalPage = 0;
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			String searchCate = paraMap.get("searchCate");	
			String re_option = ""; 
			String qna_option = "";
			
			
			
			try {
				conn = ds.getConnection();
				String sql = "";
				
				if("review".equalsIgnoreCase(searchCate)) { // 카테고리가 리뷰일 때
					
					sql = " select ceil( revCnt / ? ) AS myCnt ";
					
					if( "my_title".equalsIgnoreCase(colname) ) { // 검색조건이 제목일 때
						re_option = "re_title";
						sql +=  " from ( select COUNT(*) AS revCnt, re_title, re_contents from tbl_review_board " +
							    " where "+re_option+" like '%'|| ? ||'%' ) R ";
					}
					else if( "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 내용일 때
						re_option = "re_contents";
						sql +=  " from ( select COUNT(*) AS revCnt, re_title, re_contents from tbl_review_board " +
							    " where "+re_option+" like '%'|| ? ||'%' ) R ";
					}
					else { // 검색조건이 없을 때
						sql += " from ( select COUNT(*) AS revCnt, re_title, re_contents from tbl_review_board " +
							   " ) R ";
					}
					
				}
				else if("qna".equalsIgnoreCase(searchCate)) { // 카테고리가 문의일 때
					
					sql = " select ceil( qnaCnt / ? ) AS myCnt ";
					
					if( "my_title".equalsIgnoreCase(colname) ) { // 검색조건이 제목일 때
						qna_option = "qna_title";
						sql +=  " from ( select COUNT(*) AS qnaCnt, qna_title, qna_contents from tbl_qna_board " +
							    " where "+qna_option+" like '%'|| ? ||'%' ) Q ";
					}
					else if( "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 내용일 때
						qna_option = "qna_contents";
						sql +=  " from ( select COUNT(*) AS qnaCnt, qna_title, qna_contents from tbl_qna_board " +
							    " where "+qna_option+" like '%'|| ? ||'%' ) Q ";
					}
					else { // 검색조건이 없을 때
						sql += " from ( select COUNT(*) AS qnaCnt, qna_title, qna_contents from tbl_qna_board " +
							   " ) Q ";
					}
					
					
				}
				else { // 카테고리가 전체 혹은 없을 때
					sql = " select ceil( (revCnt + qnaCnt) / ? ) AS myCnt ";
					
					if( "my_title".equalsIgnoreCase(colname) ) { // 검색조건이 제목일 때
						re_option = "re_title";
						qna_option = "qna_title";
						sql +=  " from ( select COUNT(*) AS revCnt, re_title, re_contents from tbl_review_board " +
							    " where "+re_option+" like '%'|| ? ||'%' ) R "+
							    " , ( select COUNT(*) AS qnaCnt, qna_title, qna_contents from tbl_qna_board " +
							    " where "+qna_option+" like '%'|| ? ||'%' ) Q ";
					}
					else if( "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 내용일 때
						re_option = "re_contents";
						qna_option = "qna_contents";
						sql +=  " from ( select COUNT(*) AS revCnt, re_title, re_contents from tbl_review_board " +
							    " where "+re_option+" like '%'|| ? ||'%' ) R "+
							    " , ( select COUNT(*) AS qnaCnt, qna_title, qna_contents from tbl_qna_board " +
							    " where "+qna_option+" like '%'|| ? ||'%' ) Q ";
					}
					else { // 검색조건이 없을 때
						sql += " from ( select COUNT(*) AS revCnt, re_title, re_contents from tbl_review_board " +
							   " ) R "+
							   " , ( select COUNT(*) AS qnaCnt, qna_title, qna_contents from tbl_qna_board " +
							   " ) Q ";
					}
				}
				// System.out.println(" 확인용 colname : " + colname);
				// System.out.println(" 확인용 searchWord : " + searchWord);
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("sizePerPage"));
				
				
				if( "review".equalsIgnoreCase(searchCate) || "qna".equalsIgnoreCase(searchCate) ) { // 카테고리가 있고
					if( "my_title".equalsIgnoreCase(colname) || "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 있을 때
						pstmt.setString(2, searchWord);
					}
				}
				else { // 카테고리가 없고
					if( "my_title".equalsIgnoreCase(colname) || "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 있을 때
						pstmt.setString(2, searchWord);
						pstmt.setString(3, searchWord);
					}
				}
				rs = pstmt.executeQuery();
				
				rs.next();
				
				totalPage = rs.getInt(1);
			
			} finally {
			close();
			}
			
			return totalPage;
			
		} // end of public int getTotalAdminPage(Map<String, String> paraMap) throws SQLException

		
		// 관리자페이지 게시글관리에에 보여줄 모든 게시글 불러오기
		@Override
		public List<MyBoardVO> selectPagingAdminBoard(Map<String, String> paraMap) throws SQLException {

			MyBoardVO myBoardVO = null;
			
			List<MyBoardVO> adminBoardList = new ArrayList<>();
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			// System.out.println("currentShowPageNo : " + currentShowPageNo);
			// System.out.println("sizePerPage : " + sizePerPage);
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");	
			String searchCate = paraMap.get("searchCate");
			String re_option = "";
			String qna_option = "";
			// System.out.println(" 잘와진 카테고리 : " + searchCate);
			
			try {
			
				
				conn = ds.getConnection();
				String sql = "";
				/*
					sql = "SELECT pk_qna_num, qna_title, qna_date, pk_rnum, re_title, re_date, re_grade, re_contents, qna_contents, qna_isdelete, re_isdelete "+
						" FROM "+
						" ( "+
						"    select rownum AS rno, pk_qna_num, qna_title, qna_date, pk_rnum, re_title, re_date, re_grade, re_contents, qna_contents, qna_isdelete, re_isdelete "+
						"    from  "+
						"        ( "+
						"        select A.pk_qna_num AS pk_qna_num, A.qna_title AS qna_title, TO_CHAR(A.qna_date, 'yyyy-mm-dd') AS qna_date, A.qna_contents AS qna_contents, A.isdelete AS qna_isdelete "+
						"        from tbl_qna_board A "+
						"        FULL OUTER JOIN tbl_review_board B "+
						"        ON A.qna_title = B.re_title "+
						"		 where A.fk_userid is not null and B.re_title is null "+
						"        ) Q\n"+
						"    FULL OUTER JOIN\n"+
						"        (\n"+
						"        select B.pk_rnum AS pk_rnum, B.re_title AS re_title, TO_CHAR(B.re_date, 'yyyy-mm-dd') AS re_date, B.re_grade AS re_grade, B.re_contents AS re_contents, B.isdelete AS re_isdelete "+
						"        from tbl_qna_board A "+
						"        FULL OUTER JOIN tbl_review_board B "+
						"        ON A.qna_title = B.re_title "+
						"		 where B.fk_userid is not null and A.qna_title is null "+	
						"        ) R "+
						"    ON Q.qna_title = R.re_title " +
						"    ) V "+
						" where rno between ? and ?";		
				*/
				
				
				
				sql = " SELECT pk_qna_num, qna_title, qna_date, pk_rnum, re_title, re_date, re_grade, re_contents, qna_contents "+
						" FROM "+
						" ( "+
						"    select rownum AS rno, pk_qna_num, qna_title, qna_date, pk_rnum, re_title, re_date, re_grade, re_contents, qna_contents "+
						"    from  "+
						"        ( "+
						"        select A.pk_qna_num AS pk_qna_num, A.qna_title AS qna_title, TO_CHAR(A.qna_date, 'yyyy-mm-dd') AS qna_date, A.qna_contents AS qna_contents "+
						"        from tbl_qna_board A "+
						"        FULL OUTER JOIN tbl_review_board B "+
						"        ON A.qna_title = B.re_title "+
						"		 where A.fk_userid is not null and B.re_title is null "+
						"        order by A.qna_date desc "+
						"        ) Q\n"+
						"    FULL OUTER JOIN\n"+
						"        (\n"+
						"        select B.pk_rnum AS pk_rnum, B.re_title AS re_title, TO_CHAR(B.re_date, 'yyyy-mm-dd') AS re_date, B.re_grade AS re_grade, B.re_contents AS re_contents"+
						"        from tbl_qna_board A "+
						"        FULL OUTER JOIN tbl_review_board B "+
						"        ON A.qna_title = B.re_title "+
						"		 where B.fk_userid is not null and A.qna_title is null "+	
						"        order by B.re_date desc "+
						"        ) R "+
						"    ON Q.qna_title = R.re_title " +
						"    ) V "+
						" where rno between ? and ?";
				
				if("review".equalsIgnoreCase(searchCate)) { // 카테고리가 후기이면서
					sql += " and pk_rnum is not null and pk_qna_num is null ";
					
					if( "my_title".equalsIgnoreCase(colname) ) { // 검색조건이 제목일 때
						re_option = "re_title";
						sql += " and "+re_option+" like '%'|| ? ||'%' ";
					}
					
					if( "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 내용일 때
						re_option = "re_contents";
						sql += " and "+re_option+" like '%'|| ? ||'%' ";
					}
					
				}
				else if("qna".equalsIgnoreCase(searchCate)) { // 카테고리가 문의이면서
					sql += " and pk_qna_num is not null and pk_rnum is null ";
					
					if( "my_title".equalsIgnoreCase(colname) ) { // 검색조건이 제목일 때
						qna_option = "qna_title";
						sql += " and "+qna_option+" like '%'|| ? ||'%' ";
					}
					
					if( "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 내용일 때
						qna_option = "qna_contents";
						sql += " and "+qna_option+" like '%'|| ? ||'%' ";
					}
				}
				else { // 카테고리가 전체 혹은 없으면서
					
					if( "my_title".equalsIgnoreCase(colname) ) { // 검색조건이 제목일 때
						re_option = "re_title";
						qna_option = "qna_title";
						sql += " and "+re_option+" like '%'|| ? ||'%' or "+qna_option+" like '%'|| ? ||'%' ";
					}
					
					if( "my_contents".equalsIgnoreCase(colname) ) { // 검색조건이 내용일 때
						re_option = "re_contents";
						qna_option = "qna_contents";
						sql += " and "+re_option+" like '%'|| ? ||'%' or "+qna_option+" like '%'|| ? ||'%' ";
					}
				}
					
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage));
				
				if("review".equalsIgnoreCase(searchCate) && ( "my_title".equalsIgnoreCase(colname) || "my_contents".equalsIgnoreCase(colname) ) ) { // 카테고리가 후기면
					pstmt.setString(3, searchWord);
				}
				else if("qna".equalsIgnoreCase(searchCate) && ( "my_title".equalsIgnoreCase(colname) || "my_contents".equalsIgnoreCase(colname) ) ) { // 카테고리가 문의면
					pstmt.setString(3, searchWord);
				}
				else {
					if( "my_title".equalsIgnoreCase(colname) || "my_contents".equalsIgnoreCase(colname) ) {
						pstmt.setString(3, searchWord);
						pstmt.setString(4, searchWord);
					}
				}	
				
				rs = pstmt.executeQuery();
				
				QnABoardVO qna = null;
				ReviewBoardVO review = null;
				
				while(rs.next()) {
					if("qna".equalsIgnoreCase(searchCate)) {
						myBoardVO = new MyBoardVO();
						qna = new QnABoardVO();
						qna.setPk_qna_num(rs.getInt(1));
						qna.setQna_title(rs.getString(2));
						qna.setQna_date(rs.getString(3));
						qna.setQna_contents(rs.getString(9));
						qna.setFk_userid(rs.getString(10));
						myBoardVO.setQnaBoard(qna);
					}
					else if("review".equalsIgnoreCase(searchCate)) {
						myBoardVO = new MyBoardVO();
						review = new ReviewBoardVO();
						review.setPk_rnum(rs.getInt(4));
						review.setRe_title(rs.getString(5));
						review.setRe_date(rs.getString(6));
						review.setRe_grade(rs.getInt(7));
						review.setRe_contents(rs.getString(8));
						review.setFk_userid(rs.getString(11));
						myBoardVO.setRevBoard(review);
						
					}
					else {
						myBoardVO = new MyBoardVO();
						
						qna = new QnABoardVO();
						qna.setPk_qna_num(rs.getInt(1));
						qna.setQna_title(rs.getString(2));
						qna.setQna_date(rs.getString(3));
						qna.setQna_contents(rs.getString(9));
						myBoardVO.setQnaBoard(qna);
						
						review = new ReviewBoardVO();
						review.setPk_rnum(rs.getInt(4));
						review.setRe_title(rs.getString(5));
						review.setRe_date(rs.getString(6));
						review.setRe_grade(rs.getInt(7));
						review.setRe_contents(rs.getString(8));
						myBoardVO.setRevBoard(review);
						
						// System.out.println("잘들어감? => " + myBoardVO.getRevBoard().getRe_title());
						// System.out.println("잘들어감? => " + myBoardVO.getQnaBoard().getQna_title());
						
					}
					adminBoardList.add(myBoardVO);
					
				}//end of while(rs.next()) ------------ 
			
			
			} catch(SQLException e){  
				e.printStackTrace();
			} catch(NumberFormatException e) { 
				e.printStackTrace();
			} finally {
				close();
			}
			
			
			return adminBoardList;
			
		} // end of public List<MyBoardVO> selectPagingAdminBoard(Map<String, String> paraMap) throws SQLException---------------

	
	
}

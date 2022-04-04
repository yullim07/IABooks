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

import javax.mail.Session;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import member.model.MemberVO;
import product.model.CategoryVO;
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
          Context envContext  = (Context)initContext.lookup("java:/comp/env");
          ds = (DataSource)envContext.lookup("jdbc/semiorauser3");
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
   
   
  
   
	// *** QnA 글목록보기 메소드를 구현하기 *** //
	   @Override
	   public List<QnABoardVO> selectPagingQnaBoard(Map<String, String> paraMap) throws SQLException {
	
	      List<QnABoardVO> qnaboardList = new ArrayList<>(); // BoardDTO 속에는 MemberDTO가 들어와야 한다.
	      QnABoardVO board = null;
	      try {
	    	  conn = ds.getConnection();
	
		
	    		
	    	  String sql = "select fk_pnum, pk_qna_num,  qna_title, mname, qna_date , qna_readcount , fk_userid , qna_issecret , qna_contents , pro_name, pro_imgfile_name ,cate_name\n"+
	    			  "from \n"+
	    			  "    ( \n"+
	    			  "    select rownum AS rno, fk_pnum, pk_qna_num, qna_title, mname, qna_date , qna_readcount , fk_userid , qna_issecret , qna_contents ,pro_name, pro_imgfile_name ,cate_name\n"+
	    			  "    from \n"+
	    			  "    ( \n"+
	    			  "        select  nvl(fk_pnum,-9999) as fk_pnum , pk_qna_num, qna_title, M.mname as mname, to_char(qna_date,'yyyy-mm-dd hh24:mi:ss') as  qna_date, qna_readcount , Q.fk_userid as fk_userid , qna_issecret , qna_contents ,nvl(pro_name,-9999) as pro_name, nvl(pro_imgfile_name,-9999) as pro_imgfile_name ,nvl(C.cate_name,-9999) AS cate_name\n"+
	    			  "        from tbl_member M right JOIN tbl_qna_board Q  \n"+
	    			  "        ON M.pk_userid = Q.fk_userid \n"+
	    			  "        left JOIN tbl_product P  \n"+
	    			  "        ON Q.fk_pnum = P.pk_pro_num\n"+
	    			  "        left JOIN TBL_CATEGORY C\n"+
	    			  "		ON P.fk_cate_num = C.pk_cate_num\n"+
	    			  "        where isdelete = 0 \n";
	       
		          String colname = paraMap.get("searchContent");
		          System.out.println("searchCOnte"+colname);
		          
				  String searchWord = paraMap.get("searchWord");	
		    	   
				  if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
							sql += " and " + colname + " like '%'|| ? ||'%' ";
							// 위치홀더에 들어오는 값은 데이터값만 들어올 수 있지
							// 위치홀더에는 컬럼명이나 테이블 명은 들어올 수 없다 => 변수처리로 넣어준다.(중요)
						
				  } 		
			  
				  sql +=  " 		order by pk_qna_num desc " +
						  " 	) V " +
		   			   	  " ) T " +
						  " where rno between ? and ? ";
	         
	         
	         
		          pstmt = conn.prepareStatement(sql);
		
		          int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
				  int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
					
			
					
				  if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
						// 검색종류와 검색어가 있으면	
					  pstmt.setString(1, searchWord);
					  pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
					  pstmt.setInt(3, (currentShowPageNo * sizePerPage));
					  System.out.println("검색어 있을때 : " + currentShowPageNo + "," + sizePerPage);
						  
				  }
				  else {
					  pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
					  pstmt.setInt(2, (currentShowPageNo * sizePerPage));
					  System.out.println("검색종류 없을 때 변수들 : " + currentShowPageNo + "," + sizePerPage);
				  
				  }
			
				  rs = pstmt.executeQuery();
   
				  while (rs.next()) {

					  board = new QnABoardVO();
           
					  board.setFk_pnum(rs.getString(1));
           
					  board.setPk_qna_num(rs.getInt(2));
					           /*
					   ProductVO product = new ProductVO(); 
					   product.setPro_name(rs.getString(2));
					   product.setPro_imgfile_name(rs.getString(3)); 
					   board.setProduct(product);
					   */
					   board.setQna_title(rs.getString(3)); 
   
   
					   // **중요한 부분 
					   MemberVO member = new MemberVO();
					   member.setName(rs.getString("mname")); 
					   board.setMember(member); // 보드에 멤버를 넣어줌.
               
		               board.setQna_date(rs.getString(5)); 
		               board.setQna_readcount(rs.getInt(6));
		               board.setFk_userid(rs.getString(7));
		               board.setQna_issecret(rs.getInt(8));
		               board.setQna_contents(rs.getString(9));
		               
		               ProductVO product = new ProductVO(); 
	                   product.setPro_name(rs.getString(10));
	                   product.setPro_imgfile_name(rs.getString(11)); 
	                   board.setProduct(product);
		               
	                   
	                   CategoryVO category = new CategoryVO();
	                   category.setCate_name(rs.getString(12)); 
					   board.setCategory(category);
					   
					   
		               qnaboardList.add(board);
		               
		               System.out.println(" 넣어진 제목 : " + board.getFk_pnum());
				  }// end of while(rs.next()) ------------
				  
		       
     
         
         } catch (SQLException e) {
            e.printStackTrace();
         } finally {
            close();
         }

         return qnaboardList;
      }// end of public List<BoardDTO> boardList() -----

	   
	   
	   
	   //Qna 게시판에 글 작성하기  
	   @Override
	   public int writeQnaBoard(Map<String, String> paraMap) throws SQLException {
			
			int result = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " insert into tbl_qna_board (pk_qna_num, fk_userid, qna_title,  qna_contents , qna_passwd, qna_issecret ) "
		                   + " values(SEQ_QNA_BOARD.nextval, ?, ?, ?, ?, ?) ";
		         
				pstmt = conn.prepareStatement(sql);
			
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, paraMap.get("subject"));
				pstmt.setString(3, paraMap.get("content"));
				pstmt.setString(4, paraMap.get("passwd"));
				pstmt.setString(5, paraMap.get("issecret"));
				
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) { 
				e.printStackTrace();
			} finally {
				close();
			}
			
			return result;
		} // end of public int writeFaqBoard(Map<String, String> paraMap) throws SQLException-------------
		
	   
	   
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 Qna게시판에 대한 페이지 알아오기
	    @Override
		public int getTotalqnaPage(Map<String, String> paraMap) throws SQLException {
	    	int totalPage = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select ceil( count(*)/? ) "
						   + " from tbl_qna_board Q"
						   + " join tbl_member M"
						   + " on Q.fk_userid = M.pk_userid";
						  // + " where fk_userid != 'admin' ";
				
				String colname = paraMap.get("searchContent");
				String searchWord = paraMap.get("searchWord");	
				System.out.println(" 확인용 colname : " + colname);
				System.out.println(" 확인용 searchWord : " + searchWord);
				
				if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
					sql += " where " + colname + " like '%'|| ? ||'%' ";
					// 위치홀더에 들어오는 값은 데이터값만 들어올 수 있지
					// 위치홀더에는 컬럼명이나 테이블 명은 들어올 수 없다 => 변수처리로 넣어준다.(중요)
				}
				
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("sizePerPage"));
				
				if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
					// 검색종류와 검색어가 있으면	
					pstmt.setString(2, searchWord);
				}
				
				rs = pstmt.executeQuery();
				
				rs.next();
				
				totalPage = rs.getInt(1);
				
			} finally {
				close();
			}
			
			return totalPage;
		}
	
	    @Override
		public int qnaReadCountUp(int pk_qna_num) throws SQLException {
	    	InterBoardDAO bdao = new BoardDAO();
			
	    	QnABoardVO qnaVO = new QnABoardVO();
	    	qnaVO = bdao.selectqnaContent(pk_qna_num);
	    	int result = 0;
			try {
				conn = ds.getConnection();
					
			
				String	sql = " update tbl_qna_board set qna_readcount = qna_readcount +1 "
						+ " where pk_qna_num = ? ";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pk_qna_num);
					
					result = pstmt.executeUpdate();
				 //업데이트 하고나서 제대로 보여주는거야밑에가 
				
				
				
				System.out.println("보자구"+qnaVO.getQna_readcount());
				
				
		
			} catch(SQLException e) { 
				e.printStackTrace();
			}finally {
				close();
			}		
			
			return result;
		}
		
		
		// Qna 상세글 읽어오기
		@Override
		public QnABoardVO readqnaContent(int pk_qna_num) throws SQLException {
			InterBoardDAO bdao = new BoardDAO();
			QnABoardVO qnaVO = bdao.selectqnaContent(pk_qna_num);
			
			try {
	
				conn = ds.getConnection();
				
				String sql =  " select * "
							+ " from tbl_qna_board "
							+ " where pk_qna_num = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pk_qna_num);
				
				rs = pstmt.executeQuery();
				
				
					if(!rs.next()) {//결과물이 없어야지 남이 쓴글이라 조회수를 올리는 update를 해줘야한다.    <-> 내가 쓴글은 셀렉트 결과가 나옴.
						// 로그인한 사용자가 쓴 글이 아닌 다른 사용자가 쓴 글이라면  ex. boardno = 3234123 터무니 없는 숫자들.
						
						sql = " update tbl_qna_board set qna_readcount = qna_readcount +1 "
							+ " where pk_qna_num = ? ";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, pk_qna_num);
						
						pstmt.executeUpdate();
					}  //업데이트 하고나서 제대로 보여주는거야밑에가 
					
					
					
					System.out.println("보자구"+qnaVO.getQna_readcount());
					
					qnaVO = bdao.selectqnaContent(pk_qna_num);
					
				
					
				
				
			} catch(SQLException e) { 
				e.printStackTrace();
			}finally {
				close();
			}
			
			return qnaVO;
			
		}//end of public QnABoardVO readqnaContent(int pk_qna_num) throws SQLException {})
		
		
		// 번호 하나를 받아 Qna글 정보 받아오기 
		@Override
		public QnABoardVO selectqnaContent(int pk_qna_num) throws SQLException {


			QnABoardVO qnaVO = null;
			
			
			// System.out.println("몇 번이니? " + pk_qna_num);
			
			try {
				
				conn = ds.getConnection();
				
				
				String	sql =  " select pk_qna_num, mname, qna_title, qna_contents, fk_userid ,qna_date, qna_passwd, qna_readcount\r\n"
							+ " from tbl_qna_board  Q\r\n"
							+ " join  tbl_member M\r\n"
							+ " ON Q.fk_userid = M.pk_userid \r\n"
							+ " where pk_qna_num = ? "; //남이쓴글이든 내가 쓴 글이든 무조건 보여야 한다. 
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, pk_qna_num);
					
					rs = pstmt.executeQuery();
					
					rs.next();
					
					qnaVO = new QnABoardVO();
					
					qnaVO.setPk_qna_num(rs.getInt(1));
					MemberVO member = new MemberVO();
		            member.setName(rs.getString("mname")); 
		            qnaVO.setMember(member); 
					qnaVO.setQna_title(rs.getString(3));
					qnaVO.setQna_contents(rs.getString(4));
					qnaVO.setFk_userid(rs.getString(5));
					qnaVO.setQna_date(rs.getString(6));
					qnaVO.setQna_passwd(rs.getString(7));
					qnaVO.setQna_readcount(rs.getInt(8));
					
					System.out.println("보자구"+qnaVO.getQna_readcount());
					
				
			} catch(SQLException e) { 
				e.printStackTrace();
			}finally {
				close();
			}
			
			return qnaVO;
			
		}
		
		
		
		
		//Qna 게시판 값을 수정이나 삭제하기 위해 정보 받아오기
		@Override
		public QnABoardVO getqnaContent(int pk_qna_num) throws SQLException {

			InterBoardDAO bdao = new BoardDAO();
			
			QnABoardVO qnaVO = bdao.selectqnaContent(pk_qna_num);
			
			return qnaVO; 
			
		}
		
		//Qna 게시글 수정하기
		@Override
		public int UpdateQnaBoard(Map<String, String> paraMap) throws SQLException {
			
			int result = 0;
			
			int pk_qna_num = Integer.parseInt(paraMap.get("pk_qna_num"));
		//	System.out.println("들어왔니 pkqnanum? : " + pk_qna_num);

			try {
				conn = ds.getConnection();
				
				String sql = " update tbl_qna_board set qna_title = ?, qna_contents= ?, qna_issecret = ? "+
							 " where pk_qna_num = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("title"));
				pstmt.setString(2, paraMap.get("content"));
				pstmt.setString(3, paraMap.get("issecret"));
				pstmt.setInt(4, pk_qna_num);
				
				System.out.println("들어왔니 번호야? : " + pk_qna_num);
				
				int n = pstmt.executeUpdate();
				
				if(n==1) {
					System.out.println("업데이트 성공!");
				}
				
				result = n;
				
			} catch(SQLException e) { 
				e.printStackTrace();
			}finally {
				close();
			}
			
			
			
			return result;
		}

		
		//Qna 게시글 삭제하기
		@Override
		public int deleteQnaBoard(QnABoardVO qnaVO) throws SQLException {
			// TODO Auto-generated method stub
			
			int result = 0;
			
			
			try {
				conn = ds.getConnection();
				
				String sql = " delete tbl_qna_board  "
						   + " where pk_qna_num = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, qnaVO.getPk_qna_num());
				
				int n = pstmt.executeUpdate();
				
				if(n==1) {
					System.out.println("삭제 성공!");
				}
				
				result = n;
				
			} catch(SQLException e) { 
				e.printStackTrace();
			}finally {
				close();
			}
		
			
			return result;
		}
		
		
		
		//Qna 게시글에 댓글 작성하기
		@Override
		public int writeCmtBoard(Map<String, String> paraMap) throws SQLException{
			
			System.out.println("하잉");
			int result = 0;
			int pk_qna_num = Integer.parseInt(paraMap.get("pk_qna_num"));
			System.out.println("바잉");
			System.out.println("들어왔니 pkqnanum? : " + pk_qna_num);
			
			
			Connection conn = null;
		    PreparedStatement pstmt = null;
		    try {
		    	conn = ds.getConnection();
		        String sql = "update tbl_qna_board set qna_readcount = qna_readcount+1 where pk_qna_num = ? ";
		        System.out.println(sql);
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setInt(1, pk_qna_num);
		        pstmt.executeUpdate();
		         
		    } catch (SQLException e) {
		        // TODO Auto-generated catch block
		        e.printStackTrace();
		    } finally {
		        close();
		    }
		    
			
			try {
			
				conn = ds.getConnection();
				
				String sql = " insert into tbl_comment(pk_cmt_num, fk_userid, fk_qna_num, cmt_passwd, cmt_contents) \r\n"
						+ "values(SEQ_COMMENT.nextval, ?, ?, ?, ?)";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setInt( 2, pk_qna_num);
				pstmt.setString(3, paraMap.get("cmtPasswd"));
				pstmt.setString(4, paraMap.get("cmtContent"));
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) { 
				e.printStackTrace();
			} finally {
				close();
			}
			
			return result;
		}
		
		
		//Qna 게시글 댓글 읽어오기
		@Override
		public QnABoardVO readCmtContent(int pk_qna_num) throws SQLException {
			// TODO Auto-generated method stub
			return null;
		}

		
		
		// Qna 게시판 이전글, 다음글 정보를 가져오기
		@Override
		public QnABoardVO getqnaPrevNextContent(Map<String, String> paraMap) throws SQLException {
			
			int currentNum = Integer.parseInt(paraMap.get("currentNum"));
			System.out.println("잘 갔니? " + currentNum);
			QnABoardVO qnaPrevNext = null;
			
			try {
				conn = ds.getConnection();
				
				
				String sql = " select prevnum, prevtitle, currentnum, currenttitle, nextnum, nexttitle "+
						" from "+
						" ( "+
						" select   "+
						"         lag(pk_qna_num, 1) over(order by pk_qna_num desc) as prevnum "+
						"       , lag(qna_title, 1) over(order by pk_qna_num desc) as prevtitle "+
						"       , pk_qna_num as currentnum "+
						"       , qna_title as currenttitle "+
						"       , lead(pk_qna_num, 1) over(order by pk_qna_num desc) as nextnum "+
						"       , lead(qna_title, 1) over(order by pk_qna_num desc) as nexttitle "+
						" from tbl_qna_board "+
						" ) v " +
						" where currentnum = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, currentNum);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
				
				qnaPrevNext = new QnABoardVO();
				
				qnaPrevNext.setPrev_num(rs.getInt(1));
				qnaPrevNext.setPrev_title(rs.getString(2));
				qnaPrevNext.setCurrentNum(rs.getInt(3));
				qnaPrevNext.setCurrentTitle(rs.getString(4));
				qnaPrevNext.setNext_num(rs.getInt(5));
				qnaPrevNext.setNext_title(rs.getString(6));
				
				
				System.out.println("이전글 번호 : " + qnaPrevNext.getPrev_num());
				System.out.println("이전글 제목 : " + qnaPrevNext.getPrev_title());
				System.out.println("다음글 번호 : " + qnaPrevNext.getNext_num());
				System.out.println("다음글 제목 : " + qnaPrevNext.getNext_title());
				
				
				}
				
				
				} catch(SQLException e) { 
				e.printStackTrace();
			}finally {
				close();
			}
			
			return qnaPrevNext;
			
			
		}
		
	
	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	
	
			
		//////////////////////////////////////////////////////////////////////////////
		//////////////////정환모 작업 (안겹치도록 방파제) //////////////////////////////////
		
		// FAQ 글목록보기 메소드를 구현하기 //
		@Override
		public List<FaqBoardVO> selectPagingFaqBord(Map<String, String> paraMap) throws SQLException {
		
		List<FaqBoardVO> faqBoardList = new ArrayList<>(); // 글목록 불러올 리스트 객체화
		
		FaqBoardVO board = null;
		
		conn = ds.getConnection();
		
		try {
		
		String sql = " select pk_faq_board_num, faq_c_name, faq_title, faq_writer, isdelete, faq_c_ename "+
		" from "+
		" ( "+
		"    select rownum AS rno, pk_faq_board_num, faq_c_name, faq_title, faq_writer, isdelete, faq_c_ename "+
		"    from "+
		" 	( "+
		" 		select pk_faq_board_num, b.faq_c_name AS faq_c_name, faq_title, faq_writer, isdelete, B.faq_c_ename AS faq_c_ename  "+
		" 		from tbl_faq_board a join tbl_faq_category b on a.fk_faq_c_num = b.pk_faq_c_num "+
		" 		join tbl_member c on a.fk_userid = c.pk_userid "+
		" 		where isdelete = 0 ";
		
		
		
		String colname = paraMap.get("searchType");
		String searchWord = paraMap.get("searchWord");	
		String searchCate = paraMap.get("searchCate"); 
		
		if( !"all".equalsIgnoreCase(searchCate) ) {
		// 카테고리 값이 1(전체)이 아니고 검색종류 및 검색어가 있을 때
		sql += " and B.FAQ_C_ENAME = ? ";
		
		if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
		sql += " and " + colname + " like '%'|| ? ||'%' ";
		// 위치홀더에 들어오는 값은 데이터값만 들어올 수 있지
		// 위치홀더에는 컬럼명이나 테이블 명은 들어올 수 없다 => 변수처리로 넣어준다.(중요)
		}
		}
		else {
		
		if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
		// 카테고리 값이 없거나 1이고 검색종류 및 검색어가 있을 때
		sql += " and " + colname + " like '%'|| ? ||'%' ";
		// 위치홀더에 들어오는 값은 데이터값만 들어올 수 있지
		// 위치홀더에는 컬럼명이나 테이블 명은 들어올 수 없다 => 변수처리로 넣어준다.(중요)
		}
		}		   		
		
		sql +=  " 		order by pk_faq_board_num desc " +
		" 	) V " +
		" ) T " +
		" where rno between ? and ? ";
		
		pstmt = conn.prepareStatement(sql);
		
		int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
		int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
		
		if( !"all".equalsIgnoreCase(searchCate) ) {
		// 카테고리 값이 있으면
		pstmt.setString(1, searchCate);
		
		if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
		// 검색종류와 검색어가 있으면	
		pstmt.setString(2, searchWord);
		pstmt.setInt(3, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
		pstmt.setInt(4, (currentShowPageNo * sizePerPage));
		System.out.println("카테고리 있고 검색어 있을때 : " + currentShowPageNo + "," + sizePerPage);
		
		}
		else {
		pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
		pstmt.setInt(3, (currentShowPageNo * sizePerPage));
		System.out.println("카테고리 있고 검색종류 없을 때 변수들 : " + currentShowPageNo + "," + sizePerPage);
		
		}
		
		}
		else if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
		pstmt.setString(1, searchWord);
		pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
		pstmt.setInt(3, (currentShowPageNo * sizePerPage));
		System.out.println("카테고리 없고 검색조건 있을 때 : " + currentShowPageNo + "," + sizePerPage);
		
		}
		else {// 검색조건이 없을 때
		pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
		pstmt.setInt(2, (currentShowPageNo * sizePerPage));
		System.out.println("검색조건 없을 때 변수들 : " + currentShowPageNo + "," + sizePerPage);
		
		}
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
		
		board = new FaqBoardVO();
		board.setPk_faq_board_num(rs.getInt(1));
		
		FAQcategoryBoardVO faqCate = new FAQcategoryBoardVO();
		faqCate.setFaq_c_name(rs.getString(2));
		board.setFaqCate(faqCate);
		
		board.setFaq_title(rs.getString(3));
		board.setFaq_writer(rs.getString(4));
		
		faqBoardList.add(board);
		
		//  System.out.println(" 넣어진 작성자 : " + board.getPk_faq_board_num());
		
		
		}//end of while(rs.next()) ------------ 
		
		
		
		} catch(SQLException e){  
		e.printStackTrace();
		}finally {
		close();
		}
		
		
		return faqBoardList;
		}// end of public List<FaqBoardVO> selectPagingFaqBord(Map<String, String> paraMap) throws SQLException----------
		
		
		// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 FAQ게시판에 대한 페이지 알아오기
		@Override
		public int getTotalfaqPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		try {
		conn = ds.getConnection();
		
		String sql = " select ceil( count(*)/? ) "+
		" from tbl_faq_board A JOIN tbl_faq_category B "+
		" ON A.FK_FAQ_C_NUM = B.PK_FAQ_C_NUM ";
		// + " where fk_userid != 'admin' ";
		
		String colname = paraMap.get("searchType");
		String searchWord = paraMap.get("searchWord");	
		String searchCate = paraMap.get("searchCate");	
		System.out.println(" 확인용 colname : " + colname);
		System.out.println(" 확인용 searchWord : " + searchWord);
		System.out.println(" 확인용 searchCate : " + searchCate);
		
		if( !"all".equalsIgnoreCase(searchCate) ) {
		// 카테고리 값이 1(전체)이 아니고 검색종류 및 검색어가 있을 때
		sql += " where B.FAQ_C_ENAME = ? ";
		
		if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
		sql += " and " + colname + " like '%'|| ? ||'%' ";
		// 위치홀더에 들어오는 값은 데이터값만 들어올 수 있지
		// 위치홀더에는 컬럼명이나 테이블 명은 들어올 수 없다 => 변수처리로 넣어준다.(중요)
		}
		
		}
		else {
		
		if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
		// 카테고리 값이 없거나 1이고 검색종류 및 검색어가 있을 때
		sql += " where " + colname + " like '%'|| ? ||'%' ";
		// 위치홀더에 들어오는 값은 데이터값만 들어올 수 있지
		// 위치홀더에는 컬럼명이나 테이블 명은 들어올 수 없다 => 변수처리로 넣어준다.(중요)
		}
		}
		
		
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, paraMap.get("sizePerPage"));
		
		if( !"all".equalsIgnoreCase(searchCate) ) {
		// 카테고리 값이 있으면
		pstmt.setString(2, searchCate);
		
		if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
		// 검색종류와 검색어가 있으면	
		pstmt.setString(3, searchWord);
		}
		
		}
		else {
		
		if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
		pstmt.setString(2, searchWord);
		}
		}
		
		rs = pstmt.executeQuery();
		
		rs.next();
		
		totalPage = rs.getInt(1);
		
		} finally {
		close();
		}
		
		return totalPage;
		} // end of public int getTotalfaqPage(Map<String, String> paraMap) throws SQLException----------
		
		
		
		// FAQ 게시판에 글 작성하기  
		@Override
		public int writeFaqBoard(Map<String, String> paraMap) throws SQLException {
		
		int result = 0;
		int category = Integer.parseInt(paraMap.get("category"));
		System.out.println("category : " + category);
		
		try {
		conn = ds.getConnection();
		
		String sql = " insert into tbl_faq_board (pk_faq_board_num, fk_userid, fk_faq_c_num, faq_title, faq_writer, faq_contents) "
		+ " values(SEQ_FAQ_BOARD.nextval, ?, ?, ?, ?, ?) ";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, paraMap.get("userid"));
		pstmt.setInt( 2, category);
		pstmt.setString(3, paraMap.get("title"));
		pstmt.setString(4, paraMap.get("writer"));
		pstmt.setString(5, paraMap.get("content"));
		
		result = pstmt.executeUpdate();
		
		} catch (SQLException e) { 
		e.printStackTrace();
		} finally {
		close();
		}
		
		return result;
		} // end of public int writeFaqBoard(Map<String, String> paraMap) throws SQLException-------------
		
		
		
		// 리뷰게시판 글 목록보기 구현
		@Override
		public List<ReviewBoardVO> selectPagingRevBoard(Map<String, String> paraMap) throws SQLException {
		
		List<ReviewBoardVO> reviewList = new ArrayList<>(); // ReviewBoardVO 속에는 MemberDTO가 들어와야 한다.
		
		ReviewBoardVO board = null;
		String mname = "";
		
		
		try {
		
		int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
		int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
		
		System.out.println("currentShowPageNo : " + currentShowPageNo);
		System.out.println("sizePerPage : " + sizePerPage);
		
		conn = ds.getConnection();
		
		String sql = " SELECT pk_rnum, pro_name, pro_imgfile_name, re_title, mname, re_date, fk_userid, re_grade, cate_name"+
		" FROM   \n"+
		" (   \n"+
		"    SELECT rownum as rno, pk_rnum, pro_name, pro_imgfile_name, re_title, mname, re_date, fk_userid, re_grade, cate_name "+
		"    FROM\n"+
		"    (    \n"+
		"        select R.pk_rnum AS pk_rnum, P.pro_name AS pro_name, P.pro_imgfile_name AS pro_imgfile_name, R.re_title AS re_title, M.mname AS mname "+
		"               , to_char(re_date,'yyyy-mm-dd hh24:mi:ss') AS re_date, R.fk_userid AS fk_userid , R.re_grade AS re_grade, C.cate_name AS cate_name "+
		"        from tbl_member M\n"+
		"        JOIN tbl_review_board R\n"+
		"        ON  M.PK_USERID = R.FK_USERID "+
		"        JOIN tbl_product P\n"+
		"        ON R.fk_pnum = P.pk_pro_num "+
		"        JOIN TBL_CATEGORY C " +
		"        ON P.fk_cate_num = C.pk_cate_num " +
		"        WHERE isdelete = 0 " +
		"    ) V "+
		" ) T "+
		" where rno between ? and ?";
		
		pstmt = conn.prepareStatement(sql);
		
		
		pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
		pstmt.setInt(2, (currentShowPageNo * sizePerPage));
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
		
		board = new ReviewBoardVO();
		board.setPk_rnum(rs.getInt(1));
		
		ProductVO product = new ProductVO();
		product.setPro_name(rs.getString(2));;
		product.setPro_imgfile_name(rs.getString(3));
		board.setProduct(product);
		board.setRe_title(rs.getString(4));
		
		
		MemberVO member = new MemberVO();
		mname = rs.getString(5);
		member.setName(mname); 
		board.setMember(member); // 보드에 멤버를 넣어줌.
		
		
		board.setRe_date( rs.getString(6));
		board.setFk_userid(rs.getString(7));
		board.setRe_grade(rs.getInt(8));
		
		CategoryVO category = new CategoryVO();
		category.setCate_name(rs.getString(9));
		board.setCategory(category);
		
		// System.out.println("~~확인용 member.getName() : " + member.getName());
		
		
		/*
		System.out.println(" 넣어진 제목 : " + board.getRe_title());
		System.out.println("~~확인용   : " + product.getPro_name());
		System.out.println("~~확인용   : " + product.getPro_imgfile_name());
		System.out.println("~~확인용   : " + board.getRe_title());
		*/
		reviewList.add(board);
		
		
		}//end of while(rs.next()) ------------ 
		
		
		}catch(SQLException e){  
		e.printStackTrace();
		} finally {
		close();
		}
		
		
		return reviewList;
		
		
		} // end of public List<ReviewBoardVO> selectPagingRevBord(Map<String, String> paraMap) throws SQLException----------------
		
		
		// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 리뷰게시글에 대한 페이지 알아오기
		@Override
		public int getTotalRevPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		try {
		conn = ds.getConnection();
		
		String sql = " select ceil( count(*)/? ) " +
		" from tbl_review_board A JOIN tbl_product B " +
		" ON A.FK_PNUM = B.PK_PRO_NUM " +
		" JOIN tbl_member C ON A.FK_USERID = C.PK_USERID ";
		// + " where fk_userid != 'admin' ";
		
		String colname = paraMap.get("searchType");
		String searchWord = paraMap.get("searchWord");
		
		System.out.println(" 확인용 colname : " + colname);
		System.out.println(" 확인용 searchWord : " + searchWord);
		
		if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
		// 카테고리 값이 없거나 1이고 검색종류 및 검색어가 있을 때
		sql += " where " + colname + " like '%'|| ? ||'%' ";
		// 위치홀더에 들어오는 값은 데이터값만 들어올 수 있지
		// 위치홀더에는 컬럼명이나 테이블 명은 들어올 수 없다 => 변수처리로 넣어준다.(중요)
		}
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, paraMap.get("sizePerPage"));
		
		if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
		pstmt.setString(2, searchWord);
		}
		
		rs = pstmt.executeQuery();
		
		rs.next();
		
		totalPage = rs.getInt(1);
		
		} finally {
		close();
		}
		
		return totalPage;
		} // end of public int getTotalRevPage(Map<String, String> paraMap) throws SQLException----------------
		
		
		// FAQ 상세글 읽어오기 
		@Override
		public FaqBoardVO readContent(int pk_faq_board_num) throws SQLException {
		
		InterBoardDAO bdao = new BoardDAO();
		
		FaqBoardVO faqVO = bdao.selectContent(pk_faq_board_num);
		
		return faqVO;
		} // end of public FaqBoardVO readContent(int pk_faq_board_num) throws SQLException----------------- 
		
		
		// 번호 하나를 받아 FAQ글 정보 받아오기 
		@Override
		public FaqBoardVO selectContent(int pk_faq_board_num) throws SQLException {
		
		FaqBoardVO faqVO = null;
		
		// System.out.println("몇 번이니? " + pk_faq_board_num);
		
		try {
		conn = ds.getConnection();
		
		String sql = " select pk_faq_board_num, faq_writer, faq_title, faq_contents, fk_userid, fk_faq_c_num,  isdelete "+
		" from tbl_faq_board "+
		" where pk_faq_board_num = ? ";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, pk_faq_board_num);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
		faqVO = new FaqBoardVO();
		
		faqVO.setPk_faq_board_num(rs.getInt(1));
		faqVO.setFaq_writer(rs.getString(2));
		faqVO.setFaq_title(rs.getString(3));
		faqVO.setFaq_contents(rs.getString(4));
		faqVO.setFk_userid(rs.getString(5));
		faqVO.setFk_faq_c_num(rs.getInt(6));
		
		// System.out.println("받아왔니? " + faqVO.getFaq_contents());
		}
		
		} catch(SQLException e) { 
		e.printStackTrace();
		}finally {
		close();
		}
		
		return faqVO;
		} // end of public FaqBoardVO selectContent(int pk_faq_board_num) throws SQLException----------
		
		
		
		// FAQ 게시판 값을 수정이나 삭제하기 위해 정보 받아오기
		@Override
		public FaqBoardVO getContent(int pk_faq_board_num) throws SQLException {
		
		InterBoardDAO bdao = new BoardDAO();
		
		FaqBoardVO faqVO = bdao.selectContent(pk_faq_board_num);
		
		return faqVO;
		} // end of public FaqBoardVO getContent(int pk_faq_board_num) throws SQLException---------
		
		// FAQ 게시판 값을 수정해주기
		@Override
		public int UpdateFaqBoard(Map<String, String> paraMap) throws SQLException {
		
		int result = 0;
		
		int pk_faq_board_num = Integer.parseInt(paraMap.get("pk_faq_board_num"));
		int category = Integer.parseInt(paraMap.get("category"));
		
		
		try {
		conn = ds.getConnection();
		
		String sql = " update tbl_faq_board set faq_title = ?, faq_contents= ?, fk_faq_c_num = ?  "+
		" where pk_faq_board_num = ? ";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, paraMap.get("title"));
		pstmt.setString(2, paraMap.get("content"));
		pstmt.setInt(3, category);
		pstmt.setInt(4, pk_faq_board_num);
		
		System.out.println("들어왔니 번호야? : " + pk_faq_board_num);
		System.out.println("들어왔니 카테고리야? : " + category);
		
		int n = pstmt.executeUpdate();
		
		if(n==1) {
		System.out.println("업데이트 성공!");
		}
		
		result = n;
		
		} catch(SQLException e) { 
		e.printStackTrace();
		}finally {
		close();
		}
		
		
		
		return result;
		} // end of public int UpdateFaqBoard(Map<String, String> paraMap) throws SQLException---------
		
		
		// FAQ 게시판 값을 삭제하기
		@Override
		public int deleteFaqBoard(FaqBoardVO faqVO) throws SQLException {
		
		int result = 0;
		
		try {
		conn = ds.getConnection();
		
		String sql = " delete tbl_faq_board " 
		+ " where pk_faq_board_num = ? ";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, faqVO.getPk_faq_board_num());
		
		int n = pstmt.executeUpdate();
		
		if(n==1) {
		System.out.println("삭제 성공!");
		}
		
		result = n;
		
		} catch(SQLException e) { 
		e.printStackTrace();
		}finally {
		close();
		}
		
		
		
		return result;
		} // end of public int deleteFaqBoard(FaqBoardVO faqVO) throws SQLException--------
		
		// 이전글, 다음글 정보를 가져오기
		@Override
		public FaqBoardVO getPrevNextContent(Map<String, String> paraMap) throws SQLException {
		
		int currentNum = Integer.parseInt(paraMap.get("currentNum"));
		System.out.println("잘 갔니? " + currentNum);
		FaqBoardVO faqPrevNext = null;
		
		try {
		conn = ds.getConnection();
		
		
		String sql = "select currentnum, currenttitle, prev_num, prev_title, next_num, next_title, rno "+
		" from "+
		" ( "+
		" select   to_number(pk_faq_board_num) as currentnum "+
		"         , faq_title as currenttitle "+
		"         , lead(pk_faq_board_num, 1, 0) over(order by pk_faq_board_num desc) as prev_num "+
		"         , lead(faq_title, 1, '다음글이 없습니다') over(order by faq_title desc) as prev_title "+
		"         , lag(pk_faq_board_num, 1,	 0) over(order by pk_faq_board_num desc) as next_num "+
		"         , lag(faq_title, 1, '이전글이 없습니다') over(order by faq_title desc) as next_title "+
		"		  , rownum AS rno " +
		" from tbl_faq_board "+
		" ) v "+
		" where currentnum = ? " +
		" order by length(currentnum), currentnum ";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, currentNum);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
		
		faqPrevNext = new FaqBoardVO();
		
		faqPrevNext.setCurrentNum(rs.getInt(1));
		faqPrevNext.setCurrentTitle(rs.getString(2));
		faqPrevNext.setPrev_num(rs.getInt(3));
		faqPrevNext.setPrev_title(rs.getString(4));
		faqPrevNext.setNext_num(rs.getInt(5));
		faqPrevNext.setNext_title(rs.getString(6));
		
		
		System.out.println("이전글 번호 : " + faqPrevNext.getPrev_num());
		System.out.println("이전글 제목 : " + faqPrevNext.getPrev_title());
		System.out.println("다음글 번호 : " + faqPrevNext.getNext_num());
		System.out.println("다음글 제목 : " + faqPrevNext.getNext_title());
		
		
		}
		
		
		} catch(SQLException e) { 
		e.printStackTrace();
		}finally {
		close();
		}
		
		return faqPrevNext;
		
		
		} // end of public void getPrevNextContent(Map<String, String> paraMap) throws SQLException
		
		
		// 리뷰게시판 상세글 읽어오기 
		@Override
		public ReviewBoardVO readReviewContent(int pk_rnum) throws SQLException {
		
		InterBoardDAO bdao = new BoardDAO();
		
		ReviewBoardVO revVO = bdao.selectReviewContent(pk_rnum);
		
		return revVO;
		} // end of public ReviewBoardVO readReviewContent(int pk_rnum) throws SQLException-------------
		
		
		// 번호 하나를 받아 리뷰게시판 정보 받아오기 
		@Override
		public ReviewBoardVO selectReviewContent(int pk_rnum) throws SQLException {
		
		ReviewBoardVO revVO = null;
		
		// System.out.println("몇 번이니? " + pk_faq_board_num);
		
		try {
		conn = ds.getConnection();
		
		String sql = " select PK_RNUM, FK_PNUM, FK_USERID, RE_TITLE, to_char(re_date,'yyyy-mm-dd hh24:mi:ss') AS re_date "+
		"      , RE_GRADE, RE_CONTENTS, RE_PASSWD, RE_WRITER, isdelete, P.pro_name, P.pro_imgfile_name, P.PRO_PRICE " +
		"		, C.cate_name " +
		" from tbl_review_board R JOIN tbl_product P " +
		" ON R.FK_PNUM = P.pk_pro_num " +
		" JOIN TBL_CATEGORY C " +
		" ON P.fk_cate_num = C.pk_cate_num " +
		" where PK_RNUM = ? ";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, pk_rnum);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
		revVO = new ReviewBoardVO();
		
		revVO.setPk_rnum(rs.getInt(1));
		revVO.setFk_pnum(rs.getString(2));
		revVO.setFk_userid(rs.getString(3));
		revVO.setRe_title(rs.getString(4));
		revVO.setRe_date(rs.getString(5));
		revVO.setRe_grade(rs.getInt(6));
		revVO.setRe_contents(rs.getString(7));
		revVO.setRe_passwd(rs.getString(8));
		revVO.setRe_writer(rs.getString(9));
		revVO.setIsdelete(rs.getInt(10));
		
		ProductVO product = new ProductVO();
		product.setPro_name(rs.getString(11));
		product.setPro_imgfile_name(rs.getString(12));
		product.setPro_price(rs.getInt(13));
		revVO.setProduct(product);
		
		CategoryVO category = new CategoryVO();
		category.setCate_name(rs.getString(14));
		revVO.setCategory(category);
		
		// System.out.println("받아왔니? " + faqVO.getFaq_contents());
		}
		
		} catch(SQLException e) { 
		e.printStackTrace();
		}finally {
		close();
		}
		
		return revVO;
		} // end of public ReviewBoardVO selectReviewContent(int pk_rnum) throws SQLException---------
		
		// 리뷰게시판 이전글, 다음글 정보를 가져오기
		@Override
		public ReviewBoardVO getPrevNextReviewContent(Map<String, String> paraMap) throws SQLException {
		int currentNum = Integer.parseInt(paraMap.get("currentNum"));
		System.out.println("잘 갔니? " + currentNum);
		ReviewBoardVO revPrevNext = null;
		
		try {
		conn = ds.getConnection();
		
		
		String sql = "select currentnum, currenttitle, prev_num, prev_title, next_num, next_title, rno "+
		" from "+
		" ( "+
		" select   to_number(PK_RNUM) as currentnum "+
		"         , RE_TITLE as currenttitle "+
		"         , lead(PK_RNUM, 1, 0) over(order by PK_RNUM desc) as prev_num "+
		"         , lead(RE_TITLE, 1, '다음글이 없습니다') over(order by RE_TITLE desc) as prev_title "+
		"         , lag(PK_RNUM, 1,	 0) over(order by PK_RNUM desc) as next_num "+
		"         , lag(RE_TITLE, 1, '이전글이 없습니다') over(order by RE_TITLE desc) as next_title "+
		"		  , rownum AS rno " +
		" from tbl_review_board "+
		" ) v "+
		" where currentnum = ? " +
		" order by length(currentnum), currentnum ";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, currentNum);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
		
		revPrevNext = new ReviewBoardVO();
		
		revPrevNext.setCurrentNum(rs.getInt(1));
		revPrevNext.setCurrentTitle(rs.getString(2));
		revPrevNext.setPrev_num(rs.getInt(3));
		revPrevNext.setPrev_title(rs.getString(4));
		revPrevNext.setNext_num(rs.getInt(5));
		revPrevNext.setNext_title(rs.getString(6));
		
		
		System.out.println("이전글 번호 : " + revPrevNext.getPrev_num());
		System.out.println("이전글 제목 : " + revPrevNext.getPrev_title());
		System.out.println("다음글 번호 : " + revPrevNext.getNext_num());
		System.out.println("다음글 제목 : " + revPrevNext.getNext_title());
		
		
		}
		
		
		} catch(SQLException e) { 
		e.printStackTrace();
		}finally {
		close();
		}
		
		return revPrevNext;
		} // end of public ReviewBoardVO getPrevNextReviewContent(Map<String, String> paraMap) throws SQLException----------
		
		// 리뷰게시판 값을 수정해주기
		@Override
		public int UpdateReviewBoard(Map<String, String> paraMap) throws SQLException {
		
		int result = 0;
		
		int pk_rnum = Integer.parseInt(paraMap.get("pk_rnum"));
		
		
		try {
		conn = ds.getConnection();
		
		String sql = " update tbl_review_board set re_title = ?, re_contents= ?, re_writer = ? "+
		" where pk_rnum = ? ";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, paraMap.get("title"));
		pstmt.setString(2, paraMap.get("content"));
		pstmt.setString(3, paraMap.get("writer"));
		pstmt.setInt(4, pk_rnum);
		
		System.out.println("들어왔니 번호야? : " + pk_rnum);
		
		int n = pstmt.executeUpdate();
		
		if(n==1) {
		System.out.println("업데이트 성공!");
		}
		
		result = n;
		
		} catch(SQLException e) { 
		e.printStackTrace();
		}finally {
		close();
		}
		
		
		
		return result;
		
		} // end of public int UpdateReviewBoard(Map<String, String> paraMap) throws SQLException
		
		// 리뷰게시판 값을 삭제하기
		@Override
		public int deleteReviewBoard(ReviewBoardVO revVO) throws SQLException {
		
		int result = 0;
		
		try {
		conn = ds.getConnection();
		
		String sql = " delete tbl_review_board " 
		+ " where pk_rnum = ? ";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, revVO.getPk_rnum());
		
		int n = pstmt.executeUpdate();
		
		if(n==1) {
		System.out.println("삭제 성공!");
		}
		
		result = n;
		
		} catch(SQLException e) { 
		e.printStackTrace();
		}finally {
		close();
		}
		
		
		
		return result;
		
		} // end of public int deleteReviewBoard(ReviewBoardVO revVO) throws SQLException---------------
		
		
	
		
		
		
		
		
		
		
		
		
		
		


	
	
	

	

	

	
	

	
	
	
	
	
   
}
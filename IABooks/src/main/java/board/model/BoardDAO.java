package board.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		System.out.println("fk_pnum : " + paraMap.get("fk_pnum"));
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_qna_board (pk_qna_num, fk_pnum, fk_userid, qna_title,  qna_contents , qna_passwd, qna_issecret ) "
	                   + " values(SEQ_QNA_BOARD.nextval, ?, ?, ?, ?, ?, ?) ";
	         
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("fk_pnum"));
			pstmt.setString(2, paraMap.get("userid"));
			pstmt.setString(3, paraMap.get("subject"));
			pstmt.setString(4, paraMap.get("content"));
			pstmt.setString(5, paraMap.get("passwd"));
			pstmt.setString(6, paraMap.get("issecret"));
			
			
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
    
    //qna게시판 조회수 올리기
    @Override
	public int qnaReadCountUp(int pk_qna_num) throws SQLException {
    	InterBoardDAO bdao = new BoardDAO();
		
    	QnABoardVO qnaVO = new QnABoardVO();
    	qnaVO = bdao.selectqnaContent(pk_qna_num);
    	int result = 0;
		try {
			conn = ds.getConnection();
			
			String sql =  " select * "
						+ " from tbl_qna_board "
						+ " where pk_qna_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pk_qna_num);
			
			rs = pstmt.executeQuery();
			
			
				if(rs.next()) {
					
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
		
		return result;
	}
	
	
	// Qna 상세글 읽어오기
	@Override
	public QnABoardVO readqnaContent(int pk_qna_num) throws SQLException {
		InterBoardDAO bdao = new BoardDAO();
		QnABoardVO qnaVO = bdao.selectqnaContent(pk_qna_num);
	
			
		return qnaVO;
		
	}//end of public QnABoardVO readqnaContent(int pk_qna_num) throws SQLException {})
	
	
	// 번호 하나를 받아 Qna글 정보 받아오기 
	@Override
	public QnABoardVO selectqnaContent(int pk_qna_num) throws SQLException {


		QnABoardVO qnaVO = null;
		
		
		// System.out.println("몇 번이니? " + pk_qna_num);
		
		try {
			
			conn = ds.getConnection();
			
			
			String	sql =  " select pk_qna_num, mname, qna_title, qna_contents, fk_userid ,to_char(qna_date,'yyyy-mm-dd hh24:mi:ss') AS qna_date, qna_passwd, qna_readcount "
				    	+ " ,qna_issecret,  isdelete, pro_name, pro_imgfile_name, pro_price, cate_name "
						+ " from tbl_member M right JOIN tbl_qna_board Q  \r\n"
						+ "        ON M.pk_userid = Q.fk_userid \r\n"
						+ "        left JOIN tbl_product P  \r\n"
						+ "        ON nvl(Q.fk_pnum,-9999) = nvl(P.pk_pro_num,-9999) \r\n"
						+ "        left JOIN TBL_CATEGORY C\r\n"
						+ "		   ON nvl(P.fk_cate_num,-9999) = nvl(C.pk_cate_num,-9999)\r\n"
						+ "        where isdelete = 0  and pk_qna_num = ? "; //남이쓴글이든 내가 쓴 글이든 무조건 보여야 한다. 
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
				qnaVO.setQna_issecret(rs.getInt(9));
				qnaVO.setIsdelete(rs.getInt(10));
				
				ProductVO product = new ProductVO();
				product.setPro_name(rs.getString(11));
				product.setPro_imgfile_name(rs.getString(12));
				product.setPro_price(rs.getInt(13));
				qnaVO.setProduct(product);
				
				
				CategoryVO category = new CategoryVO();
				category.setCate_name(rs.getString(14));
				qnaVO.setCategory(category);
				
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
		int fk_qna_num = Integer.parseInt(paraMap.get("pk_qna_num"));
		System.out.println("바잉");
		System.out.println("들어왔니 fkqnanum? : " + fk_qna_num);
		
		
		try {
		
			conn = ds.getConnection();
			
			String sql = " insert into tbl_comment(pk_cmt_num, fk_userid, fk_qna_num, cmt_passwd, cmt_contents) \r\n"
					+ "values(SEQ_COMMENT.nextval, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("fk_userid"));
			pstmt.setInt( 2, fk_qna_num);
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
		InterBoardDAO bdao = new BoardDAO();
		QnABoardVO qnaVO = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select pk_cmt_num , fk_userid, fk_qna_num, cmt_passwd, cmt_contents, cmt_date, isdelete \r\n"
					+ "			from tbl_comment \r\n"
					+ "			where isdelete = 0 and fk_qna_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			/* pstmt.setInt(1, fk_qna_num); */
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
			
			}
		
		
			} catch(SQLException e) { 
				e.printStackTrace();
			}finally {
				close();
			}
			
			return qnaVO;
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
	
	
	
	
	
	// 페이징 처리를 위한 하나의 상품에 대한 Qna게시글 페이지 알아오기
	@Override
	public int getProductQnaPage(Map<String, String> paraMap) throws SQLException {

		int totalPage = 0;
		String pk_pro_num = paraMap.get("pk_pro_num");
		
		try {
		conn = ds.getConnection();
		
		String sql = " select ceil( count(*)/? ) "
				   + " from tbl_qna_board A JOIN tbl_product B "
				   + " ON A.FK_PNUM = B.PK_PRO_NUM "
				   + " JOIN tbl_member C ON A.FK_USERID = C.PK_USERID "
				   + " where pk_pro_num = ? ";
	
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, paraMap.get("sizePerPage"));
		pstmt.setString(2, pk_pro_num);
		
		rs = pstmt.executeQuery();
		
		rs.next();
		
		totalPage = rs.getInt(1);
		
		} finally {
		close();
		}
		
		return totalPage;
	}
	
	

	// 제품상세페이지에 보여줄 한 제품에 대한 게시글 불러오기
	@Override
	public List<QnABoardVO> selectPagingProductQna(Map<String, String> paraMap) throws SQLException {

		List<QnABoardVO> productQnaList = new ArrayList<>(); 
		
		QnABoardVO board = null;
		String pk_pro_num = paraMap.get("pk_pro_num");
		
		
		try {
		
		int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
		int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
		
		System.out.println("currentShowPageNo : " + currentShowPageNo);
		System.out.println("sizePerPage : " + sizePerPage);
		
		conn = ds.getConnection();
		
		String sql =  " select pk_pro_num, pk_qna_num,  qna_title, mname, qna_date , qna_readcount , fk_userid , qna_issecret , qna_contents , pro_name, pro_imgfile_name ,cate_name\r\n"
					+ "	    			  from \r\n"
					+ "	    			      ( \r\n"
					+ "	    			      select rownum AS rno, pk_pro_num, pk_qna_num, qna_title, mname, qna_date , qna_readcount , fk_userid , qna_issecret , qna_contents ,pro_name, pro_imgfile_name ,cate_name\r\n"
					+ "	    			      from \r\n"
					+ "	    			      ( \r\n"
					+ "	    			          select   pk_pro_num , pk_qna_num, qna_title, M.mname as mname, to_char(qna_date,'yyyy-mm-dd hh24:mi:ss') as  qna_date, qna_readcount , Q.fk_userid as fk_userid , qna_issecret , qna_contents , pro_name,  pro_imgfile_name , cate_name \r\n"
					+ "	    			          from tbl_member M JOIN tbl_qna_board Q  \r\n"
					+ "	    			          ON M.pk_userid = Q.fk_userid \r\n"
					+ "	    			          JOIN tbl_product P \r\n"
					+ "	    			          ON Q.fk_pnum = P.pk_pro_num\r\n"
					+ "	    			          JOIN TBL_CATEGORY C\r\n"
					+ "	    			  		  ON P.fk_cate_num = C.pk_cate_num\r\n"
					+ "	    			          where isdelete = 0  and P.pk_pro_num = ? \r\n"
					+ " 						  order by pk_qna_num desc " 
					+ "                     	  ) V \r\n"
					+ "		               ) T \r\n"
					+ "		              where rno between ? and ? ";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, pk_pro_num);
		pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
		pstmt.setInt(3, (currentShowPageNo * sizePerPage));
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
		
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
			   
			   
			   productQnaList.add(board);
		
		
		}//end of while(rs.next()) ------------ 
		
		
		}catch(SQLException e){  
			e.printStackTrace();
		} finally {
			close();
		}
		
		
		return productQnaList;
		
		
	} // public List<QnABoardVO> selectPagingProductQna(Map<String, String> paraMap) throws SQLException --------

	
	
	// 한 제품에 대한 리뷰게시글 갯수 알아오기
	@Override
	public int countOneProductQna(Map<String, String> paraMap) throws SQLException {

		List<QnABoardVO> productQnaList = new ArrayList<>(); 
		
		QnABoardVO board = null;
		String pk_pro_num = paraMap.get("pk_pro_num");
		int cnt = 0;
		
		try {
		
		
		conn = ds.getConnection();
		
		String sql = " select count(*)\r\n"
				   + "	    			  from \r\n"
				   + "	    			      ( \r\n"
				   + "	    			      select rownum AS rno, pk_pro_num, pk_qna_num, qna_title, mname, qna_date , qna_readcount , fk_userid , qna_issecret , qna_contents ,pro_name, pro_imgfile_name ,cate_name\r\n"
				   + "	    			      from \r\n"
				   + "	    			      ( \r\n"
				   + "	    			          select   pk_pro_num , pk_qna_num, qna_title, M.mname as mname, to_char(qna_date,'yyyy-mm-dd hh24:mi:ss') as  qna_date, qna_readcount , Q.fk_userid as fk_userid , qna_issecret , qna_contents , pro_name,  pro_imgfile_name , cate_name \r\n"
				   + "	    			          from tbl_member M JOIN tbl_qna_board Q  \r\n"
				   + "	    			          ON M.pk_userid = Q.fk_userid \r\n"
				   + "	    			          JOIN tbl_product P \r\n"
				   + "	    			          ON Q.fk_pnum = P.pk_pro_num "
				   + "	    			          JOIN TBL_CATEGORY C "
				   + "	    			  		ON P.fk_cate_num = C.pk_cate_num "
				   + "	    			          where isdelete = 0 and  pk_pro_num =  ? "
				   + "                     	  ) V \r\n"
				   + "		               ) T ";	
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, pk_pro_num);
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
		
		board = new QnABoardVO();
		cnt = Integer.parseInt(rs.getString(1));
		board.setQnaCnt(cnt);
		
		System.out.println("몇개> " + cnt);
		
		productQnaList.add(board);
		
		
		}//end of while(rs.next()) ------------ 
		
		
		}catch(SQLException e){  
			e.printStackTrace();
		} finally {
			close();
		}
		
		
		return cnt;
		
	} // end of public List<ReviewBoardVO> countOneProductReview(Map<String, String> paraMap) throws SQLException--------

	
	


	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
		
	
	
			
		//////////////////////////////////////////////////////////////////////////////
		//////////////////정환모 작업 (안겹치도록 방파제) //////////////////////////////////
		
		// FAQ 글목록보기 메소드를 구현하기 //
		@Override
		public List<FaqBoardVO> selectPagingFaqBoard(Map<String, String> paraMap) throws SQLException {
		
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
			// System.out.println("카테고리 있고 검색어 있을때 : " + currentShowPageNo + "," + sizePerPage);
			
			}
			else {
			pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
			pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			// System.out.println("카테고리 있고 검색종류 없을 때 변수들 : " + currentShowPageNo + "," + sizePerPage);
			
			}
		
		}
		else if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
			pstmt.setString(1, searchWord);
			pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
			pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			// System.out.println("카테고리 없고 검색조건 있을 때 : " + currentShowPageNo + "," + sizePerPage);
			
		}
		else {// 검색조건이 없을 때
			pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
			pstmt.setInt(2, (currentShowPageNo * sizePerPage));
			// System.out.println("검색조건 없을 때 변수들 : " + currentShowPageNo + "," + sizePerPage);
		
		}
		
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
		
		board = new FaqBoardVO();
		board.setPk_faq_board_num(rs.getInt(1));
		
		FAQcategoryBoardVO faqCate = new FAQcategoryBoardVO();
		faqCate.setFaq_c_name(rs.getString(2));
		faqCate.setFaq_c_ename(rs.getString(6));
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
		// System.out.println(" 확인용 colname : " + colname);
		// System.out.println(" 확인용 searchWord : " + searchWord);
		// System.out.println(" 확인용 searchCate : " + searchCate);
		
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
			
			String sql = " SELECT pk_rnum, pro_name, pro_imgfile_name, re_title, mname, re_date, fk_userid, re_grade, cate_name, rownum, fk_pnum"+
			" FROM   \n"+
			" (   \n"+
			"    SELECT rownum as rno, pk_rnum, pro_name, pro_imgfile_name, re_title, mname, re_date, fk_userid, re_grade, cate_name, fk_pnum "+
			"    FROM\n"+
			"    (    \n"+
			"        select R.pk_rnum AS pk_rnum, P.pro_name AS pro_name, P.pro_imgfile_name AS pro_imgfile_name, R.re_title AS re_title, M.mname AS mname "+
			"               , to_char(re_date,'yyyy-mm-dd hh24:mi:ss') AS re_date, R.fk_userid AS fk_userid , R.re_grade AS re_grade, C.cate_name AS cate_name, R.fk_pnum AS fk_pnum "+
			"        from tbl_member M\n"+
			"        JOIN tbl_review_board R\n"+
			"        ON  M.PK_USERID = R.FK_USERID "+
			"        JOIN tbl_product P\n"+
			"        ON R.fk_pnum = P.pk_pro_num "+
			"        JOIN TBL_CATEGORY C " +
			"        ON P.fk_cate_num = C.pk_cate_num " +
			"        WHERE isdelete = 0 ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
			if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
				sql += " and " + colname + " like '%'|| ? ||'%' ";
				// 위치홀더에 들어오는 값은 데이터값만 들어올 수 있지
				// 위치홀더에는 컬럼명이나 테이블 명은 들어올 수 없다 => 변수처리로 넣어준다.(중요)
			}
			
			sql +=  "	order by re_date desc " +
					"    ) V"+
					   " ) T "+
					   " where rno between ? and ?";	
			
			pstmt = conn.prepareStatement(sql);
			
			if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
				pstmt.setString(1, searchWord);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
				// System.out.println("카테고리 없고 검색조건 있을 때 : " + currentShowPageNo + "," + sizePerPage);	  
			}
			else {
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage));
				// System.out.println("검색조건 없을 때 변수들 : " + currentShowPageNo + "," + sizePerPage);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
			
			board = new ReviewBoardVO();
			board.setPk_rnum(rs.getInt(1));
			board.setFk_pnum(rs.getString(11));
			
			ProductVO product = new ProductVO();
			product.setPro_name(rs.getString(2));;
			product.setPro_imgfile_name(rs.getString(3));
			board.setProduct(product);
			board.setRe_title(rs.getString(4));
			
			
			MemberVO member = new MemberVO();
			mname = rs.getString(5);
			member.setName(mname); 
			board.setMember(member); // 보드에 멤버를 넣어줌.
			// System.out.println("이름 : " + mname);
			
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
			
			// System.out.println(" 확인용 colname : " + colname);
			// System.out.println(" 확인용 searchWord : " + searchWord);
			
			if( colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord) ) {
			// 검색종류 및 검색어가 있을 때
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
			
			// System.out.println("들어왔니 번호야? : " + pk_faq_board_num);
			// System.out.println("들어왔니 카테고리야? : " + category);
			
			int n = pstmt.executeUpdate();
			
			if(n==1) {
			// System.out.println("업데이트 성공!");
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
			// System.out.println("잘 갔니? " + currentNum);
			FaqBoardVO faqPrevNext = null;
			
			try {
			conn = ds.getConnection();
			
			
			String sql = " select prevnum, prevtitle, currentnum, currenttitle, nextnum, nexttitle "+
					" from "+
					" ( "+
					" select   "+
					"         lag(pk_faq_board_num, 1) over(order by pk_faq_board_num desc) as prevnum "+
					"       , lag(faq_title, 1) over(order by pk_faq_board_num desc) as prevtitle "+
					"       , pk_faq_board_num as currentnum "+
					"       , faq_title as currenttitle "+
					"       , lead(pk_faq_board_num, 1) over(order by pk_faq_board_num desc) as nextnum "+
					"       , lead(faq_title, 1) over(order by pk_faq_board_num desc) as nexttitle "+
					" from tbl_faq_board "+
					" ) v " +
					" where currentnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, currentNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
			
			faqPrevNext = new FaqBoardVO();
			
			faqPrevNext.setPrev_num(rs.getInt(1));
			faqPrevNext.setPrev_title(rs.getString(2));
			faqPrevNext.setCurrentNum(rs.getInt(3));
			faqPrevNext.setCurrentTitle(rs.getString(4));
			faqPrevNext.setNext_num(rs.getInt(5));
			faqPrevNext.setNext_title(rs.getString(6));
			
			
			// System.out.println("이전글 번호 : " + faqPrevNext.getPrev_num());
			// System.out.println("이전글 제목 : " + faqPrevNext.getPrev_title());
			// System.out.println("다음글 번호 : " + faqPrevNext.getNext_num());
			// System.out.println("다음글 제목 : " + faqPrevNext.getNext_title());
			
			
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
			// System.out.println("잘 갔니? " + currentNum);
			ReviewBoardVO revPrevNext = null;
			
			try {
			conn = ds.getConnection();
			
			String sql = " select prevnum, prevtitle, currentnum, currenttitle, nextnum, nexttitle "+
					" from "+
					" ( "+
					" select   "+
					"         lag(PK_RNUM, 1) over(order by PK_RNUM desc) as prevnum "+
					"       , lag(RE_TITLE, 1) over(order by PK_RNUM desc) as prevtitle "+
					"       , PK_RNUM as currentnum "+
					"       , RE_TITLE as currenttitle "+
					"       , lead(PK_RNUM, 1) over(order by PK_RNUM desc) as nextnum "+
					"       , lead(RE_TITLE, 1) over(order by PK_RNUM desc) as nexttitle "+
					" from tbl_review_board "+
					" ) v " +
					" where currentnum = ? ";
	
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, currentNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
			
			revPrevNext = new ReviewBoardVO();
			
	
			revPrevNext.setPrev_num(rs.getInt(1));
			revPrevNext.setPrev_title(rs.getString(2));
			revPrevNext.setCurrentNum(rs.getInt(3));
			revPrevNext.setCurrentTitle(rs.getString(4));
			revPrevNext.setNext_num(rs.getInt(5));
			revPrevNext.setNext_title(rs.getString(6));
			
			
			// System.out.println("이전글 번호 : " + revPrevNext.getPrev_num());
			// System.out.println("이전글 제목 : " + revPrevNext.getPrev_title());
			// System.out.println("다음글 번호 : " + revPrevNext.getNext_num());
			// System.out.println("다음글 제목 : " + revPrevNext.getNext_title());
			
			
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
			
			// System.out.println("들어왔니 번호야? : " + pk_rnum);
			
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

		
		
		// 페이징 처리를 위한 하나의 상품에 대한 리뷰게시글 페이지 알아오기
		@Override
		public int getProductRevPage(Map<String, String> paraMap) throws SQLException {
			
			int totalPage = 0;
			String pk_pro_num = paraMap.get("pk_pro_num");
			
			try {
			conn = ds.getConnection();
			
			String sql = " select ceil( count(*)/? ) "
					   + " from tbl_review_board A JOIN tbl_product B "
					   + " ON A.FK_PNUM = B.PK_PRO_NUM "
					   + " JOIN tbl_member C ON A.FK_USERID = C.PK_USERID "
					   + " where pk_pro_num = ? ";
		
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sizePerPage"));
			pstmt.setString(2, pk_pro_num);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
			} finally {
			close();
			}
			
			return totalPage;
			
		} // end of public int getProductRevPage(Map<String, String> paraMap) throws SQLException---------

		
		// 제품상세페이지에 보여줄 한 제품에 대한 게시글 불러오기
		@Override
		public List<ReviewBoardVO> selectPagingProductRev(Map<String, String> paraMap) throws SQLException {

			List<ReviewBoardVO> productRevList = new ArrayList<>(); 
			
			ReviewBoardVO board = null;
			String pk_pro_num = paraMap.get("pk_pro_num");
			
			
			try {
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			System.out.println("currentShowPageNo : " + currentShowPageNo);
			System.out.println("sizePerPage : " + sizePerPage);
			
			conn = ds.getConnection();
			
			String sql = " SELECT pk_rnum, pro_name, pro_imgfile_name, re_title, re_writer, re_date, fk_userid, re_grade, cate_name "+
			" FROM   \n"+
			" (   \n"+
			"    SELECT rownum as rno, pk_rnum, pro_name, pro_imgfile_name, re_title, re_writer, re_date, fk_userid, re_grade, cate_name "+
			"    FROM\n"+
			"    (    \n"+
			"        select R.pk_rnum AS pk_rnum, P.pro_name AS pro_name, P.pro_imgfile_name AS pro_imgfile_name, R.re_title AS re_title, R.re_writer AS re_writer "+
			"               , to_char(re_date,'yyyy-mm-dd hh24:mi:ss') AS re_date, R.fk_userid AS fk_userid , R.re_grade AS re_grade, C.cate_name AS cate_name "+
			"        from tbl_member M\n"+
			"        JOIN tbl_review_board R\n"+
			"        ON  M.PK_USERID = R.FK_USERID "+
			"        JOIN tbl_product P\n"+
			"        ON R.fk_pnum = P.pk_pro_num "+
			"        JOIN TBL_CATEGORY C " +
			"        ON P.fk_cate_num = C.pk_cate_num " +
			"        WHERE isdelete = 0 and P.pk_pro_num = ?"+
		    "	  ) V "+
		    " ) T "+
		    " where rno between ? and ?" +
		    " order by to_char(re_date) asc";		
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pk_pro_num);
			pstmt.setInt(2, 1);
			pstmt.setInt(3, 5);
			// pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
			// pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
			
			board = new ReviewBoardVO();
			board.setPk_rnum(rs.getInt(1));
			
			ProductVO product = new ProductVO();
			product.setPro_name(rs.getString(2));;
			product.setPro_imgfile_name(rs.getString(3));
			board.setProduct(product);
			board.setRe_title(rs.getString(4));
			board.setRe_writer(rs.getString(5));;
			
			board.setRe_date( rs.getString(6));
			board.setFk_userid(rs.getString(7));
			board.setRe_grade(rs.getInt(8));
			
			CategoryVO category = new CategoryVO();
			category.setCate_name(rs.getString(9));
			board.setCategory(category);
			
			productRevList.add(board);
			
			
			}//end of while(rs.next()) ------------ 
			
			
			}catch(SQLException e){  
				e.printStackTrace();
			} finally {
				close();
			}
			
			
			return productRevList;
			
			
		} // public List<ReviewBoardVO> selectPagingProductRev(Map<String, String> paraMap) throws SQLException

		@Override
		public int writeRevBoard(Map<String, String> paraMap) throws SQLException {

			int result = 0;
			int grade = Integer.parseInt(paraMap.get("grade"));
			System.out.println("grade : " + grade);
			System.out.println("fk_pnum : " + paraMap.get("fk_pnum"));
			
			try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_review_board (PK_RNUM, FK_USERID, FK_PNUM, RE_TITLE, RE_WRITER, RE_GRADE,  RE_CONTENTS, RE_PASSWD) "
			+ " values(SEQ_REVIEW_BOARD.nextval, ?, ?, ?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("fk_pnum"));
			pstmt.setString(3, paraMap.get("title"));
			pstmt.setString(4, paraMap.get("writer"));
			pstmt.setInt(5, grade);
			pstmt.setString(6, paraMap.get("content"));
			pstmt.setString(7, paraMap.get("passwd"));
			
			
			result = pstmt.executeUpdate();
			
			} catch (SQLException e) { 
			e.printStackTrace();
			} finally {
			close();
			}
		
			return result;
			
			
			
		} // end of public int writeRevBoard(Map<String, String> paraMap) throws SQLException--------------

		
		// 한 제품에 대한 리뷰게시글 갯수 알아오기
		@Override
		public int countOneProductReview(Map<String, String> paraMap) throws SQLException {

			List<ReviewBoardVO> productRevList = new ArrayList<>(); 
			
			ReviewBoardVO board = null;
			String pk_pro_num = paraMap.get("pk_pro_num");
			int cnt = 0;
			
			try {
			
			
			conn = ds.getConnection();
			
			String sql = " SELECT count(*) "+
			" FROM   \n"+
			" (   \n"+
			"    SELECT rownum as rno, pk_rnum, pro_name, pro_imgfile_name, re_title, re_writer, re_date, fk_userid, re_grade, cate_name "+
			"    FROM\n"+
			"    (    \n"+
			"        select R.pk_rnum AS pk_rnum, P.pro_name AS pro_name, P.pro_imgfile_name AS pro_imgfile_name, R.re_title AS re_title, R.re_writer AS re_writer "+
			"               , to_char(re_date,'yyyy-mm-dd hh24:mi:ss') AS re_date, R.fk_userid AS fk_userid , R.re_grade AS re_grade, C.cate_name AS cate_name "+
			"        from tbl_member M\n"+
			"        JOIN tbl_review_board R\n"+
			"        ON  M.PK_USERID = R.FK_USERID "+
			"        JOIN tbl_product P\n"+
			"        ON R.fk_pnum = P.pk_pro_num "+
			"        JOIN TBL_CATEGORY C " +
			"        ON P.fk_cate_num = C.pk_cate_num " +
			"        WHERE isdelete = 0 and P.pk_pro_num = ?"+
		    "	  ) V "+
		    " ) T ";	
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pk_pro_num);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
			
			board = new ReviewBoardVO();
			cnt = Integer.parseInt(rs.getString(1));
			board.setReviewCnt(cnt);
			
			// System.out.println("몇개야 " + cnt);
			
			productRevList.add(board);
			
			
			}//end of while(rs.next()) ------------ 
			
			
			}catch(SQLException e){  
				e.printStackTrace();
			} finally {
				close();
			}
			
			
			return cnt;
			
		} // end of public List<ReviewBoardVO> countOneProductReview(Map<String, String> paraMap) throws SQLException--------

		
		
		// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체 내게시글에 대한 페이지 알아오기
		@Override
		public int getTotalMyPage(Map<String, String> paraMap) throws SQLException {
			
			int totalPage = 0;
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
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
			
		} // end of public int getTotalMyPage(Map<String, String> paraMap) throws SQLException

		
		// 마이페이지에 보여줄 내가 쓴 게시글 불러오기
		@Override
		public List<MyBoardVO> selectPagingMyBoard(Map<String, String> paraMap) throws SQLException {
			
			MyBoardVO myBoardVO = null;
			
			List<MyBoardVO> myBoardList = new ArrayList<>();
			
			try {
			
				int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
				int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
				
				System.out.println("currentShowPageNo : " + currentShowPageNo);
				System.out.println("sizePerPage : " + sizePerPage);
				
				String colname = paraMap.get("searchType");
				String searchWord = paraMap.get("searchWord");
				String re_option = "";
				String qna_option = "";
				
				conn = ds.getConnection();
				/*
				String sql = " SELECT pk_rnum, fk_pnum, re_title, re_date, re_grade, pk_qna_num, qna_title, qna_date "+
				" FROM   "+
				" (   "+
				"    SELECT rownum as rno, pk_rnum, fk_pnum, re_title, re_date, re_grade, pk_qna_num, qna_title, qna_date "+
				"    FROM "+
				"    (    "+
				" 		select R.pk_rnum AS pk_rnum, R.fk_pnum AS fk_pnum, R.re_title AS re_title "+
				"     		, to_char(R.re_date, 'yyyy-mm-dd') AS re_date, R.re_grade AS re_grade "+
				"     		, Q.pk_qna_num AS pk_qna_num, Q.qna_title AS qna_title "+
				"     		, to_char(Q.qna_date, 'yyyy-mm-dd') AS qna_date "+
				" 		from tbl_review_board R "+
				" 		LEFT OUTER JOIN tbl_qna_boa	rd Q "+
				" 		ON R.fk_userid = Q.fk_userid "+
				" 		WHERE R.fk_userid = ? OR Q.fk_userid = ? AND R.isdelete = 0 AND Q.isdelete = 0 ";
				*/
				
				String sql = "SELECT pk_qna_num, qna_title, qna_date, pk_rnum, re_title, re_date, re_grade, re_contents, qna_contents "+
							" FROM "+
							" ( "+
							"    select rownum AS rno, pk_qna_num, qna_title, qna_date, pk_rnum, re_title, re_date, re_grade, re_contents, qna_contents "+
							"    from  "+
							"        ( "+
							"        select A.pk_qna_num AS pk_qna_num, A.qna_title AS qna_title, TO_CHAR(A.qna_date, 'yyyy-mm-dd') AS qna_date, A.qna_contents AS qna_contents "+
							"        from tbl_qna_board A "+
							"        FULL OUTER JOIN tbl_review_board B "+
							"        ON A.qna_title = B.re_title "+
							"        where A.fk_userid = ? "+
							"        ) Q\n"+
							"    FULL OUTER JOIN\n"+
							"        (\n"+
							"        select B.pk_rnum AS pk_rnum, B.re_title AS re_title, TO_CHAR(B.re_date, 'yyyy-mm-dd') AS re_date, B.re_grade AS re_grade, B.re_contents AS re_contents "+
							"        from tbl_qna_board A "+
							"        FULL OUTER JOIN tbl_review_board B "+
							"        ON A.qna_title = B.re_title "+
							"        where B.fk_userid = ? "+
							"        ) R "+
							"    ON Q.qna_title = R.re_title " +
							"    ) V "+
							" where rno between ? and ?";		
				
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
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, paraMap.get("userid"));
				pstmt.setString(2, paraMap.get("userid"));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(4, (currentShowPageNo * sizePerPage));
				
				
				if( "my_title".equalsIgnoreCase(colname) || "my_contents".equalsIgnoreCase(colname) ) {
					pstmt.setString(5, searchWord);
					pstmt.setString(6, searchWord);
				}
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
				
					myBoardVO = new MyBoardVO();
					
					QnABoardVO qna = new QnABoardVO();
					qna.setPk_qna_num(rs.getInt(1));
					qna.setQna_title(rs.getString(2));
					qna.setQna_date(rs.getString(3));
					qna.setQna_contents(rs.getString(9));
					myBoardVO.setQnaBoard(qna);
					
					ReviewBoardVO review = new ReviewBoardVO();
					review.setPk_rnum(rs.getInt(4));
					review.setRe_title(rs.getString(5));
					review.setRe_date(rs.getString(6));
					review.setRe_grade(rs.getInt(7));
					review.setRe_contents(rs.getString(8));
					myBoardVO.setRevBoard(review);
					
					// System.out.println("잘들어감? => " + myBoardVO.getRevBoard().getRe_title());
					// System.out.println("잘들어감? => " + myBoardVO.getQnaBoard().getQna_title());
					
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
			
		} // end of public MyBoardVO selectPagingMyBoard(Map<String, String> paraMap) throws SQLException

		// FAQ 카테고리 불러오기
		@Override
		public List<HashMap<String, String>> getFaqCateList() throws SQLException {

			List<HashMap<String, String>> categoryList = new ArrayList<>();
			
			try {
				conn = ds.getConnection();
				
				String sql = " select pk_faq_c_num, faq_c_name, faq_c_ename "
						   + " from tbl_faq_category "
						   + " order by pk_faq_c_num asc ";
				
				pstmt = conn.prepareStatement(sql); // 연결
				
				rs = pstmt.executeQuery(); // 실행(select니까 query)
				
				while(rs.next()) {
					
					HashMap<String, String> map = new HashMap<>();
					
					map.put("pk_faq_c_num", rs.getString(1));
					map.put("faq_c_name", rs.getString(2));
					map.put("faq_c_ename", rs.getString(3));
					
					categoryList.add(map);
					
				} // end of while
					
			} finally {
				close();
			}
		
			
			return categoryList;
			
		} // end of public List<HashMap<String, String>> getFaqCateList() throws SQLException
		
		
		
		
		
		
		
		
		
		
		
		
		


	
	
	

	

	

	
	

	
	
	
	
	
   
}
package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class MemberDAO implements InterMemberDAO {
   
   private DataSource ds;   // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
   private Connection conn;
   private PreparedStatement pstmt;
   private ResultSet rs; 
   
   private AES256 aes;
   
   
   // 기본생성자
   public MemberDAO() {
      
      try {
            Context initContext = new InitialContext();
             Context envContext  = (Context)initContext.lookup("java:/comp/env");
             ds = (DataSource)envContext.lookup("jdbc/semiorauser3");
             aes = new AES256(SecretMyKey.KEY);
             // SecretMyKey.KEY 은 우리가 만든 비밀키이다.
      
         } catch(NamingException e) {
            e.printStackTrace();
         } catch(UnsupportedEncodingException e) {
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
   
   // 회원가입을 해주는 메소드(tbl_member 테이블에 insert)
   @Override
   public int registerMember(MemberVO member) throws SQLException {
      
      int result = 0;
      
      try {
         conn =ds.getConnection();
         
         String sql = " insert into tbl_member(PK_USERID, PWD, MNAME, UQ_EMAIL, UQ_PHONE, POSTCODE, ADDRESS, DETAILADDRESS, EXTRAADDRESS, CK_GENDER, BIRTHDAY, TEL) "
                  +" values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
         
         pstmt = conn.prepareStatement(sql);
         
         pstmt.setString(1, member.getUserid());
         pstmt.setString(2, Sha256.encrypt( member.getPwd()) );      // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.
         pstmt.setString(3, member.getName());
         pstmt.setString(4, aes.encrypt(member.getEmail()));      // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다.
         pstmt.setString(5, aes.encrypt(member.getPhone()));      // 핸드폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다.
         pstmt.setString(6, member.getPostcode());
         pstmt.setString(7, member.getAddress());
         pstmt.setString(8, member.getDetailaddress());
         pstmt.setString(9, member.getExtraaddress());
         pstmt.setString(10, member.getGender());
         pstmt.setString(11, member.getBirthday());
         pstmt.setString(12, member.getTel());
         
         
         result = pstmt.executeUpdate();
      
      } catch(GeneralSecurityException | UnsupportedEncodingException e) {
         e.printStackTrace();
      } catch(Exception e) {
         e.printStackTrace();   
      } finally {
         close();
      }
      
      return result;
   }
   
   
// 입력받은 paraMap 을 가지고 한명의 회원정보를 리턴시켜주는 메소드(로그인 처리)
   @Override
   public MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException {
      
      MemberVO member = null;
      
      try {
          conn = ds.getConnection();
          
          String sql = "SELECT pk_userid, mname, uq_email, uq_phone, postcode, address, detailaddress, extraaddress, ck_gender, "+
                "       birthday, registerday, pwdchangegap, tel, "+
                "       nvl(lastlogingap, trunc( months_between(sysdate, registerday) ) ) AS lastlogingap "+
                " FROM "+
                " ( "+
                " select pk_userid, mname, uq_email, uq_phone, postcode, address, detailaddress, extraaddress, ck_gender "+
                "     , birthday , tel, to_char(registerday, 'yyyy-mm-dd') AS registerday "+
                "     , trunc( months_between(sysdate, lastpwdchangedate) ) AS pwdchangegap "+
                " from tbl_member "+
                " where ck_status = 1 and pk_userid = ? and pwd = ? "+
                " ) M "+
                " CROSS JOIN "+
                " ("+
                " select trunc( months_between(sysdate, max(logindate)) ) AS lastlogingap "+
                " from tbl_loginhistory "+
                " where fk_userid = ? "+
                " ) H";
          
          pstmt = conn.prepareStatement(sql);
          
          pstmt.setString(1, paraMap.get("userid"));
          pstmt.setString(2, Sha256.encrypt(paraMap.get("pwd")) ); 
          pstmt.setString(3, paraMap.get("userid"));
          
          rs = pstmt.executeQuery();
          
          if(rs.next()) {
             member = new MemberVO();
             
             member.setUserid(rs.getString(1));
             member.setName(rs.getString(2));
             member.setEmail( aes.decrypt(rs.getString(3)) );  // 복호화 
             member.setPhone( aes.decrypt(rs.getString(4)) ); // 복호화 
             member.setPostcode(rs.getString(5));
             member.setAddress(rs.getString(6));
             member.setDetailaddress(rs.getString(7));
             member.setExtraaddress(rs.getString(8));
             member.setGender(rs.getString(9));
            
             member.setBirthday(rs.getString(10));
             member.setRegisterday(rs.getString(11));
             member.setTel(rs.getString(13));
             
             if(rs.getInt(12) >= 3) {
                // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
               // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false
               
               member.setRequirePwdChange(true); // 로그인시 암호를 변경해라는 alert 를 띄우도록 할때 사용한다. 
             }
             
             if(rs.getInt(14) >= 12) {
                // 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 휴면으로 지정 
                member.setU_status(1);
                
                // === tbl_member 테이블의 idle 컬럼의 값을 1로 변경하기 === //
                sql = " update tbl_member set ck_u_status = 1 "
                    + " where pk_userid = ? ";
                
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, paraMap.get("userid")); 
                
                pstmt.executeUpdate();
             }
             
             // === tbl_loginhistory(로그인기록) 테이블에 insert 하기 === //
             if(member.getU_status() != 1) {
                sql = " insert into tbl_loginhistory(fk_userid, clientip) "
                    + " values(?, ?) ";
                
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, paraMap.get("userid")); 
                pstmt.setString(2, paraMap.get("clientip"));
                
                pstmt.executeUpdate();
             }
             
          }
      
      } catch(GeneralSecurityException | UnsupportedEncodingException e) { 
          e.printStackTrace();    
      } finally {
         close();
      }
      
      return member;
   }

   // ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
	@Override
	public boolean idDuplicateCheck(String userid) throws SQLException {
		
		boolean isExist = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select * "
					   + " from tbl_member"
					   + " where pk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			isExist = rs.next();  // 행이 있으면(중복된 userid)     true,
			                      // 행이 없으면(사용가능한 userid)  false
			
		} finally {
			close();
		}
		
		return isExist;
	}
	
	// email 중복검사 (tbl_member 테이블에서 email 이 존재하면 true를 리턴해주고, email 이 존재하지 않으면 false를 리턴한다) 
		@Override
		public boolean emailDuplicateCheck(String email) throws SQLException {

			boolean isExist = false;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select * "
						   + " from tbl_member"
						   + " where uq_email = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, aes.encrypt(email));
				
				rs = pstmt.executeQuery();
				
				isExist = rs.next();  // 행이 있으면(중복된 userid)     true,
				                      // 행이 없으면(사용가능한 userid)  false
				
			} catch(GeneralSecurityException | UnsupportedEncodingException e) { 
				e.printStackTrace();
			} finally {
				close();
			}
			
			return isExist;		
		}

		// 아이디 찾기(성명, 이메일을 입력받아서 해당 사용자의 아이디를 알려준다)
	      @Override
	      public String findUserid(Map<String, String> paraMap, int select) throws SQLException {
	         
	         String userid = null;
	         
	         try {
	             conn = ds.getConnection();
	             
	             String sql = " select pk_userid "
	                       + " from tbl_member"
	                       + " where ck_status = 1 and mname = ? and ";
	             
	             if(select == 0) {
	                sql += "uq_email = ?";
	             }else if (select == 1) {
	                sql += "uq_phone = ? ";
	             }
	             
	             pstmt = conn.prepareStatement(sql);
	             pstmt.setString(1, paraMap.get("name"));
	             if(select == 0) {
	                pstmt.setString(2, aes.encrypt(paraMap.get("email")));
	             }else if (select == 1) {
	                pstmt.setString(2, aes.encrypt(paraMap.get("phone")));
	             }
	             
	             rs = pstmt.executeQuery();
	             
	             if(rs.next()) {
	                userid = rs.getString(1);
	             }
	         
	         } catch(GeneralSecurityException | UnsupportedEncodingException e) { 
	             e.printStackTrace();    
	         } finally {
	            close();
	         }
	         
	         return userid;
	      }

		// 회원정보 수정하기
		@Override
		public int updateMember(MemberVO member) throws SQLException {
			
			int result = 0;
			
			try {
				conn = ds.getConnection();
				String sql = " update tbl_member set  mname =? "
						   + " 						, pwd=? "
						   + " 						, uq_email=? "
						   + " 						, tel=? "
						   + " 						, UQ_phone=? "
						   + " 						, postcode=? "
						   + " 						, address=? "
						   + " 						, detailaddress=? "
						   + " 						, extraaddress=? "
						   + " 						, lastpwdchangedate= sysdate "
						   + " where pk_userid = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1,  member.getName());
				pstmt.setString(2,  Sha256.encrypt(member.getPwd()));  // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.   
				pstmt.setString(3,  aes.encrypt(member.getEmail()));   // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다.   
				pstmt.setString(4,  member.getTel());   
				pstmt.setString(5,  aes.encrypt(member.getPhone()));  // 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다.  
				pstmt.setString(6,  member.getPostcode());
				pstmt.setString(7,  member.getAddress());
				pstmt.setString(8,  member.getDetailaddress());
				pstmt.setString(9,  member.getExtraaddress());
				pstmt.setString(10, member.getUserid());
				
				result = pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			
			return result;
			
		}
		
		// 회원탈퇴하기 
		@Override
		public int memberDelete(Map<String, String> paraMap) throws SQLException {
			
			int result = 0;
			
			try {
				conn = ds.getConnection();
				String sql = " update tbl_member set ck_status = '0' "
						   + " 						, deleteday = sysdate "
						   + " where pk_userid = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				
				pstmt.setString(1, paraMap.get("userid"));
				
				result = pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			
			return result;
		}
	
		// 비밀번호 찾기(아이디, 이메일을 입력받아서 해당 사용자가 존재하는지 유무를 알려준다)
	      @Override
	      public boolean isUserExist(Map<String, String> paraMap , int select) throws SQLException {
	         
	         boolean isUserExist = false;
	         
	         try {
	             conn = ds.getConnection();
	             
	             String sql = " select pk_userid "
	                       + " from tbl_member"
	                       + " where ck_status = 1 and pk_userid = ? and mname = ? and ";
	             
	             if(select == 0) {
	                sql += "uq_email = ?";
	             }else if (select == 1) {
	                sql += "uq_phone = ? ";
	             }
	             
	             pstmt = conn.prepareStatement(sql);
	             pstmt.setString(1, paraMap.get("userid"));
	             pstmt.setString(2, paraMap.get("name"));
	             if(select == 0) {
	                pstmt.setString(3, aes.encrypt(paraMap.get("email")));
	             }else if (select == 1) {
	                pstmt.setString(3, aes.encrypt(paraMap.get("phone")));
	             }
	         
	             rs = pstmt.executeQuery();
	             isUserExist = rs.next(); 
	             
	         } catch(GeneralSecurityException | UnsupportedEncodingException e) { 
	             e.printStackTrace();    
	         } finally {
	            close();
	         }
	         
	         return isUserExist;
	      }
		
	      
	   // 암호 변경하기
	      @Override
	      public int pwdUpdate(Map<String, String> paraMap) throws SQLException {

	         int result = 0;
	         
	         try {
	             conn = ds.getConnection();
	             
	             String sql = " update tbl_member set pwd = ? "
	                       + "  , lastpwdchangedate = sysdate "
	                       + " where pk_userid = ? ";
	             
	             pstmt = conn.prepareStatement(sql);
	             
	             pstmt.setString(1, Sha256.encrypt(paraMap.get("pwd")) ); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.
	             pstmt.setString(2, paraMap.get("userid") );
	             
	             result = pstmt.executeUpdate();
	             
	         } finally {
	            close();
	         }
	         
	         return result;
	      }
	      
	      
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
	  	
	  	

	  	// 쿠폰조회를 위한 메소드 리스트
	  	@Override
	  	public List<CouponVO> selectCouponList(Map<String, String> paraMap) {

	  		List<CouponVO> couponList = new ArrayList<>();
	  		
	  		try {
	  			conn = ds.getConnection();
	  			
	  			 String sql = " select rno, pk_coupon_id, cname, cprice, cdate, cstartdate, CENDDATE, CMINPRICE, CPSTATUS, pk_userid, user_cp_status  "
	  			 		+ " from "
	  			 		+ " ( "
	  			 		+ " select row_number() over(order by M.pk_userid desc) as rno , "
	  			 		+ " M.pk_userid, C.pk_coupon_id, cname, cprice, cdate, cstartdate, CENDDATE, CMINPRICE, CPSTATUS, U.user_cp_status  "
	  			 		+ " from tbl_member M "
	  			 		+ " join tbl_user_coupon_status U "
	  			 		+ " on M.pk_userid = U.pk_userid "
	  			 		+ " join tbl_coupon C "
	  			 		+ " on C.pk_coupon_id = U.coupon_id "
	  			 		+ " )V "
	  			 		+ " where pk_userid=? and CPSTATUS='1' ";
	  	         
	  	        
	  	         
	  	         pstmt = conn.prepareStatement(sql);
	  	        
	  	         pstmt.setString(1, paraMap.get("userid"));
	  			
	  	         rs = pstmt.executeQuery();
	  	         
	  	         while(rs.next()){
	  				
	  	        // 쿠폰사용방지
	  				String cenddate = rs.getString(7);
	  				String user_cp_status = rs.getString(11);
	  				boolean bool = true;
	  		        	
	  	        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	  				
	  				LocalDate today = LocalDate.now();
	  				String sToday = sdf.format(today);
	  				
	  				Date todayD = (Date) sdf.parse(sToday);
	  				Date cenddateD = (Date) sdf.parse(cenddate);
	  				
	  				// 쿠폰 만료기간이 지나면 사용하지 못하도록 값 변경해준다.
	  				if( cenddateD.after(todayD) ) {
	  					bool = false;
	  				}
	  	        	
	  				if( user_cp_status == "0" ) {
	  					bool = false;
	  				}
	  				
	  		
	  	        	 
	  				CouponVO cvo = new CouponVO();
	  				
	  				cvo.setRno(rs.getString(1));
	  				cvo.setCouponid(rs.getString(2));
	  				cvo.setCname(rs.getString(3));
	  				cvo.setCprice(rs.getString(4));
	  				cvo.setCdate(rs.getString(5));
	  				cvo.setCstartdate(rs.getString(6));
	  				cvo.setCenddate(rs.getString(7));
	  				cvo.setCminprice(rs.getString(8));
	  				cvo.setCpstatus(rs.getString(9));
	  				
	  				MemberVO mvo = new MemberVO();
	  				mvo.setUserid(rs.getString(10));
	  				
	  				UserCouponStatusVO ucvo = new UserCouponStatusVO();
	  				ucvo.setUser_cp_status(rs.getString(11));
	  				
	  				cvo.setUserCouponCheck(bool);
	  				
	  				
	  				couponList.add(cvo);
	  	         } // end of while
	  			
	  		} catch(Exception e) { 
	  		    e.printStackTrace();	
	  		} finally {
	  			close();
	  		}
	  		
	  		return couponList;
	  	}


	  	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 쿠폰에 대한 총페이지 알아오기. 
	  	@Override
	  	public int getTotalPage(Map<String, String> paraMap) {
	  		
	  		int totalPage = 0;
	  		
	  		try {
	  			conn = ds.getConnection();
	  			
	  			String sql = " select ceil(count(*)/?) "
	  					   + " from tbl_user_coupon_status "
	  					   + " where pk_userid = ? ";
	  			
	  			pstmt = conn.prepareStatement(sql);
	  			pstmt.setString(1, paraMap.get("sizePerPage"));
	  			pstmt.setString(2, paraMap.get("userid"));
	  			
	  			rs = pstmt.executeQuery();
	  			
	  			if(rs.next()) {
	  				totalPage = rs.getInt(1);
	  			}
	  			
	  		} catch (SQLException e) {
	  				e.printStackTrace();
	  		} finally {
	  			close();
	  		}
	  		return totalPage;
	  	}

	  	
	  	// 페이징 처리가된 쿠폰 리스트를 가져오기 
	  	@Override
	  	public List<CouponVO> selectPagingCouponList(Map<String, String> paraMap) throws SQLException {
	  		
	  		List<CouponVO> pagingCouponList = new ArrayList<>();
	  		
	  		try {
	  			conn = ds.getConnection();
	  			
	  			String sql =  " select rownum, pk_coupon_id, cname, cprice, cdate, cstartdate, CENDDATE, CMINPRICE, CPSTATUS , pk_userid, user_cp_status "
	  						+ " from "
	  						+ " (  "
	  						+ "    select rownum as rno , "
	  						+ "    pk_userid, pk_coupon_id, cname, cprice, cdate, cstartdate, CENDDATE, CMINPRICE, CPSTATUS, user_cp_status  "
	  						+ "    from ( "
	  						+ "         select M.pk_userid, C.pk_coupon_id, C.cname, C.cprice, C.cdate, C.cstartdate, C.CENDDATE, C.CMINPRICE, C.CPSTATUS, U.user_cp_status  "
	  						+ "         from tbl_member M  "
	  						+ "         join tbl_user_coupon_status U  "
	  						+ "         on M.pk_userid = U.pk_userid  "
	  						+ "         join tbl_coupon C  "
	  						+ "         on C.pk_coupon_id = U.coupon_id  "
	  						+ "         order by C.cenddate "
	  						+ "         )V  "
	  						+ "     )v2 "
	  						+ " where pk_userid=? and CPSTATUS='1' and rownum between ? and ? ";
	  						
	  							
	  			pstmt = conn.prepareStatement(sql);
	  			
	  			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo") );
	  			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage") );
	  			
	  			/*
	  			  	where rno between A and B
	  	            >>> A 와 B를 구하는 공식 <<<
	  	            
	  	            currentShowPageNo 은 보고자하는 페이지 번호이다. 즉, 1페이지, 2페이지, 3페이지.... 를 말한다.
	  	            sizePerPage는 한페이지당 보여줄 행의 개수를 말한다. 즉, 3개, 5개, 10개를 보여줄때의 개수를 말한다.
	  	            
	  	            
	  	            A는 (currentShowPageNo * sizePerPage) - (sizePerPage - 1); 이다.
	  	            B는 (currentShowPageNo * sizePerPage); 이다.
	  			*/
	  		/*		
	  			 // 쿠폰사용방지
  				String cenddate = rs.getString(7);
  				String user_cp_status = rs.getString(11);
  				boolean bool = true;
  		        	
  	        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
  				
  				LocalDate today = LocalDate.now();
  				String sToday = sdf.format(today);
  				
  				Date todayD = (Date) sdf.parse(sToday);
  				Date cenddateD = (Date) sdf.parse(cenddate);
  				
  				// 쿠폰 만료기간이 지나면 사용하지 못하도록 값 변경해준다.
  				if( cenddateD.after(todayD) ) {
  					bool = false;
  				}
  	        	
  				if( user_cp_status == "0" ) {
  					bool = false;
  				}
  			*/	
	  			
	  			
	  		
	  				pstmt.setString(1, paraMap.get("userid"));
	  				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
	  				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
	  			
	  				rs = pstmt.executeQuery();
	  			
	  				while(rs.next()){
	  					
	  					CouponVO cvo = new CouponVO();
	  		
	  					cvo.setRno(rs.getString(1));
	  					cvo.setCouponid(rs.getString(2));
	  					cvo.setCname(rs.getString(3));
	  					cvo.setCprice(rs.getString(4));
	  					cvo.setCdate(rs.getString(5));
	  					cvo.setCstartdate(rs.getString(6));
	  					cvo.setCenddate(rs.getString(7));
	  					cvo.setCminprice(rs.getString(8));
	  					cvo.setCpstatus(rs.getString(9));
	  					
	  					MemberVO mvo = new MemberVO();
	  					mvo.setUserid(rs.getString(10));
	  					cvo.setMvo(mvo);
	  					
	  					UserCouponStatusVO ucvo = new UserCouponStatusVO();
	  					ucvo.setUser_cp_status(rs.getString(11));
	  					cvo.setUcvo(ucvo);
	  					
	  			//		cvo.setUserCouponCheck(bool);
	  					
	  					pagingCouponList.add(cvo);
	  					
	  				} // end of while
	  		
	  			} catch(Exception  e) { 
	  			    e.printStackTrace();	
	  			} finally {
	  				close();
	  			}
	  				return pagingCouponList;
	  			}

		// 유저가 쿠폰등록하는 기능   
		@Override
		public int UserCouponStatus(UserCouponStatusVO userCouponStatus) throws SQLException {
			int result = 0;
			
			try {
		         conn =ds.getConnection();
		         
		         String sql = " insert into tbl_user_coupon_status(PK_USERID,COUPON_ID,USER_CP_STATUS) "
		                  +" values(?, ?, '1') ";
		         
		         pstmt = conn.prepareStatement(sql);
		         
		         pstmt.setString(1, userCouponStatus.getUserid());
		         pstmt.setString(2, userCouponStatus.getCoupon_id());
		         
		         result = pstmt.executeUpdate();
		      
		      } catch(Exception e) {
		         e.printStackTrace();   
		      } finally {
		         close();
		      }
			
			return result;
		}
		   
		   
		// 개인이 가지고 있는 쿠폰 개수 가져오기
			@Override
			public int CouponNum(Map<String, String> paraMap) throws SQLException {
				
				int couponNum = 0;
					
					try {
						conn = ds.getConnection();
						
						 String sql = " select count(*) "
							 		+ " from tbl_user_coupon_status "
							 		+ " where pk_userid = ? ";
				         
				         pstmt = conn.prepareStatement(sql);
				        
				         pstmt.setString(1, paraMap.get("userid"));
						
				         rs = pstmt.executeQuery();
				         
				         if( rs.next()) {
				        	 couponNum = rs.getInt(1);
				         }
						
					} catch(Exception e) { 
					    e.printStackTrace();	
					} finally {
						close();
					}
					
					return couponNum;
			}

			// 쿠폰만료기간 지나면 사용막기 (수정해야함)
			@Override
			public int expireCoupon(Map<String, String> paraMap) throws SQLException {
				
				int result = 0;
				
				try {
			         conn =ds.getConnection();
			         
			         String sql = " update TBL_USER_COUPON_STATUS "
			         			+ " set USER_CP_STATUS = '0' "
			         			+ " where COUPON_ID=? and pk_user_id = ? ";
			         
			         pstmt = conn.prepareStatement(sql);
			         
			         pstmt.setString(1, paraMap.get("couponid"));
			         
			         result = pstmt.executeUpdate();
			      
			      } catch(Exception e) {
			         e.printStackTrace();   
			      } finally {
			         close();
			      }
				
				return result;
			}

			// 쿠폰번호 중복 발행을 막는 메소드
			@Override
			public String randDuplicateCheck(String couponNumber) {
				
				String Number = "";
				
				try {
			         conn =ds.getConnection();
			         
			         String sql = " select PK_COUPON_ID  "
				         		+ " from tbl_coupon "
				         		+ " where PK_COUPON_ID = ? ";
			         
			         pstmt = conn.prepareStatement(sql);
			         
			         pstmt.setString(1, couponNumber);
			         
			         pstmt.executeQuery();
			         
			        if( rs.next() ) {
			        	Number = rs.getString(1);
			        }
			      
			      } catch(Exception e) {
			         e.printStackTrace();   
			      } finally {
			         close();
			      }
				
				return Number;
			}

			
			
			
			// 쿠폰등록시 개인이 쿠폰을 가지고 있는지 확인하는 용도
			@Override
			public boolean couponDuplicateCheck(Map<String, String> paraMap) throws SQLException {
				
				boolean bool = false;
				
				try {
			         conn =ds.getConnection();
			         
			         String sql = " select coupon_id "
				         		+ " from tbl_user_coupon_status "
				         		+ " where coupon_id = ? and PK_USERID = ? ";
			         
			         pstmt = conn.prepareStatement(sql);
			         
			         pstmt.setString(1, paraMap.get("userCoupon"));
			         pstmt.setString(2, paraMap.get("userid"));
			         
			         rs=pstmt.executeQuery();
			         
			         bool = rs.next();
			         
			      
			      } catch(Exception e) {
			         e.printStackTrace();   
			      } finally {
			         close();
			      }
				
				return bool;
			}

			
			// 쿠폰등록시 이상한 쿠폰번호 쓰는 거 막기
			@Override
			public boolean CPDuplicateCheck(Map<String, String> paraMap) throws SQLException {
				
				boolean bool = false;
				
				try {
			         conn =ds.getConnection();
			         
			         String sql = " select pk_coupon_id "
				         		+ " from tbl_coupon "
				         		+ " where pk_coupon_id= ? ";
				         		
			         pstmt = conn.prepareStatement(sql);
			         
			         pstmt.setString(1, paraMap.get("userCoupon"));
			         
			         rs=pstmt.executeQuery();
			         
			         bool = rs.next();
			      
			      } catch(Exception e) {
			         e.printStackTrace();   
			      } finally {
			         close();
			      }
				
				return bool;
			}

		
///////////////////////////////////////////////////////////////////////////////////////////////파일 합치기	
		
			
		      
			   // 아이디를 입력받아서 해당 사용자의 마일리지액 조회
				@Override
				public int mgCheck(Map<String, String> paraMap) throws SQLException {
					
					int result = 0;
					
					try {
				         conn =ds.getConnection();
				         
				         String sql = " select All_MG "
				         		+ " from tbl_mileage "
				         		+ " where USERID = ? ";
				         
				         pstmt = conn.prepareStatement(sql);
				        
				         pstmt.setString(1, paraMap.get("userid")); 
				         
				         rs = pstmt.executeQuery();
				         
				         if(rs.next()) {
				        	 result = Integer.parseInt(rs.getString(1));
				         }
				         
				      } catch(SQLException e) {
				         e.printStackTrace();   
				      } finally {
				         close();
				      }
					
					return result;
				}
					
			

}
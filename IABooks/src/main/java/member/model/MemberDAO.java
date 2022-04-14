package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

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
                "       birthday, registerday, pwdchangegap, tel, ck_u_status, ck_status, "+
                "       nvl(lastlogingap, trunc( months_between(sysdate, registerday) ) ) AS lastlogingap "+
                " FROM "+
                " ( "+
                " select pk_userid, mname, uq_email, uq_phone, postcode, address, detailaddress, extraaddress, ck_gender, ck_u_status, ck_status "+
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
             member.setU_status(rs.getInt(14));
             member.setStatus(rs.getInt(15));
             
             if(rs.getInt(12) >= 3) {
                // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
               // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false
               
               member.setRequirePwdChange(true); // 로그인시 암호를 변경해라는 alert 를 띄우도록 할때 사용한다. 
             }
             
             if(rs.getInt(16) >= 12) {
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
	  	
	  	

	  	// 만료기간 지나면 쿠폰 사용못하도록 데이터값 변경
	  	@Override
	  	public int deleteCouponList(Map<String, String> paraMap) {

	  		int result = 0;
	  		
	  		try {
	  			conn = ds.getConnection();
	  			
	  			 String sql = " select M.pk_userid, C.pk_coupon_id "
		  			 		+ " from tbl_member M   "
		  			 		+ " join tbl_user_coupon_status U  "
		  			 		+ " on M.pk_userid = U.fk_userid   "
		  			 		+ " join tbl_coupon C  "
		  			 		+ " on C.pk_coupon_id = U.coupon_id   "
		  			 		+ " where pk_userid=? and user_cp_status='1'  "
		  			 		+ " AND TO_DATE(C.CENDDATE,'YYYY-MM-DD') < TO_DATE( TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'YYYY-MM-DD')  ";
		  	         
	  	        
	  	         
	  	         pstmt = conn.prepareStatement(sql);
	  	        
	  	         pstmt.setString(1, paraMap.get("userid"));
	  			
	  	         rs = pstmt.executeQuery();
	  	         
	  	         List<CouponVO> dcp = new ArrayList<>();
	  	         
	  	         CouponVO cvo = new CouponVO();
	  	         MemberVO mvo = new MemberVO();

	  	         while(rs.next()) {
	  	        	 
	  	        	 mvo.setUserid(rs.getString(1));
	  	        	 cvo.setMvo(mvo);
	  	        	 cvo.setCouponid(rs.getString(2));
	  	        	 
	  	        	 dcp.add(cvo);
		  	         
	  	         } // end of while
		  	    
	  	         for(int i=0; i < dcp.size(); i++ ) {
		  			// 쿠폰사용방지
	  	     /*   	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	  				
	  	        	Date today = new Date();
	  	       // 	String str_today = sdf.format(today);
	  				
	  	       //	Date todayD = (Date) sdf.parse(str_today);
	  				Date cenddateD = (Date) sdf.parse(dcp.get(i).getCenddate());
	  				
	  				// 쿠폰 만료기간이 지나면 사용하지 못하도록 값 변경해준다.
	  				int compare = cenddateD.compareTo(today);
	  				*/
	  				
	  		//		if( compare < 0  ) {
		  	        // cenddateD.after(today) => 엔드데이트 > 오늘 
		 				conn = ds.getConnection();
			  	         
		 				sql = " update TBL_USER_COUPON_STATUS "
				        	+ " set USER_CP_STATUS = '0' "
				        	+ " where COUPON_ID=? and fk_userid = ? ";
		 				
		 				pstmt = conn.prepareStatement(sql);
		 				
				        pstmt.setString(1, dcp.get(i).getCouponid());
				        pstmt.setString(2, dcp.get(i).getMvo().getUserid());
				         
				        result = pstmt.executeUpdate();
		 			    
		  	         } // end of for
  				
	  
	  	         
	  	         
	  		} catch(Exception e) { 
	  		    e.printStackTrace();	
	  		} finally {
	  			close();
	  		}
	  		
	  		return result;
	  	}


	  	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 쿠폰에 대한 총페이지 알아오기. 
	  	@Override
	  	public int getTotalPage(Map<String, String> paraMap) {
	  		
	  		int totalPage = 0;
	  		
	  		try {
	  			conn = ds.getConnection();
	  			
	  			String sql = " select ceil(count(*)/?) "
	  					   + " from tbl_user_coupon_status "
	  					   + " where fk_userid = ? and user_cp_status='1' ";
	  			
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
	  			
	  			String sql =  " select rno, pk_coupon_id, cname, cprice, cdate, cstartdate, CENDDATE, CMINPRICE, CPSTATUS , pk_userid, user_cp_status  "
		  					+ " from "
		  					+ " ( "
		  					+ "    select rownum as rno , "
		  					+ "    pk_userid, pk_coupon_id, cname, cprice, cdate, cstartdate, CENDDATE, CMINPRICE, CPSTATUS, user_cp_status  "
		  					+ "    from ( "
		  					+ "         select M.pk_userid, C.pk_coupon_id, C.cname, C.cprice, C.cdate, C.cstartdate, C.CENDDATE, C.CMINPRICE, C.CPSTATUS, U.user_cp_status  "
		  					+ "         from tbl_member M  "
		  					+ "         join tbl_user_coupon_status U  "
		  					+ "         on M.pk_userid = U.fk_userid   "
		  					+ "         join tbl_coupon C  "
		  					+ "         on C.pk_coupon_id = U.coupon_id  "
		  					+ "         where pk_userid=? and CPSTATUS='1' and user_cp_status='1'   "
		  					+ "         order by C.cenddate "
		  					+ "         )V  "
		  					+ "     )v2 "
		  					+ " where rno between ? and ? ";
	  						
	  							
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
		         
		         String sql = " insert into tbl_user_coupon_status(FK_USERID,COUPON_ID,USER_CP_STATUS) "
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
							 		+ " where fk_userid = ? and USER_CP_STATUS = '1' ";
				         
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
				         		+ " where coupon_id = ? and FK_USERID = ? ";
			         
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
				/*
				 * @Override public Map<String, String> mgInfo (Map<String, String> paraMap)
				 * throws SQLException {
				 * 
				 * Map<String, String> map = new HashMap<>();
				 * 
				 * try { conn =ds.getConnection();
				 * 
				 * String sql =
				 * " select sum(all_mg), sum(used_mg), ( sum(all_mg)-sum(used_mg)-sum(unsecured_mg) ) AS available_mg , sum(refund_mg) , sum(unsecured_mg)  "
				 * + " from tbl_mileage " + " where fk_userid = ? ";
				 * 
				 * pstmt = conn.prepareStatement(sql);
				 * 
				 * pstmt.setString(1, paraMap.get("userid"));
				 * 
				 * rs = pstmt.executeQuery();
				 * 
				 * if(rs.next()) { map.put("all_mg", rs.getString(1)); map.put("used_mg",
				 * rs.getString(2)); map.put("available_mg", rs.getString(3));
				 * map.put("refund_mg", rs.getString(4)); map.put("unsecured_mg",
				 * rs.getString(5)); }
				 * 
				 * } catch(SQLException e) { e.printStackTrace(); } finally { close(); }
				 * 
				 * return map; }
				 * 
				 * @Override public List<MileageVO> orderMileageInfo(Map<String, String>
				 * paraMap) throws SQLException {
				 * 
				 * 
				 * 
				 * return null; }
				 */

				
//////////////////////////////////////////////////////////////////////////////////////////// 새로시작
				
				
				// == 페이징 처리가 되어진 모든 회원 또는 검색한 회원 목록 보여주기 ==
				@Override
				public List<MemberVO> selectPagingMember(Map<String, String> paraMap) throws SQLException {
					
					List<MemberVO> memberList = new ArrayList<>();
					
					try {
						conn = ds.getConnection();
						
						String sql =  " select pk_userid, mname, uq_email, ck_gender "
									+ " from "
									+ "  (  "
									+ "    select rownum as rno, pk_userid, mname, uq_email, ck_gender "
									+ "    from "
									+ "    ( "
									+ "        select pk_userid, mname, uq_email, ck_gender "
									+ "        from tbl_member "
									+ "        where pk_userid != 'admin' ";
									
						
						String colname = paraMap.get("searchType");
						String searchWord = paraMap.get("searchWord");
						
				//		System.out.println("확인용 colname => "+ colname);
				//		System.out.println("확인용 searchWord  => "+ searchWord );
						
						
						if(colname != null && !("".equals(colname)) && searchWord != null && !("".equals(searchWord)) && "name".equals(colname)) {
							sql += " and mname like '%'|| ? ||'%' ";
						} else if(colname != null && !("".equals(colname)) && searchWord != null && !("".equals(searchWord)) && "email".equals(colname)) {
							sql += " and uq_email like '%'|| ? ||'%' ";
						} else if(colname != null && !("".equals(colname)) && searchWord != null && !("".equals(searchWord)) && "userid".equals(colname)) {
							sql += " and pk_userid like '%'|| ? ||'%' ";
						}
						
						
						sql += "        order by registerday desc "
								+ "    ) V "
								+ "   ) T  "
								+ " where rno between ? and ?  ";
						
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
						
						if(colname != null && !("".equals(colname)) && searchWord != null && !("".equals(searchWord))) {
							
							if( "email".equals(colname) ) {
								pstmt.setString(1, aes.encrypt(searchWord));
							} else {
								pstmt.setString(1, searchWord);
							}
							
							pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
							pstmt.setInt(3, (currentShowPageNo * sizePerPage));
							
						} else {
							pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
							pstmt.setInt(2, (currentShowPageNo * sizePerPage));
						}
						
						rs = pstmt.executeQuery();
						
						while(rs.next()){
							
							MemberVO mvo = new MemberVO();
							mvo.setUserid(rs.getString(1));
							mvo.setName(rs.getString(2));
							mvo.setEmail(aes.decrypt(rs.getString(3))); // 복호화
							mvo.setGender(rs.getString(4));
							
							memberList.add(mvo);
						} // end of while
						
					} catch(GeneralSecurityException | UnsupportedEncodingException e) { 
					    e.printStackTrace();	
					} finally {
						close();
					}
					
					return memberList;
				}
				
				
				// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총페이지 알아오기. 
				@Override
				public int getMemberTotalPage(Map<String, String> paraMap) throws SQLException {
					
					int totalPage = 0;
					
					try {
						conn = ds.getConnection();
						
						String sql = " select ceil(count(*)/?) "
								   + " from tbl_member "
								   + " where pk_userid != 'admin' ";
						
						String colname = paraMap.get("searchType");
						String searchWord = paraMap.get("searchWord");
						
				//		System.out.println("확인용 colname => "+ colname);
				//		System.out.println("확인용 searchWord  => "+ searchWord );
						
						
						if(colname != null && !("".equals(colname)) && searchWord != null && !("".equals(searchWord)) && "name".equals(colname)) {
							sql += " and mname like '%'|| ? ||'%' ";
						} else if(colname != null && !("".equals(colname)) && searchWord != null && !("".equals(searchWord)) && "email".equals(colname)) {
							sql += " and uq_email like '%'|| ? ||'%' ";
						} else if(colname != null && !("".equals(colname)) && searchWord != null && !("".equals(searchWord)) && "userid".equals(colname)) {
							sql += " and pk_userid like '%'|| ? ||'%' ";
						}
						
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, paraMap.get("sizePerPage")); 
						
						if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
							if( "email".equals(colname) ) {
								pstmt.setString(2, aes.encrypt(paraMap.get("searchWord")));
							} else {
								pstmt.setString(2, paraMap.get("searchWord"));
							}
						}
						
						rs = pstmt.executeQuery();
						
						rs.next();
						
						totalPage = rs.getInt(1);
						
					} catch(GeneralSecurityException | UnsupportedEncodingException e) { 
					    e.printStackTrace();	
					} finally {
						close();
					}
					
					return totalPage;
				}

				
				
				// userid 값을 입력받아서 회원 한명에 대한 상세 정보를 알아오기 
				@Override
				public MemberVO memberOneDetail(String userid) throws SQLException {

					MemberVO mvo = null;
					
					try {
						 conn = ds.getConnection();
						 
						 String sql = " select pk_userid, mname, uq_email, uq_phone, postcode, address, detailaddress, extraaddress, ck_gender, birthday, "+
								 	 " to_char(sysdate, 'yyyy')- substr(birthday,1,4)+1 as age , to_char(registerday, 'yyyy-mm-dd') as registerday,"
								 	 + "CK_STATUS, CK_U_STATUS " +
									 	" from tbl_member "+
									 	" where pk_userid = ? ";
						 
						 pstmt = conn.prepareStatement(sql);
						 pstmt.setString(1, userid);
						 
						 rs = pstmt.executeQuery();
						 
						 if(rs.next()) {
							 mvo = new MemberVO();
							 
							 mvo.setUserid(rs.getString(1));
							 mvo.setName(rs.getString(2));
							 mvo.setEmail( aes.decrypt(rs.getString(3)) );  // 복호화 
							 mvo.setPhone( aes.decrypt(rs.getString(4)) ); // 복호화 
							 mvo.setPostcode(rs.getString(5));
							 mvo.setAddress(rs.getString(6));
							 mvo.setDetailaddress(rs.getString(7));
							 mvo.setExtraaddress(rs.getString(8));
							 mvo.setGender(rs.getString(9));
							 mvo.setBirthday(rs.getString(10));
							 mvo.setAge(rs.getInt(11));
							 mvo.setRegisterday(rs.getString(12));
							 mvo.setStatus(rs.getInt(13));
							 mvo.setU_status(rs.getInt(14));
							 
						 }
					
					} catch(GeneralSecurityException | UnsupportedEncodingException e) { 
					    e.printStackTrace();	 
					} finally {
						close();
					}
					
					return mvo;
				}

				
				// 관리자 페이지에서 관리자가 회원의 정보변경 휴면계정
				@Override
				public int userUStatusUpdate(String userid) throws SQLException {
					int result = 0;
					
					try {
				         
				         conn =ds.getConnection();
				         
				         // 휴면계정일때 기본값 0 휴면계정일 때 1  
				         String sql = " UPDATE tbl_member SET ck_u_status=1 , ck_status = 1 "
				        			+ " WHERE pk_userid = ? ";
				         
				         
				         pstmt = conn.prepareStatement(sql);
				         pstmt.setString(1, userid);
				         
				         result = pstmt.executeUpdate();
				      
				      } catch(Exception e) {
				         e.printStackTrace();   
				      } finally {
				         close();
				      }
					
					return result;
				}


				// 관리자 페이지에서 관리자가 회원의 정보변경 회원탈퇴
				@Override
				public int userStatusUpdate(String userid) throws SQLException {
					int result = 0;
					
					try {
				         
				         conn =ds.getConnection();
				        	
				         // 회원탈퇴일때
				         String sql = " UPDATE tbl_member SET ck_u_status = 0, ck_status = 0 WHERE pk_userid = ? ";
				         
				         pstmt = conn.prepareStatement(sql);
				         pstmt.setString(1, userid);
				         
				         result = pstmt.executeUpdate();
				      
				      } catch(Exception e) {
				         e.printStackTrace();   
				      } finally {
				         close();
				      }
					
					return result;
				}
				
				
				// 관리자 페이지에서 관리자가 회원의 정보변경 일반회원으로 변경
				@Override
				public int userNormalStatusUpdate(String userid) throws SQLException {
					int result = 0;
					
					try {
				         
				         conn =ds.getConnection();
				        	
			        	 // 일반회원일때
				         String sql = " UPDATE tbl_member SET ck_u_status = 0, ck_status = 1 WHERE pk_userid = ? ";
				         
				         pstmt = conn.prepareStatement(sql);
				         pstmt.setString(1, userid);
				         
				         result = pstmt.executeUpdate();
				      
				      } catch(Exception e) {
				         e.printStackTrace();   
				      } finally {
				         close();
				      }
					
					return result;
				}
				
				
				// 쿠폰삭제하기
				@Override
				public int couponDelete() throws SQLException {
					
					int result = 0;
					
					try {
				         
				         conn =ds.getConnection();
				        	
			        	 // 쿠폰삭제하기
				         String sql = " update tbl_coupon set CPSTATUS=0 "
				         		    + " where TO_DATE(CENDDATE,'YYYY-MM-DD') < TO_DATE( TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'YYYY-MM-DD')  ";
				         
				         pstmt = conn.prepareStatement(sql);
				         
				         
				         result = pstmt.executeUpdate();
				      
				      } catch(Exception e) {
				         e.printStackTrace();   
				      } finally {
				         close();
				      }
					
					return result;
				}
				
				// 모든 쿠폰 정보 보여주기
				@Override
				public List<CouponVO> couponListInfo() throws SQLException {
					
					List<CouponVO> cpList = new ArrayList<>();
					
					try {
				         conn =ds.getConnection();
				         
				         String sql = " select rownum, PK_COUPON_ID, CNAME, CPRICE, CDATE, CSTARTDATE, CENDDATE, CPSTATUS, CMINPRICE "
			         		 + " from tbl_coupon "
			         		 + "  order by CPSTATUS desc , CENDDATE  ";
					         		
					         		
				         pstmt = conn.prepareStatement(sql);
				         
				         rs=pstmt.executeQuery();
				         
				         while(rs.next()) {
				        	 
				        	 CouponVO cvo = new CouponVO();
				        	 cvo.setRno(rs.getString(1));
				        	 cvo.setCouponid(rs.getString(2));
				        	 cvo.setCname(rs.getString(3));
				        	 cvo.setCprice(rs.getString(4));
				        	 cvo.setCdate(rs.getString(5));
				        	 cvo.setCstartdate(rs.getString(6));
				        	 cvo.setCenddate(rs.getString(7));
				        	 cvo.setCpstatus(rs.getString(8));
				        	 cvo.setCminprice(rs.getString(9));
				        	 
				        	 cpList.add(cvo);
				         }
				      
				      } catch(Exception e) {
				         e.printStackTrace();   
				      } finally {
				         close();
				      }
					
					return cpList;
					
				}

				
				// 마이페이지 주문처리현황 1단계
				@Override
				public int deliverStep1(String userid) throws SQLException {
					
					int step1 = 0;
					
					try {
						conn = ds.getConnection();
						
						 String sql = " select count(*) "
							 		+ "from tbl_orderdetail D "
							 		+ "join tbl_order O "
							 		+ "on D.fk_odrcode = O.pk_odrcode "
							 		+ "join tbl_member M "
							 		+ "on M.pk_userid = O.fk_userid "
							 		+ "where D.CK_DELIVERSTATUS = '1' and M.pk_userid=?  ";
				         
				         pstmt = conn.prepareStatement(sql);
				        
				         pstmt.setString(1, userid);
						
				         rs = pstmt.executeQuery();
				         
				         if( rs.next()) {
				        	 step1 = rs.getInt(1);
				         }
						
					} catch(Exception e) { 
					    e.printStackTrace();	
					} finally {
						close();
					}
					
					return step1;
					
				}

				// 마이페이지 주문처리현황 2단계
				@Override
				public int deliverStep2(String userid) throws SQLException {
					int step2 = 0;
					
					try {
						conn = ds.getConnection();
						
						 String sql = " select count(*) "
							 		+ "from tbl_orderdetail D "
							 		+ "join tbl_order O "
							 		+ "on D.fk_odrcode = O.pk_odrcode "
							 		+ "join tbl_member M "
							 		+ "on M.pk_userid = O.fk_userid "
							 		+ "where D.CK_DELIVERSTATUS = '2' and M.pk_userid=?  ";
				         
				         pstmt = conn.prepareStatement(sql);
				        
				         pstmt.setString(1, userid);
						
				         rs = pstmt.executeQuery();
				         
				         if( rs.next()) {
				        	 step2 = rs.getInt(1);
				         }
						
					} catch(Exception e) { 
					    e.printStackTrace();	
					} finally {
						close();
					}
					
					return step2;
				}

				// 마이페이지 주문처리현황 3단계
				@Override
				public int deliverStep3(String userid) throws SQLException {
					int step3 = 0;
					
					try {
						conn = ds.getConnection();
						
						 String sql = " select count(*) "
							 		+ "from tbl_orderdetail D "
							 		+ "join tbl_order O "
							 		+ "on D.fk_odrcode = O.pk_odrcode "
							 		+ "join tbl_member M "
							 		+ "on M.pk_userid = O.fk_userid "
							 		+ "where D.CK_DELIVERSTATUS = '3' and M.pk_userid=?  ";
				         
				         pstmt = conn.prepareStatement(sql);
				        
				         pstmt.setString(1, userid);
						
				         rs = pstmt.executeQuery();
				         
				         if( rs.next()) {
				        	 step3 = rs.getInt(1);
				         }
						
					} catch(Exception e) { 
					    e.printStackTrace();	
					} finally {
						close();
					}
					
					return step3;
				}

				// 마이페이지 주문처리현황 4단계
				@Override
				public int deliverStep4(String userid) throws SQLException {
					int step4 = 0;
					
					try {
						conn = ds.getConnection();
						
						 String sql = " select count(*) "
							 		+ "from tbl_orderdetail D "
							 		+ "join tbl_order O "
							 		+ "on D.fk_odrcode = O.pk_odrcode "
							 		+ "join tbl_member M "
							 		+ "on M.pk_userid = O.fk_userid "
							 		+ "where D.CK_DELIVERSTATUS = '4' and M.pk_userid=?  ";
				         
				         pstmt = conn.prepareStatement(sql);
				        
				         pstmt.setString(1, userid);
						
				         rs = pstmt.executeQuery();
				         
				         if( rs.next()) {
				        	 step4 = rs.getInt(1);
				         }
						
					} catch(Exception e) { 
					    e.printStackTrace();	
					} finally {
						close();
					}
					
					return step4;
				}

				// 마이페이지 주문처리현황 5단계
				@Override
				public int deliverStep5(String userid) throws SQLException {
					int step5 = 0;
					
					try {
						conn = ds.getConnection();
						
						 String sql = " select count(*) "
							 		+ "from tbl_orderdetail D "
							 		+ "join tbl_order O "
							 		+ "on D.fk_odrcode = O.pk_odrcode "
							 		+ "join tbl_member M "
							 		+ "on M.pk_userid = O.fk_userid "
							 		+ "where D.CK_DELIVERSTATUS = '5' and M.pk_userid=?  ";
				         
				         pstmt = conn.prepareStatement(sql);
				        
				         pstmt.setString(1, userid);
						
				         rs = pstmt.executeQuery();
				         
				         if( rs.next()) {
				        	 step5 = rs.getInt(1);
				         }
						
					} catch(Exception e) { 
					    e.printStackTrace();	
					} finally {
						close();
					}
					return step5;
				}
				
				
				
				// 마이페이지 지금까지 구매한 내역 조회하기
				@Override
				public int allPrice(String userid) throws SQLException {
					int allPrice = 0;
					
					try {
						conn = ds.getConnection();
						
						 String sql = " select sum(odr_price) "
							 		+ " from tbl_orderdetail D "
							 		+ " join tbl_order O "
							 		+ " on D.fk_odrcode = O.pk_odrcode "
							 		+ " join tbl_member M "
							 		+ " on M.pk_userid = O.fk_userid "
							 		+ " where M.pk_userid=? ";
					         
				         pstmt = conn.prepareStatement(sql);
				        
				         pstmt.setString(1, userid);
						
				         rs = pstmt.executeQuery();
				         
				         if( rs.next()) {
				        	 allPrice = rs.getInt(1);
				         }
						
					} catch(Exception e) { 
					    e.printStackTrace();	
					} finally {
						close();
					}
					
					return allPrice;
				}

				
				// 마이페이지 지금까지 구매한 횟수 조회하기
				@Override
				public int allOdrCount(String userid) throws SQLException {
					int allcount = 0;
					
					try {
						conn = ds.getConnection();
						
						 String sql = " select count(*) "
							 		+ " from tbl_order O "
							 		+ " join tbl_member M "
							 		+ " on M.pk_userid = O.fk_userid "
							 		+ " where M.pk_userid=? ";
					         
				         pstmt = conn.prepareStatement(sql);
				        
				         pstmt.setString(1, userid);
						
				         rs = pstmt.executeQuery();
				         
				         if( rs.next()) {
				        	 allcount = rs.getInt(1);
				         }
						
					} catch(Exception e) { 
					    e.printStackTrace();	
					} finally {
						close();
					}
					
					return allcount;
				}

				
				// 마이페이지 사용가능한 마일리지 금액 조회
				@Override
				public int useMileage(String userid) throws SQLException {
					int mileage = 0;
					
					try {
						conn = ds.getConnection();
						
						 String sql = " select sum(mileageInfo) "
							 		+ " from tbl_mileage I "
							 		+ " join tbl_member M "
							 		+ " on M.pk_userid = I.fk_userid "
							 		+ " join tbl_order O "
							 		+ " on I.fk_odrcode = O.pk_odrcode "
							 		+ " where m.pk_userid = ? ";
					         
				         pstmt = conn.prepareStatement(sql);
				        
				         pstmt.setString(1, userid);
						
				         rs = pstmt.executeQuery();
				         
				         if( rs.next()) {
				        	 mileage = rs.getInt(1);
				         }
						
					} catch(Exception e) { 
					    e.printStackTrace();	
					} finally {
						close();
					}
					
					return mileage;
				}

				
				// 마일리지조회를 페이징처리 해주기 전체개수 알아오기 //
				@Override
				public int totalMileageCount(Map<String, String> paraMap) throws SQLException {
					
					int totalCount = 0;
					
					try {
						 conn = ds.getConnection();
						 
						 String sql = " select count(*) "
							 		+ " from tbl_mileage A join tbl_order B "
							 		+ " on A.FK_ODRCODE = B.PK_ODRCODE "
							 		+ " join tbl_orderdetail C "
							 		+ " on B.PK_ODRCODE = C.FK_ODRCODE "
							 		+ " join TBL_PRODUCT D "
							 		+ " on D.PK_PRO_NUM = C.FK_PRO_NUM "
							 		+ " where B.fk_userid= ? ";
						 
						 
						 
						 pstmt = conn.prepareStatement(sql);
						 pstmt.setString(1, paraMap.get("userid"));
						 
						 rs = pstmt.executeQuery();
						 
						 rs.next();
						 
						 totalCount = rs.getInt(1);
						 
					} finally {
						close();
					}
					
					return totalCount;
				}

				
				// 마일리지사용내역 전체조회
				@Override
				public List<Map<String, String>> selectMileageListAll(Map<String, String> paraMap) throws SQLException {
					
					List<Map<String, String>> mileageList = new ArrayList<>();
					
					try {
						 conn = ds.getConnection();
						 
						 String sql = " select MILEAGEINFO, FK_ODRCODE, PRO_NAME, ODR_DATE "
							 		+ " from  "
							 		+ " ( "
							 		+ " select row_number() over(order by ODR_DATE  desc) AS RNO, "
							 		+ " MILEAGEINFO, A.FK_ODRCODE, PRO_NAME, ODR_DATE "
							 		+ " from tbl_mileage A join tbl_order B "
							 		+ " on A.FK_ODRCODE = B.PK_ODRCODE "
							 		+ " join tbl_orderdetail C "
							 		+ " on B.PK_ODRCODE = C.FK_ODRCODE "
							 		+ " join TBL_PRODUCT D "
							 		+ " on D.PK_PRO_NUM = C.FK_PRO_NUM "
							 		+ " where B.fk_userid= ? "
							 		+ " )V "
							 		+ " where V.RNO between ? and ? ";
							 
						 pstmt = conn.prepareStatement(sql);
						 
						 pstmt.setString(1, paraMap.get("userid"));
						 pstmt.setString(2, paraMap.get("start"));
						 pstmt.setString(3, paraMap.get("end"));
						 
						 rs = pstmt.executeQuery();
						 
						 while(rs.next()) {
							 
							 Map<String, String> map = new HashMap<>();
							 
							 map.put("MILEAGEINFO", rs.getString(1));
							 map.put("ODRCODE", rs.getString(2));
							 map.put("PRO_NAME", rs.getString(3));
							 map.put("ODR_DATE", rs.getString(4));
							 
							 mileageList.add(map);
						
						 }// end of while(rs.next())-------------------------------
						 
					} finally {
						close();
					}
					
					return mileageList;
					
				}

				
				// 페이징되어진 전체 마일리지 내역 조회
				@Override
				public List<Map<String, String>> selectPagingmileage(Map<String, String> paraMap) throws SQLException {
					
					List<Map<String, String>> mileageList = new ArrayList<>();
			  		
			  		try {
			  			conn = ds.getConnection();
			  			
			  			String sql = " select MILEAGEINFO, FK_ODRCODE, PRO_NAME, to_char(ODR_DATE, 'yyyy-MM-dd') "
				  				   + " from  "
				  				   + " ( "
				  				   + " select row_number() over(order by ODR_DATE  desc) AS RNO, "
			  					   + " MILEAGEINFO, A.FK_ODRCODE, PRO_NAME, ODR_DATE "
			  					   + " from tbl_mileage A join tbl_order B "
			  					   + " on A.FK_ODRCODE = B.PK_ODRCODE "
			  					   + " join tbl_orderdetail C "
			  					   + " on B.PK_ODRCODE = C.FK_ODRCODE "
			  					   + " join TBL_PRODUCT D "
			  					   + " on D.PK_PRO_NUM = C.FK_PRO_NUM "
			  					   + " where B.fk_userid= ? and mileageinfo != '0' and mileageinfo != '-0' "
			  					   + " )V "
			  					   + " where V.RNO between ? and ? ";
			  						
			  							
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
			  		
			  				pstmt.setString(1, paraMap.get("userid"));
			  				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
			  				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			  			
			  				rs = pstmt.executeQuery();
			  			
			  				while(rs.next()){
			  					
			  					Map<String,String> map = new HashMap<>();
			  					
			  					map.put("MILEAGEINFO", rs.getString(1));
			  					map.put("ODRCODE", rs.getString(2));
			  					map.put("PRO_NAME", rs.getString(3));
			  					map.put("ODR_DATE", rs.getString(4));
			  					
			  					mileageList.add(map);
			  					
			  				} // end of while
			  		
			  			} catch(Exception  e) { 
			  			    e.printStackTrace();	
			  			} finally {
			  				close();
			  			}
			  				return mileageList;
			  		}
				
				// 페이징 처리를 위한 마일리지에 대한 총페이지 알아오기. 
				@Override
				public int getMileageTotalPage(Map<String, String> paraMap) throws SQLException {
					
					int totalPage = 0;
			  		
			  		try {
			  			conn = ds.getConnection();
			  			
			  			String sql  = " select ceil(count(*)/?) "
				  					+ " from tbl_mileage A join tbl_order B "
				  					+ " on A.FK_ODRCODE = B.PK_ODRCODE "
				  					+ " join tbl_orderdetail C "
				  					+ " on B.PK_ODRCODE = C.FK_ODRCODE "
				  					+ " join TBL_PRODUCT D "
				  					+ " on D.PK_PRO_NUM = C.FK_PRO_NUM "
				  					+ " where B.fk_userid= ?  and mileageinfo != '0' and mileageinfo != '-0'  ";
			  			
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

				// 페이징되어진 전체 마일리지 내역 조회2
				@Override
				public List<Map<String, String>> selectPagingmileage2(Map<String, String> paraMap) throws SQLException {
					List<Map<String, String>> mileageList = new ArrayList<>();
			  		
			  		try {
			  			conn = ds.getConnection();
			  			
			  			String sql = " select MILEAGEINFO, FK_ODRCODE, PRO_NAME, to_char(ODR_DATE, 'yyyy-MM-dd') "
				  				   + " from  "
				  				   + " ( "
				  				   + " select row_number() over(order by ODR_DATE  desc) AS RNO, "
			  					   + " MILEAGEINFO, A.FK_ODRCODE, PRO_NAME, ODR_DATE "
			  					   + " from tbl_mileage A join tbl_order B "
			  					   + " on A.FK_ODRCODE = B.PK_ODRCODE "
			  					   + " join tbl_orderdetail C "
			  					   + " on B.PK_ODRCODE = C.FK_ODRCODE "
			  					   + " join TBL_PRODUCT D "
			  					   + " on D.PK_PRO_NUM = C.FK_PRO_NUM "
			  					   + " where B.fk_userid= ? and MILEAGEINFO > 0 "
			  					   + " )V "
			  					   + " where V.RNO between ? and ? ";
			  						
			  							
			  			pstmt = conn.prepareStatement(sql);
			  			
			  			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo2") );
			  			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage2") );
			  			
			  			/*
			  			  	where rno between A and B
			  	            >>> A 와 B를 구하는 공식 <<<
			  	            
			  	            currentShowPageNo 은 보고자하는 페이지 번호이다. 즉, 1페이지, 2페이지, 3페이지.... 를 말한다.
			  	            sizePerPage는 한페이지당 보여줄 행의 개수를 말한다. 즉, 3개, 5개, 10개를 보여줄때의 개수를 말한다.
			  	            
			  	            
			  	            A는 (currentShowPageNo * sizePerPage) - (sizePerPage - 1); 이다.
			  	            B는 (currentShowPageNo * sizePerPage); 이다.
			  			*/
			  		
			  				pstmt.setString(1, paraMap.get("userid"));
			  				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
			  				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			  			
			  				rs = pstmt.executeQuery();
			  			
			  				while(rs.next()){
			  					
			  					Map<String,String> map = new HashMap<>();
			  					
			  					map.put("MILEAGEINFO", rs.getString(1));
			  					map.put("ODRCODE", rs.getString(2));
			  					map.put("PRO_NAME", rs.getString(3));
			  					map.put("ODR_DATE", rs.getString(4));
			  					
			  					mileageList.add(map);
			  					
			  				} // end of while
			  		
			  			} catch(Exception  e) { 
			  			    e.printStackTrace();	
			  			} finally {
			  				close();
			  			}
			  				return mileageList;
				}

				// 페이징되어진 전체 마일리지 내역 조회3
				@Override
				public List<Map<String, String>> selectPagingmileage3(Map<String, String> paraMap) throws SQLException {
					List<Map<String, String>> mileageList = new ArrayList<>();
			  		
			  		try {
			  			conn = ds.getConnection();
			  			
			  			String sql = " select MILEAGEINFO, FK_ODRCODE, PRO_NAME, to_char(ODR_DATE, 'yyyy-MM-dd') "
				  				   + " from  "
				  				   + " ( "
				  				   + " select row_number() over(order by ODR_DATE  desc) AS RNO, "
			  					   + " MILEAGEINFO, A.FK_ODRCODE, PRO_NAME, ODR_DATE "
			  					   + " from tbl_mileage A join tbl_order B "
			  					   + " on A.FK_ODRCODE = B.PK_ODRCODE "
			  					   + " join tbl_orderdetail C "
			  					   + " on B.PK_ODRCODE = C.FK_ODRCODE "
			  					   + " join TBL_PRODUCT D "
			  					   + " on D.PK_PRO_NUM = C.FK_PRO_NUM "
			  					   + " where B.fk_userid= ? and MILEAGEINFO < 0 "
			  					   + " )V "
			  					   + " where V.RNO between ? and ? ";
			  						
			  							
			  			pstmt = conn.prepareStatement(sql);
			  			
			  			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo3") );
			  			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage3") );
			  			
			  			/*
			  			  	where rno between A and B
			  	            >>> A 와 B를 구하는 공식 <<<
			  	            
			  	            currentShowPageNo 은 보고자하는 페이지 번호이다. 즉, 1페이지, 2페이지, 3페이지.... 를 말한다.
			  	            sizePerPage는 한페이지당 보여줄 행의 개수를 말한다. 즉, 3개, 5개, 10개를 보여줄때의 개수를 말한다.
			  	            
			  	            
			  	            A는 (currentShowPageNo * sizePerPage) - (sizePerPage - 1); 이다.
			  	            B는 (currentShowPageNo * sizePerPage); 이다.
			  			*/
			  		
			  				pstmt.setString(1, paraMap.get("userid"));
			  				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
			  				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			  			
			  				rs = pstmt.executeQuery();
			  			
			  				while(rs.next()){
			  					
			  					Map<String,String> map = new HashMap<>();
			  					
			  					map.put("MILEAGEINFO", rs.getString(1));
			  					map.put("ODRCODE", rs.getString(2));
			  					map.put("PRO_NAME", rs.getString(3));
			  					map.put("ODR_DATE", rs.getString(4));
			  					
			  					mileageList.add(map);
			  					
			  				} // end of while
			  		
			  			} catch(Exception  e) { 
			  			    e.printStackTrace();	
			  			} finally {
			  				close();
			  			}
			  				return mileageList;
				}

				@Override
				public int getMileageTotalPage2(Map<String, String> paraMap) throws SQLException {
					int totalPage = 0;
			  		
			  		try {
			  			conn = ds.getConnection();
			  			
			  			String sql  = " select ceil(count(*)/?) "
				  					+ " from tbl_mileage A join tbl_order B "
				  					+ " on A.FK_ODRCODE = B.PK_ODRCODE "
				  					+ " join tbl_orderdetail C "
				  					+ " on B.PK_ODRCODE = C.FK_ODRCODE "
				  					+ " join TBL_PRODUCT D "
				  					+ " on D.PK_PRO_NUM = C.FK_PRO_NUM "
				  					+ " where B.fk_userid= ?  and MILEAGEINFO > 0  ";
			  			
			  			pstmt = conn.prepareStatement(sql);
			  			pstmt.setString(1, paraMap.get("sizePerPage2"));
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
			  		return totalPage;				}

				@Override
				public int getMileageTotalPage3(Map<String, String> paraMap) throws SQLException {
					int totalPage = 0;
			  		
			  		try {
			  			conn = ds.getConnection();
			  			
			  			String sql  = " select ceil(count(*)/?) "
				  					+ " from tbl_mileage A join tbl_order B "
				  					+ " on A.FK_ODRCODE = B.PK_ODRCODE "
				  					+ " join tbl_orderdetail C "
				  					+ " on B.PK_ODRCODE = C.FK_ODRCODE "
				  					+ " join TBL_PRODUCT D "
				  					+ " on D.PK_PRO_NUM = C.FK_PRO_NUM "
				  					+ " where B.fk_userid= ? and MILEAGEINFO < 0   ";
			  			
			  			pstmt = conn.prepareStatement(sql);
			  			pstmt.setString(1, paraMap.get("sizePerPage3"));
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
			
////////////////////////////////////////////////////////////////////////////////////////////////
				
	            // 내 주문내역 조회 
	            @Override
	            public List<Map<String, String>> orderInfo (Map<String, Object> paraMap) throws SQLException {
	               
	               List<Map<String, String>> orderInfoList = new ArrayList<>(); 
	               
	               try {
	                  
	                  conn = ds.getConnection();
	                  
	                  String sql = " select O.fk_userid , to_char(O.odr_date , 'yyyy-MM-dd') , C.cate_name, P.pro_imgfile_name , P.pro_name , G.ck_odr_totalqty, O.odr_totalprice , D.delivername "
	                        + " from tbl_order O "
	                        + " join tbl_orderdetail G "
	                        + " on o.pk_odrcode = g.fk_odrcode "
	                        + " join tbl_product P "
	                        + " on G.fk_pro_num = P.pk_pro_num "
	                        + " join tbl_category C "
	                        + " on C.pk_cate_num = P.fk_cate_num "
	                        + " join tbl_deliverstatus D "
	                        + " on G.ck_deliverstatus = D.deliverstatus "
	                        + " where O.fk_userid = ? "
	                        + " and O.odr_date  between ? and ? ";
	                  
	                        if( paraMap.get("status").toString() == "0") {
	                           sql += "and d.deliverstatus between '0' and '6'"
	                              + " order by odr_date DESC ";
	                        }
	                        else {
	                           sql += "and d.deliverstatus = ? "
	                              + " order by odr_date DESC ";
	                        }
	                  
	                        
	                    pstmt = conn.prepareStatement(sql);
	                    
	                    pstmt.setString(1, paraMap.get("userid").toString());
	                    
	                    // if( paraMap.get("fromDate").toString().equals(null) || paraMap.get("toDate").toString().equals( null ) ) {
	                    if( paraMap.get("fromDate") == null || paraMap.get("toDate") == null  ) {    
	                       pstmt.setString(2, paraMap.get("lastMonth_three").toString());
	                       pstmt.setString(3, paraMap.get("today").toString());
	                       
	                    }
	                    else {
	                       
	                       pstmt.setString(2, paraMap.get("fromDate").toString());
	                       pstmt.setString(3, paraMap.get("toDate").toString());
	                    }
	                    
	                    
	                    
	                    if( paraMap.get("status").toString() != "0") {
	                       pstmt.setString(4, paraMap.get("status").toString());
	                  }
	                    
	                  
	                    
	                    rs = pstmt.executeQuery();
	                    
	                    while( rs.next()) {
	                       Map<String, String> map = new HashMap<>();
	                       
	                       map.put("userid" , rs.getString(1));
	                       map.put("odr_date" , rs.getString(2));
	                       map.put("cate_name" , rs.getString(3));
	                       map.put("pro_imgfile_name" , rs.getString(4));
	                       map.put("pro_name" , rs.getString(5));
	                       map.put("ck_odr_totalqty" , rs.getString(6));
	                       map.put("odr_totalprice" , rs.getString(7));
	                       map.put("delivername" , rs.getString(8));
	                       
	                       orderInfoList.add(map);
	                    }
	                  
	               } catch(Exception e) { 
	                   e.printStackTrace();   
	               } finally {
	                  close();
	               }
	               
	               return orderInfoList;
	            }

	            
	            // 페이징 처리를 위한 전체회원에 대한 총페이지 알아오기 
	            @Override
	            public int getOrderInfoTotalPage(Map<String, Object> paraMap) throws SQLException {
	               
	               int OrderInfototalPage = 0;
	                 
	                 try {
	                    conn = ds.getConnection();
	                    
	                    String sql  = " select ceil(count(*)/?) "
	                          + " from  "
	                          + " ( "
	                          + " select O.fk_userid , to_char(O.odr_date , 'yyyy-MM-dd') , C.cate_name, P.pro_imgfile_name , P.pro_name , G.ck_odr_totalqty, O.odr_totalprice , D.delivername "
	                          + " from tbl_order O "
	                          + " join tbl_orderdetail G "
	                          + " on o.pk_odrcode = g.fk_odrcode "
	                          + " join tbl_product P "
	                          + " on G.fk_pro_num = P.pk_pro_num "
	                          + " join tbl_category C "
	                          + " on C.pk_cate_num = P.fk_cate_num "
	                          + " join tbl_deliverstatus D "
	                          + " on G.ck_deliverstatus = D.deliverstatus "
	                          + " where O.fk_userid = ? "
	                          + " and O.odr_date  between ? and ? ";
	                       
	                          if( paraMap.get("status").toString() == "0") {
	                           sql += "and d.deliverstatus between '0' and '6'"
	                              + " order by odr_date DESC )";
	                        }
	                        else {
	                           sql += "and d.deliverstatus = ? "
	                              + " order by odr_date DESC )";
	                        }
	                    
	              pstmt = conn.prepareStatement(sql);
	              
	              pstmt.setString(1, (String) paraMap.get("sizePerPage"));
	              
	              pstmt.setString(2, paraMap.get("userid").toString());
	              
	              // if( paraMap.get("fromDate").toString().equals(null) || paraMap.get("toDate").toString().equals( null ) ) {
	              if( paraMap.get("fromDate") == null || paraMap.get("toDate") == null  ) {    
	                 pstmt.setString(3, paraMap.get("lastMonth_three").toString());
	                 pstmt.setString(4, paraMap.get("today").toString());
	              }
	              else {
	                 pstmt.setString(3, paraMap.get("fromDate").toString());
	                 pstmt.setString(4, paraMap.get("toDate").toString());
	              }
	              
	              
	              if( paraMap.get("status").toString() != "0") {
	                 pstmt.setString(5, paraMap.get("status").toString());
	            }
	                    
	              rs = pstmt.executeQuery();
	                    
	                  if(rs.next()) {
	                    OrderInfototalPage = rs.getInt(1);
	                    }
	                    
	                 } catch (SQLException e) {
	                       e.printStackTrace();
	                 } finally {
	                    close();
	                 }
	                 return OrderInfototalPage;
	            }

	            // 페이징 처리를 위한 목록 불러오기
	            @Override
	            public List<Map<String, String>> selectPagingOrderInfo(Map<String, Object> paraMap) {
	               
	               List<Map<String, String>> orderInfoPageList = new ArrayList<>(); 
	               
	               try {
	                  
	                  conn = ds.getConnection();
	                  
	                  String sql = " select fk_userid , odr_date , cate_name, pro_imgfile_name , pro_name , ck_odr_totalqty, odr_totalprice , delivername "
	                        + " from "
	                        + " ( "
	                        + " select row_number() over(order by O.ODR_DATE  desc) as rno, O.fk_userid , to_char(O.odr_date , 'yyyy-MM-dd') as odr_date , C.cate_name, P.pro_imgfile_name , P.pro_name , G.ck_odr_totalqty, O.odr_totalprice , D.delivername "
	                        + " from tbl_order O "
	                        + " join tbl_orderdetail G "
	                        + " on o.pk_odrcode = g.fk_odrcode "
	                        + " join tbl_product P "
	                        + " on G.fk_pro_num = P.pk_pro_num "
	                        + " join tbl_category C "
	                        + " on C.pk_cate_num = P.fk_cate_num "
	                        + " join tbl_deliverstatus D "
	                        + " on G.ck_deliverstatus = D.deliverstatus "
	                        + " where O.fk_userid = ? "
	                        + " and O.odr_date  between ? and ? ";
	                        
	                  
	                        if( paraMap.get("status").toString() == "0") {
	                           sql += "and d.deliverstatus between '0' and '6'"
	                              + " order by odr_date DESC ";
	                        }
	                        else {
	                           sql += "and d.deliverstatus = ? "
	                              + " order by odr_date DESC ";
	                        }
	                  
	                        sql +=  " )V "
	                              + " where V.rno between ? and ? ";
	                    
	                     
	                        
	                    pstmt = conn.prepareStatement(sql);
	                    
	                    int currentShowPageNo = Integer.parseInt((String) paraMap.get("currentShowPageNo") );
	                    int sizePerPage = Integer.parseInt((String) paraMap.get("sizePerPage") );   
	                    
	                    
	                    pstmt.setString(1, paraMap.get("userid").toString());
	                    
	                    // if( paraMap.get("fromDate").toString().equals(null) || paraMap.get("toDate").toString().equals( null ) ) {
	                    if( paraMap.get("fromDate") == null || paraMap.get("toDate") == null  ) {    
	                       pstmt.setString(2, paraMap.get("lastMonth_three").toString());
	                       pstmt.setString(3, paraMap.get("today").toString());
	                    }
	                    else {
	                       pstmt.setString(2, paraMap.get("fromDate").toString());
	                       pstmt.setString(3, paraMap.get("toDate").toString());
	                    }
	                    
	                    
	                    if( paraMap.get("status").toString() != "0") {
	                       pstmt.setString(4, paraMap.get("status").toString());
	                       
	                       pstmt.setInt(5, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
	                       pstmt.setInt(6, (currentShowPageNo * sizePerPage));
	                       
	                  }
	                    else {
	                       pstmt.setInt(4, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
	                       pstmt.setInt(5, (currentShowPageNo * sizePerPage));
	                    }
	                  
	                    
	                    rs = pstmt.executeQuery();
	                    
	                    while( rs.next()) {
	                       Map<String, String> map = new HashMap<>();
	                       
	                       map.put("userid" , rs.getString(1));
	                       map.put("odr_date" , rs.getString(2));
	                       map.put("cate_name" , rs.getString(3));
	                       map.put("pro_imgfile_name" , rs.getString(4));
	                       map.put("pro_name" , rs.getString(5));
	                       map.put("ck_odr_totalqty" , rs.getString(6));
	                       map.put("odr_totalprice" , rs.getString(7));
	                       map.put("delivername" , rs.getString(8));
	                       
	                       orderInfoPageList.add(map);
	                    }
	                  
	               } catch(Exception e) { 
	                   e.printStackTrace();   
	               } finally {
	                  close();
	               }
	               
	               return orderInfoPageList;
	            }
				


			

}
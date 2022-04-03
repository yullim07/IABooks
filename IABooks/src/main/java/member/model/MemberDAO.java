package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
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
                "       birthday, mileage, registerday, pwdchangegap, tel, "+
                "       nvl(lastlogingap, trunc( months_between(sysdate, registerday) ) ) AS lastlogingap "+
                " FROM "+
                " ( "+
                " select pk_userid, mname, uq_email, uq_phone, postcode, address, detailaddress, extraaddress, ck_gender "+
                "     , birthday , mileage , tel, to_char(registerday, 'yyyy-mm-dd') AS registerday "+
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
             member.setMileage(rs.getInt(11));
             member.setRegisterday(rs.getString(12));
             member.setTel(rs.getString(14));
             
             if(rs.getInt(13) >= 3) {
                // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
               // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false
               
               member.setRequirePwdChange(true); // 로그인시 암호를 변경해라는 alert 를 띄우도록 할때 사용한다. 
             }
             
             if(rs.getInt(15) >= 12) {
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
	         
	             isUserExist = pstmt.execute();
	             
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
	                       + "                     , lastpwdchangedate = sysdate "
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
		

}
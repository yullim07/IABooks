package member.model;

import java.sql.SQLException;
import java.util.Map;

public interface InterMemberDAO {

   

   // ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
   boolean idDuplicateCheck(String userid) throws SQLException;
   
   // email 중복검사 (tbl_member 테이블에서 email 가 존재하면 true를 리턴해주고, email 가 존재하지 않으면 false를 리턴한다)
   boolean emailDuplicateCheck(String email) throws SQLException;
   
   // 회원가입을 해주는 메소드(tbl_member 테이블에 insert)
   int registerMember(MemberVO member) throws SQLException;

   // 입력받은 paraMap을 가지고 한명의 회원정보를 리턴시켜주는 메소드(로그인 처리)
   MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException;

   // 성명과 이메일을 입력 받아서 해당 사용자에 아이디를 알려주는 메소드(아이디 찾기) 
   String findUserid(Map<String, String> paraMap) throws SQLException;

   // 아이디와 이메일을 입력받아서 해당 사용자가 존재하는지 유무를 알려주는 메소드(비밀번호 찾기)
//   boolean isUserExist(Map<String, String> paraMap) throws SQLException;

   // 암호 변경하기 메소드
//   int pwdUpdate(Map<String, String> paraMap) throws SQLException;
   
   
}
package member.model;

import java.sql.SQLException;
import java.util.List;
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

   // 회원정보 수정하기
   int updateMember(MemberVO member) throws SQLException;

   // 회원 탈퇴하기
   int memberDelete(Map<String, String> paraMap) throws SQLException;
   
   // 성명과 이메일을 입력 받아서 해당 사용자에 아이디를 알려주는 메소드(아이디 찾기) 
   String findUserid(Map<String, String> paraMap, int select) throws SQLException;

   // 아이디와 이메일을 입력받아서 해당 사용자가 존재하는지 유무를 알려주는 메소드(비밀번호 찾기)
   boolean isUserExist(Map<String, String> paraMap,  int select) throws SQLException;

   // 암호 변경하기 메소드
   int pwdUpdate(Map<String, String> paraMap) throws SQLException;

   	// 쿠폰등록을 해주는 메소드
	int couponRegister(CouponVO coupon) throws SQLException;
	
	// 쿠폰 기간만료시 삭제하는 메소드
	int deleteCouponList(Map<String, String> paraMap);

	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 쿠폰에 대한 총페이지 알아오기. 
	int getTotalPage(Map<String, String> paraMap) throws SQLException;
	
	// 페이징 처리가된 쿠폰 리스트를 가져오기 
	List<CouponVO> selectPagingCouponList(Map<String, String> paraMap) throws SQLException;

	// 유저에게 쿠폰등록
	int UserCouponStatus(UserCouponStatusVO userCouponStatus) throws SQLException;

	// 회원이 가지고 있는 쿠폰 개수 알아오기
	int CouponNum(Map<String, String> paraMap) throws SQLException;

	// 쿠폰만료기간 지나면 사용막기 
	int expireCoupon(Map<String, String> paraMap) throws SQLException;
	
	// 쿠폰번호 중복 발행을 막는 메소드
	String randDuplicateCheck(String couponNumber) throws SQLException;
	
	// 쿠폰등록시 개인이 쿠폰을 가지고 있는지 확인하는 용도
	boolean couponDuplicateCheck(Map<String, String> paraMap) throws SQLException;
	
	// 쿠폰등록시 이상한 쿠폰번호 쓰는 거 막기
	boolean CPDuplicateCheck(Map<String, String> paraMap) throws SQLException;
  
/////////////////////////////////////////////// 파일 합치기
	
	// 아이디를 입력받아서 해당 사용자의 마일리지액 조회
	int mgCheck(Map<String, String> paraMap) throws SQLException;

	
   
   
   
}
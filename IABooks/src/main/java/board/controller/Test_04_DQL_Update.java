package board.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Test_04_DQL_Update {

	public static void main(String[] args) {
		
		Connection conn = null;
		// Connection conn 은 오라클 데이터베이스 서버와 연결을 맺어주는 객체 
		
		PreparedStatement pstmt = null;
		// PreparedStatement pstmt 은 Connection conn(연결할 오라클 서버)에 전송할 SQL문(편지)을 전달할 객체(우편배달부)이다.
		
		ResultSet rs = null;
		// ResultSet rs 는 select 되어진 결과물이 저장되어지는 곳.
		
		Scanner sc = new Scanner(System.in);
		
		try {
			// >>> 1. 오라클 드라이버 로딩 <<<  //
	        /*
	           === OracleDriver(오라클 드라이버)의 역할 ===
	           1). OracleDriver 를 메모리에 로딩시켜준다.
	           2). OracleDriver 객체를 생성해준다.
	           3). OracleDriver 객체를 DriverManager에 등록시켜준다.
	               --> DriverManager 는 여러 드라이버들을 Vector 에 저장하여 관리해주는 클래스이다.
	        */ 
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// >>> 2. 어떤 오라클 서버와 연결을 할래? <<< //
			String ip = "211.238.142.70";
			
			conn = DriverManager.getConnection("jdbc:oracle:thin:@"+ip+":1521:xe", "semiorauser3", "cclass");
			
						

				System.out.println("\n=== 글 수정하기 ===");
				System.out.print(" ▷ 글쓴이 : ");
				String name = sc.nextLine();
				System.out.print(" ▷ 글내용 : ");
				String msg = sc.nextLine();
				System.out.print(" ▷ 바꿀 글쓴이 : ");
				String userid =sc.nextLine();
				
				String sql = " update test_board set userid = ? "
						+ "                        , contents = ? "
						+ " where userid = ? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, name);
					pstmt.setString(2, msg);
					pstmt.setString(3, userid);
					
				
				int n = pstmt.executeUpdate(); // no 는 항상 1이 나옴. Primary Key 이기 때문에.
				
				System.out.println("n : " + n);
				
			
		} catch (ClassNotFoundException e) {
			System.out.println(">> ojdbc6.jar 파일이 없습니다. << ");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			/// >>> 6. 사용하였던 자원을 반납하기 <<< //
			// 반납의 순서는 생성순서의 역순으로 한다.
			
			try {
				if(rs != null) {
					rs.close();
				}
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				} // 이렇게 해야 Exception 에러가 뜨지 않음.
			} catch (SQLException e) {
				
			}
			
		}
        
        
        
        sc.close();
        System.out.println("~~~ 프로그램 종료 ~~~");

	}

}

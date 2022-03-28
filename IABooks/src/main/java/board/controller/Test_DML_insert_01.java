package board.controller;

import java.sql.*;
import java.util.Scanner;

public class Test_DML_insert_01 {

	public static void main(String[] args) {
		
		Connection conn = null;
		// Connection conn 은 오라클 데이터베이스 서버와 연결을 맺어주는 객체 
		
		PreparedStatement pstmt = null;
		// PreparedStatement pstmt 은 Connection conn(연결할 오라클 서버)에 전송할 SQL문(편지)을 전달할 객체(우편배달부)이다.
		
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
			
			// >>> 3. SQL문(편지) 을 작성한다. <<< //
			System.out.print("▷ 글쓴이 : ");
			String userid = sc.nextLine(); // SQL 컬럼명과 일치시키는게 좋음.
			
			System.out.print("▷ 글내용 : ");
			String msg = sc.nextLine(); 
			
			String sql = " insert into test_board(userid, contents) "+
					     " values(?, ?) ";
			
			// >>> 4. 연결한 오라클서버(conn)에 SQL문(편지)을 전달할 PreparedStatement 객체(우편배달부) 생성하기 <<< //
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid); // 1 은 String sql 에서 첫번째 위치홀더(?)를 말한다. 첫번째 위치홀더(?)에 name 을 넣어준다.
			// '1' 번째 위치홀더에 'name'을 넣겠다.
			pstmt.setString(2, msg);
			// '2' 번째 위치홀더에 'msg' 를 넣겠다.
			
			System.out.println("SQL 문장 : " + sql);
			
			// >>> 5. PreparedStatement pstmt 객체(우편배달부)는 작성된 SQL문(편지)을 오라클 서버에 보내서 실행이 되도록 해야 한다 <<< //
						int n = pstmt.executeUpdate();
						/*  .executeUpdate(); 은 SQL문이 DML문(insert, update, delete, merge) 이거나 
			            						 SQL문이 DDL문(create, drop, alter, truncate) 일 경우에 사용된다. 

						SQL문이 DML문이라면 return 되어지는 값은 적용되어진 행의 개수를 리턴시켜준다.
						예를 들어, insert into ... 하면 1 개행이 입력되므로 리턴값은 1 이 나온다. 
						 update ... 할 경우에 update 할 대상의 행의 개수가 5 이라면 리턴값은 5 가 나온다. 
						 delete ... 할 경우에 delete 되어질 대상의 행의 개수가 3 이라면 리턴값은 3 가 나온다.
						 
						SQL문이 DDL문이라면 return 되어지는 값은 무조건 0 이 리턴된다.       
						
						.executeQuery(); 은 SQL문이 DQL문(select) 일 경우에 사용된다.
						*/
						
						System.out.println("n : " + n);

						
					} catch (ClassNotFoundException e) {
						System.out.println(">> ojdbc6.jar 파일이 없습니다. << ");
					} catch (SQLException e) {
						e.printStackTrace();
					} finally {
						/// >>> 6. 사용하였던 자원을 반납하기 <<< //
						// 반납의 순서는 생성순서의 역순으로 한다.
						
						try {
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

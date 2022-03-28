package board.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Test_DQL_select_02 {

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
			
			System.out.println("찾을 내용 : ");
			String contents = sc.nextLine();
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// >>> 2. 어떤 오라클 서버와 연결을 할래? <<< //
			String ip = "211.238.142.70";
			
			conn = DriverManager.getConnection("jdbc:oracle:thin:@"+ip+":1521:xe", "semiorauser3", "cclass");
			
			
			// >>> 3. SQL문(편지) 을 작성한다. <<< //\

			
			String sql = " select * "+
						 " from test_board " +
						 " where contents = ? ";
			// Java에서 SQL로 넘어갈 때 공백을 주지 않으면 그대로 이어져서 실행이 되지 않음 (ex AS writedayfrom 으로 되서 실행X)

			
		
			
			
			// >>> 4. 연결한 오라클서버(conn)에 SQL문(편지)을 전달할 PreparedStatement 객체(우편배달부) 생성하기 <<< //
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, contents);
			
			// >>> 5. PreparedStatement pstmt 객체(우편배달부)는 작성된 SQL문(편지)을 오라클 서버에 보내서 실행이 되도록 해야 한다 <<< //
			rs = pstmt.executeQuery();
			/* SQL문이 DQL(select) 문이므로 .executeQuery();이다.
				pstmt.executeQuery(); 을 실행하면 select 되어진 결과물을 가져오는데 그 타입은 ResultSet 으로 가져온다.
			*/
			
			
			/*
            === 인터페이스 ResultSet 의 주요한 메소드 ===
            1. next()  : select 되어진 결과물에서 커서를 다음으로 옮겨주는 것             리턴타입은 boolean 
            2. first() : select 되어진 결과물에서 커서를 가장 처음으로 옮겨주는 것       리턴타입은 boolean
            3. last()  : select 되어진 결과물에서 커서를 가장 마지막으로 옮겨주는 것    리턴타입은 boolean
            
            == 커서가 위치한 행에서 컬럼의 값을 읽어들이는 메소드 ==
            getInt(숫자) : 컬럼의 타입이 숫자이면서 정수로 읽어들이때
                           파라미터 숫자는 컬럼의 위치값 
                          
            getInt(문자) : 컬럼의 타입이 숫자이면서 정수로 읽어들이때
                           파라미터 문자는 컬럼명 또는 alias명 
                           
            getLong(숫자) : 컬럼의 타입이 숫자이면서 정수로 읽어들이때
                              파라미터 숫자는 컬럼의 위치값 
                          
            getLong(문자) : 컬럼의 타입이 숫자이면서 정수로 읽어들이때
                              파라미터 문자는 컬럼명 또는 alias명                
            
            getFloat(숫자) : 컬럼의 타입이 숫자이면서 실수로 읽어들이때
                               파라미터 숫자는 컬럼의 위치값 
                          
            getFloat(문자) : 컬럼의 타입이 숫자이면서 실수로 읽어들이때
                               파라미터 문자는 컬럼명 또는 alias명 
                               
            getDouble(숫자) : 컬럼의 타입이 숫자이면서 실수로 읽어들이때
                                 파라미터 숫자는 컬럼의 위치값 
                          
            getDouble(문자) : 컬럼의 타입이 숫자이면서 실수로 읽어들이때
                                 파라미터 문자는 컬럼명 또는 alias명    
                                 
            getString(숫자) : 컬럼의 타입이 문자열로 읽어들이때
                                 파라미터 숫자는 컬럼의 위치값 
                          
            getString(문자) : 컬럼의 타입이 문자열로 읽어들이때
                                 파라미터 문자는 컬럼명 또는 alias명                                                        
			 */
			
			System.out.println("---------------------------------------------------------------------------");
			System.out.println("글쓴이\t글내용");
			System.out.println("---------------------------------------------------------------------------");
			
			StringBuilder sb = new StringBuilder();
			
			while(rs.next()) {
				/*
	               rs.next() 는 select 되어진 결과물에서 위치(행의 위치)를 다음으로 옮긴 후 
	                 행이 존재하면 true 를 리턴해주고, 행이 없으면 false 를 리턴해주는 메소드이다.
	            */
				
				/*
				int no = rs.getInt("NO"); // "NO" 는 select 해온 컬럼명이다. 
				String name = rs.getString("NAME"); // "NAME" 는 select 해온 컬럼명이다. 
				String msg = rs.getString("MSG"); // "MSG" 는 select 해온 컬럼명이다. 
				String writeday = rs.getString("WRITEDAY"); // "WRITEDAY" 는 select 해온 컬럼명이다. 
				*/
				// 또는 
				
				String name = rs.getString(1); //  1 는 select 해온 두번째 컬럼명이다. 
				String msg = rs.getString(2); //  2 은 select 해온 세번째 컬럼명이다. 
				
				sb.append(name);
				sb.append("\t"+msg+"\n");
				
				
			} // end of while ------------------------------------------------
			
			System.out.println(sb.toString());
			
			
			
			
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

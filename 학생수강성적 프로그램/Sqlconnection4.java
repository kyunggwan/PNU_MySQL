package sql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

// SQL 관련 클래스는 java.sql .*에 포함되어 있다.
public class Sqlconnection4 {
	Connection con;

// 클래스 list를 선언한다. java.sql의 Connection 객체 con을 선언한다.  	
	public Sqlconnection4() {
		String Driver = "";
		// DB에 연결
		String url = "jdbc:mysql://localhost:3306/pnusw13";
		String userid = "musthave";
		String pwd = "tiger";

// 접속변수를 초기화한다. url은 자바 드라이버 이름, 호스트명(localhost), 포트번호를 입력한다
// userid는 관리자, pwd는 사용자의 비밀번호를 입력한다.    
		try { /* 드라이버를 찾는 과정 */
			Class.forName("com.mysql.cj.jdbc.Driver");

			System.out.println("드라이버 로드 성공");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
// Class.forName()으로 드라이버를 로딩한다. 드라이버 이름을 Class.forName에 입력한다.      
		try { /* 데이터베이스를 연결하는 과정 */
			System.out.println("데이터베이스 연결 준비...");
			con = DriverManager.getConnection(url, userid, pwd);
			System.out.println("데이터베이스 연결 성공");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 전체 목록 조회 메소드 구현
	private void select() {
		System.out.println("[조회할 테이블을 고르세요]");
		System.out.println("1. [전체 테이블]");
		System.out.println("2. [학생 테이블]");
		System.out.println("3. [강좌 테이블]");
		System.out.println("4. [학부 테이블]");
		System.out.println("5. [성적 테이블]");
		System.out.println("0. [목차]로 돌아가기");
		System.out.println("");

		Scanner s = new Scanner(System.in);
		int choice = s.nextInt();
		while (true) {
			switch (choice) {
			case 1:
				System.out.println("\t[학생수강성적]");
				System.out.println("\t[학생번호]\t[학생이름]\t[주소]\t[학과]\t[학과사무실]\t[강좌이름]\t[강의실]\t[성적]");
				String query = "select 학생.학생번호, 학생.학생이름, 학생.주소, 학부.학과, 학부.학과사무실, 강좌.강좌이름, 강좌.강의실, 성적 \r\n"
						+ "from 학생 학생, 학부 학부, 강좌 강좌, 성적 성적\r\n" + "where 학생.학과 = 학부.학과\r\n"
						+ "and 학생.학생번호 = 성적.학생_학생번호\r\n" + "and 성적.강좌_강좌이름 = 강좌.강좌이름;";
				try {
					/* 데이터베이스에 질의 결과를 가져오는 과정 */
					Statement stmt = con.createStatement();
					ResultSet rs = stmt.executeQuery(query);
					while (rs.next()) {
						System.out.print("\t" + rs.getInt(1));
						System.out.print("\t" + rs.getString(2));
						System.out.print("\t" + rs.getString(3));
						System.out.print("\t" + rs.getString(4));
						System.out.print("\t" + rs.getString(5));
						System.out.print("\t" + rs.getString(6));
						System.out.print("\t" + rs.getString(7));
						System.out.print("\t" + rs.getDouble(8));
						System.out.println("");
					}

				} catch (SQLException e) {
					e.printStackTrace();
				}

				break;
			case 2:
				System.out.println("\t[학생 테이블]");
				String query2 = "SELECT * FROM 학생"; /* SQL 문 */
				try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
					Statement stmt = con.createStatement();
					ResultSet rs = stmt.executeQuery(query2);
					System.out.println("\t[학생번호]\t[학생이름]\t[주소]\t[학과] ");
					while (rs.next()) {
						System.out.print("\t" + rs.getInt(1));
						System.out.print("\t" + rs.getString(2));
						System.out.print("\t" + rs.getString(3));
						System.out.print("\t" + rs.getString(4));
						System.out.println("");
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;

			case 3:
				System.out.println("\t[강좌 테이블]");
				String query3 = "SELECT * FROM 강좌"; /* SQL 문 */
				try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
					Statement stmt = con.createStatement();
					ResultSet rs = stmt.executeQuery(query3);
					System.out.println("\t[강좌이름] \t[강의실]");
					while (rs.next()) {
						System.out.print("\t" + rs.getString(1));
						System.out.print("\t" + rs.getString(2));
						System.out.println("");
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}

				break;

			case 4:
				System.out.println("\t[학부 테이블]");
				String query4 = "SELECT * FROM 학부"; /* SQL 문 */
				try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
					Statement stmt = con.createStatement();
					ResultSet rs = stmt.executeQuery(query4);
					System.out.println("\t[학과]\t[학과사무실] ");
					while (rs.next()) {
						System.out.print("\t" + rs.getString(1));
						System.out.print("\t" + rs.getString(2));
						System.out.println("");
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;

			case 5:
				System.out.println("\t[성적 테이블]");
				String query5 = "SELECT * FROM 성적"; /* SQL 문 */
				try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
					Statement stmt = con.createStatement();
					ResultSet rs = stmt.executeQuery(query5);
					System.out.println("\t[학생번호]\t[강좌이름]\t[성적] ");
					while (rs.next()) {
						System.out.print("\t" + rs.getInt(1));
						System.out.print("\t" + rs.getString(2));
						System.out.print("\t" + rs.getString(3));
						System.out.println("");
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;

			case 0:
				System.out.println("[목차로 돌아갑니다]");
				break;

			default:
				System.out.println("[다시 입력하세요]");
				break;
			}
			break;
		}
	}

	// CRUD메소드 구현
	// 추가 메소드
	private void insert() {
		System.out.println("[데이터를 추가할 테이블을 고르세요]");
		System.out.println("1. 학생에 데이터 추가");
		System.out.println("2. 강좌에 데이터 추가");
		System.out.println("3. 학부에 데이터 추가");
		System.out.println("4. 성적에 데이터 추가");
		System.out.println("0. [목차]로 돌아가기");
		System.out.println("");

		Scanner s = new Scanner(System.in);
		Scanner sc = new Scanner(System.in);
		int choice = s.nextInt();
		while (true) {
			switch (choice) {
			case 1:
				System.out.print("[새로운 학생 등록]학생번호를 입력하세요 : ");
				int code = sc.nextInt();
				System.out.print("[새로운 학생 등록]학생이름을 입력하세요 : ");
				String name = sc.next();
				System.out.print("[새로운 학생 등록]주소를 입력하세요 : ");
				String address = sc.next();
				System.out.print("[새로운 학생 등록]학생의 전공 입력하세요(**주의 [학부]테이블의 [학과]중에서 입력해야합니다**) : ");
				String major = sc.next();
				// CallableStatment로 insert 프로시저 호출
				try {
					CallableStatement cs = con.prepareCall("{ call insert학생(?, ?, ?, ?)}");
					cs.setInt(1, code);
					cs.setString(2, name);
					cs.setString(3, address);
					cs.setString(4, major);
					cs.execute();
				} catch (

				SQLException e) {
					e.printStackTrace();
				}

				break;

			case 2:
				System.out.print("추가할 강좌이름을 입력하세요 : ");
				String lecture = sc.next();
				System.out.print("추가할 강의실을 입력하세요 : ");
				String room = sc.next();
				// CallableStatment로 insert 프로시저 호출
				try {
					CallableStatement cs = con.prepareCall("{ call insert강좌(?, ?)}");
					cs.setString(1, lecture);
					cs.setString(2, room);
					cs.execute();
				} catch (

				SQLException e) {
					e.printStackTrace();
				}

				break;

			case 3:
				System.out.print("추가할 학과를 입력하세요 : ");
				String major1 = sc.next();
				System.out.print("추가할 학과사무실 입력하세요 : ");
				String center = sc.next();
				// CallableStatment로 insert 프로시저 호출
				try {
					CallableStatement cs = con.prepareCall("{ call insert학부(?, ?)}");
					cs.setString(1, major1);
					cs.setString(2, center);
					cs.execute();
				} catch (

				SQLException e) {
					e.printStackTrace();
				}
				break;

			case 4:
				System.out.print("추가할 학생번호를 입력하세요 : ");
				int stu = sc.nextInt();
				System.out.print("추가할 강좌이름을 입력하세요 : ");
				String lec = sc.next();
				System.out.print("추가할 성적을 입력하세요 : ");
				String record = sc.next();
				// CallableStatment로 insert 프로시저 호출
				try {
					CallableStatement cs = con.prepareCall("{ call insert성적(?, ?, ?)}");
					cs.setInt(1, stu);
					cs.setString(2, lec);
					cs.setString(3, record);
					cs.execute();
				} catch (

				SQLException e) {
					e.printStackTrace();
				}
				break;

			case 0:
				System.out.println("[목차로 돌아갑니다]");
				break;

			default:
				System.out.println("[다시 입력하세요]");
				break;
			}
			break;
		}
	}

	// 수정 메소드
	private void update() {
		System.out.println("[데이터를 수정할 테이블을 고르세요]");
		System.out.println("1. 학생 수정");
		System.out.println("2. 강좌 수정");
		System.out.println("3. 학부 수정");
		System.out.println("4. 성적 수정");
		System.out.println("0. [목차]로 돌아가기");
		System.out.println("");

		Scanner s = new Scanner(System.in);
		Scanner sc = new Scanner(System.in);
		int choice = sc.nextInt();

		while (true) {
			switch (choice) {
			case 1:
				System.out.print("[학생 데이터 수정]학생 번호를 입력하세요 : ");
				int updateCode = s.nextInt();
				System.out.print("[학생 데이터 수정]이름을 입력하세요 : ");
				String updateName = s.next();
				System.out.print("[학생 데이터 수정]주소를 입력하세요 : ");
				String updateAddress = s.next();
				System.out.print("[학생 데이터 수정]학생의 전공 입력하세요(**주의 [학부]테이블의 [학과]중에서 입력해야합니다**) : ");
				String updateMajor = s.next();

				// CallableStatment로 update프로시저 호출
				try {
					CallableStatement cs = con.prepareCall("{ call update학생(?,?,?,?)}");
					cs.setInt(1, updateCode);
					cs.setString(2, updateName);
					cs.setString(3, updateAddress);
					cs.setString(4, updateMajor);
					cs.execute();

				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;
			case 2:

				System.out.print("[강좌 데이터 수정]수정할 강좌이름을 입력하세요 : ");
				String updateLecture = s.next();
				System.out.print("[강좌 데이터 수정]강의실 입력하세요 : ");
				String updateRoom = s.next();

				// CallableStatment로 update프로시저 호출
				try {
					CallableStatement cs = con.prepareCall("{ call update강좌(?,?)}");
					cs.setString(1, updateLecture);
					cs.setString(2, updateRoom);
					cs.execute();

				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;

			case 3:
				System.out.print("[학부 데이터 수정]수정할 학과를 입력하세요 : ");
				String updateMajor1 = s.next();
				System.out.print("[학부 데이터 수정]수정할 학과사무실 입력하세요 : ");
				String updateCenter = s.next();

				// CallableStatment로 update프로시저 호출
				try {
					CallableStatement cs = con.prepareCall("{ call update학부(?,?)}");
					cs.setString(1, updateMajor1);
					cs.setString(2, updateCenter);
					cs.execute();

				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;

			case 4:
				System.out.print("[성적 데이터 수정]수정할 학생 번호를 입력하세요 : ");
				int updateStu = s.nextInt();
				System.out.print("[성적 데이터 수정]수정할 강좌이름을 입력하세요 : ");
				String updateLec = s.next();
				System.out.print("[성적 데이터 수정]수정할 성적을 입력하세요 : ");
				String updateGrade = s.next();

				// CallableStatment로 update프로시저 호출
				try {
					CallableStatement cs = con.prepareCall("{ call update성적(?,?,?)}");
					cs.setInt(1, updateStu);
					cs.setString(2, updateLec);
					cs.setString(3, updateGrade);
					cs.execute();

				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;

			case 0:
				System.out.println("[목차로 돌아갑니다]");
				break;

			default:
				System.out.println("[다시 입력하세요]");
				break;
			}
			break;
		}
	}

	// 삭제 메소드
	private void delete() {
		System.out.println("[데이터를 삭제할 테이블을 고르세요]");
		System.out.println("1. 학생 데이터 삭제");
		System.out.println("2. 강좌 데이터 삭제");
		System.out.println("3. 학부 데이터 삭제");
		System.out.println("4. 성적 데이터 삭제");
		System.out.println("0. [목차]로 돌아가기");
		System.out.println("");

		Scanner s = new Scanner(System.in);
		Scanner delete = new Scanner(System.in);
		int choice = s.nextInt();

		while (true) {
			switch (choice) {

			case 1:
				System.out.print("[학생 데이터 삭제]삭제할 학생번호를 입력하세요 : ");
				int deleteCode = delete.nextInt();
				// CallableStatment로 delete프로시저 호출
				try {
					CallableStatement cs = con.prepareCall("{ call delete학생(?)}");
					cs.setInt(1, deleteCode);
					cs.execute();

				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;

			case 2:
				System.out.print("[강좌 데이터 삭제]삭제할 강좌명을 입력하세요 : ");
				String deleteLecture = delete.next();

				// CallableStatment로 delete프로시저 호출
				try {
					CallableStatement cs = con.prepareCall("{ call delete강좌(?)}");
					cs.setString(1, deleteLecture);
					cs.execute();

				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;

			case 3:
				System.out.print("[학부 데이터 삭제]삭제할 학부를 입력하세요 : ");
				String deleteMajor = delete.next();

				// CallableStatment로 delete프로시저 호출
				try {
					CallableStatement cs = con.prepareCall("{ call delete학부(?)}");
					cs.setString(1, deleteMajor);
					cs.execute();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;

			case 4:
				System.out.print("[성적 데이터 삭제]성적을 삭제할 학생번호를 입력하세요 : ");
				int deleteStu = delete.nextInt();
				System.out.print("[성적 데이터 삭제]성적을 삭제할 과목을 입력하세요 :");
				String deleteLec = delete.next();

				// CallableStatment로 delete프로시저 호출
				try {
					CallableStatement cs = con.prepareCall("{ call delete성적(?, ?)}");
					cs.setInt(1, deleteStu);
					cs.setString(2, deleteLec);
					cs.execute();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				break;

			case 0:
				System.out.println("[목차로 돌아갑니다]");
				break;

			default:
				System.out.println("[다시 입력하세요]");
				break;
			}
			break;
		}
	}

	public static void main(String args[]) {

		Sqlconnection4 sq = new Sqlconnection4();
		Scanner s = new Scanner(System.in);
		int choice;

		while (true) {
			System.out.println("★★★학생수강성적 데이터베이스 시스텝입니다★★★");
			System.out.println("\t[목차]");
			System.out.println("1. 데이터 목록 다시보기");
			System.out.println("2. 데이터 추가하기");
			System.out.println("3. 데이터 수정하기");
			System.out.println("4. 데이터 삭제하기");
			System.out.println("0. 프로그램 종료하기");
			choice = s.nextInt();
			switch (choice) {
			case 1:
				sq.select();
				break;
			case 2:
				sq.insert();
				break;
			case 3:
				sq.update();
				break;
			case 4:
				sq.delete();
				break;
			case 0:
				System.out.println("[프로그램을 종료합니다]");
				System.exit(0);
				break;

			default:
				System.out.println("[다시 입력하세요]");
				break;
			}
		}
	}
}
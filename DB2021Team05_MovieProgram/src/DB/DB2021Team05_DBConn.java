package DB;

import java.sql.*;
public class DB2021Team05_DBConn {
	private static Connection conn = null; //���� ��Ų���� ����ٰ� �����Ѵ�. 
	private DB2021Team05_DBConn () {};
	public static Connection getConnection() {
		if(conn==null) {
	        try{
	            //1. ����̹� �ε� : mysql ����̹� �ε�
	           Class.forName("com.mysql.cj.jdbc.Driver"); 
	            //����̹����� �����⸸ �ϸ� �ڵ� ��ü�� �����ǰ� DriverManager�� ��ϵȴ�.
	 
	            //2. mysql�� �����Ű��
	            String url = "jdbc:mysql://localhost:3306/DB2021Team05?allowPublicKeyRetrieval=true";

	            conn = DriverManager.getConnection(url, "DB2021Team05", "DB2021Team05");
	            System.out.println("Successfully Connection!");
	        }
	 
	        catch(ClassNotFoundException e){
	            System.out.println("Failed because of not loading driver");
	        }
	        catch(SQLException e){
	            System.out.println("error : " + e);
	        }
		}
        return conn;
		
	}
}

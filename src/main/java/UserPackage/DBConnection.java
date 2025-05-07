package UserPackage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	private static String url = "jdbc:mysql://localhost:3306/videobrowsing";
	private static String user = "root";
	private static String pass = "Abi0021@";
	private static Connection con;
	
	public static Connection getConnection() throws SQLException {
		try {
			if (con == null || con.isClosed()) {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(url, user, pass);
				System.out.println("Database connection established successfully!");
			}
		} catch (ClassNotFoundException e) {
			System.err.println("MySQL JDBC Driver not found: " + e.getMessage());
			throw new SQLException("Database driver not found", e);
		} catch (SQLException e) {
			System.err.println("Database connection failed: " + e.getMessage());
			throw e;
		}
		return con;
	}
		

}

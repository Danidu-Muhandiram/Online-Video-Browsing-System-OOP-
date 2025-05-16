package UserPackage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Logger;
import java.util.logging.Level;

public class DBConnection {
	private static final Logger logger = Logger.getLogger(DBConnection.class.getName());
	private static String url = "jdbc:mysql://localhost:3306/videobrowsing?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
	private static String user = "root";
	private static String pass = "Abi0021@";
	private static Connection con;
	
	static {
		try {
			// Try to load the driver
			Class.forName("com.mysql.cj.jdbc.Driver");
			logger.info("MySQL JDBC Driver loaded successfully");
		} catch (ClassNotFoundException e) {
			logger.log(Level.SEVERE, "MySQL JDBC Driver not found. Please ensure mysql-connector-java-8.0.33.jar is in WEB-INF/lib", e);
		}
	}
	
	public static Connection getConnection() throws SQLException {
		try {
			if (con == null || con.isClosed()) {
				con = DriverManager.getConnection(url, user, pass);
				logger.info("Database connection established successfully!");
			}
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "Database connection failed", e);
			throw e;
		}
		return con;
	}
	
	public static void closeConnection() {
		if (con != null) {
			try {
				con.close();
				logger.info("Database connection closed successfully!");
			} catch (SQLException e) {
				logger.log(Level.WARNING, "Error closing database connection", e);
			}
		}
	}
}

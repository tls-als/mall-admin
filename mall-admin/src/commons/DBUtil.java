package commons;
import java.sql.*;

public class DBUtil {
	public Connection getConnection() throws Exception {
		String Driver = "org.mariadb.jdbc.Driver";
		String dbaddr = "jdbc:mariadb://localhost:3306/mall";	// localhost : 127.0.0.1
		String dbid = "root";
		String dbpw = "java1004";
		Class.forName(Driver);
		Connection conn = DriverManager.getConnection(dbaddr,dbid,dbpw);
		return conn;
	}
}

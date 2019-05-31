package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBOpen {
	
	public static Connection open() {
		Connection con = null;
		
		try {
			Class.forName(Constant.DRIVER);	// create constant '~' in constant type
			
			try {
				con = DriverManager.getConnection(Constant.URL, Constant.USER, Constant.PASSWORD);
			} catch (SQLException e) {
				e.printStackTrace();
			}	// 순서 => url, user, password
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	// create class constant
		return con;
	}
}

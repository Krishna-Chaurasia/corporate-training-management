package com.ctp;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnect {

	public static Connection conn;

	public static Connection getConn() {

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");
			 conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false",
					"root", "mysql");
		}

		catch (Exception e) {

			e.printStackTrace();
		}

		return conn;
	}

}

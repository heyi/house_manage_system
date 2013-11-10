package com.xt.test;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class TestSqlJdbc {
	public static void main(String[] args) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar c = Calendar.getInstance();
		System.out.println(c.get(Calendar.HOUR_OF_DAY) + ":"
				+ c.get(Calendar.MINUTE));

		try {
			java.util.Date date = sdf.parse("2013-4-8 15:30:22");
			System.out.println(date + ":" + date.getTime() + ":" + System.currentTimeMillis());
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		// Create a variable for the connection string.
		String connectionUrl = "jdbc:mysql://localhost:3306/fw";

		// Declare the JDBC objects.
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			// Establish the connection.
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(connectionUrl, "root", "wlz_1226");

			// Create and execute an SQL statement that returns some data.
			String SQL = "SELECT * FROM tb_user_info";
			stmt = con.createStatement();
			rs = stmt.executeQuery(SQL);

			// Iterate through the data in the result set and display it.
			while (rs.next()) {
				System.out.println(rs.getString(4) + " " + rs.getString(6));
			}
		}

		// Handle any errors that may have occurred.
		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			if (rs != null)
				try {
					rs.close();
				} catch (Exception e) {
				}
			if (stmt != null)
				try {
					stmt.close();
				} catch (Exception e) {
				}
			if (con != null)
				try {
					con.close();
				} catch (Exception e) {
				}
		}
	}
}

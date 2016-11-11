package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import bean.Cart;

public class MySqlJDBC implements DatabaseConstants {

	private static Connection conn = null;
	private static Statement stmt = null;
	private static String sqlQuery = "";

	public MySqlJDBC() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public Cart getUserCart(String userid){

		Cart cart = new Cart();
		ArrayList<String> productList = new ArrayList<String>();

		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "select * from Cart where UID = '" + userid + "'";
			ResultSet rs = stmt.executeQuery(sqlQuery);

			while(rs.next()){
				productList.add(rs.getString("PID"));
			}
			cart.setProductList(productList);
			cart.setUserId(userid);
			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}

		return cart;
	}

	public boolean doesUserExists(String email) {

		boolean ret = false;
		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "select * from User where Email = '" + email + "'";
			ResultSet rs = stmt.executeQuery(sqlQuery);
			//Fetch user data from result set.
			while(rs.next()){
				ret = true;
				break;
			}

			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
		return ret;
	}

	public boolean matchPassword(String email, String pass) {

		boolean ret = false;
		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "select Password from User where Email = '" + email + "'";
			ResultSet rs = stmt.executeQuery(sqlQuery);

			while(rs.next()){
				System.out.println(rs.getString("Password") + " " + pass);
				if(rs.getString("Password").equals(pass)){
					ret = true;
					break;
				}
			}

			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
		return ret;
	}

	public void insertUser(String username, String password, String email, String address, String role, String phone){

		Date date = new Date();
		DateFormat format = new SimpleDateFormat("ddMMyyHHmmSS"); 
		String uid = format.format(date);

		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			String insertUser = "Insert into user(UID, UserName, Password, Type, Email, PhoneNumber, Address) values('" + uid + "', '" + username + "', '" + 
													 password + "', '" + role + "', '" + email + "', '" + phone +"', '" + address + "')";

			int i = stmt.executeUpdate(insertUser);

		}catch(Exception e){
			e.printStackTrace();
		}
	}

}

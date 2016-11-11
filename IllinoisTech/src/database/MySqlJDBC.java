package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import java.util.ArrayList;

import bean.Cart;




public class MySqlJDBC implements DatabaseConstants {

	private Connection conn = null;
	private Statement stmt = null;
	private String sqlQuery = "";

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

}

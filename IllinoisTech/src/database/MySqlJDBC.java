package database;

import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MySqlJDBC implements DatabaseConstants {
	
	static java.sql.Connection con = null;
	static PreparedStatement pst ;
	
	public static void insertUser(String username, String password, String email, String address, String role, String phone){
		
		Date date = new Date();
		DateFormat format = new SimpleDateFormat("ddMMyyHHmmSS"); 
		String uid = format.format(date);
		
		try{
			
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/IllinoisTech?autoReconnect=true&useSSL=false", "root", "root");
			
			String insertUser = "Insert into user(UID, UserName, Password, Type, Email, PhoneNumber, Address) values(?, ?, ?, ?, ?, ?, ?);";
			pst = con.prepareStatement(insertUser);

			pst.setString(1, uid);
			pst.setString(2, username);
			pst.setString(3, password);
			pst.setString(4, role);
			pst.setString(5, email);
			pst.setString(6, phone);
			pst.setString(7, address);
			int i = pst.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}

}

package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import bean.Cart;
import bean.Products;
import bean.User;
import bean.Product;

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

	public Cart getUserCart(String userid) {

		Cart cart = new Cart();
		ArrayList<String> productList = new ArrayList<String>();

		try {
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			stmt = conn.createStatement();
			sqlQuery = "select * from Cart where UID = '" + userid + "'";
			ResultSet rs = stmt.executeQuery(sqlQuery);

			while (rs.next()) {
				productList.add(rs.getString("PID"));
			}
			cart.setProductList(productList);
			cart.setUserId(userid);
			// Close db connection.
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return cart;
	}

	public boolean doesUserExists(String email) {

		boolean ret = false;
		try {
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			stmt = conn.createStatement();
			sqlQuery = "select * from User where Email = '" + email + "'";
			ResultSet rs = stmt.executeQuery(sqlQuery);
			// Fetch user data from result set.
			while (rs.next()) {
				ret = true;
				break;
			}

			// Close db connection.
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ret;
	}

	public boolean matchPassword(String email, String pass) {

		boolean ret = false;
		try {
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			stmt = conn.createStatement();
			sqlQuery = "select Password from User where Email = '" + email + "'";
			ResultSet rs = stmt.executeQuery(sqlQuery);

			while (rs.next()) {
				System.out.println(rs.getString("Password") + " " + pass);
				if (rs.getString("Password").equals(pass)) {
					ret = true;
					break;
				}
			}

			// Close db connection.
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ret;
	}

	public void insertUser(String username, String password, String email, String address, String role, String phone) {

		Date date = new Date();
		DateFormat format = new SimpleDateFormat("ddMMyyHHmmSS");
		String uid = format.format(date);

		try {
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			stmt = conn.createStatement();
			String insertUser = "Insert into user(UID, UserName, Password, Type, Email, PhoneNumber, Address) values('"
					+ uid + "', '" + username + "', '" + password + "', '" + role + "', '" + email + "', '" + phone
					+ "', '" + address + "')";

			int i = stmt.executeUpdate(insertUser);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insertProduct(String category, String pid, String rid, String pName, String iPath, String price,String discount,String active) {

		

		try {
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			stmt = conn.createStatement();
			String insertProduct = "Insert into Products(PID, RetailerId, Category, ProductName, ImagePath, Price, Discount,Active) values('"
					+ pid + "', '" + rid + "', '" + category + "', '" + pName + "', '" + iPath + "', '" + price
					+ "', '" + discount + "' ,'" + active + "')";
			System.out.println(insertProduct);

			int i = stmt.executeUpdate(insertProduct);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public User getUserData(String email){

		User user = new User();

		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "select * from user where Email = '" + email + "'";
			ResultSet rs = stmt.executeQuery(sqlQuery);

			while(rs.next()){
				user.setAddress(rs.getString("Address"));
				user.setEmail(email);
				user.setPhonenumber(rs.getString("PhoneNumber"));
				user.setUsername(rs.getString("UserName"));
				user.setRole("customer");
			}
			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
		return user;
	}

	public int completeUserProfile(String phonenumber, String address,
			String email) {

		int i = 0;

		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "update user set Address = '" + address + "', PhoneNumber = '" + phonenumber + "' where email = '" + email + "'";
			System.out.println(sqlQuery);
			i = stmt.executeUpdate(sqlQuery);

			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
		return i;
	}
	

	
public Product getProducts(String productName){
		
		Product productObj = new Product();
	
		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "select * from Products where productname = '" + productName + "'";
			ResultSet rs = stmt.executeQuery(sqlQuery);

			while(rs.next()){
				productObj.setCategory(rs.getString("Category"));
				productObj.setProductname(rs.getString("ProductName"));
				productObj.setImage(rs.getString("ImagePath"));
				productObj.setPrice(rs.getString("Price"));
				productObj.setDiscount("Discount");
			}
			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
		return productObj;
	}

public HashMap<String,Product> getProductList(){
	
	HashMap<String,Product> map =new HashMap<String,Product>();
	Product productObj;

	try{
		conn = DriverManager.getConnection(DB_URL,USER,PASS);
		stmt = conn.createStatement();
		sqlQuery = "select * from Products";
		ResultSet rs = stmt.executeQuery(sqlQuery);
		

		while(rs.next()){
			System.out.println(rs.getString("ProductName"));
			productObj = new Product();
			productObj.setPid(rs.getString("Pid"));
			productObj.setRetailerid(rs.getString("RetailerId"));
			productObj.setCategory(rs.getString("Category"));
			productObj.setProductname(rs.getString("ProductName"));
			productObj.setImage(rs.getString("ImagePath"));
			productObj.setPrice(rs.getString("Price"));
			productObj.setDiscount(rs.getString("Discount"));
			productObj.setActive(rs.getString("Active"));
			//System.out.println(productObj.getProductname() + productObj.getPid());
			map.put(productObj.getPid(),productObj);
		}
		Product prod = new Product();
		for (Map.Entry<String, Product> entry : map.entrySet()) {
	 		prod = entry.getValue();
	 		System.out.println("Product name: " + prod.getProductname() + "Product id: " + prod.getPid());
		}
		
		//Close db connection.
		stmt.close();
		conn.close();
	}catch(SQLException e){
		e.printStackTrace();
	}
	return map;
}

public void updateProducts(String category,String pid,String rid,String pName ,String iPath,String price,String discount,String active) {
	
	int i = 0;
	
	try{
		conn = DriverManager.getConnection(DB_URL,USER,PASS);
		stmt = conn.createStatement();
		sqlQuery = "update products set Category = '" + category + "', Pid = '" + pid + "',"
				+ "RetailerId = '" + rid + "',ProductName = '" + pName + "',"
				+ "ImagePath = '" + iPath + "',Price = '" + price + "',Discount = '" + discount + "',Active ='" + active + "' "
						+ "where ProductName = '" + pName + "'";
		System.out.println(sqlQuery);
		i = stmt.executeUpdate(sqlQuery);

		//Close db connection.
		stmt.close();
		conn.close();
	}catch(SQLException e){
		e.printStackTrace();
	}
	
}

public boolean deleteProduct(String Pid) {
	


	try{
		conn = DriverManager.getConnection(DB_URL,USER,PASS);
		stmt = conn.createStatement();
		sqlQuery = "delete from products where Pid = '"+Pid+"'" ;
		System.out.println(sqlQuery);
		int rs = stmt.executeUpdate(sqlQuery);
		//Close db connection.
		stmt.close();
		conn.close();
		if(rs == 0)
			return false;
		return true;
	}catch(SQLException e){
		e.printStackTrace();
		return false;
	}
	
}

	public static ArrayList<Products> selectProducts(String categ) {


		ArrayList<Products> prodInfo=new ArrayList<Products>();

		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "select * from products where Category = '" + categ + "'";
			ResultSet rs = stmt.executeQuery(sqlQuery);
			while(rs.next()){
				if(!prodInfo.contains(rs.getString(1))){
					
					Products p = new Products(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8));
					
					prodInfo.add(p);

				}
			}
			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}


		return prodInfo;



	}

}

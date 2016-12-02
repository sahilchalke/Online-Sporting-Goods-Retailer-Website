package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import com.mysql.jdbc.PreparedStatement;

import bean.Cart;
import bean.Products;
import bean.Retailer;
import bean.User;

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

	public void insertRetailer(String username, String email){

		Date date = new Date();
		DateFormat format = new SimpleDateFormat("ddMMyyHHmmSS"); 
		String RetailerId = format.format(date);
		String flag="0";
		System.out.println(username + email + RetailerId + flag);
		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			String insertRetailer = "Insert into Retailer(RetailerId, RetailerName, Flag, Email) values('" + RetailerId + "', '" + username + "', '" + flag +
					"', '" + email +  "')";	
			System.out.println( insertRetailer);

			int i = stmt.executeUpdate(insertRetailer);



		}catch(Exception e){
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
			System.out.println(cart.getUserId());
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

		Date date = new Date();
		DateFormat format = new SimpleDateFormat("ddMMyyHHmmSS");
		pid = format.format(date);

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
				user.setUid(rs.getString("Uid"));
				user.setAddress(rs.getString("Address"));
				user.setEmail(email);
				user.setPhonenumber(rs.getString("PhoneNumber"));
				user.setUsername(rs.getString("UserName"));
				user.setRole(rs.getString("Type"));
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


	public Products getProducts(String productName){

		Products productObj = new Products();

		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "select * from Products where productname = '" + productName + "'";
			ResultSet rs = stmt.executeQuery(sqlQuery);

			while(rs.next()){
				productObj.setCategory(rs.getString("Category"));
				productObj.setProductName(rs.getString("ProductName"));
				productObj.setImagePath(rs.getString("ImagePath"));
				productObj.setPrce(rs.getString("Price"));
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

	public HashMap<String,Products> getProductList(){

		HashMap<String,Products> map =new HashMap<String,Products>();
		Products productObj;

		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "select * from Products p inner join retailer r on p.RetailerId = r.RetailerId";
			ResultSet rs = stmt.executeQuery(sqlQuery);


			while(rs.next()){
				System.out.println(rs.getString("ProductName"));
				productObj = new Products();
				productObj.setPid(rs.getString("Pid"));
				productObj.setRetailerId(rs.getString("RetailerId"));
				productObj.setRetailerName(rs.getString("RetailerName"));
				productObj.setCategory(rs.getString("Category"));
				productObj.setProductName(rs.getString("ProductName"));
				productObj.setImagePath(rs.getString("ImagePath"));
				productObj.setPrce(rs.getString("Price"));
				productObj.setDiscount(rs.getString("Discount"));
				productObj.setActive(rs.getString("Active"));
				//System.out.println(productObj.getProductname() + productObj.getPid());
				map.put(productObj.getPid(),productObj);
			}
			Products prod = new Products();
			for (Map.Entry<String, Products> entry : map.entrySet()) {
				prod = entry.getValue();
				System.out.println("Product name: " + prod.getProductName() + "Product id: " + prod.getPid());
			}

			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
		return map;
	}

	public HashMap<String,Products> getRetailerProductList(String rid){

		HashMap<String,Products> map =new HashMap<String,Products>();
		Products productObj;
		String temp= "2311161613492";
		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "select * from Products p inner join retailer r on p.RetailerId = r.RetailerId  AND r.RetailerId = '" + rid + " ' ";
			ResultSet rs = stmt.executeQuery(sqlQuery);


			while(rs.next()){
				System.out.println(rs.getString("ProductName"));
				productObj = new Products();
				productObj.setPid(rs.getString("Pid"));
				productObj.setRetailerId(rs.getString("RetailerId"));
				productObj.setRetailerName(rs.getString("RetailerName"));
				productObj.setCategory(rs.getString("Category"));
				productObj.setProductName(rs.getString("ProductName"));
				productObj.setImagePath(rs.getString("ImagePath"));
				productObj.setPrce(rs.getString("Price"));
				productObj.setDiscount(rs.getString("Discount"));
				productObj.setActive(rs.getString("Active"));
				//System.out.println(productObj.getProductname() + productObj.getPid());
				map.put(productObj.getPid(),productObj);
			}
			Products prod = new Products();
			for (Map.Entry<String, Products> entry : map.entrySet()) {
				prod = entry.getValue();
				System.out.println("Product name: " + prod.getProductName() + "Product id: " + prod.getPid());
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
					+ "where Pid = '" + pid + "'";
			System.out.println(sqlQuery);
			i = stmt.executeUpdate(sqlQuery);
			System.out.println("Update: " + i);

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


	public ArrayList<Products> selectProducts(String categ) {


		ArrayList<Products> prodInfo=new ArrayList<Products>();

		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "select * from products p inner join retailer r on p.RetailerId = r.RetailerId where p.Category = '" + categ + "'";
			ResultSet rs = stmt.executeQuery(sqlQuery);
			while(rs.next()){
				if(!prodInfo.contains(rs.getString(1))){

					Products p = new Products(rs.getString(1), rs.getString(2), rs.getString(10), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8));
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

	public ArrayList<Products> selectRetailerProducts(String categ, String rid) {


		ArrayList<Products> prodInfo=new ArrayList<Products>();
		String temp = "1611161609508";

		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "select * from products p inner join retailer r on p.RetailerId = r.RetailerId where p.Category = '" + categ + "' AND r.RetailerId = '" + rid + "'";
			ResultSet rs = stmt.executeQuery(sqlQuery);
			while(rs.next()){
				if(!prodInfo.contains(rs.getString(1))){

					Products p = new Products(rs.getString(1), rs.getString(2), rs.getString(10), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8));
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

	public HashMap<String, Products> getCartProdFromDB(Cart cart){

		HashMap<String, Products> cartMap = new HashMap<String, Products>();
		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			System.out.println("userId" + cart.getUserId());
			sqlQuery = "select * from products p inner join retailer r on p.RetailerId = r.RetailerId where p.pid in (select pid from cart where uid = '" + cart.getUserId() + "')";
			ResultSet rs = stmt.executeQuery(sqlQuery);
			while(rs.next()){
				Products p = new Products(rs.getString(1), rs.getString(2), rs.getString(10), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8));
				cartMap.put(p.getPid(), p);
			}
			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
		return cartMap;
	}

	public void removeProductFromCart(String prodId, String userId){

		try{

			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "delete from cart where pid = '" + prodId + "' and uid = '" + userId + "';";
			int i = stmt.executeUpdate(sqlQuery);
			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}

	public Products getProductFromId(String prodid){

		Products productObj = new Products();

		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "select * from Products p inner join retailer r on p.RetailerId = r.RetailerId where p.pid = '" + prodid + "'";
			ResultSet rs = stmt.executeQuery(sqlQuery);

			while(rs.next()){
				productObj.setCategory(rs.getString("Category"));
				productObj.setProductName(rs.getString("ProductName"));
				productObj.setImagePath(rs.getString("ImagePath"));
				productObj.setPrce(rs.getString("Price"));
				productObj.setDiscount(rs.getString("Discount"));
				productObj.setPid(rs.getString("pid"));
				productObj.setRetailerId(rs.getString("RetailerId"));
				productObj.setRetailerName(rs.getString("RetailerName"));
			}
			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
		return productObj;
	}

	public void addProductToCart(String prodId, String userId){

		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "insert into cart (pid, uid) values('"+ prodId + "', '" + userId + "');";
			int i = stmt.executeUpdate(sqlQuery);
			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}


	public static HashMap query2(HashMap<String,Integer> topOrderedProducts) {

		try {
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			String topProdcuts = "select p.productname, o.pid, count(*) as count from products p inner join orders o on p.pid=o.oid group "
					+ "by o.pid order by count desc;";
			PreparedStatement pst = (PreparedStatement) conn.prepareStatement(topProdcuts);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Integer count = rs.getInt("count");
				String pName = rs.getString("productname");
				topOrderedProducts.put(pName,count);
			}

		} catch (Exception e) {
		}
		return topOrderedProducts;
	}


	public void addCreditCart(String uid, String ccnumber, String name, String cvv, String exp, String billadd){

		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "insert into cart (UID, CreditCardNumber, NameOnCard, CVV, ExpiryDate, BillingAddress)"
					+ "values('"+ uid + "', '" + ccnumber + ", "+ name +", " + cvv +", " + exp + ", " + billadd + "');";
			int i = stmt.executeUpdate(sqlQuery);
			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}

	public void addOrders(String oid, String pid, String quantity, String warranty, String price){

		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "insert into orders (oid, pid, quantity, warranty, price)"
					+ "values('"+ oid + "', '" + pid + "', '"+ quantity +"', '" + warranty +"', '" + price + "');";
			System.out.println(sqlQuery);
			int i = stmt.executeUpdate(sqlQuery);
			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}

	public void insertInvoice(String oid,String uid,  String cc, String total, String delDate, String purDate, String shipAdd){

		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "insert into invoice (OID, UID, CC, Total, DeliveryDate, PurchaseDate, ShippingAddress)"
					+ "values('"+ oid + "', '" + uid + "', '"+  cc + "', '" + total +"', '" + delDate +"', '" + purDate + "', '"+shipAdd+ "');";
			//	System.out.println(sqlQuery);
			int i = stmt.executeUpdate(sqlQuery);
			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}

	public HashMap<String, Products> getProdFromDB(String oid){

		HashMap<String, Products> prodMap = new HashMap<String, Products>();
		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			//System.out.println("userId" + cart.getUserId());
			sqlQuery = "select * from products p inner join orders o on p.PID=o.PID where p.PID in (Select pid from orders where oid = '"+oid+"')";
			ResultSet rs = stmt.executeQuery(sqlQuery);
			while(rs.next()){
				//Products p = new Products(rs.getString(1), rs.getString(2), rs.getString(10), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8));
				Products p =new Products(rs.getString(1), rs.getString(2), rs.getString(10), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8));
				prodMap.put(p.getPid(), p);
			}
			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
		return prodMap;
	}

	public void deleteOrder(String orderid){

		try{

			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();

			sqlQuery = "delete from orders where oid = '"+orderid+ "';";
			int j = stmt.executeUpdate(sqlQuery);
			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}

	}

	//Getting Retailer Data
	public Retailer getRetailerData(String email){

		Retailer retailer = new Retailer();

		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "select * from retailer where Email = '" + email + "'";
			ResultSet rs = stmt.executeQuery(sqlQuery);

			while(rs.next()){
				retailer.setRid(rs.getString("RetailerId"));
				retailer.setRetailerName(rs.getString("RetailerName"));
				retailer.setEmail(rs.getString("Email"));
				retailer.setFlag(rs.getString("Flag"));
			}
			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
		return retailer;
	}

	//Getting all Retailer 

	public boolean changeRetailerAuth (String rid,String flag){


		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "update retailer set Flag = '"+flag+"' where RetailerId = '"+rid+"'";
			int rs = stmt.executeUpdate(sqlQuery);

			//Close db connection.
			stmt.close();
			conn.close();
			if(rs==0){
				return false;
			}

		}catch(SQLException e){
			e.printStackTrace();
		}
		return true;

	}

	//change retailer status 
	public ArrayList<Retailer> getAllRetailerData(){
		ArrayList<Retailer> retailerList = new ArrayList<Retailer>();


		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "select * from retailer";
			ResultSet rs = stmt.executeQuery(sqlQuery);

			while(rs.next()){
				Retailer retailer = new Retailer();
				retailer.setRid(rs.getString("RetailerId"));
				retailer.setRetailerName(rs.getString("RetailerName"));
				retailer.setEmail(rs.getString("Email"));
				retailer.setFlag(rs.getString("Flag"));
				retailerList.add(retailer);
			}
			//Close db connection.
			stmt.close();
			conn.close();
		}catch(SQLException e){
			e.printStackTrace();
		}
		return retailerList;
	}

	public boolean emptyUserCart(String userid){
		
		try{
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			stmt = conn.createStatement();
			sqlQuery = "delete from cart where uid = '"+userid+"'" ;
			System.out.println(sqlQuery);
			int rs = stmt.executeUpdate(sqlQuery);
			//Close db connection.
			stmt.close();
			conn.close();
			if(rs == 0)
				return false;
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}
		return true;
		
	}


}

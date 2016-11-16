package bean;

import java.util.ArrayList;

public class Cart {
	
	private String userId;
	private ArrayList<String> productList;
	
	public Cart(){}
	
	public String getUserId() {
		return userId;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public ArrayList<String> getProductList() {
		return productList;
	}
	
	public void setProductList(ArrayList<String> productList) {
		this.productList = productList;
	}
	
	
	
}

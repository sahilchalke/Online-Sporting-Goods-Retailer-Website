package bean;

public class Product {
	
	String pid;
	String retailerid;
	String category;
	String productname;
	String image;
	String price;
	String discount;
	String active;
	
	public Product(){
		
	}
	
	public Product(String pid,String retailerid,String category,String productname,String image,String price,String
			discount,String active){
		
		this.pid=pid;
		this.retailerid=retailerid;
		this.category=category;
		this.productname=productname;
		this.image=image;
		this.price=price;
		this.discount=discount;
		this.active=active;
	}
	
	
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getRetailerid() {
		return retailerid;
	}
	public void setRetailerid(String retailerid) {
		this.retailerid = retailerid;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getProductname() {
		return productname;
	}
	public void setProductname(String productname) {
		this.productname = productname;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getDiscount() {
		return discount;
	}
	public void setDiscount(String discount) {
		this.discount = discount;
	}
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	
	

}

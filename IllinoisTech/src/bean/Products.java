package bean;

public class Products {
	
	String pid;
	String retailerId;
	String retailerName;
	String category;
	String productName;
	String imagePath;
	String prce;
	String discount;
	String active;
	
	public Products(){}
	
	public Products(String pid, String retailerId, String retailerName, String category, String productName, String imagePath, String prce,
			String discount, String active) {
		super();
		this.pid = pid;
		this.retailerId = retailerId;
		this.retailerName = retailerName;
		this.category = category;
		this.productName = productName;
		this.imagePath = imagePath;
		this.prce = prce;
		this.discount = discount;
		this.active = active;
	}
	
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getRetailerId() {
		return retailerId;
	}
	public void setRetailerId(String retailerId) {
		this.retailerId = retailerId;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getPrce() {
		return prce;
	}
	public void setPrce(String prce) {
		this.prce = prce;
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
	public String getRetailerName() {
		return retailerName;
	}

	public void setRetailerName(String retailerName) {
		this.retailerName = retailerName;
	}	
	
}

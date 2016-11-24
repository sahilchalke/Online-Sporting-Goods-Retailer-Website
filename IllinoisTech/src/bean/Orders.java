package bean;

public class Orders {
	
	String oid;
	String pid;
	String quantity;
	String warranty;
	String price;
	
	public Orders(){}
	
	public Orders(String oid, String pid, String quantity, String warranty, String price) {
		super();
		this.oid = oid;
		this.pid = pid;
		this.quantity = quantity;
		this.warranty = warranty;
		this.price = price;
	}
	public String getOid() {
		return oid;
	}
	public void setOid(String oid) {
		this.oid = oid;
	}
	public String getPID() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid= pid;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getWarranty() {
		return warranty;
	}
	public void setWarranty(String warranty) {
		this.warranty = warranty;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	
	
	
}

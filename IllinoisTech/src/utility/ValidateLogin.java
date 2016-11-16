package utility;

import database.MySqlJDBC;

public class ValidateLogin {
	
	private String email;
	private String pass;
	
	public ValidateLogin(String email, String pass) {
		super();
		this.email = email;
		this.pass = pass;
	}
	
	public boolean validateUser(){
		
		MySqlJDBC mysql = new MySqlJDBC();
		boolean ret = false;
		
		if(mysql.doesUserExists(this.email)){
			System.out.println("user exists");
			ret = mysql.matchPassword(this.email, this.pass);
		}
		System.out.println(ret);
		return ret;
	}

}

package utility;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.MySqlJDBC;


public class fbservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		System.out.println(email+name);
		
		MySqlJDBC mysql = new MySqlJDBC();
		try{
		if(mysql.doesUserExists(email)){
		
			if(mysql.matchPassword(email, "fb")){
				//response.sendRedirect("/index.html");
				System.out.println("Login FB");
				response.sendRedirect("index.html");
			}
		}else{
			mysql.insertUser(name, "fb", email, "", "customer", "");
			response.sendRedirect("index.html");
		}
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}

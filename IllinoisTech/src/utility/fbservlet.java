package utility;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Cart;
import bean.User;
import database.MySqlJDBC;


public class fbservlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String email = request.getParameter("email");
		String name = request.getParameter("name");

		MySqlJDBC mysql = new MySqlJDBC();
		try{
			if(!mysql.doesUserExists(email)){
				mysql.insertUser(name, "fb", email, "", "customer", "");
			}
			User user = new User();
			Cart cart = new Cart();
			System.out.println(email);
			user = mysql.getUserData(email);
			cart = mysql.getUserCart(user.getUid());
			request.getSession().setAttribute("userData", user);
			request.getSession().setAttribute("userCart", cart);
			if(user.getAddress().equals("") || user.getPhonenumber().equals("")){
				System.out.println("FB user profile incomplte.");
				request.getSession().setAttribute("userProf", "incomplete");
			}else
				request.getSession().setAttribute("userProf", "complete");
				
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("value").equals("profilecomplete")){
			
			User user = (User)request.getSession().getAttribute("userData");
			
			String phonenumber = request.getParameter("phonenumber");
			String address = request.getParameter("address");
			String email = request.getParameter("email");
			
			MySqlJDBC mysql = new MySqlJDBC();
			int ret = mysql.completeUserProfile(phonenumber, address, email);
			
			if(ret != 0){
				user.setAddress(address);
				user.setPhonenumber(phonenumber);
				request.getSession().setAttribute("userData", user);
				request.getSession().setAttribute("userProf", "complete");
			}
			response.sendRedirect("UserHome.jsp");
			
		}

	}

}

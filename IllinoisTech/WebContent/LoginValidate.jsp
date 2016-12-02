<%@page import="bean.Retailer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="utility.ValidateLogin, database.MySqlJDBC, bean.Cart, bean.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String email = request.getParameter("email");
		String pass = request.getParameter("psw");
		User user = new User();
		Cart cart = new Cart();
		Retailer retailer = new Retailer();
		ValidateLogin validate = new ValidateLogin(email, pass);
		if (validate.validateUser()) {
			MySqlJDBC mysql = new MySqlJDBC();
			user = mysql.getUserData(email);
			try {
				request.getSession().setAttribute("userData", user);
				if (user.getRole().equalsIgnoreCase("customer")) {
					System.out.println("Customer logged in.");
					cart = mysql.getUserCart(user.getUid());
					request.getSession().setAttribute("userCart", cart);
					request.getSession().setAttribute("userProf", "complete");
					response.sendRedirect("UserHome.jsp");
				}
				if (user.getRole().equalsIgnoreCase("manager")||user.getRole().equalsIgnoreCase("retailer")) {
					System.out.println("Logged in.");
					/*cart = mysql.getUserCart(user.getUid());
					request.getSession().setAttribute("userCart", cart);
					request.getSession().setAttribute("userProf", "complete");*/
					
					//Creating retailer session
					retailer = mysql.getRetailerData(email);
					if(retailer.getFlag().equals("0") || retailer.getFlag().equals("2")){
						response.sendRedirect("RetailerStatus.jsp?status="+retailer.getFlag());
					}
					session.setAttribute("retailer", retailer);
					response.sendRedirect("RetailerHome.jsp");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			request.setAttribute("status", "invalid");
			request.getRequestDispatcher("Login.jsp").forward(request,
					response);
		}
	%>
</body>
</html>

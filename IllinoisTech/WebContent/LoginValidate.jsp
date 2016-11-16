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
		ValidateLogin validate = new ValidateLogin(email, pass);
		if (validate.validateUser()) {
			MySqlJDBC mysql = new MySqlJDBC();
			user = mysql.getUserData(email);
			try {
				if (user.getRole().equalsIgnoreCase("customer")) {
					System.out.println("Customer logged in.");
					cart = mysql.getUserCart(user.getUid());
					request.getSession().setAttribute("userData", user);
					request.getSession().setAttribute("userCart", cart);
					request.getSession().setAttribute("userProf", "complete");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			//redirect to user home. pending
			response.sendRedirect("UserHome.jsp");
		} else {
			request.setAttribute("status", "value");
			request.getRequestDispatcher("Login.jsp").forward(request,
					response);
		}
	%>
</body>
</html>
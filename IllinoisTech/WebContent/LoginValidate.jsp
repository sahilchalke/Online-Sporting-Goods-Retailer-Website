<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="utility.ValidateLogin, database.MySqlJDBC, bean.Cart, bean.User" %>
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
	if(validate.validateUser()){
		MySqlJDBC mysql = new MySqlJDBC();
		out.println("Success");
		//user = mysql.getUserData(email);
		//if(user is not manager){
			//cart = mysql.getUserCart(user.getUserId());
		//}
		response.sendRedirect("index.html");
	}else{
		request.setAttribute("status", "value");
		request.getRequestDispatcher("Login.jsp").forward(request, response);
	}

%>
</body>
</html>
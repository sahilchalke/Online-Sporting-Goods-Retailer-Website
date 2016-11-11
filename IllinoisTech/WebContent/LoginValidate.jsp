<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="utility.ValidateLogin, database.MySqlJDBC, bean.Cart" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	
	String email = request.getParameter("email");
	String pass = request.getParameter("pwd");
	//User user = new User();
	Cart cart = new Cart();
	ValidateLogin validate = new ValidateLogin(email, pass);
	if(validate.validateUser()){
		MySqlJDBC mysql = new MySqlJDBC();
		//user = mysql.getUserData(email);
		//if(user is not manager){
			//cart = mysql.getUserCart(user.getUserId());
		//}
		response.sendRedirect("UserHome.jsp");
	}else{
		request.setAttribute("status", "invalid");
		RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
		rd.forward(request, response);
	}

%>
</body>
</html>
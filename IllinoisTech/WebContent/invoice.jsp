<%@page import="bean.Orders"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%@page import="bean.Products, bean.Cart, bean.User"%>
<%@page import="database.MySqlJDBC"%>

<%
	if(request.getSession().getAttribute("userData") == null || request.getSession().getAttribute("userCart") == null)
		System.out.println("User/Cart null");
	User user = (User)request.getSession().getAttribute("userData");
    Cart cart = (Cart)request.getSession().getAttribute("userCart");
    MySqlJDBC mysql = new MySqlJDBC();
    cart.getProductList().removeAll(cart.getProductList());
    request.getSession().setAttribute("userCart", cart);
    mysql.emptyUserCart(user.getUid());
    
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>IllinoisTech Sporting Goods</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<!--[if lte IE 6]><style type="text/css" media="screen">.tabbed { height:420px; }</style><![endif]-->
<script src="js/jquery-1.4.1.min.js" type="text/javascript"></script>
<script src="js/jquery.jcarousel.pack.js" type="text/javascript"></script>
<script src="js/jquery.slide.js" type="text/javascript"></script>
<script src="js/jquery-func.js" type="text/javascript"></script>
</head>
<body>
	<div id="body">
		<!-- Top -->
		<div id="top">
			<div class="shell">
				<!-- Header -->
				<div id="header">
					<h1 id="logo">
						<a href="#">IllinoisTech Sporting Goods</a>
					</h1>
					<div id="navigation">
						<ul>
							<li><a href="UserHome.jsp">Home</a></li>
          					<li><a href="#">Support</a></li>
          					<li><a href="MyOrders.html">My Orders</a></li>
          					<li><a href="#">Contact</a></li>
          					<li><a href="index.jsp?value=logout">Logout</a></li>
						</ul>
					</div>
				</div>
				<!-- End Header -->
				<!-- Slider -->
				<div id="slider">
					<div id="slider-holder">
						<ul>
							<li><a href="#"><img src="css/images/slide1.jpg" alt="" /></a></li>
							<li><a href="#"><img src="css/images/slide2.jpg" alt="" /></a></li>
							<!--<li><a href="#"><img src="css/images/slide1.jpg" alt="" /></a></li>
          <li><a href="#"><img src="css/images/slide2.jpg" alt="" /></a></li>
          <li><a href="#"><img src="css/images/slide1.jpg" alt="" /></a></li>
          <li><a href="#"><img src="css/images/slide2.jpg" alt="" /></a></li>-->
						</ul>
					</div>
					<div id="slider-nav">
						<a href="#" class="prev">Previous</a> <a href="#" class="next">Next</a>
					</div>
				</div>
				<!-- End Slider -->
			</div>
		</div>
		<div id="main">
			<div class="shell">
				<!-- Search, etc -->
				<div class="options">
					<div class="search">
						<form action="#" method="post">
							<span class="field"> <input type="text" class="blink"
								value=" search here.." title="SEARCH" />
							</span> <input type="text" class="search-submit" value="GO" />
						</form>
					</div>
					<div class="right">
						<span class="cart"> <a href="#" class="cart-ico">&nbsp;</a>
							<strong>$0.00</strong>
						</span> <span class="left more-links"> <a href="#">Checkout</a>
					</div>
				</div>
				<div id="content">
					<!--Login Container -->
					<div id="container">
						
							<%
								/*User user = (User) request.getSession().getAttribute("userData");
								MySqlJDBC mysql = new MySqlJDBC();
								Cart cart = (Cart) request.getSession().getAttribute("userCart");*/
								Products prod = new Products();
								Orders ord = new Orders();
								
								HashMap<String, Orders> orderList = new HashMap<String, Orders>(); 
								orderList = (HashMap<String, Orders>)request.getSession().getAttribute("orderlist");
								
								
								HashMap<String, Products> cartMap = new HashMap<String, Products>();
								cartMap = mysql.getCartProdFromDB(cart);
								
								
								String orderid = request.getParameter("orderid");
							%>

							
								<%
									String sum = request.getParameter("sum");
									String cc = request.getParameter("ccnumber");
									String shipAdd = request.getParameter("shipAddress");
									//System.out.println("Sum "+sum+ " CC= "+cc+" shipAdd= "+shipAdd);
								%>
								<%
									Date date = new Date();

									DateFormat format = new SimpleDateFormat("MM/dd/YYYY");
									date.setTime(date.getTime() + 14 * 1000 * 60 * 60 * 24);
								%>
								<%
									
									DateFormat dtf = new SimpleDateFormat("MM/dd/yyyy");
									Date localDate = new Date();
									
									mysql.insertInvoice(orderid, user.getUid(), cc, sum, format.format(date),
											dtf.format(localDate), shipAdd);
									
									String q;
									for(Map.Entry<String, Orders> m : orderList.entrySet()) {
										
								 		
										 ord = m.getValue();
										// System.out.println("Order id "+ord.getOid());
										q=ord.getQuantity();
										 mysql.addOrders(ord.getOid(), ord.getPID(), ord.getQuantity(), ord.getWarranty(), ord.getPrice());
									}
									HashMap<String, Products> prodList = new HashMap<String, Products>();
									prodList = mysql.getProdFromDB(ord.getOid());
									//Products prod = new Products();
									
									
								%>
								<div id="login_container">
								<h2><font size="5" color = "red">Congratulations!!!!!</font></h2>
								<br>
								<h1><font size="5" color = "red">Below is your order summary</font></h1>
								<br><br>
								<h2>
									Your Total Cost is
									<%=sum%></h2>
								<br> 
								
								<table class='specialtable'>


									<tr>
										<td><h2><font size="3" color = "red">Order ID is:</font></h2></td>
										<td><font size="3" color = "red"><%=orderid%></font></td></h2>
									</tr>
									<br><br>
									<tr>
										<td><h2><font size="3" color = "red">Delivery Date is:</font><h2></td>
										<td><h2><font size="3" color = "red"><%=format.format(date)%></font></h2></td>
									</tr>
									<br><br>
									<%
									for(Map.Entry<String, Products> m : cartMap.entrySet()) {
										prod = m.getValue();
									%>
									 <div class="image"> 
                  	<img src="<%=prod.getImagePath() %>" alt="" style="width: 150px; height: 150px;"/>
                  </div>
                  <br></br><p><h2>Product Name: <span><%= prod.getProductName() %> </h2></span></p>
									<br>
									<%} %>
									 
				
				<%-- <tr>
				<td> Product Price: </td>				
				<td><%= total %></td>
				</tr> --%>  



								</table>

</div>

								



								<!-- Brands -->
								<div class="brands">
									<h3>Brands</h3>
									<div class="logos">
										<a href="#"><img src="css/images/logo1.gif" alt="" /></a> <a
											href="#"><img src="css/images/logo2.gif" alt="" /></a> <a
											href="#"><img src="css/images/logo3.gif" alt="" /></a> <a
											href="#"><img src="css/images/logo4.gif" alt="" /></a> <a
											href="#"><img src="css/images/logo5.gif" alt="" /></a>
									</div>
								</div>
								<!-- End Brands -->
								<!-- End Brands -->
								<!-- Footer -->
								<div id="footer">
									<div class="left">
										<a href="#">Home</a> <span>|</span> <a href="#">Support</a> <span>|</span>
										<a href="#">My Account</a> <span>|</span> <a href="#">The
											Store</a> <span>|</span> <a href="#">Contact</a>
									</div>
									<div class="right">
										&copy; Design by Grad Students at <a
											href="https://web.iit.edu">Illinois Tech</a>
									</div>
								</div>
								<!-- End Footer -->
							</div>
							<!-- End Container -->
						</div>
						<!-- End Content -->
					</div>
					<!-- End Main -->
				</div>
</body>
</html>


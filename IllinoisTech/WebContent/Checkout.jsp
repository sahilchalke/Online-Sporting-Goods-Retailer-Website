<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@page import="bean.Products, bean.Cart, bean.User"%>
<%@page import="database.MySqlJDBC"%>
<%@page import="bean.Orders"%>
<%	
	MySqlJDBC mysql = new MySqlJDBC();
	Cart cart = (Cart)request.getSession().getAttribute("userCart");
	User user = (User)request.getSession().getAttribute("userData");
	HashMap<String, Products> cartMap = new HashMap<String, Products>();
	cartMap = mysql.getCartProdFromDB(cart);
	Products prod = new Products();

	String prodId = request.getParameter("productId");
	
	//System.out.println(user.getUid());
	
	
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
      	<div id="login_container">
      	<p align="center" style="color:red;" > <font size="5" >Below is your order summary</font></p>
					<% int sum;
					sum = 0;
					
					Random r = new Random();
					int Low = 10;
					int High = 10000;
					int Result = r.nextInt(High - Low) + Low;
					
					HashMap<String, Orders> productInOrder = new HashMap<String, Orders>();
					Orders o1;
					for(Map.Entry<String, Products> m : cartMap.entrySet()) {
					
					 		
					 prod = m.getValue();
					 String quantity = request.getParameter("Quantity"+prod.getPid());
					 String warranty = request.getParameter("Warranty"+prod.getPid());
					 String price = prod.getPrce();
					 String discount = prod.getDiscount();
					 System.out.println(prod.getPrce());
					 o1 = new Orders(Integer.toString(Result),prod.getPid(),quantity, warranty, prod.getPrce());
					 productInOrder.put(prod.getPid(), o1);
					 
					// System.out.println("Quantity "+quantity);
					//System.out.println("Price= "+price + "Discount= "+discount);
					int total ;
					//System.out.println(cartMap.size());
					System.out.println("Product id : "+prod.getPid());
					total=Integer.parseInt(quantity)*Integer.parseInt(price)-(Integer.parseInt(price)*Integer.parseInt(discount)/100);
					sum =sum + total;
              %>
			<br>
				
				<table class='specialtable'>
				
				<div class="image"> 
                  	<img src="<%=prod.getImagePath() %>" alt="" style="width: 150px; height: 150px;"/>
                  </div>
				
				<tr>
				<td> Product Name: </td>				
				<td><%= prod.getProductName()  %></td>
				</tr>
				
				<tr>
				<td> Quantity: </td>				
				<td><%= quantity %></td>
				</tr> 
				
				<tr>
				<td> Product Price: </td>				
				<td><%= total %></td>
				</tr> 
				
				
				
			
				</table>
				<br>
				<%  %>		
				<% } 
					request.getSession().setAttribute("orderlist", productInOrder);
				%>	
				<p align="center" style="color:red;" ><font size="5" >Your total Checkout price is $<%= sum %></font></p>
				<form action='Buy.jsp' >
				<button type="submit">Proceed</button>
				<input type="hidden" name="sum" value="<%=sum%>"/>
				<input type="hidden" name="orderid" value="<%=Result%>"/>
                 </form>
					  	</div>
					  	
        <!-- Brands -->
        <div class="brands">
          <h3>Brands</h3>
          <div class="logos"> <a href="#"><img src="css/images/logo1.gif" alt="" /></a> <a href="#"><img src="css/images/logo2.gif" alt="" /></a> <a href="#"><img src="css/images/logo3.gif" alt="" /></a> <a href="#"><img src="css/images/logo4.gif" alt="" /></a> <a href="#"><img src="css/images/logo5.gif" alt="" /></a> </div>
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
						&copy; Design by Grad Students at <a href="https://web.iit.edu">Illinois
							Tech</a>
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
		
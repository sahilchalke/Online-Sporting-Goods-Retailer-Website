<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@page import="bean.Products, bean.Cart, bean.User"%>
<%@page import="database.MySqlJDBC"%>
<%
	System.out.println("checkpoint1");
	if (request.getSession().getAttribute("userData") == null) {
		System.out.println("checkpoint2");
		response.sendRedirect("Login.jsp?value=kindlyLogin");
	} else {
		System.out.println("checkpoint3");
		MySqlJDBC mysql = new MySqlJDBC();
		HashMap<String, Products> cartMap = new HashMap<String, Products>();
		Products prod = new Products();

		User user = (User) request.getSession()
				.getAttribute("userData");
		Cart cart = (Cart) request.getSession()
				.getAttribute("userCart");
		cartMap = mysql.getCartProdFromDB(cart);
		
		if (request.getParameter("action") != null) {
			//Delete item from cart.
			if (request.getParameter("action").equals("delete")) {
				System.out.println("In delete");
				String prodId = request.getParameter("productId");
				System.out.println(prodId);
				int index = 0;
				for (String s : cart.getProductList()) {
					if (prodId.equals(s)) {
						break;
					}
					index++;
				}
				cart.getProductList().remove(index);
				request.getSession().setAttribute("userCart", cart);
				cartMap.remove(prodId);
				mysql.removeProductFromCart(prodId, user.getUid());
			}
			//Add item to cart.
			else if (request.getParameter("action").equals("addToCart")) {
				String prodId = request.getParameter("productId");
				cart.getProductList().add(prodId);
				cartMap.put(prodId, mysql.getProductFromId(prodId));
				request.getSession().setAttribute("userCart", cart);
				mysql.addProductToCart(prodId, user.getUid());
			} else {
				System.out.println("No action");
			}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
						</ul>
					</div>
					<div id="slider-nav">
						<a href="#" class="prev">Previous</a> <a href="#" class="next">Next</a>
					</div>
				</div>
				<!-- End Slider -->
			</div>
		</div>
		<!-- Top -->
		<!-- Main -->
		<div id="main">
			<div class="shell">
				<!-- Search, etc -->
				<div class="options">
				      <div style="float: left; margin-top: 10px; padding-right: 7px;">
				    	 <p>Search IllinoisTech</p>
				      </div>
				      <div class="search">
				        <form action="#" method="post">
				          <span class="field">
				          <input type="text" class="blink" value=" search here.." title="SEARCH" />
				          </span>
				          <input type="text" class="search-submit" value="GO" />
				        </form>
				      </div>
				      <div style="float: left; margin-top: 10px; margin-left:220px; padding-right: 10px; width: 150px:">
				      	<p>Hello, <%=user.getUsername() %></p>
				      </div>
				      <div class="right" style="float: left; margin-left:30px"> 
				      	<span class="cart"><a href="ViewCart.jsp" class="cart-ico">&nbsp;</a><strong>$0.00</strong></span> 
				      	<span class="left more-links"> <a href="UserHome.jsp">Products</a></span>
				      </div>
				    </div>
				
			<!-- End Search, etc -->
			<!-- Content -->
			<div id="content">
				<!-- Tabs -->
				<div class="tabs">
					<ul>
						<li><a href="#" class="active"><span>My Cart</span></a></li>
					</ul>
				</div>
				<!-- Tabs -->
				<!-- Container -->
				<div id="container">
					<div class="tabbed">
					<form action='Checkout.jsp'>
						<!-- First Tab Content -->
						<div class="tab-content" style="display: block;">
							<div class="items">
								<div class="cl">&nbsp;</div>
								

									<%
										if (cartMap.size() == 0) {
									%>
									<ul>
										<li>
											<p>No products in cart.</p>
										</li>
									</ul>
									<%
										}
									%>
									<ul>

										<%
											for (Map.Entry<String, Products> m : cartMap.entrySet()) {
												prod = m.getValue();
										%>

										<li>
											<div class="image">
												<img src="<%=prod.getImagePath()%>" alt=""
													style="width: 150px; height: 150px;" />
											</div> <br></br>
											<p>
												Product Name: <span><%=prod.getProductName()%></span>
											</p>
											<p>
												Retailer Name: <span><%=prod.getRetailerName()%></span>
											</p> <label>Buy Warranty for: </label> <select
											name="Warranty<%=prod.getPid()%>">
												<option value="yes">Yes</option>
												<option value="no">No</option>
										</select>
											<p>
												<label>Quantity: </label> <select
													name="Quantity<%=prod.getPid()%>">
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
												</select>
											</p> <br></br> <a
											href="ViewCart.jsp?action=delete&productId=<%=prod.getPid()%>"
											class="button">Delete</a>

										</li>
										<%
											}
										%>
									</ul>
									
									<input type="hidden" name="action" value="checkout" />
								


								<div class="cl">&nbsp;</div>
							</div>
						</div>
						<!-- End 5th -->
						<ul>
							<li>
							<input class='submit-button' type='submit' value='Checkout'
								style="margin-left: 20px; width: 100px; height: 30px;" /> <input
								type="hidden" name="productID" value="<%=prod.getPid()%>" />
							</li>
						</ul>

					</form>
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
	</div>
	</div>
	<!-- End Main -->
</body>
</html>
<%} %>

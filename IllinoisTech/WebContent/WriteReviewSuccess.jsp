<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@page import="bean.Products"%>
<%@page import="database.MySqlJDBC"%>  

<%@ page import="com.mongodb.BasicDBObject"%>
<%@page import="database.MongoDbUtil"%>
<%  MySqlJDBC mysql = new MySqlJDBC(); %>
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
      <h1 id="logo"><a href="#">IllinoisTech Sporting Goods</a></h1>
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
      <div id="slider-nav"> <a href="#" class="prev">Previous</a> <a href="#" class="next">Next</a></div>
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
      <div class="search">
        <form action="#" method="post">
          <span class="field">
          <input type="text" class="blink" value=" search here.." title="SEARCH" />
          </span>
          <input type="text" class="search-submit" value="GO" />
        </form>
      </div>
      <div class="right"> <span class="cart"> <a href="#" class="cart-ico">&nbsp;</a> <strong>$0.00</strong> </span> <span class="left more-links"> <a href="#">Checkout</a></div>
    </div>
    <!-- End Search, etc -->
    <!-- Content -->
    <div id="content">
      <!-- Tabs -->
      <div class="tabs">
        <ul>
         <!--  <li><a href="#" class="active"><span>Baseball</span></a></li>
		  <li><a href="#" class="active"><span>Basketball</span></a></li>
          <li><a href="#"><span>Soccer</span></a></li>
          <li><a href="#"><span>Football</span></a></li>
          <li><a href="#"><span>Other</span></a></li> -->
          
        </ul>
      </div>
      <%
      try{
      String image = request.getParameter("productImage");
      String discount = request.getParameter("productDiscount");
      String productName = request.getParameter("productName");
      String productPrice = request.getParameter("productPrice");
      String rating = request.getParameter("rating");
      String date = request.getParameter("rdate");
      String text = request.getParameter("reviewtext");
      String username =request.getParameter("uid");
      String comment = request.getParameter("comment");
      String id = request.getParameter("id");
      
      MongoDbUtil.getConnection();
      BasicDBObject doc = new BasicDBObject("title", "myReviews").
      		append("productName", productName).
      		append("productPrice", productPrice).
      		append("userName",username).
      		append("rating", rating).
      		append("date",date).
      		append("text", text);
      MongoDbUtil.myReviews.insert(doc);

      %>
      <h4> Review Successfully submitted. </h4> 
 
          
    
      <div id="container">
        <div class="tabbed">
          <!-- First Tab Content -->
          <div class="tab-content" style="display:block;">
            <div class="items">
              <div class="cl">&nbsp;</div>
              
              <ul>
              <li>
                  <div class="image"> <img src="<%=image %>" alt="" style="width: 150px; height: 150px;"/></div>
                  <p> Product Name : <span><%= productName %></span><br/>         
                  <p class="price">Price: <strong><%= productPrice %></strong></p>
                  
                   <form class = 'submit-button' method = 'post' action = 'ProductInfo.jsp'  >
			            <input type='hidden' name = 'productName' value = '<%=productName %>' />
			            <input type='hidden' name = 'productPrice' value = '<%=productPrice %>' />
			            <input type='hidden' name = 'productImage' value = '<%=image %>' />
			            <input type='hidden' name = 'discount' value = '<%=discount %>' />			           
			            <input class = 'submit-button' type = 'submit'  value = 'More Details' style="width: 100px; height: 30px;"/>
			        </form>
                </li>
              
              </ul>
              <div class="cl">&nbsp;</div>
            </div>
          </div>
          </div>
          <%
      }catch(Exception e){
      	e.printStackTrace();
      }
          %>
      <!-- Brands -->
        <div class="brands">
          <h3>Brands</h3>
          <div class="logos"> <a href="#"><img src="css/images/logo1.gif" alt="" /></a> <a href="#"><img src="css/images/logo2.gif" alt="" /></a> <a href="#"><img src="css/images/logo3.gif" alt="" /></a> <a href="#"><img src="css/images/logo4.gif" alt="" /></a> <a href="#"><img src="css/images/logo5.gif" alt="" /></a> </div>
        </div>
        <!-- End Brands -->
        <!-- Footer -->
        <div id="footer">
          <div class="left"> <a href="#">Home</a> <span>|</span> <a href="#">Support</a> <span>|</span> <a href="#">My Account</a> <span>|</span> <a href="#">The Store</a> <span>|</span> <a href="#">Contact</a> </div>
          <div class="right"> &copy; Design by Grad Students at <a href="https://web.iit.edu">Illinois Tech</a> </div>
        </div>
        </center>
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
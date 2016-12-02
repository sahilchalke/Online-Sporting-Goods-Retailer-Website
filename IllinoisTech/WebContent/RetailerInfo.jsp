<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@page import="bean.*"%>
<%@ page import="com.mongodb.DBCursor"%>
<%@page import="database.MySqlJDBC"%>  

<%@ page import="com.mongodb.BasicDBObject"%>
<%@page import="database.MongoDbUtil"%>
<%  MySqlJDBC mysql = new MySqlJDBC(); %>
<%
User user = (User)session.getAttribute("userData");
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
      <h1 id="logo"><a href="#">IllinoisTech Sporting Goods</a></h1>
      <div id="navigation">
        <ul>
          <li><a href="#">Support</a></li>
					          <li><a href="RetailerHome.jsp">My Actions</a></li>
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
      <div style="float: left; margin-top: 10px; margin-left:220px; padding-right: 10px; width: 150px:">
				      	<p>Hello, <%=user.getUsername() %></p>
				      
					</div>
      <div class="right"> <span class="cart"> <a href="#" class="cart-ico">&nbsp;</a> <strong>$0.00</strong> </span> <span class="left more-links"> <a href="#">Checkout</a></span>
      </div>
    </div>
    <!-- End Search, etc -->
    <!-- Content -->
    <div id="content">
      <!-- Tabs -->
      <div class="tabs">
        <ul>
          <li><a href="#" class="active"><span>Product Information</span></a></li>
        </ul>
      </div>
      <!-- End Tabs -->
      <!-- Container -->
       <%
       	String productName = request.getParameter("productName");
       	String price = request.getParameter("productPrice");
       	String discount = request.getParameter("discount");
       	String image = request.getParameter("productImage");
       	String retailer = request.getParameter("retailerName");
       %>
      <div id="container">
       <div class="tabbed">
          <!-- First Tab Content -->
          <div class="tab-content" style="display:block;">
            <div class="items">
              <div class="cl">&nbsp;</div>
       		  <ul>
       		  <li>
                 <div class="image"> <img src="<%= image %>" alt="" style="width: 150px; height: 150px;"/></div>
                 <br></br><p> Product Name: <span><%= productName %></span></p>
                 <p> Retailer Name: <span><%= retailer %></span></p>        
                 <p>Price: <span><%= price %></span></p>
                 <p> Discount: <span><%= discount %></span></p>
                 <br></br>
                 <center>
                  <form class = 'submit-button' method = 'post' action = 'RetailerModify.jsp'  >
			            <input type='hidden' name = 'productName' value = '<%=productName %>' />
			            <input type='hidden' name = 'productPrice' value = '<%=price %>' />
			            <input type='hidden' name = 'productImage' value = '<%=image %>' />
			            <input type='hidden' name = 'discount' value = '<%=discount %>' />			           
			            <input class = 'submit-button' type = 'submit'  value = 'Update/Delete Products' style="width: 150px; height: 30px;"/>
			        </form>
			      </center>
               </li>
               </ul>
                  </div>
                  </div>
          <!-- End Prod Info -->
          
<!-- End Main -->
</body>
</html>


<%@page import="com.mongodb.DBCollection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@page import="bean.Products, bean.User"%>
<%@ page import="com.mongodb.DBCursor"%>
<%@page import="database.MySqlJDBC"%>  

<%@ page import="com.mongodb.BasicDBObject"%>
<%@page import="database.MongoDbUtil"%>
<%  
	MySqlJDBC mysql = new MySqlJDBC(); 
	User user = (User)request.getSession().getAttribute("userData");
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
          <%if(user!=null) {%>	
          <li><a href="UserHome.jsp">Home</a></li>
          <li><a href="#">Support</a></li>
          <li><a href="#">My Orders</a></li>
          <li><a href="#">Contact</a></li>
          <li><a href="index.jsp?value=logout">Logout</a></li>
          <%}else{ %>
          <li><a href="index.jsp">Home</a></li>
          <li><a href="#">Support</a></li>
          <li><a href="Login.jsp">Login</a></li>
          <li><a href="Signup.html">Sign Up</a></li>
          <li><a href="#">Contact</a></li>
          <%} %>
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
      <div style="float: left; margin-top: 10px; margin-left:220px; padding-right: 10px;">
      	<%if(user!=null){ %>
      	<p>Hello, <%=user.getUsername() %></p>
      	<%} %>
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
         <!--  <li><a href="#" class="active"><span>Baseball</span></a></li>
		  <li><a href="#" class="active"><span>Basketball</span></a></li>
          <li><a href="#"><span>Soccer</span></a></li>
          <li><a href="#"><span>Football</span></a></li>
          <li><a href="#"><span>Other</span></a></li> -->
          <li><a href="#" class="active"><span>Product Information</span></a></li>
          <li><a href="#" ><span>Read Reviews</span></a></li>
          <li><a href="#" ><span>Write Reviews</span></a></li>
        </ul>
      </div>
      <!-- Tabs -->
      <!-- Container -->
       <%
        String productName = "";
      	String price = "";
      	String discount = "";
      	String image = "";
      	String retailer = "";
      	String productId = "";
        if(request.getParameter("value")!=null){
        	if(request.getParameter("value").equals("fromAjax")){
        		Products prod = new Products();
        		prod = (Products)request.getSession().getAttribute("Product");
        		 productName = prod.getProductName();
               	 price = prod.getPrce();
               	 discount = prod.getDiscount();
               	 image = prod.getImagePath();
               	 retailer = prod.getRetailerName();
               	 productId = prod.getPid();
        	}
        }else{
	      	 productName = request.getParameter("productName");
	      	 price = request.getParameter("productPrice");
	      	 discount = request.getParameter("discount");
	      	 image = request.getParameter("productImage");
	      	 retailer = request.getParameter("retailerName");
	      	 productId = request.getParameter("productId");
        }
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
                 <p>Retailer Name: <span><%= retailer%></span></p>        
                 <p>Price: <span><%= price %></span></p>
                 <p> Discount: <span><%= discount%></span></p>
                 <br></br>
                 <center>
                  <form class = 'submit-button' method = 'post' action = 'ViewCart.jsp'>	
                  		<%
			            	if(user == null){
			            %>
			            	<input type="hidden" name="action" value="kindlyLogin"/>
			            <%}else{ %>
			            <input type="hidden" name="action" value="addToCart"/>
			            <%} %>	           
                  		<input type="hidden" name="productId" value="<%=productId%>"/>
                  		
			            <input class = 'submit-button' type = 'submit'  value = 'Add To Cart' style="width: 100px; height: 30px;"/>
			      </form>
			     </center>
               </li>
               </ul>
                  </div>
                  </div>
          <!-- End Prod Info -->
          <!-- second Tab Content -->
          <%
          String searchField = "productName";
          String searchParameter = request.getParameter("productName");
          MongoDbUtil.getConnection();
          BasicDBObject searchQuery = new BasicDBObject();
          searchQuery.put(searchField, searchParameter);

          DBCursor cursor = MongoDbUtil.myReviews.find(searchQuery);
          %>
          <div class="tab-content" style="display:block;">
            <div class="items">
              <div class="cl">&nbsp;</div>
      
       
      
                  <h3> Reviews For: <%= searchParameter %></h3>
		
		<%  if(cursor.count() == 0){
			%>
			There are no reviews for this product.
		<% 
		}else{

			

			String pName = "";
			String userID = "";
			String reviewRating = "";
			String reviewDate =  "";
			String reviewText = "";
			String prodPrice = "";
			
			

			while (cursor.hasNext()) {
				%>
				 <ul>
       <li>
				<br></br><br></br>
				
				<table class='specialtable'>
				<% BasicDBObject obj = (BasicDBObject) cursor.next(); %>				

				<tr>
				<td> Product Name: </td>
				<% pName = obj.getString("productName"); %>
				<td><%= pName %></td>
				</tr>
				
				<tr>
				<td> Product Price: </td>
				<% prodPrice = obj.getString("productPrice"); %>
				<td><%= prodPrice %></td>
				</tr>
				
				
				
				<tr>
				<td> User ID: </td>
				<% userID = obj.getString("userName"); %>
				<td><%= userID %></td>
				
				</tr>
				
				
				<tr>
				<td> Review Rating: </td>
				<% reviewRating = obj.getString("rating").toString(); %>
				<td><%= reviewRating %></td>
				</tr>

				<tr>
				<td> Review Date: </td>
				<% reviewDate = obj.getString("date"); %>
				<td><%= reviewDate %></td>
				</tr>

				<tr>
				<td> Review Text: </td>
				<% reviewText = obj.getString("text"); %>
				<td><%= reviewText %></td>
				</tr>
				</table>
				<br></br><br></br>
				</li>
                  </ul>
			<% 
			}
		}	
		%>        
			        
                  
                 
                  </div>
                  </div>
          <!-- End View  Review -->
          <!-- Third Tab Content -->
          <div class="tab-content" style="display:block;">
             <div id="login_container">
      
       
       <ul>
       <li>
                  
                 <%--  <form method='post' action='WriteReviewSuccess.jsp'>
			<br></br>
			<h3>Write Review</h3>
			<table class='specialtable'>
			<tr><td>Product Name: </td><td> <%= productName %></td></tr>
			<tr><td>Product Price: </td><td> <%= price %></td></tr>
			<tr><td>Username: </td><td> <input type='text' name='uid'/></td></tr>
			<tr><td>ReviewRating (1 to 5): </td><td> <input type='text' name='rating'/></td></tr>
			<tr><td>ReviewDate: </td><td> <input type='date' name='rdate'/></td></tr>
			<tr><td>ReviewText: </td><td> <input type='text' name='reviewtext'/></td></tr>
			<tr></tr>
			<tr></tr>
			<tr></tr>
			<tr>
			<td colspan='2'>
			<input type='submit' name='review' value='Submit Review' />
			<input type='hidden' name = 'productName' value = '<%=productName %>'/>
            <input type='hidden' name = 'productPrice' value = '<%= price %>'/>
            <input type='hidden' name = 'productImage' value = '<%= image %>'/>
            <input type='hidden' name = 'productDiscount' value = '<%= discount %>'/>
           	</td>
			</tr>
			</table>
			</form> --%>
			<!-- <div id="login_container" align="left"> -->
			<h2><font size="5" color = "red">Write Review</font></h2>
			<br></br>
      		<form action='WriteReviewSuccess.jsp' method="post">
      			
						<br>
						<label><b>Product Name: </b></label><%= productName %><br> 
						
						<br>
						
						<label><b>Product Price: </b><%= price %></label><br> 
						
						<br></br>
						<label><b>Username</b></label><br></br>
						<input type="text" placeholder="Enter username" name="uid" id = "uid" required><br>
						<br></br>
						<label><b>ReviewRating (1 to 5):</b></label><br></br>
						<input type="text" placeholder="Enter Ratings" name="rating" id = "rating" required><br>
						<br>
						<label><b>ReviewDate: </b></label><br></br>
						<input type="date" placeholder="Date" name="rdate" id = "rdate" required><br>
						<br>
						<label><b>Review Text</b></label><br></br>
						<input type="text" placeholder="Enter Review" name="reviewtext" id = "reviewtext" required><br>
						<br></br>
						<button type="submit">Submit Review</button><br></br>
						<input type='hidden' name = 'productName' value = '<%=productName %>'/>
           				 <input type='hidden' name = 'productPrice' value = '<%= price %>'/>
          				  <input type='hidden' name = 'productImage' value = '<%= image %>'/>
           				 <input type='hidden' name = 'productDiscount' value = '<%= discount %>'/>
					</form>
             </div>
                  </li>
                  </ul>
                 
                  
                  <!--</div>  -->
                  
          <!-- End Write Review -->
        </div>
        </div>
        </div>
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

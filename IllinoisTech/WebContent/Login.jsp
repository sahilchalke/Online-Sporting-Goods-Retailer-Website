<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<script>  // This is called with the results from from FB.getLoginStatus().
  function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else if (response.status === 'not_authorized') {
      // The person is logged into Facebook, but not your app.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into this app.';
    } else {
      // The person is not logged into Facebook, so we're not sure if
      // they are logged into this app or not.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into Facebook.';
    }
  }

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }

  window.fbAsyncInit = function() {
  FB.init({
    appId      : '1736299703362131',
    cookie     : false,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.8' // use graph api version 2.8
  });

  // Now that we've initialized the JavaScript SDK, we call 
  // FB.getLoginStatus().  This function gets the state of the
  // person visiting this page and can return one of three states to
  // the callback you provide.  They can be:
  //
  // 1. Logged into your app ('connected')
  // 2. Logged into Facebook, but not your app ('not_authorized')
  // 3. Not logged into Facebook and can't tell if they are logged into
  //    your app or not.
  //
  // These three cases are handled in the callback function.

  /* FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  }); */

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me',{locale: 'en_US', fields: 'name, email'}, function(response) {
    	
    	 var url = "fbservlet?email="+response.email+"&name="+response.name;
    	    req = initRequest();
    	    req.open("GET", url, true);
    	    req.onreadystatechange = callback;
    	    req.send(null);
    });
  }
  function initRequest() {
	    if (window.XMLHttpRequest) {
	        if (navigator.userAgent.indexOf('MSIE') != -1) {
	            isIE = true;
	        }
	        return new XMLHttpRequest();
	    } else if (window.ActiveXObject) {
	        isIE = true;
	        return new ActiveXObject("Microsoft.XMLHTTP");
	    }
	}
  
  function callback(){  
		window.top.location = "UserHome.jsp?value=fromfb";
  }
	  </script>
	  
</head>
<body>
<div id="body">
<!-- Top -->
<div id="top">
  <div class="shell">
    <!-- Header -->
    <div id="header">
      <h1 id="logo"><a href="index.jsp">IllinoisTech Sporting Goods</a></h1>
      <div id="navigation">
        <ul>
          <li><a href="index.jsp">Home</a></li>
          <li><a href="#">Support</a></li>
          <li><a href="Signup.html">Sign Up</a></li>
          <li><a href="#">Contact</a></li>
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
    <div style="float: left; margin-top: 10px; padding-right: 7px;">
    	 <p>Search IllinoisTech</p>
      </div>
      <div class="search">
      		<div>
      			<span class="field">	
				<input type="text" class="blink" name="searchId" id="searchId" onkeyup="doCompletion()" value="  Search here.." autocomplete="on"/>
				</span>
				<input type="text" class="search-submit" value="GO" />
			</div>	
			<div id="autocompleteContainer" style="height: auto; float: top; margin-top: 25px;">
					<table id="complete-table" 
					style="position: absolute; border-collapse: collapse; background: white; font-size: 14px; width: 195px;">
					</table>
			</div>	
	  </div>
      <div class="right"> <span class="cart"> <a href="Login.jsp" class="cart-ico">&nbsp;</a> <strong>$0.00</strong> </span></div>
    </div>
    <!-- End Search, etc -->
    <!-- Content -->
    <div id="content">
      <!--Login Container -->
      <div id="container">
      	<div id="login_container">
      		<form action='LoginValidate.jsp' method="POST">
						<div align="center">
							<h2>Login</h2>
						</div>
						<%
							if(request.getAttribute("status")!=null){
								if(request.getAttribute("status").equals("invalid")){
									out.println("<br><h4 align=\"center\"> Invalid username/password.</h4>");
								}
							}
							if(request.getParameter("value")!=null){
								if(request.getParameter("value").equals("kindlyLogin")){
									out.println("<br><h4 align=\"center\"> Kindly Login.</h4>");
								}
							}	
						%>
						<label><b>Email Id:</b></label><br> 
						<input type="text" placeholder="Enter Email" name="email" id = "email" required><br> 
						
						<label><b>Password:</b></label><br>
						<input type="password" placeholder="Enter Password" name="psw" id = "psw"required><br>

						<button type="submit">Login</button><br>
						<span>Forgot <a href="#">password?</a></span><br> <br>
					</form>
					<form action="Registration.html">
						<label><b>Don't have an account?</b></label><br>
						<button type="submit">Create a new account</button>
					</form>
					<label><b>Or</b></label><br>
					<fb:login-button scope="public_profile,email" onlogin="checkLoginState();" style="width=100%">
					</fb:login-button>
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
</div>
</div>
<!-- End Main -->
</body>
</html>

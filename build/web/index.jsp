<%@page contentType="text/html" pageEncoding="UTF-8" %>﻿
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html" charset="utf-8">
        <title>MiaCucina Order Food Online</title>
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Cache-Control" content="no-cache">
        <meta http-equiv="Expires" content="0">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <!--Less styles -->
        <!-- Other Less css file //different less files has different color scheam
             <link rel="stylesheet/less" type="text/css" href="themes/less/simplex.less">
             <link rel="stylesheet/less" type="text/css" href="themes/less/classified.less">
             <link rel="stylesheet/less" type="text/css" href="themes/less/amelia.less">  MOVE DOWN TO activate
        -->
        <!--<link rel="stylesheet/less" type="text/css" href="themes/less/bootshop.less">
        <script src="themes/js/less.js" type="text/javascript"></script> -->

        <!-- Bootstrap style --> 
        <link id="callCss" rel="stylesheet" href="themes/bootshop/bootstrap.min.css" media="screen"/>
        <link href="themes/css/base.css" rel="stylesheet" media="screen"/>
        <!-- Bootstrap style responsive -->	
        <link href="themes/css/bootstrap-responsive.min.css" rel="stylesheet"/>
        <link href="themes/css/font-awesome.css" rel="stylesheet" type="text/css">
        <!-- Google-code-prettify -->	
        <link href="themes/js/google-code-prettify/prettify.css" rel="stylesheet"/>
        <script type="text/javascript" src="themes/js/json2.js"></script>
        <script type="text/javascript" src="themes/js/script.js"></script>
        <!-- fav and touch icons -->
        <link rel="shortcut icon" href="themes/images/ico/favicon.ico">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="themes/images/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="themes/images/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="themes/images/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="themes/images/ico/apple-touch-icon-57-precomposed.png">
        <style type="text/css" id="enject"></style>
        <%
            String username = (String) session.getAttribute("userName");
            String cartJSON = (String) session.getAttribute("cartJSON");
        %> 
    </head>
    <body>
        <div id="header">
            <div class="container">
                <div id="welcomeLine" class="row">
                    <div id="userHeader" class="span6">Welcome!<strong> User</strong></div>
                    <div class="span6">
                        <div class="pull-right">

                           <!-- <a href="product_summary.jsp"><span>&pound;</span></a>
                            <span class="btn btn-mini">$155.00</span>
                            <a href="product_summary.jsp"><span class="">$</span></a>-->
                            <a href="product_summary.jsp"><span id="cartSize" class="btn btn-mini btn-primary"><i class="icon-shopping-cart icon-white"></i> [ 3 ] Items in your cart </span> </a> 
                        </div>
                    </div>
                </div>
                <!-- Navbar ================================================== -->
                <div id="logoArea" class="navbar">
                    <a id="smallScreen" data-target="#topMenu" data-toggle="collapse" class="btn btn-navbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <div class="navbar-inner">
                        <a class="brand" href="index.jsp"><img src="themes/images/logo.png" alt="Bootsshop" height="20"/></a>
                        <form class="form-inline navbar-search" method="post">
                            <input id="srchFld" class="srchTxt" type="text" >
                            <select class="srchTxt" id="searchCat">
                                <option>ALL</option>
                                <option>Computer</option>
                                <option>Mobile</option>
                                <option>Tablet</option>

                            </select> 
                            <button type="button" id="submitButton" class="btn btn-primary" onclick="search()" >Go</button>
                        </form>
                        <ul id="topMenu" class="nav pull-right">
                            <li id="myOrdersDialog" class="" style="display:none"><a href="#myOrdersdiv" onclick="salesAggregate('MY_ORDERS','myOrdersTable')" style="color: #fff" role="button" data-toggle="modal">My Orders</a></li>
                             <div id="myOrdersdiv" class="modal hide fade in" tabindex="-1" style="width:700px;top: 0% !important;margin-top: 5px !important;"  role="dialog" aria-labelledby="aggregationdiv" aria-hidden="false" >
                                <div class="modal-header" >
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                    <h3>My Previous Orders</h3>
                                </div>
                                <div class="modal-body" style="max-height: 700px !important;overflow: auto!important">
                                    <table class="table table-bordered" id="myOrdersTable"> </table>
                                </div>
                            </div>
                            <li id="aggregationDialog" style="display:none"><a href="#aggregationdiv"  style="color: #fff" role="button" data-toggle="modal">Aggregate</a></li>
                            
                            <div id="aggregationdiv" class="modal hide fade in" tabindex="-1" style="width:700px;top: 0% !important;margin-top: 5px !important;"  role="dialog" aria-labelledby="aggregationdiv" aria-hidden="false" >
                                <div class="modal-header" >
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                    <h3>Aggregation Summary</h3>
                                </div>
                                <div class="modal-body" style="max-height: 700px !important;overflow: auto!important">
                                     <button type="submit" class="btn btn-success" onclick="salesAggregate('SALES_BY_PRODUCT','aggregationTable')">Product Sales</button>
                                     <button type="submit" class="btn btn-success" onclick="salesAggregate('CATEGORY_TOP','aggregationTable')">Top Cat</button>
                                     <button type="submit" class="btn btn-success" onclick="salesAggregate('SALES_BY_REGION','aggregationTable')">Region Sales</button>
                        <table class="table table-bordered" id="aggregationTable">
                            <!--<thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Description</th>
                                    <th>Quantity/Update</th>
                                </tr>
                            </thead>
                            <tbody id="aggregationValues">
                                <tr>
                                    <td>$120.00</td>

                                    <td>$15.23</td>
                                    <td >$120.00</td>
                                </tr>
                                <tr>
                                    <td>$7.00</td>

                                    <td>$1.00</td>
                                    <td >$7.00</td>
                                </tr>
                                <tr>
                                    <td>$120.00</td>

                                    <td>$15.00</td>
                                    <td >$120.00</td>
                                </tr>

                            </tbody>-->
                        </table>
                                </div>
                            </div>
                            
                            <li id=registerMaintenance" class="" ><a href="#registerMaintenancediv" style="color: #fff" role="button" data-toggle="modal">Register</a></li>
                              <div id="registerMaintenancediv" class="modal hide fade in" tabindex="-1" style="width:700px;top: 0% !important;margin-top: 5px !important;"  role="dialog" aria-labelledby="registerMaintenancediv" aria-hidden="false" >
                                  <div class="modal-header" >
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                    <h3>New Customer Registration</h3>
                                </div>
                                <div class="modal-body" style="max-height: 700px !important;overflow: auto!important">
                                    <form id="addNewCustomerForm" action="javascript:addNewCustomer()" class="form-horizontal loginFrm" style="margin-bottom: 1 !important;">
                                        <div class="control-group">								
                                             <label for="customer_id" class="control-label">Customer Id :</label> 
                                             <div class="controls" ><input type="text" pattern="[0-9]{9}" title="Only Enter a 9 digit number" id="customer_id"  placeholder="SSN" required="true"></div>
                                        </div>
                                        <div class="control-group">								
                                             <label for="customer_name" class="control-label" >Customer Name :</label>
                                             <div class="controls"><input type="text" pattern="[a-zA-Z\s]+" title="Only Enter Alphabets" id="customer_name"  placeholder="Customer Name" required="true"></div>
                                        </div>
                                        <div class="control-group">
                                            <label for="customer_password" style="display:inline-block;vertical-align:left;">Customer Password :</label> <input  type="password"  id="customer_password" style="display:inline-block;vertical-align:right;" placeholder="Customer Password" required="true">
                                        </div>
                                        <div class="control-group">
                                            <label for="address_street" style="display:inline-block;vertical-align:left;">Street :</label> <input type="text" id="address_street" style="display:inline-block;vertical-align:right;" placeholder="Street" required="true">
                                        </div>
					<div class="control-group">
                                            <label for="address_state" style="display:inline-block;vertical-align:middle;">State :</label> <input type="text" id="address_state" pattern="[a-zA-Z\s]+" style="display:inline-block;vertical-align:middle;" placeholder="State" required="true">
                                        </div>
                                        <div class="control-group">
                                            <label for="address_city" style="display:inline-block;vertical-align:middle;">City :</label> <input type="text" id="address_city" pattern="[a-zA-Z\s]+" style="display:inline-block;vertical-align:middle;" placeholder="City" required="true">
                                        </div>
                                        <div class="control-group">
                                            <label for="address_zipcode" style="display:inline-block;vertical-align:middle;">ZIP Code :</label> <input type="text" id="address_zipcode" pattern="[0-9]+" style="display:inline-block;vertical-align:middle;" placeholder="ZIP Code" required="true">
                                        </div>
                                        <div class="control-group">
                                            <label for="customer_kind" style="display:inline-block;vertical-align:middle;">Customer Kind :</label>
                                            <select id="customer_kind" onchange="home_business(this)">
                                                    <option selected="selected" value="Home">Home</option>
                                                    <option  value="Business">Business</option>
                                            </select>
                                        </div>
                                        <div class="control-group" id="id_home_business" style="display: block">
                                            <label for="marriage_status" style="display:inline-block;vertical-align:middle;">Marriage Status :</label>
                                             <select id="marriage_status" ><option selected="selected" value="Married">Married</option><option  value="Unmarried">Unmarried</option> <option  value="Widowed">Widowed</option><option  value="Separated">Separated</option></select>
                                              <label for="gender" style="display:inline-block;vertical-align:middle;">Gender :</label>
                                               <select id="gender"><option value="Male">Male</option><option value="Female">Female</option></select>
                                                <label for="age" style="display:inline-block;vertical-align:middle;">Age :</label> <input type="number" id="age" min="1" step="1" style="display:inline-block;vertical-align:middle;" placeholder="Age" required="true">
                                                <label for="income" style="display:inline-block;vertical-align:middle;">Income :</label> <input type="number" id="income" step="any" min="1" style="display:inline-block;vertical-align:middle;" placeholder="Income" required="true">
                                       </div>

                                        <button type="submit" class="btn btn-success" >Submit</button>
                                        <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
                                    </form>		
                                </div>
                            </div>
                            <li id="productMaintenance" class="" style="display:none" ><a href="#productMaintenancediv" style="color: #fff" role="button" data-toggle="modal" >New Product</a></li>
                            <div id="productMaintenancediv" class="modal hide fade in" tabindex="-1" style="width:700px;top: 0% !important;margin-top: 5px !important;"  role="dialog" aria-labelledby="productMaintenancediv" aria-hidden="false" >
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                    <h3>Add New Product</h3>
                                </div>
                                <div class="modal-body" style="max-height: 500px !important">
                                    <form id="addProductForm" action="javascript:addNewProduct()" class="form-horizontal loginFrm">
                                        <div class="control-group">								
                                             <label for="product_id" style="display:inline-block;vertical-align:middle;">Product ID :</label> <input type="text" pattern="[a-zA-Z0-9-]+" title="Only Enter AlphaNumeric Value" id="product_id" style="display:inline-block;vertical-align:middle;"    placeholder="Product ID :" required="true" >
                                        </div>
                                        <div class="control-group">
                                            <label for="product_name" style="display:inline-block;vertical-align:left;">Product Name :</label> <input  type="text"  id="product_name" style="display:inline-block;vertical-align:right;" placeholder="Product Name" required="true">
                                        </div>
                                        <div class="control-group">
                                            <label for="product_description" style="display:inline-block;vertical-align:left;">Product Description :</label> <input type="text" id="product_description" style="display:inline-block;vertical-align:right;" placeholder="Product Desciption" required="true">
                                        </div>
                                        <div class="control-group">
                                            <label for="inventory_amount" style="display:inline-block;vertical-align:middle;">Inventory Amount :</label> <input type="number" min="1" step="1" id="inventory_amount" style="display:inline-block;vertical-align:middle;" placeholder="Inventory Amount" required="true">
                                        </div>
                                        <div class="control-group">
                                            <label for="product_price" style="display:inline-block;vertical-align:middle;">Product Price :</label> <input type="number" step="any" min="0" id="product_price" style="display:inline-block;vertical-align:middle;" placeholder="Product Price" required="true">
                                        </div>
                                        <div class="control-group">
                                            <label for="product_kind" style="display:inline-block;vertical-align:middle;">Product Kind :</label> 
                                            <select id="product_kind">
                                                <option value="Computer">Computer</option>
                                                <option value="Mobile">Mobile</option>
                                                <option value="Tablet">Tablet</option>
                                            </select>
                                            <!--<input type="text" id="product_kind" style="display:inline-block;vertical-align:middle;" placeholder="Product Kind" required="true">-->
                                        </div>
                                        <div class="control-group">
                                            <label for="image_url" style="display:inline-block;vertical-align:middle;">Image URL : </label> <input type="text" id="image_url" style="display:inline-block;vertical-align:middle;" placeholder="Image URL">
                                        </div>
                                        <button type="submit" class="btn btn-success" >Submit</button>
                                        <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
                                    </form>		
                                </div>
                            </div>
                            <li class="" style="display:none"><a href="contact.html">Contact</a></li>
                            <li class="" id="logoutButton" style="display:block"><a href="#" onclick="logout()" role="button" data-toggle="modal" style="padding-right:0"><span class="btn btn-large btn-success">Logout</span></a></li>
                            <li id="loginButton" class="">
                                <a href="#login" role="button" data-toggle="modal" style="padding-right:0"><span class="btn btn-large btn-success">Login</span></a>
                                <div id="login" class="modal hide fade in" tabindex="-1" role="dialog" aria-labelledby="login" aria-hidden="false" >
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                        <h3>Login Block</h3>
                                    </div>
                                    <div class="modal-body">
                                        <form id="loginForm" class="form-horizontal loginFrm">
                                            <div class="control-group">								
                                                <input type="text" id="inputEmail"  placeholder="Email">
                                            </div>
                                            <div class="control-group">
                                                <input type="password" id="inputPassword" placeholder="Password">
                                            </div>
                                           <!-- <div class="control-group">
                                                <label class="checkbox">
                                                    <input type="checkbox"> Remember me
                                                </label>
                                            </div>-->
                                        </form>		
                                        <button type="submit" class="btn btn-success" onclick="login()" >Sign in</button>
                                        <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- Header End====================================================================== -->

        <div id="mainBody">
            <div class="container">
                <div class="row">
                    <!-- Sidebar ================================================== -->
                    <div id="sidebar" class="span3" style="display:none !important">
                        <div class="well well-small"><a id="myCart" href="product_summary.jsp"><img src="themes/images/ico-cart.png" alt="cart">3 Items in your cart  <span class="badge badge-warning pull-right">$155.00</span></a></div>
                        <ul id="sideManu" class="nav nav-tabs nav-stacked">
                            <li class="subMenu open"><a> Indian</a>
                                <ul>
                                    <li><a class="active" href="products.html"><i class="icon-chevron-right"></i>Matar Paneer</a></li>
                                    <li><a href="products.html"><i class="icon-chevron-right"></i>Rajma</a></li>
                                    <li><a href="products.html"><i class="icon-chevron-right"></i>Paneer Butter Masala</a></li>

                                </ul>
                            </li>
                            <li class="subMenu"><a> Chinese </a>
                                <ul >
                                    <li><a href="products.html"><i class="icon-chevron-right"></i>Schezwan Fried Rice</a></li>
                                    <li><a href="products.html"><i class="icon-chevron-right"></i>Fried Wonton</a></li>												
                                    <li><a href="products.html"><i class="icon-chevron-right"></i>Vegetable Chow mei fun</a></li>	

                                </ul>
                            </li>
                            <li class="subMenu"><a>Mexican</a>
                                <ul >
                                    <li><a href="products.html"><i class="icon-chevron-right"></i>Chicken Taco</a></li>
                                    <li><a href="products.html"><i class="icon-chevron-right"></i>Topped Nachos</a></li>												
                                    <li><a href="products.html"><i class="icon-chevron-right"></i>Volcano Taco</a></li>	

                                </ul>
                            </li>

                        </ul>
                        <br/>
                        <div class="thumbnail" style="display:none">
                            <img src="themes/images/products/panasonic.jpg" alt="Bootshop panasonoc New camera"/>
                            <div class="caption">
                                <h5></h5>
                                <h4 style="text-align:center"><a class="btn" href="product_details.jsp"> <i class="icon-zoom-in"></i></a> <a class="btn" href="#"><i class="icon-shopping-cart"></i></a> <a class="btn btn-primary" href="#"></a></h4>
                            </div>
                        </div><br/>
                        <div class="thumbnail" style="display:none">
                            <img src="themes/images/products/kindle.png" title="Bootshop New Kindel" alt="Bootshop Kindel">
                            <div class="caption">
                                <h5></h5>
                                <h4 style="text-align:center"><a class="btn" href="product_details.jsp"> <i class="icon-zoom-in"></i></a> <a class="btn" href="#"><i class="icon-shopping-cart"></i></a> <a class="btn btn-primary" href="#"></a></h4>
                            </div>
                        </div><br/>
                        <div class="thumbnail" style="display:none">
                            <img src="themes/images/payment_methods.png" title="Bootshop Payment Methods" alt="Payments Methods">
                            <div class="caption">
                                <h5></h5>
                            </div>
                        </div>
                    </div>
                    <!-- Sidebar end=============================================== -->
                    <div class="span9">		

                        <ul id="allProducts" class="thumbnails">
                           <!-- <li class="span3">
                                <div class="thumbnail">
                                    <a  href="product_details.jsp"><img src="themes/images/products/1.jpg" alt=""/></a>
                                    <div class="caption">
                                        <h5>Product name</h5>
                                        <p> 
                                            Lorem Ipsum is simply dummy text. 
                                        </p>

                                        <h4 style="text-align:center"><a class="btn" href="product_details.jsp"> <i class="icon-zoom-in"></i></a> <a class="btn" href="#" onclick="addToCart(this.parentNode)">Add to <i class="icon-shopping-cart"></i></a> <a class="btn btn-primary" href="#">$222.00</a></h4>
                                    </div>
                                </div>
                            </li>
                            <li class="span3">
                                <div class="thumbnail">
                                    <a  href="product_details.jsp"><img src="themes/images/products/2.jpg" alt=""/></a>
                                    <div class="caption">
                                        <h5>Product name</h5>
                                        <p> 
                                            Lorem Ipsum is simply dummy text. 
                                        </p>
                                        <h4 style="text-align:center"><a class="btn" href="product_details.jsp"> <i class="icon-zoom-in"></i></a> <a class="btn" href="#">Add to <i class="icon-shopping-cart"></i></a> <a class="btn btn-primary" href="#">$222.00</a></h4>
                                    </div>
                                </div>
                            </li>
                            <li class="span3">
                                <div class="thumbnail">
                                    <a  href="product_details.jsp"><img src="themes/images/products/3.jpg" alt=""/></a>
                                    <div class="caption">
                                        <h5>Product name</h5>
                                        <p> 
                                            Lorem Ipsum is simply dummy text. 
                                        </p>
                                        <h4 style="text-align:center"><a class="btn" href="product_details.jsp"> <i class="icon-zoom-in"></i></a> <a class="btn" href="#">Add to <i class="icon-shopping-cart"></i></a> <a class="btn btn-primary" href="#">$222.00</a></h4>
                                    </div>
                                </div>
                            </li>
                            <li class="span3">
                                <div class="thumbnail">
                                    <a  href="product_details.jsp"><img src="themes/images/products/9.jpg" alt=""/></a>
                                    <div class="caption">
                                        <h5>Product name</h5>
                                        <p> 
                                            Lorem Ipsum is simply dummy text. 
                                        </p>
                                        <h4 style="text-align:center"><a class="btn" href="product_details.jsp"> <i class="icon-zoom-in"></i></a> <a class="btn" href="#">Add to <i class="icon-shopping-cart"></i></a> <a class="btn btn-primary" href="#">$222.00</a></h4>
                                    </div>
                                </div>
                            </li>
                            <li class="span3">
                                <div class="thumbnail">
                                    <a  href="product_details.jsp"><img src="themes/images/products/10.jpg" alt=""/></a>
                                    <div class="caption">
                                        <h5>Product name</h5>
                                        <p> 
                                            Lorem Ipsum is simply dummy text. 
                                        </p>
                                        <h4 style="text-align:center"><a class="btn" href="product_details.jsp"> <i class="icon-zoom-in"></i></a> <a class="btn" href="#">Add to <i class="icon-shopping-cart"></i></a> <a class="btn btn-primary" href="#">$222.00</a></h4>
                                    </div>
                                </div>
                            </li>
                            <li class="span3">
                                <div class="thumbnail">
                                    <a  href="product_details.jsp"><img src="themes/images/products/11.jpg" alt=""/></a>
                                    <div class="caption">
                                        <h5>Product name</h5>
                                        <p> 
                                            Lorem Ipsum is simply dummy text. 
                                        </p>
                                        <h4 style="text-align:center"><a class="btn" href="product_details.jsp"> <i class="icon-zoom-in"></i></a> <a class="btn" href="#">Add to <i class="icon-shopping-cart"></i></a> <a class="btn btn-primary" href="#">$222.00</a></h4>
                                    </div>
                                </div>
                            </li>-->
                        </ul>	
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer ================================================================== -->


        <div  id="footerSection" style="display: none">
            <div class="container">
                <div class="row">
                    <div class="span3">
                        <h5>ACCOUNT</h5>
                        <a href="login.html">YOUR ACCOUNT</a>
                        <a href="login.html">PERSONAL INFORMATION</a> 
                        <a href="login.html">ADDRESSES</a> 
                        <a href="login.html">DISCOUNT</a>  
                        <a href="login.html">ORDER HISTORY</a>
                    </div>
                    <div class="span3">
                        <h5>INFORMATION</h5>
                        <a href="contact.html">CONTACT</a>  
                        <a href="register.html">REGISTRATION</a>  
                        <a href="legal_notice.html">LEGAL NOTICE</a>  
                        <a href="tac.html">TERMS AND CONDITIONS</a> 
                        <a href="faq.html">FAQ</a>
                    </div>
                    <div class="span3">
                        <h5>OUR OFFERS</h5>
                        <a href="#">NEW PRODUCTS</a> 
                        <a href="#">TOP SELLERS</a>  
                        <a href="special_offer.html">SPECIAL OFFERS</a>  
                        <a href="#">MANUFACTURERS</a> 
                        <a href="#">SUPPLIERS</a> 
                    </div>
                    <div id="socialMedia" class="span3 pull-right">
                        <h5>SOCIAL MEDIA </h5>
                        <a href="#"><img width="60" height="60" src="themes/images/facebook.png" title="facebook" alt="facebook"/></a>
                        <a href="#"><img width="60" height="60" src="themes/images/twitter.png" title="twitter" alt="twitter"/></a>
                        <a href="#"><img width="60" height="60" src="themes/images/youtube.png" title="youtube" alt="youtube"/></a>
                    </div> 
                </div>
                <p class="pull-right">&copy; Bootshop</p>
            </div><!-- Container End -->
        </div>
        <!-- Placed at the end of the document so the pages load faster ============================================= -->
        <script src="themes/js/jquery.js" type="text/javascript"></script>
        <script src="themes/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="themes/js/google-code-prettify/prettify.js"></script>

        <script src="themes/js/bootshop.js"></script>
        <script src="themes/js/jquery.lightbox-0.5.js"></script>

        <!-- Themes switcher section ============================================================================================= -->
        <div id="secectionBox">
            <link rel="stylesheet" href="themes/switch/themeswitch.css" type="text/css" media="screen" />
            <script src="themes/switch/theamswitcher.js" type="text/javascript" charset="utf-8"></script>
            <div id="themeContainer">
                <div id="hideme" class="themeTitle">Style Selector</div>
                <div class="themeName">Oregional Skin</div>
                <div class="images style">
                    <a href="themes/css/#" name="bootshop"><img src="themes/switch/images/clr/bootshop.png" alt="bootstrap business templates" class="active"></a>
                    <a href="themes/css/#" name="businessltd"><img src="themes/switch/images/clr/businessltd.png" alt="bootstrap business templates" class="active"></a>
                </div>
                <div class="themeName">Bootswatch Skins (11)</div>
                <div class="images style">
                    <a href="themes/css/#" name="amelia" title="Amelia"><img src="themes/switch/images/clr/amelia.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="spruce" title="Spruce"><img src="themes/switch/images/clr/spruce.png" alt="bootstrap business templates" ></a>
                    <a href="themes/css/#" name="superhero" title="Superhero"><img src="themes/switch/images/clr/superhero.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="cyborg"><img src="themes/switch/images/clr/cyborg.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="cerulean"><img src="themes/switch/images/clr/cerulean.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="journal"><img src="themes/switch/images/clr/journal.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="readable"><img src="themes/switch/images/clr/readable.png" alt="bootstrap business templates"></a>	
                    <a href="themes/css/#" name="simplex"><img src="themes/switch/images/clr/simplex.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="slate"><img src="themes/switch/images/clr/slate.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="spacelab"><img src="themes/switch/images/clr/spacelab.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="united"><img src="themes/switch/images/clr/united.png" alt="bootstrap business templates"></a>
                    <p style="margin:0;line-height:normal;margin-left:-10px;display:none;"><small>These are just examples and you can build your own color scheme in the backend.</small></p>
                </div>
                <div class="themeName">Background Patterns </div>
                <div class="images patterns">
                    <a href="themes/css/#" name="pattern1"><img src="themes/switch/images/pattern/pattern1.png" alt="bootstrap business templates" class="active"></a>
                    <a href="themes/css/#" name="pattern2"><img src="themes/switch/images/pattern/pattern2.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern3"><img src="themes/switch/images/pattern/pattern3.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern4"><img src="themes/switch/images/pattern/pattern4.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern5"><img src="themes/switch/images/pattern/pattern5.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern6"><img src="themes/switch/images/pattern/pattern6.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern7"><img src="themes/switch/images/pattern/pattern7.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern8"><img src="themes/switch/images/pattern/pattern8.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern9"><img src="themes/switch/images/pattern/pattern9.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern10"><img src="themes/switch/images/pattern/pattern10.png" alt="bootstrap business templates"></a>

                    <a href="themes/css/#" name="pattern11"><img src="themes/switch/images/pattern/pattern11.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern12"><img src="themes/switch/images/pattern/pattern12.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern13"><img src="themes/switch/images/pattern/pattern13.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern14"><img src="themes/switch/images/pattern/pattern14.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern15"><img src="themes/switch/images/pattern/pattern15.png" alt="bootstrap business templates"></a>

                    <a href="themes/css/#" name="pattern16"><img src="themes/switch/images/pattern/pattern16.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern17"><img src="themes/switch/images/pattern/pattern17.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern18"><img src="themes/switch/images/pattern/pattern18.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern19"><img src="themes/switch/images/pattern/pattern19.png" alt="bootstrap business templates"></a>
                    <a href="themes/css/#" name="pattern20"><img src="themes/switch/images/pattern/pattern20.png" alt="bootstrap business templates"></a>

                </div>
            </div>
        </div>
        <script>
                var username = '<%=username%>';
                // alert(username);
                if (username == "null" || username == null || username == "") {
                    //  alert("user is null");
                    document.getElementById("loginButton").style.display = "block";
                    document.getElementById("logoutButton").style.display = "none";
                } else if (username === "admin") {
                    document.getElementById("productMaintenance").style.display = "block";
                    document.getElementById("loginButton").style.display = "none";
                    document.getElementById("logoutButton").style.display = "block";
                    document.getElementById("aggregationDialog").style.display = "block";
                    document.getElementById("userHeader").innerHTML = "Welcome!<strong> Administrator</strong>";
                } else {
                    document.getElementById("loginButton").style.display = "none";
                    document.getElementById("logoutButton").style.display = "block";
                    document.getElementById("myOrdersDialog").style.display = "block";
                    document.getElementById("userHeader").innerHTML = "Welcome!<strong> " + username.toString().trim() + "</strong>";
                }
                fetchProducts();
                loadCartOnStartup('<%=cartJSON%>');
                refreshCart();
                var myEvent = window.attachEvent || window.addEventListener;
                var chkevent = window.attachEvent ? 'onbeforeunload' : 'beforeunload';
                myEvent(chkevent, function (e) { // For >=IE7, Chrome, Firefox
                    document.cookie = "cart=" + escape(JSON.stringify(cart)) + "; " + "expires=Thu, 23 Jan 2025 00:00:01 UTC; path=/";
                    //document.cookie = "userid="+""+"; "+"expires=expires=Thu, 01 Jan 1970 00:00:01 GMT;";
                    flushCart();
                });
        </script>

        <span id="themesBtn"></span>
    </body>
</html>
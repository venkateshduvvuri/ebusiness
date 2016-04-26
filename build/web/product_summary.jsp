<%@page contentType="text/html" pageEncoding="UTF-8" %>﻿
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html" charset="utf-8">
        <title>The Diner Cafe</title>
        <script type = "text/javascript" >
            history.pushState(null, null, 'product_summary.jsp');
            window.addEventListener('popstate', function (event) {
                history.pushState(null, null, 'product_summary.jsp');
            });

        </script>
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
        <style>
            
            #myProgress {
                position: relative;
                width: 100%;
                height: 30px;
                background-color: #ddd;
            }

            #myBar {
                position: absolute;
                width: 33%;
                height: 100%;
                background-color: #4CAF50;
            }
            
            #mylabel {
                text-align: center;
                line-height: 30px;
                font-size: 25px;
                color: white;
            }
        </style>
        <link id="callCss" rel="stylesheet" href="themes/bootshop/bootstrap.min.css" media="screen"/>
        <link href="themes/css/base.css" rel="stylesheet" media="screen"/>
        <!-- Bootstrap style responsive -->	
        <link href="themes/css/bootstrap-responsive.min.css" rel="stylesheet"/>
        <link href="themes/css/font-awesome.css" rel="stylesheet" type="text/css">
        <!-- Google-code-prettify -->	
        <link href="themes/js/google-code-prettify/prettify.css" rel="stylesheet"/>
        <!-- fav and touch icons -->
        <link rel="shortcut icon" href="themes/images/ico/favicon.ico">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="themes/images/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="themes/images/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="themes/images/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="themes/images/ico/apple-touch-icon-57-precomposed.png">
        <script type="text/javascript" src="themes/js/json2.js"></script>
        <script src="themes/js/script.js" type="text/javascript"></script>
        <style type="text/css" id="enject"></style>
        <%
            String username = (String) session.getAttribute("userName");
            String allProductsJSON = (String) session.getAttribute("allProductsJSON");
            String cartJSON = (String) session.getAttribute("cartJSON");
        %> 
    </head>
    <body >
        <div id="header">
            <div class="container">
                <div id="welcomeLine" class="row">
                    <div id="userHeader" class="span6">Welcome!<strong> User</strong></div>
                    <div class="span6">
                        <div class="pull-right">
                            <!--<a href="product_summary.jsp"><span>&pound;</span></a>
                            <span class="btn btn-mini">$155.00</span>
                            <a href="product_summary.jsp"><span class="">$</span></a>-->
                            <a href="product_summary.jsp"><span id="cartSize" class="btn btn-mini btn-primary"><i class="icon-shopping-cart icon-white"></i> [ ] Items in your cart </span> </a> 
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
                        <a class="brand" href="index.jsp"><img src="themes/images/4.gif" alt="Bootsshop"/></a>
                        <form class="form-inline navbar-search" method="post" action="" >
                            <input id="srchFld" class="srchTxt" type="text" />
                            <select class="srchTxt">
                                 <option>ALL</option>
                                <option>Indian</option>
                                <option>Chinese</option>
                                <option>Mexican</option>
                            </select> 
                            <button type="submit" id="submitButton" class="btn btn-primary">Go</button>
                        </form>
                        <ul id="topMenu" class="nav pull-right">
                            <li class=""><a style="display:none" href="special_offer.html">Specials Offer</a></li>
                            <li class="" id="productMaintenance" style="display:none"><a href="normal.html">Delivery</a></li>
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
                                        <form class="form-horizontal loginFrm">
                                            <div class="control-group">								
                                                <input type="text" id="inputEmail" placeholder="Email">
                                            </div>
                                            <div class="control-group">
                                                <input type="password" id="inputPassword" placeholder="Password">
                                            </div>
                                            <div class="control-group">
                                                <label class="checkbox">
                                                    <input type="checkbox"> Remember me
                                                </label>
                                            </div>
                                        </form>		
                                        <button type="submit" class="btn btn-success">Sign in</button>
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
                    <div id="sidebar" class="span3" style="display: none">
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

                        <div class="thumbnail">
                            <img src="themes/images/payment_methods.png" title="Bootshop Payment Methods" alt="Payments Methods">
                            <div class="caption">
                                <h5>Payment Methods</h5>
                            </div>
                        </div>
                    </div>
                    <!-- Sidebar end=============================================== -->
                    <div class="span9">
                        <ul class="breadcrumb">
                            <li><a href="index.jsp">Home</a> <span class="divider">/</span></li>
                            <li class="active"> SHOPPING CART</li>
                        </ul>
                        <div id="myProgress" style="display:none">
                            <div id="myBar">
                                <div id="mylabel">Order Placed!</div>
                            </div>
                        </div>
                        <h3>  SHOPPING CART <a href="index.jsp" class="btn btn-large pull-right"><i class="icon-arrow-left"></i> Continue Ordering </a></h3>	
                        <hr class="soft"/>
                        <table class="table table-bordered" style="display: none">
                            <tr><th> I AM ALREADY REGISTERED  </th></tr>
                            <tr> 
                                <td>
                                    <form class="form-horizontal">
                                        <div class="control-group">
                                            <label class="control-label" for="inputUsername">Username</label>
                                            <div class="controls">
                                                <input type="text" id="inputUsername" placeholder="Username">
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="inputPassword1">Password</label>
                                            <div class="controls">
                                                <input type="password" id="inputPassword1" placeholder="Password">
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <div class="controls">
                                                <button type="submit" class="btn">Sign in</button> OR <a href="register.html" class="btn">Register Now!</a>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <div class="controls">
                                                <a href="forgetpass.html" style="text-decoration:underline">Forgot password ?</a>
                                            </div>
                                        </div>
                                    </form>
                                </td>
                            </tr>
                        </table>		

                        <table class="table table-bordered" id="totalTable">
                            <thead>
                                <tr>
                                    <th >Product</th>
                                    <th>Description</th>
                                    <th>Quantity/Update</th>
                                    <th>Price</th>

                                    <!--<th>Tax</th>-->
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody id="cartGrid">
                                <tr>
                                    <td> <img width="60" src="themes/images/products/4.jpg" alt=""/></td>
                                    <td>MASSA AST<br/>Color : black, Material : metal</td>
                                    <td>
                                        <div class="input-append"><input class="span1" style="max-width:34px;height:20px" placeholder="1" size="16" type="text" onkeypress="return false"  value="1"><button class="btn" onclick="minus(this.parentNode)" type="button"><i class="icon-minus"></i></button><button class="btn" onclick="plus(this.parentNode)" type="button"><i class="icon-plus"></i></button><button onclick="removeRow(this.parentNode)" class="btn btn-danger" type="button"><i class="icon-remove icon-white"></i></button>				</div>
                                    </td>
                                    <td>$120.00</td>

                                    <td>$15.23</td>
                                    <td >$120.00</td>
                                </tr>
                                <tr>
                                    <td> <img width="60" src="themes/images/products/8.jpg" alt=""/></td>
                                    <td>MASSA AST<br/>Color : black, Material : metal</td>
                                    <td>
                                        <div class="input-append"><input class="span1" style="max-width:34px;height:20px" placeholder="1"  size="16" type="text" onkeypress="return false" value="1"><button class="btn" onclick="minus(this.parentNode)" type="button"><i class="icon-minus"></i></button><button class="btn" onclick="plus(this.parentNode)" type="button"><i class="icon-plus"></i></button><button onclick="removeRow(this.parentNode)" class="btn btn-danger" type="button"><i class="icon-remove icon-white"></i></button>				</div>
                                    </td>
                                    <td>$7.00</td>

                                    <td>$1.00</td>
                                    <td >$7.00</td>
                                </tr>
                                <tr>
                                    <td> <img width="60" src="themes/images/products/3.jpg" alt=""/></td>
                                    <td>MASSA AST<br/>Color : black, Material : metal</td>
                                    <td>
                                        <div class="input-append"><input class="span1" style="max-width:34px;height:20px" placeholder="1"  size="16" type="text" onkeypress="return false" value="1"><button class="btn" onclick="minus(this.parentNode)" type="button"><i class="icon-minus"></i></button><button class="btn" onclick="plus(this.parentNode)" type="button"><i class="icon-plus"></i></button><button class="btn btn-danger" onclick="removeRow(this.parentNode)" type="button"><i class="icon-remove icon-white"></i></button>				</div>
                                    </td>
                                    <td>$120.00</td>

                                    <td>$15.00</td>
                                    <td >$120.00</td>
                                </tr>

                                <tr>
                                    <td colspan="5" style="text-align:right">Total Price:	</td>
                                    <td id="totalvalue"> </td>
                                </tr>

                                <tr>
                                    <td colspan="5" style="text-align:right" >Total Tax:	</td>
                                    <td id="totalTax"> </td>
                                </tr>
                                <tr>
                                    <td colspan="5" style="text-align:right" ><strong>TOTAL = </strong></td>
                                    <td id="totalCost" class="label label-important" style="display:block"> </td>
                                </tr>
                            </tbody>
                        </table>

                        <a href="index.jsp" class="btn btn-large"><i class="icon-arrow-left"></i> Continue Ordering </a>
                        <button type="button" onclick="submitOrder('<%=username%>')" class="btn btn-large pull-right">Submit <i class="icon-arrow-right"></i></button>

                    </div>
                </div></div>
        </div>
        <!-- MainBody End ============================= -->
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
                //document.getElementById("productMaintenance").style.display = "block";
                document.getElementById("loginButton").style.display = "none";
                document.getElementById("logoutButton").style.display = "block";
                document.getElementById("userHeader").innerHTML = "Welcome!<strong> Administrator</strong>";
            } else {
                document.getElementById("loginButton").style.display = "none";
                document.getElementById("logoutButton").style.display = "block";
                document.getElementById("userHeader").innerHTML = "Welcome!<strong> " + username.toString().trim() + "</strong>";
            }
            allProductsJSON = null;
            allProductsJSON = JSON.parse('<%=allProductsJSON%>');
            loadCartOnStartup('<%=cartJSON%>');

            // alert(allProductsJSON);
            //alert(cart);
            function renderCartGrid() {
                var cartRow = "";
                var cartToRender = cart;
                for (var i in cartToRender.orderdetails) {
                    cartRow += "<tr>";
                    cartRow += "<td><img width=\"60\" src=\"" + cartToRender.orderdetails[i].url + "\" alt=\"\"/></td>";
                    cartRow += "<td>" + cartToRender.orderdetails[i].productname + "<br/>" + cartToRender.orderdetails[i].productname + "</td>";
                    cartRow += "<td><div class=\"input-append\">";
                    cartRow += "<input class=\"span1\" style=\"max-width:34px;height:20px\" placeholder=\"1\" size=\""+cartToRender.orderdetails[i].inventory_amount+"\" type=\"text\" onkeypress=\"return false\"  value=\"" + cartToRender.orderdetails[i].quantity + "\">";
                    cartRow += "<button class=\"btn\" onclick=\"minus(this.parentNode)\" type=\"button\"><i class=\"icon-minus\"></i></button>";
                    cartRow += "<button class=\"btn\" onclick=\"plus(this.parentNode)\" type=\"button\"><i class=\"icon-plus\"></i></button>";
                    cartRow += "<button onclick=\"removeRow(this.parentNode)\" class=\"btn btn-danger\" type=\"button\"><i class=\"icon-remove icon-white\"></i></button>";
                    cartRow += "</div></td>";
                    cartRow += "<td>$" + cartToRender.orderdetails[i].price + "</td>";
                    //cartRow += "<td>$1.23</td>";
                    cartRow += "<td >$" + cartToRender.orderdetails[i].price + "</td></tr>";
                }
                cartRow += "<tr><td colspan=\"4\" style=\"text-align:right\">Total Price: </td><td id=\"totalvalue\"> </td></tr>";
                //cartRow += "<tr><td colspan=\"4\" style=\"text-align:right\" >Total Tax: </td><td id=\"totalTax\"> </td></tr>";
                cartRow += "<tr><td colspan=\"4\" style=\"text-align:right\" ><strong>TOTAL =</strong></td><td id=\"totalCost\" class=\"label label-important\" style=\"display:block\"> </td></tr>";
                document.getElementById("cartGrid").innerHTML = cartRow;
            }
            renderCartGrid();
            total();
            refreshCart();
            var myEvent = window.attachEvent || window.addEventListener;
            var chkevent = window.attachEvent ? 'onbeforeunload' : 'beforeunload';
            myEvent(chkevent, function (e) { // For >=IE7, Chrome, Firefox
                //var confirmationMessage = 'Are you sure to leave the page?';  // a space
                //(e || window.event).returnValue = confirmationMessage;
                //return confirmationMessage;
                // document.cookie = "cart="+""+"; "+"expires=expires=Thu, 01 Jan 1970 00:00:01 GMT;";
                document.cookie = "cart=" + escape(JSON.stringify(cart)) + "; " + "expires=Thu, 23 Jan 2025 00:00:01 UTC; path=/";

                flushCart();
            });
            function move(orderId) {
                 var orderId = orderId;
                 var elem = document.getElementById("myBar");   
                 document.getElementById("myProgress").style.display = "block";
                 var width = 33;
                 var id = setInterval(frame, 7000);
                    
                 function frame() {
                    var XHR = createXMLHttpRequest();
                    var productRequestJSON = {
                       "requestType": "OrderStatus",
                       "orderId" : orderId
                    };
                    XHR.onreadystatechange = function () {
                        if (XHR.readyState == 4) {
                            if (XHR.status == 200) {
                                var response = XHR.responseText;
                                response = response.toString();
                                console.log("Response Received...");
                                console.log(response);
                                if(response == "1" || response == 1){
                                    width = 33;
                                    elem.style.width = width + '%'; 
                                    document.getElementById("mylabel").innerHTML = 'Order Placed!';
                                }
                                else if (response == "2" || response == 2) {
                                    width = 66;
                                    elem.style.width = width + '%';
                                    document.getElementById("mylabel").innerHTML = 'Food is being Prepared. Please Wait!';
                                } else if (response == "3" || response == 3){
                                    width = 100; 
                                    elem.style.width = width + '%'; 
                                    document.getElementById("mylabel").innerHTML = 'Your Food is Ready! Will be Served. Enjoy!';
                                    clearInterval(id);
                                }
                            }
                        }
                    };

                    XHR.open("POST", "ProductManagementServlet", true);
                    XHR.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    XHR.send("productRequestJSON=" + escape(JSON.stringify(productRequestJSON)));
                   
                 }
            }
          </script>

        <span id="themesBtn"></span>
    </body>
</html>
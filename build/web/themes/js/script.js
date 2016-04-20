function addNewProduct() {    var XHR = createXMLHttpRequest();    var newProductJSON = {};    var productFormElements = document.forms["addProductForm"].querySelectorAll("input,select");    for (var i = 0; i < productFormElements.length; i++) {        newProductJSON[(productFormElements[i].id).toString()] = productFormElements[i].value;    }    var productRequestJSON = {        "requestType": "AddNewProduct",        "productJSON": newProductJSON    };    XHR.onreadystatechange = function () {        if (XHR.readyState == 4) {            if (XHR.status == 200) {                var response = XHR.responseText;                response = response.toString();                if (response.trim() === 'Successful') {                    alert("New Product Added Successfully.");                    window.location = "";                } else {                    alert("Failed  to Add New Product");                }            }        }    };    XHR.open("POST", "ProductManagementServlet", true);    XHR.setRequestHeader("Content-type", "application/x-www-form-urlencoded");    XHR.send("productRequestJSON=" + escape(JSON.stringify(productRequestJSON)));}function addNewCustomer() {    var newCustomerJSON = {};    var customerFormElements = document.forms["addNewCustomerForm"].querySelectorAll("input,select");    alert(customerFormElements.length);    for (var i = 0; i < customerFormElements.length; i++) {        newCustomerJSON[(customerFormElements[i].id).toString()] = customerFormElements[i].value;    }    var homeBusinessElements = document.getElementById("id_home_business").getElementsByTagName("input");    for (var i = 0; i < homeBusinessElements.length; i++) {        newCustomerJSON[(homeBusinessElements[i].id).toString()] = homeBusinessElements[i].value;    }    alert(JSON.stringify(newCustomerJSON));    var XHR = createXMLHttpRequest();    XHR.onreadystatechange = function () {        if (XHR.readyState == 4) {            if (XHR.status == 200) {                // var response = XHR.responseText;                // response = response.toString();                //  if (response.trim() === 'Successful') {                alert("New Customer Registration Successful.");                window.location = "";                // } else {                //   alert("Invalid Username or Password.");                // }            }        }    };    XHR.open("POST", "CustomerInfoServlet", true);    XHR.setRequestHeader("Content-type", "application/x-www-form-urlencoded");    XHR.send("customerRequestJSON=" + escape(JSON.stringify(newCustomerJSON)));}function createXMLHttpRequest() {    if (window.XMLHttpRequest) {        var XHR = new XMLHttpRequest();        if (XHR.overrideMimeType) {            XHR.overrideMimeType("text/html");        }        return XHR;    }    if (window.ActiveXObject) {        try {            var XHR = new ActiveXObject("Msxml2.XMLHTTP");            browserType = "IE";            return XHR;        } catch (e) {            try {                var XHR = new ActiveXObject("Microsoft.XMLHTTP");                browserType = "IE";                return XHR;            } catch (e) {                alert("Your browser does not support AJAX!");                browserType = "Unknown";                return null;            }        }    }    return null;}function login() {    var userId = document.getElementById("inputEmail").value;    var pass = document.getElementById("inputPassword").value;    var XHR = createXMLHttpRequest();    var requestJSON = {        "requestType": "login",        "userId": userId,        "password": pass    };    XHR.open("POST", "LoginServlet", false);    XHR.setRequestHeader("Content-type", "application/x-www-form-urlencoded");    XHR.send("loginRequestJSON=" + escape(JSON.stringify(requestJSON)));    refreshPage(XHR);}function logout() {    var XHR = createXMLHttpRequest();    var requestJSON = {        "requestType": "logout"    };    XHR.open("POST", "LoginServlet", false);    XHR.setRequestHeader("Content-type", "application/x-www-form-urlencoded");    XHR.send("loginRequestJSON=" + escape(JSON.stringify(requestJSON)));    refreshPage(XHR);}function refreshPage(XHR) {    if (XHR.readyState == 4) {        if (XHR.status == 200) {            var response = XHR.responseText;            response = response.toString();            if (response.trim() == 'Successful') {                window.location = "";            } else {                alert("Invalid Username or Password.");            }        }    }}function updateCart(productName, quant) {    for (var i in cart.orderdetails) {        if (cart.orderdetails[i].productname == productName) {            cart.orderdetails[i].quantity = quant;        }    }}function refreshCart() {    //alert("ddd");    document.getElementById("cartSize").innerHTML = "<i class=\"icon-shopping-cart icon-white\"></i> [" + cart.orderdetails.length + "] Items in your cart ";}var cart = {"orderdetails": []};var allProductsJSON;function addToCart(nodeObj) {    var divNode = nodeObj.parentNode;    var productName = divNode.getElementsByTagName("h5")[0].innerHTML;    if (!checkProductInCart(productName)) {        var aTag = nodeObj.getElementsByTagName("a");        var price = parseFloat((aTag[aTag.length - 1].innerHTML).replace("$", ""));        var details = getImageURL(productName);        cart.orderdetails.push({"productname": productName, "url": details[0], "quantity": 1, "price": price, "inventory_amount": parseInt(details[1]), "productId": details[2]});    }    else{        alert("Product is already in the cart");    }    refreshCart();   // alert(JSON.stringify(cart));    //alert(productName.trim());}function submitOrder(user) {    //alert("user :::"+user);    if(user == null ||  user == '' || user == 'null'){        alert('Please Login to Place the Order');        return;    }    if (cart.orderdetails.length == 0) {        alert("Cart Cannot be Empty.");        return;    }    var XHR = createXMLHttpRequest();    //alert(JSON.stringify(cart));    XHR.onreadystatechange = function () {        if (XHR.readyState == 4) {            if (XHR.status == 200) {                var response = XHR.responseText;                response = response.toString();                if (response.trim() === 'Successful') {                    alert("Order has been placed Successfully.");                    window.location = "index.jsp";                } else {                    alert("Order Request Failed");                }            }        }    };    XHR.open("POST", "OrderRequestServlet", true);    XHR.setRequestHeader("Content-type", "application/x-www-form-urlencoded");    XHR.send("orderRequestJSON=" + escape(JSON.stringify(cart)));}function plus(inpobj) {    var a = inpobj.getElementsByTagName("input")[0].value;    var inventory = inpobj.getElementsByTagName("input")[0].size;    if (parseInt(a) == inventory) {        alert("Maximum Order Limit Reached for this Product...");        return;    }    var quant = parseInt(a) + 1;    inpobj.getElementsByTagName("input")[0].value = quant;    var productName = (inpobj.parentNode.parentNode.cells[1].innerHTML.split("<br>")[0]).trim();    total();    updateCart(productName, quant);}function minus(inpobj) {    var a = inpobj.getElementsByTagName("input")[0].value;    a = parseInt(a);    if (a !== 1) {        var quant = parseInt(a) - 1;        var productName = (inpobj.parentNode.parentNode.cells[1].innerHTML.split("<br>")[0]).trim();        inpobj.getElementsByTagName("input")[0].value = quant;        total();        updateCart(productName, quant);    }}function removeRow(inpobj) {    nodetd = inpobj.parentNode;    nodetr = nodetd.parentNode;    //alert(nodetr.innerHTML);    nodetr.parentNode.removeChild(nodetr);    var productName = (nodetr.cells[1].innerHTML.split("<br>")[0]).trim();   // alert(productName);   // alert(JSON.stringify(cart));    var ind = -1;    for (var i in cart.orderdetails) {        if (cart.orderdetails[i].productname == productName) {            ind = i;            break;        }    }    if (ind != -1) {        cart.orderdetails.splice(ind, 1);    }   // alert(JSON.stringify(cart));    refreshCart();    total();}function total() {    var table = document.getElementById("totalTable");    var row = table.getElementsByTagName("tr");    var rows = table.rows.length;    var total = 0;   // var totalTax = 0;    var totalCost = 0;    //for (var i = 1; i < rows - 3; i++) {      for (var i = 1; i < rows - 2; i++) {        var totR = parseFloat((row[i].cells[3].innerHTML).replace("$", ""));        var totalRow = parseInt(row[i].getElementsByTagName("input")[0].value) * totR;        totalRow = totalRow.toFixed(2);        row[i].cells[4].innerHTML = "$" + totalRow;        total = parseFloat(total) + parseFloat((row[i].cells[4].innerHTML).replace("$", ""));      //  totalTax = totalTax + parseFloat((row[i].cells[4].innerHTML).replace("$", ""));        total = total.toFixed(2);             //  totalTax = Math.round(totalTax * 100) / 100;    }    //totalCost = (parseFloat(total) + parseFloat(totalTax)).toFixed(2);      totalCost = (parseFloat(total)).toFixed(2);    document.getElementById("totalvalue").innerHTML = "$" + total;   // document.getElementById("totalTax").innerHTML = "$" + totalTax;    document.getElementById("totalCost").innerHTML = "<strong> $" + totalCost + "</strong>";}function fetchProducts() {    var XHR = createXMLHttpRequest();    var productRequestJSON = {        "requestType": "FetchProducts"    };    XHR.onreadystatechange = function () {        addProducts(XHR);    };    XHR.open("POST", "ProductManagementServlet", true);    XHR.setRequestHeader("Content-type", "application/x-www-form-urlencoded");    XHR.send("productRequestJSON=" + escape(JSON.stringify(productRequestJSON)));}function addProducts(XHR) {    if (XHR.readyState == 4) {        if (XHR.status == 200) {            var response = XHR.responseText;            //alert(response);            var productsArrayJSON = JSON.parse(response);            allProductsJSON = productsArrayJSON;            var productTag = "";            for (var i in productsArrayJSON) {                productTag += "<li class=\"span3\">";                productTag += "<div class=\"thumbnail\">";                productTag += "<a  href=\"product_details.jsp\"><img src=\"" + productsArrayJSON[i].url + "\" alt=\"\"/></a>";                productTag += "<div class=\"caption\">";                productTag += "<h5>" + productsArrayJSON[i].productName + "</h5>";                productTag += "<p>" + productsArrayJSON[i].productDescription + "</p>";                productTag += "<h4 style=\"text-align:center\">"                if(username == 'admin'){                    productTag += "<a class=\"btn btn-danger\" href=\"javascript:deleteProduct('"+productsArrayJSON[i].productId+"')\"> Delete</a> ";                    productTag += "<a class=\"btn\" href=\"#updateProductdiv\" onclick=\"getProduct('"+productsArrayJSON[i].productId+"')\" role=\"button\" data-toggle=\"modal\" >Edit </a> <a class=\"btn btn-primary\" href=\"#\">" + productsArrayJSON[i].productPrice + "</a></h4></div></div></li>"                }                else{                    productTag += "<a class=\"btn\" href=\"#\" onclick=\"addToCart(this.parentNode)\">Add to <i class=\"icon-shopping-cart\"></i></a> <a class=\"btn btn-primary\" href=\"#\">" + productsArrayJSON[i].productPrice + "</a></h4></div></div></li>";                }            }            //alert(productTag);            document.getElementById("allProducts").innerHTML = productTag;        }    }}function deleteProduct(productId) {    var XHR = createXMLHttpRequest();    var productRequestJSON = {        "requestType": "deleteProduct",        "productId" : productId    };    XHR.onreadystatechange = function () {        if (XHR.readyState == 4) {            if (XHR.status == 200) {                var response = XHR.responseText;                if (response.trim() == 'Successful') {                   alert("Product Deleted Successfully.");                   window.location = "";                }                else{                    alert("Failed to Delete the Product");                }            }        }    };    XHR.open("POST", "ProductManagementServlet", true);    XHR.setRequestHeader("Content-type", "application/x-www-form-urlencoded");    XHR.send("productRequestJSON=" + escape(JSON.stringify(productRequestJSON)));}function getProduct(productId) {    var XHR = createXMLHttpRequest();    var productRequestJSON = {        "requestType": "getProduct",        "productId" : productId    };    XHR.onreadystatechange = function () {        if (XHR.readyState == 4) {            if (XHR.status == 200) {                var response = XHR.responseText;                var productJSON = JSON.parse(response);                for(var i in productJSON){                    var j = "" + i + "1";                    document.getElementById(j).value = productJSON[i];                }                document.getElementById("product_id1").disabled = true;            }        }    };    XHR.open("POST", "ProductManagementServlet", true);    XHR.setRequestHeader("Content-type", "application/x-www-form-urlencoded");    XHR.send("productRequestJSON=" + escape(JSON.stringify(productRequestJSON)));}function updateProduct() {    var XHR = createXMLHttpRequest();    var updateProductJSON = {};    var productFormElements = document.forms["updateProductForm"].querySelectorAll("input,select");    for (var i = 0; i < productFormElements.length; i++) {        updateProductJSON[(productFormElements[i].id).toString()] = productFormElements[i].value;    }    var productRequestJSON = {        "requestType": "updateProduct",        "updateProductJSON": updateProductJSON    };    XHR.onreadystatechange = function () {        if (XHR.readyState == 4) {            if (XHR.status == 200) {                var response = XHR.responseText;                response = response.toString();                if (response.trim() === 'Successful') {                    alert("Product Details Updated Successfully.");                    window.location = "";                } else {                    alert("Failed to Update Product Details");                }            }        }    };    XHR.open("POST", "ProductManagementServlet", true);    XHR.setRequestHeader("Content-type", "application/x-www-form-urlencoded");    XHR.send("productRequestJSON=" + escape(JSON.stringify(productRequestJSON)));}function getImageURL(productName) {    var detailsArray = [];    for (var i in allProductsJSON) {        if (allProductsJSON[i].productName == productName.toString().trim()) {            detailsArray.push(allProductsJSON[i].url);            detailsArray.push(allProductsJSON[i].inventory_amount);            detailsArray.push(allProductsJSON[i].productId);            return detailsArray;        }    }}function flushCart() {    var XHR = createXMLHttpRequest();    XHR.onreadystatechange = function () {    };    XHR.open("POST", "ShoppingCartServlet", false);    XHR.setRequestHeader("Content-type", "application/x-www-form-urlencoded");    XHR.send("cartJSON=" + escape(JSON.stringify(cart)));}function loadCartOnStartup(cartJSONString) {    if (null != cartJSONString && "null" != cartJSONString && '' != cartJSONString) {        cart = null;        cart = JSON.parse(cartJSONString);    }}function checkProductInCart(productName) {    for (var i in cart.orderdetails) {        if (cart.orderdetails[i].productname == productName) {            return true;        }    }    return false;}function search() {    var searchItem = (document.getElementById("srchFld").value).toString().trim();    var searchCat = (document.getElementById("searchCat").value).toString().trim();    var XHR = createXMLHttpRequest();    var productRequestJSON = {        "requestType": "SearchProducts",        "searchQuery": searchItem,        "searchCategory" : searchCat    };    XHR.onreadystatechange = function () {        addProducts(XHR);    };    XHR.open("POST", "ProductManagementServlet", true);    XHR.setRequestHeader("Content-type", "application/x-www-form-urlencoded");    XHR.send("productRequestJSON=" + escape(JSON.stringify(productRequestJSON)));}function home_business(obj) {    var business = "<div class=\"control-group\" id=\"id_business\" >";    business += "<label for=\"business_category\" style=\"display:inline-block;vertical-align:middle;\">Business Category :</label> <input type=\"text\" id=\"business_category\"  style=\"display:inline-block;vertical-align:middle;\" placeholder=\"Business Category\" required=\"true\">";    business += "<label for=\"gross_income\" style=\"display:inline-block;vertical-align:middle;\">Gross Income :</label> <input type=\"number\" id=\"gross_income\" step=\"any\" min=\"1\"  style=\"display:inline-block;vertical-align:middle;\" placeholder=\"Gross Income\" required=\"true\"></div>";    var home = "<div class=\"control-group\" id=\"id_home\" style=\"display: block\">";    home += "<label for=\"marriage_status\" style=\"display:inline-block;vertical-align:middle;\">Marriage Status :</label> <select id=\"marriage_status\" ><option selected=\"selected\" value=\"Married\">Married</option><option  value=\"Unmarried\">Unmarried</option> <option  value=\"Widowed\">Widowed</option><option  value=\"Separated\">Separated</option></select>";    home += "<label for=\"gender\" style=\"display:inline-block;vertical-align:middle;\">Gender :</label> <select id=\"gender\"><option value=\"Male\">Male</option><option value=\"Female\">Female</option></select>";    home += "<label for=\"age\" style=\"display:inline-block;vertical-align:middle;\">Age :</label> <input type=\"number\" id=\"age\" min=\"1\" step=\"1\" style=\"display:inline-block;vertical-align:middle;\" placeholder=\"Age\" required=\"true\">";    home += "<label for=\"income\" style=\"display:inline-block;vertical-align:middle;\">Income :</label> <input type=\"number\" id=\"income\" step=\"any\" min=\"1\" style=\"display:inline-block;vertical-align:middle;\" placeholder=\"Income\" required=\"true\"></div>";    if (obj.selectedIndex == 0) {        document.getElementById("id_home_business").innerHTML = home;        return;    }    document.getElementById("id_home_business").innerHTML = business;}function salesAggregate(aggType, tableId) {    // var searchItem=(document.getElementById("srchFld").value).toString().trim();    var XHR = createXMLHttpRequest();    var productRequestJSON = {        "requestType": "SalesAggregate",        "aggregationType": aggType    };    XHR.onreadystatechange = function () {        renderAggregateTable(XHR, tableId);    };    XHR.open("POST", "ProductManagementServlet", true);    XHR.setRequestHeader("Content-type", "application/x-www-form-urlencoded");    XHR.send("productRequestJSON=" + escape(JSON.stringify(productRequestJSON)));}function renderAggregateTable(XHR, tableId) {    var aggregateTable = document.getElementById(tableId);    if (XHR.readyState == 4) {        if (XHR.status == 200) {            var response = XHR.responseText;            //alert(response);            var aggregateJSONArray = JSON.parse(response);            var columnNames = aggregateJSONArray[0].columnNames;            var columnHeaders = "";            for (var i = 0; i < columnNames.length; i++) {                columnHeaders += "<th>" + columnNames[i] + "</th>";            }            var thead = "<thead><tr>" + columnHeaders + "</tr></thead>";            var columnValuesInRow = aggregateJSONArray[1].columnValues;            var rows = "";            for (var j = 0; j < columnValuesInRow.length; j++) {                var columnValues = columnValuesInRow[j];                var cols = "";                for (var k = 0; k < columnValues.length; k++) {                    cols += "<td>" + columnValues[k] + "</td>"                }                rows += "<tr>" + cols + "</tr>";            }            var tbody = "<tbody>" + rows + "</tbody>";            //alert(thead+tbody);            aggregateTable.innerHTML = thead + tbody;        }    }}
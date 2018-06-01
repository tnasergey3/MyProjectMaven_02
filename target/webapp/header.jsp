<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 28.11.2017
  Time: 04:46
  To change this template use File | Settings | File Templates.
--%>
<%
    //String result1_str = null;
    session = request.getSession(true);

    if(session.getAttribute("role") == "null") {
        //session.invalidate();
        session.setAttribute("role", "Guest");
        session.setAttribute("statusLoginInHeader", "Sign in or Create an account");
        session.setAttribute("amountProductsInShoppingBag", "0");
        session.setAttribute("quantityProductsInShoppingBag", "0");
    } else {
//        String roleUser_str = request.getParameter("role");

//        // Connect to database
//        String hostName = "sqlserverdb0.database.windows.net";
//        String dbName = "luxuryWatchesDB";
//        String user = "sqladmin";
//        String password = "80978986707sS";
//        String url = String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;", hostName, dbName, user, password);
//        Connection connection = null;
//        Statement statement = null;

//        try {
//            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//            connection = DriverManager.getConnection(url);
//            statement = connection.createStatement();
//
//            // Выборка стоимости товаров в корзине конкретного пользователя
//            String query = "SELECT SUM(product_price) FROM Shoppingbag WHERE client = (SELECT listUsers_id FROM ListUsers WHERE listUsers_Email = '" + roleUser_str + "'";
//            ResultSet result1 = statement.executeQuery(query);
//
//            result1.first();
//            session.setAttribute("summPriceOfShoppingBag", result1.getInt(1));
//
//            // Выборка количества товаров в корзине конкретного пользователя
//            query = "SELECT COUNT(product_price) FROM Shoppingbag WHERE client = (SELECT listUsers_id FROM ListUsers WHERE listUsers_Email = '" + roleUser_str + "'";
//            result1 = statement.executeQuery(query);
//
//            result1.first();
//            session.setAttribute("statusOfShoppingBag", result1.getString(1));
//
//        } catch (Exception ex) {
//            //выводим наиболее значимые сообщения
//            Logger.getLogger(AccountServlet.class.getName()).log(Level.SEVERE, null, ex);
//        } finally {
//            if (connection != null) {
//                try {
//                    connection.close();
//                } catch (SQLException ex) {
//                    Logger.getLogger(AccountServlet.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
//        }
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Luxury Watches</title>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
    <!--jQuery(necessary for Bootstrap's JavaScript plugins)-->
    <script src="js/jquery-1.11.0.min.js"></script>
    <!--Custom-Theme-files-->
    <!--theme-style-->
    <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
    <!--//theme-style-->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Luxury Watches, watch" />
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    <!--start-menu-->
    <script src="js/simpleCart.min.js"> </script>
    <link href="css/memenu.css" rel="stylesheet" type="text/css" media="all" />
    <script type="text/javascript" src="js/memenu.js"></script>
    <script>$(document).ready(function(){$(".memenu").memenu();});</script>
    <!--dropdown-->
    <script src="js/jquery.easydropdown.js"></script>
</head>
<body>
<!--top-header-->
<div class="top-header">
    <div class="container">
        <div class="top-header-main">
            <div class="col-md-6 top-header-left">
                <div class="drop">
                    <div class="box">
                        <select tabindex="4" class="dropdown drop">
                            <option value="" class="label">Dollar :</option>
                            <option value="1">Dollar</option>
                            <option value="2">Euro</option>
                        </select>
                    </div>
                    <%--<div class="box1">--%>
                    <%--<select tabindex="4" class="dropdown">--%>
                    <%--<option value="" class="label">English :</option>--%>
                    <%--<option value="1">English</option>--%>
                    <%--<option value="2">French</option>--%>
                    <%--<option value="3">German</option>--%>
                    <%--</select>--%>
                    <%--</div>--%>
                    <div class="clearfix"></div>
                </div>
            </div>
            <div class="col-md-6 top-header-left">
                <div class="login" style="visibility:visible;">
                    Hello <span id="user_login" style="font-weight:bold;">${ role }</span>
                    <div style="visibility:visible;">
                        <a href="AccountServlet">
                            <div class="">
                                <span class="login" style="color:rgba(255, 255, 255, 0.6);">${ statusLoginInHeader }</span>
                            </div>
                        </a>
                    </div>
                    <!-- <div class="clearfix"> </div>  -->
                </div>

                <div class="cart box_1">
                    <a href="checkout.jsp">
                        <div class="total">
                            <%--<span class="simpleCart_total"></span></div>--%>
                        <span class="">Amount:&nbsp ${ amountProductsInShoppingBag } $</span></div>
                        <img src="images/cart-1.png" alt="" />
                    </a>
                    <p><a href="javascript:;" class="simpleCart_empty">Quantity:&nbsp ${ quantityProductsInShoppingBag }&nbsp pr.</a></p>
                    <div class="clearfix"> </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
</div>
<!--top-header-->
<!--start-logo-->
<div class="logo">
    <a href="index.jsp"><h3>
        Luxury Watches </br>
        Role: ${role}   </br>
        ID Session: ${pageContext.session.id} </br>
        amountProductsInShoppingBag: ${amountProductsInShoppingBag} </br>
        quantityProductsInShoppingBag: ${quantityProductsInShoppingBag} </br>
    </h3></a>
</div>
<!--start-logo-->
<!--bottom-header-->
<div class="header-bottom">
    <div class="container">
        <div class="header">
            <div class="col-md-9 header-left">
                <div class="top-nav">
                    <ul class="memenu skyblue" class="menu"><li class="active"><a href="index.jsp">Home</a></li>
                        <li class="grid"><a href="#">Men</a>
                            <div class="mepanel">
                                <div class="row">
                                    <div class="col1 me-one">
                                        <h4>Watches by style</h4>
                                        <ul>
                                            <li><a href="products.jsp">Automatic</a></li>
                                            <li><a href="products.jsp">Casual</a></li>
                                            <li><a href="products.jsp">Ceramic</a></li>
                                            <li><a href="products.jsp">Chronograph</a></li>
                                            <li><a href="products.jsp">Diamond</a></li>
                                            <li><a href="products.jsp">Digital</a></li>
                                            <li><a href="products.jsp">Diving</a></li>
                                         </ul>
                                    </div>
                                    <div class="col1 me-one">
                                        <h4>Watch accessories</h4>
                                        <ul>
                                            <li><a href="products.jsp">Collectors Cases</a></li>
                                            <li><a href="products.jsp">Replacement Bands</a></li>
                                            <li><a href="products.jsp">Toolkits</a></li>
                                            <li><a href="products.jsp">Coats</a></li>
                                            <li><a href="products.jsp">Watch Boxes</a></li>
                                            <li><a href="products.jsp">Watch Winders</a></li>
                                        </ul>
                                    </div>
                                    <div class="col1 me-one">
                                        <h4>Popular brands</h4>
                                        <ul>
                                            <li><a href="MenuMaintenanceServlet?brand=Rolex">Rolex</a></li>
                                            <li><a href="MenuMaintenanceServlet?brand=Cartier">Cartier</a></li>
                                            <li><a href="MenuMaintenanceServlet?brand=Casio">Casio</a></li>
                                            <li><a href="MenuMaintenanceServlet?brand=Fossil">Fossil</a></li>
                                            <li><a href="MenuMaintenanceServlet?brand=Maxima">Maxima</a></li>
                                            <li><a href="MenuMaintenanceServlet?brand=Timex">Timex</a></li>
                                            <li><a href="MenuMaintenanceServlet?brand=TomTom">TomTom</a></li>
                                            <li><a href="MenuMaintenanceServlet?brand=Titan">Titan</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="grid"><a href="#">Women</a>
                            <div class="mepanel">
                                <div class="row">
                                    <div class="col1 me-one">
                                        <h4>Watches by style</h4>
                                        <ul>
                                            <li><a href="products.jsp">Fashion</a></li>
                                            <li><a href="products.jsp">Casual</a></li>
                                            <li><a href="products.jsp">Ceramic</a></li>
                                            <li><a href="products.jsp">Chronograph</a></li>
                                            <li><a href="products.jsp">Diamond</a></li>
                                            <li><a href="products.jsp">Digital</a></li>
                                            <li><a href="products.jsp">Diving</a></li>
                                        </ul>
                                    </div>
                                    <div class="col1 me-one">
                                        <h4>Watch accessories</h4>
                                        <ul>
                                            <li><a href="products.jsp">Collectors Cases</a></li>
                                            <li><a href="products.jsp">Replacement Bands</a></li>
                                            <li><a href="products.jsp">Toolkits</a></li>
                                            <li><a href="products.jsp">Coats</a></li>
                                            <li><a href="products.jsp">Watch Boxes</a></li>
                                            <li><a href="products.jsp">Watch Winders</a></li>
                                        </ul>
                                    </div>
                                    <div class="col1 me-one">
                                        <h4>Popular brands</h4>
                                        <ul>
                                            <li><a href="products.jsp">Rolex</a></li>
                                            <li><a href="products.jsp">Cartier</a></li>
                                            <li><a href="products.jsp">Casio</a></li>
                                            <li><a href="products.jsp">Fossil</a></li>
                                            <li><a href="products.jsp">Maxima</a></li>
                                            <li><a href="products.jsp">Timex</a></li>
                                            <li><a href="products.jsp">TomTom</a></li>
                                            <li><a href="products.jsp">Titan</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="grid"><a href="typo.jsp">Unisex</a>
                            <div class="mepanel">
                                <div class="row">
                                    <div class="col1 me-one">
                                        <h4>Watches by style</h4>
                                        <ul>
                                            <li><a href="products.jsp">Automatic111</a></li>
                                            <li><a href="products.jsp">Casual</a></li>
                                            <li><a href="products.jsp">Ceramic</a></li>
                                            <li><a href="products.jsp">Chronograph</a></li>
                                            <li><a href="products.jsp">Diamond</a></li>
                                            <li><a href="products.jsp">Digital</a></li>
                                            <li><a href="products.jsp">Diving</a></li>
                                        </ul>
                                    </div>
                                    <div class="col1 me-one">
                                        <h4>Watch accessories</h4>
                                        <ul>
                                            <li><a href="products.jsp">Collectors Cases</a></li>
                                            <li><a href="products.jsp">Replacement Bands</a></li>
                                            <li><a href="products.jsp">Toolkits</a></li>
                                            <li><a href="products.jsp">Coats</a></li>
                                            <li><a href="products.jsp">Watch Boxes</a></li>
                                            <li><a href="products.jsp">Watch Winders</a></li>
                                        </ul>
                                    </div>
                                    <div class="col1 me-one">
                                        <h4>Popular brands</h4>
                                        <ul>
                                            <li><a href="products.jsp">Rolex</a></li>
                                            <li><a href="products.jsp">Fastrack</a></li>
                                            <li><a href="products.jsp">Casio</a></li>
                                            <li><a href="products.jsp">Fossil</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li><a href="typo.jsp">Brands</a>
                        </li>
                        <li class="grid"><a href="contact.jsp">Contact</a>
                        </li>
                    </ul>
                </div>
                <div class="clearfix"> </div>
            </div>
            <div class="col-md-3 header-right">
                <div class="search-bar">
                    <input type="text" value="Search" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Search';}">
                    <input type="submit" value="">
                </div>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
</div>

<!--bottom-header-->

<%@ page import="java.util.logging.Logger" %>
<%@ page import="com.AccountServlet" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 28.11.2017
  Time: 03:58
  To change this template use File | Settings | File Templates.
--%>
<%
    session = request.getSession(true);
    String roleUser_str = (String) session.getAttribute("role");
    //Список для хранения товаров в корзине
    List<Product> listProductsInShoppingbag = new ArrayList<Product>();
    // Количество товаров в корзине
    String countProductInShoppingbag = null;


    // Connect to database
    String hostName = "sqlserverdb0.database.windows.net";
    String dbName = "luxuryWatchesDB";
    String user = "sqladmin";
    String password = "80978986707sS";
    String url = String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;hostNameInCertificate=*.database.windows.net;loginTimeout=30;", hostName, dbName, user, password);
    Connection connection = null;

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        connection = DriverManager.getConnection(url);

        Statement statement = null;
        statement = connection.createStatement();

        String query = "SELECT COUNT(shoppingbag_id) FROM Shoppingbag" ;
        ResultSet result1 = statement.executeQuery(query);

        //result это указатель на первую строку с выборки
        //чтобы вывести данные мы будем использовать
        //метод next() , с помощью которого переходим к следующему элементу
            while (result1.next()) {
                countProductInShoppingbag = result1.getString(1);
            }

        // Чтение из базы содержимого корзины
        String query2 = "SELECT * FROM Shoppingbag";
        ResultSet result2 = statement.executeQuery(query2);

        while (result2.next()) {

//            Product prodShoppingbag = new Product();
//            prodShoppingbag. = result1.getString("product_id");
//            prod.product_name = result1.getString("product_name");
//            prod.category = Integer.parseInt(result1.getString("category"));
//            prod.brand = Integer.parseInt(result1.getString("brand"));
//            prod.product_description_short = result1.getString("product_description_short");
//            prod.product_description_long = result1.getString("product_description_long");
//            prod.color = Integer.parseInt(result1.getString("color"));
//            prod.size = result1.getString("size");
//            prod.discount = Integer.parseInt(result1.getString("discount"));
//            prod.product_price = Integer.parseInt(result1.getString("product_price"));
//            prod.product_tag = result1.getString("product_tag");
//            prod.product_review = result1.getString("product_review");
//            prod.product_sku = result1.getString("product_sku");
//            prod.product_picture01 = result1.getString("product_picture01");
//            prod.product_picture02 = result1.getString("product_picture02");
//            prod.product_picture03 = result1.getString("product_picture03");
//
//            listProducts.add(prod);
//            request.setAttribute("listProducts", listProducts);
        }

    } catch (Exception ex) {
        //выводим наиболее значимые сообщения
        Logger.getLogger(AccountServlet.class.getName()).log(Level.SEVERE, null, ex);
    } finally {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AccountServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file = "header.jsp" %>

<!--start-breadcrumbs-->
<div class="breadcrumbs">
    <div class="container">
        <div class="breadcrumbs-main">
            <ol class="breadcrumb">
                <li><a href="index.jsp">Home</a></li>
                <li class="active">Checkout</li>
            </ol>
        </div>
    </div>
</div>
<!--end-breadcrumbs-->
<!--start-ckeckout-->
<div class="ckeckout">
    <div class="container">
        <div class="ckeck-top heading">
            <h2>CHECKOUT</h2>
        </div>
        <div class="ckeckout-top">
            <div class="cart-items">
                <h3>My Shopping Bag</h3>
                <script>$(document).ready(function(c) {
                    $('.close1').on('click', function(c){
                        $('.cart-header').fadeOut('slow', function(c){
                            $('.cart-header').remove();
                        });
                    });
                });
                </script>
                <script>$(document).ready(function(c) {
                    $('.close2').on('click', function(c){
                        $('.cart-header1').fadeOut('slow', function(c){
                            $('.cart-header1').remove();
                        });
                    });
                });
                </script>
                <script>$(document).ready(function(c) {
                    $('.close3').on('click', function(c){
                        $('.cart-header2').fadeOut('slow', function(c){
                            $('.cart-header2').remove();
                        });
                    });
                });
                </script>

                <div class="in-check" >
                    <ul class="unit">
                        <li><span>Item</span></li>
                        <li><span>Product Name</span></li>
                        <li><span>Unit Price</span></li>
                        <li><span>Delivery Details</span></li>
                        <li> </li>
                        <div class="clearfix"> </div>
                    </ul>
                    <%
                        int countProductInShoppingbag_int = Integer.parseInt(countProductInShoppingbag);
                        for (int i = 0; i < countProductInShoppingbag_int; i++){
                            out.println("<ul class=\"cart-header\">");
                            out.println("<div class=\"close1\"> </div>");
                            out.println("<li class=\"ring-in\"><a href=\"single.jsp\" ><img src=\"images/c-1.jpg\" class=\"img-responsive\" alt=\"\"></a></li>");
                            out.println("<li><span class=\"name\">Analog Watches</span></li>");
                            out.println("<li><span class=\"cost\">$ 290.00</span></li>");
                            out.println("<li><span>Free</span>");
                            out.println("<p>Delivered in 2-3 weeks days</p></li>");
                            out.println("<div class=\"clearfix\"> </div>");
                            out.println("</ul>");
                        }
                    %>
                    <%--<ul class="cart-header">--%>
                        <%--<div class="close1"> </div>--%>
                        <%--<li class="ring-in"><a href="single.jsp" ><img src="images/c-1.jpg" class="img-responsive" alt=""></a>--%>
                        <%--</li>--%>
                        <%--<li><span class="name">Analog Watches</span></li>--%>
                        <%--<li><span class="cost">$ 290.00</span></li>--%>
                        <%--<li><span>Free</span>--%>
                            <%--<p>Delivered in 2-3 business days</p></li>--%>
                        <%--<div class="clearfix"> </div>--%>
                    <%--</ul>--%>
                    <%--<ul class=" cart-header1">--%>
                        <%--<div class="close2"> </div>--%>
                        <%--<li class="ring-in"><a href="single.jsp" ><img src="images/c-2.jpg" class="img-responsive" alt=""></a>--%>
                        <%--</li>--%>
                        <%--<li><span class="name">Analog Watches</span></li>--%>
                        <%--<li><span class="cost">$ 300.00</span></li>--%>
                        <%--<li><span>Free</span>--%>
                            <%--<p>Delivered in 2-3 business days</p></li>--%>
                        <%--<div class="clearfix"> </div>--%>
                    <%--</ul>--%>
                    <%--<ul class="cart-header2">--%>
                        <%--<div class="close3"> </div>--%>
                        <%--<li class="ring-in"><a href="single.jsp" ><img src="images/c-3.jpg" class="img-responsive" alt=""></a>--%>
                        <%--</li>--%>
                        <%--<li><span class="name">Analog Watches</span></li>--%>
                        <%--<li><span class="cost">$ 360.00</span></li>--%>
                        <%--<li><span>Free</span>--%>
                            <%--<p>Delivered in 2-3 business days</p></li>--%>
                        <%--<div class="clearfix"> </div>--%>
                    <%--</ul>--%>
                </div>
            </div>
        </div>
    </div>
</div>
<!--end-ckeckout-->

<%@ include file = "footer.jsp" %>
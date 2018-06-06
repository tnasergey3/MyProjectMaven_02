<%@ page import="java.util.logging.Logger" %>
<%@ page import="com.AccountServlet" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.ProductInShoppingbag" %>
<%@ page import="com.Purchases" %><%--
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
    List<Purchases> listProductsOfPurchases = new ArrayList<>();
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

        // Чтение из базы содержимого корзины
        String query333 = "SELECT * FROM Purchase WHERE client = (SELECT listUsers_id FROM ListUsers WHERE listUsers_Email = " + "'" + roleUser_str + "'" + ")";
        ResultSet result11 = statement.executeQuery(query333);

        while (result11.next()) {

            Purchases purchases = new Purchases();
            purchases.purchase_id = Integer.parseInt(result11.getString("purchase_id"));
            purchases.purchase_date = result11.getString("purchase_date");
            purchases.client = Integer.parseInt(result11.getString("client"));
            purchases.status = result11.getString("status");
            purchases.product_id = Integer.parseInt(result11.getString("product_id"));
            purchases.product_name = result11.getString("product_name");
            purchases.product_price = Integer.parseInt(result11.getString("product_price"));
            purchases.product_img01 = result11.getString("product_img01");

            listProductsOfPurchases.add(purchases);
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
            <h2>Purchases: ... for testing ...</h2>
        </div>
        <div class="ckeckout-top">
            <div class="cart-items">

                <%
                    for (int i = 0; i < listProductsOfPurchases.size(); i++){  %>


                <script>
                    <%--$(document).ready(function(c) {--%>
                        <%--$('.close<%= i %>').on('click', function(c){--%>
                            <%--$('.cart-header<%= i %>').fadeOut('slow', function(c){--%>
                                <%--$('.cart-header<%= i %>').remove();--%>
                                <%--//alert('<%= listProductsOfPurchases.get(i).product_name %>');--%>

                                <%--$.ajax({--%>
                                    <%--type: "POST",--%>
                                    <%--url: "DeleteFromShoppingBagServlet",--%>
                                    <%--data: "client_del=<%= listProductsOfPurchases.get(i).client %>&product_id_del=<%= listProductsOfPurchases.get(i).product_id %>",--%>
                                    <%--success: function(data) {--%>
<%--//                                        alert("Success");--%>
                                        <%--location.reload();--%>
                                    <%--},--%>
                                    <%--error: function(data){--%>
<%--//                                        alert("Not success");--%>
                                    <%--}--%>
                                <%--});--%>
                            <%--});--%>
                        <%--});--%>
                    <%--});--%>
                </script>
                <%  } %>

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
                        // Создание разметки корзины
                        for (int i = 0; i < listProductsOfPurchases.size(); i++){ %>
                            <ul class="cart-header<%= i %>">
                                <div class="close<%= i %>" value="123456"></div>
                                    <li class="ring-in"><a href="single.jsp" ><img width="100px" height="100px" src=" <%= listProductsOfPurchases.get(i).product_img01 %>" class="img-responsive" alt=""></a></li>
                                    <li><span class="name"> <%= listProductsOfPurchases.get(i).product_name %> </span></li>
                                    <li><span class="cost"> $ <%= listProductsOfPurchases.get(i).product_price %> </span></li>
                                    <li><span>Free</span>
                                    <p>Delivered in 2-3 weeks</p></li>
                                <div class="clearfix"> </div>
                            </ul>
                    <%  }  %>

                </div>
                <ul class="unit" style="background: #BCBBBB;">
                    <li><span></span></li>
                    <li><span style="font-weight:bold">Quantity: &nbsp ${quantityProductsInPurchase} &nbsp pr.</span></li>
                    <li><span style="font-weight:bold">Total price: &nbsp $ &nbsp ${amountProductsInPurchase}</span></li>
                    <li><span style="font-weight:bold">  </span></li>
                    <div class="clearfix"> </div>
                </ul>
            </div>
        </div>
        <div >
    </div>
</div>
<!--end-ckeckout-->

<%@ include file = "footer.jsp" %>
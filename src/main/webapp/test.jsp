<%@ page import="com.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 13.05.2018
  Time: 5:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    List<Product> listProducts = (ArrayList<Product>)request.getAttribute("listProducts");

//    for(Product listProduct : listProducts)
//    {
//        out.print("Name: " + listProduct.product_name);
//        out.print("<br/>");
//        out.print("Id: " + listProduct.product_id);
//        out.print("<br/>");
//        out.print("description_long: " + listProduct.product_description_long);
//        out.print("<br/>");
//        out.print("description_short: " + listProduct.product_description_short);
//        out.print("<br/>");
//    }
    out.print("Past for ... " + listProducts.get(0).product_name);
    out.print("<br/>");
    listProducts.get(0).Get_product_name();
    out.print("<br/>");
    out.print("02: ");


%>

<%= listProducts.get(0).Get_product_name() %>
</body>
</html>

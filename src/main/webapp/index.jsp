<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="com.AccountServlet" %>
<%@ page import="java.util.logging.Level" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.ProductInShoppingbag" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.Product" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 28.11.2017
  Time: 03:33
  To change this template use File | Settings | File Templates.
--%>


<%
  // Создание "гостя"
  session = request.getSession(true);
  if (session.getAttribute("statusLoginInHeader") == null) {
    session.setAttribute("role", "Guest");
    session.setAttribute("statusLoginInHeader", "Sign in or Create an account");
    session.setAttribute("amountProductsInShoppingBag", "0");
    session.setAttribute("quantityProductsInShoppingBag", "0");
    // Подключение к базе данных нет, его нужно создать
    session.setAttribute("connectToDB", "connect");
    request.getRequestDispatcher("/index.jsp").forward(request, response);
  } else {
    // Подключение к базе данных есть, его не нужно создать
    session.setAttribute("connectToDB", "connect");
  }

  //
  // Выборка количества товаров из базы
  int countProducts = 0;
  //Список для хранения количества видов товаров в базе
  List<Product> listProductsForIndexJSP = new ArrayList<>();
  // Список для хранения чисел для проверки на повтроры
  List<Integer> listRandom = new ArrayList<>();

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
    Statement statement = connection.createStatement();

    // Выборка количества товаров в корзине конкретного пользователя
    String query  = "SELECT COUNT(product_id) FROM Product";
    ResultSet result1 = statement.executeQuery(query);

    while (result1.next()) {
      countProducts = Integer.parseInt(result1.getString(1));
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

  //
  // Прочитать данные из базы и загрузить в список
  try {
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    connection = DriverManager.getConnection(url);
    Statement statement = connection.createStatement();

    //
    // Чтение из базы содержимого корзины
    String query333 = "SELECT * FROM Product";
    ResultSet result1 = statement.executeQuery(query333);

    while (result1.next()) {

      Product prod = new Product();
      prod.product_id = Integer.parseInt(result1.getString("product_id"));
      prod.product_name = result1.getString("product_name");
      prod.category = Integer.parseInt(result1.getString("category"));
      prod.brand = Integer.parseInt(result1.getString("brand"));
      prod.product_description_short = result1.getString("product_description_short");
      prod.product_description_long = result1.getString("product_description_long");
      prod.color = Integer.parseInt(result1.getString("color"));
      prod.size = result1.getString("size");
      prod.discount = Integer.parseInt(result1.getString("discount"));
      prod.product_price = Integer.parseInt(result1.getString("product_price"));
      prod.product_tag = result1.getString("product_tag");
      prod.product_review = result1.getString("product_review");
      prod.product_sku = result1.getString("product_sku");
      prod.product_picture01 = result1.getString("product_picture01");
      prod.product_picture02 = result1.getString("product_picture02");
      prod.product_picture03 = result1.getString("product_picture03");

      listProductsForIndexJSP.add(prod);
      //request.setAttribute("listProducts", listProducts);
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

<%@ include file = "header.jsp" %>

<!--banner-starts-->
<div class="bnr" id="home">
  <div  id="top" class="callbacks_container">
    <ul class="rslides" id="slider4">
      <li>
        <img src="images/bnr-1.jpg" alt=""/>
      </li>
      <li>
        <img src="images/bnr-2.jpg" alt=""/>
      </li>
      <li>
        <img src="images/bnr-3.jpg" alt=""/>
      </li>
    </ul>
  </div>
  <div class="clearfix"> </div>
</div>
<!--banner-ends-->

<!--Slider-Starts-Here-->
<script src="js/responsiveslides.min.js"></script>
<script>
    // You can also use "$(window).load(function() {"
    $(function () {
        // Slideshow 4
        $("#slider4").responsiveSlides({
            auto: true,
            pager: true,
            nav: true,
            speed: 500,
            namespace: "callbacks",
            before: function () {
                $('.events').append("<li>before event fired.</li>");
            },
            after: function () {
                $('.events').append("<li>after event fired.</li>");
            }
        });

    });
</script>
<!--End-slider-script-->
<!--about-starts-->
<div class="about">
  <div class="container">
      <%--<h3>LUXURY SWISS WATCH RETAILER</h3>--%>
      <p class="subitem1">
          The Watch Gallery has the pleasure of introducing luxury Swiss retailer Bucherer to the UK. After a recent acquisition we are now proud to be part of the Bucherer family. With 130 years of watch expertise, your Swiss watch purchases will be courtesy of Europe leading Swiss watch retailer.
          Bucherer combine their strong passion for watches, impeccable hospitality and brand relationships straight from Lucerne - the heart of Switzerland.
      </p>
      <p class="subitem1">
          If you would like to spread the cost of your watch, you can choose from one of our finance options with free 0% interest.
          All watches are available to buy from the UK. For more information please see our delivery information. Bucherer is an authorised dealer of luxury watches, available for sale online with an international manufacturers guarantee.
      </p>


  <%--<div class="about-top grid-1">--%>
      <%--<div class="col-md-4 about-left">--%>
        <%--<figure class="effect-bubba">--%>
          <%--<img class="img-responsive" src="images/abt-1.jpg" alt=""/>--%>
          <%--<figcaption>--%>
            <%--<h2>Nulla maximus nunc</h2>--%>
            <%--<p>In sit amet sapien eros Integer dolore magna aliqua</p>--%>
          <%--</figcaption>--%>
        <%--</figure>--%>
      <%--</div>--%>
      <%--<div class="col-md-4 about-left">--%>
        <%--<figure class="effect-bubba">--%>
          <%--<img class="img-responsive" src="images/abt-2.jpg" alt=""/>--%>
          <%--<figcaption>--%>
            <%--<h4>Mauris erat augue</h4>--%>
            <%--<p>In sit amet sapien eros Integer dolore magna aliqua</p>--%>
          <%--</figcaption>--%>
        <%--</figure>--%>
      <%--</div>--%>
      <%--<div class="col-md-4 about-left">--%>
        <%--<figure class="effect-bubba">--%>
          <%--<img class="img-responsive" src="images/abt-3.jpg" alt=""/>--%>
          <%--<figcaption>--%>
            <%--<h4>Cras elit mauris</h4>--%>
            <%--<p>In sit amet sapien eros Integer dolore magna aliqua</p>--%>
          <%--</figcaption>--%>
        <%--</figure>--%>
      <%--</div>--%>
      <%--<div class="clearfix"></div>--%>
    <%--</div>--%>
  </div>
</div>
<!--about-end-->
<!--product-starts-->
<div class="product">
  <div class="container">
    <div class="product-top">
      <%
        int numberRandom = 0;
        listRandom.;
        for (int i = 0; i < 2; i++) { // Two rows
      %>
      <div class="product-one">
      <%
          for (int q = 0; q < 4; q++) { // Four colums

            do {
              numberRandom = (int)(Math.random() * countProducts);
            } while (listRandom.contains(numberRandom));
            listRandom.add(numberRandom);
      %>
          <div class="col-md-3 product-left">
            <div class="product-main simpleCart_shelfItem">
              <a href="single.jsp?idProduct=<%= listProductsForIndexJSP.get(numberRandom).product_id %>" class="mask"><img class="img-responsive zoom-img" src="<%= listProductsForIndexJSP.get(numberRandom).product_picture01 %>" alt="" /></a>
              <div class="product-bottom">
                <h3><%= listProductsForIndexJSP.get(numberRandom).product_name %></h3>
                <p>Explore Now</p>
                <h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ &nbsp <%= listProductsForIndexJSP.get(numberRandom).product_price %></span></h4>
              </div>
              <div class="srch">
                <span>-50%</span>
              </div>
            </div>
          </div>
        <%
          }
        %>
      </div>
      <%
        }
      %>

      <%--<div class="product-one">--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-1.png" alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-2.png" alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-3.png"  alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-4.png" alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="clearfix"></div>--%>
      <%--</div>--%>
      <%--<div class="product-one">--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-5.png" alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-6.png" alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-7.png" alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-8.png" alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="clearfix"></div>--%>
      <%--</div>--%>
    </div>
  </div>
</div>
<!--product-end-->

<%@ include file = "footer.jsp" %>

<!--product-starts-->
<%--<div class="product">--%>
  <%--<div class="container">--%>
    <%--<div class="product-top">--%>
      <%--<div class="product-one">--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-1.png" alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-2.png" alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-3.png"  alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-4.png" alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="clearfix"></div>--%>
      <%--</div>--%>
      <%--<div class="product-one">--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-5.png" alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-6.png" alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-7.png" alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="col-md-3 product-left">--%>
          <%--<div class="product-main simpleCart_shelfItem">--%>
            <%--<a href="single.jsp" class="mask"><img class="img-responsive zoom-img" src="images/p-8.png" alt="" /></a>--%>
            <%--<div class="product-bottom">--%>
              <%--<h3>Smart Watches</h3>--%>
              <%--<p>Explore Now</p>--%>
              <%--<h4><a class="item_add" href="#"><i></i></a> <span class=" item_price">$ 329</span></h4>--%>
            <%--</div>--%>
            <%--<div class="srch">--%>
              <%--<span>-50%</span>--%>
            <%--</div>--%>
          <%--</div>--%>
        <%--</div>--%>
        <%--<div class="clearfix"></div>--%>
      <%--</div>--%>
    <%--</div>--%>
  <%--</div>--%>
<%--</div>--%>
<!--product-end-->

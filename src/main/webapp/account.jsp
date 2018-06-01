<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 28.11.2017
  Time: 03:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file = "header.jsp" %>

<%-- Проверка на существования пользователя в БД --%>
<script>
    if ('${userExistence_Switch}' == "on") {
        if ('${userExistence}' == undefined || '${userExistence}' == null || '${userExistence}' == "true") {
            alert("Ошибка! Пользователь не существует");
        } else if ('${userExistence}' == "false") {
            //alert("Пользователь существует");
        }
    }
</script>

<!--start-breadcrumbs-->
<div class="breadcrumbs">
    <div class="container">
        <div class="breadcrumbs-main">
            <ol class="breadcrumb">
                <li><a href="index.jsp">Home</a></li>
                <li class="active">Account</li>
            </ol>
        </div>
    </div>
</div>
<!--end-breadcrumbs-->
<!--account-starts-->
<div class="account">
    <div class="container">
        <div class="account-top heading">
            <h2>ACCOUNT</h2>
        </div>
        <div class="account-main">
            <div class="col-md-6 account-left">
                <h3>Existing User</h3>
                <div class="account-bottom">
                    <form action="AccountServlet" method="post">
                        <input name="roleUser" placeholder="Email" type="text" tabindex="3" required>
                        <input placeholder="Password" type="password" tabindex="4" required>
                        <div class="address">
                            <a class="forgot" href="#">Forgot Your Password?</a>
                            <input type="submit" value="Login">
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-md-6 account-right account-left">
                <h3>New User? Create an Account</h3>
                <p>By creating an account with our store, you will be able to move through the checkout process faster, store multiple shipping addresses, view and track your orders in your account and more.</p>
                <a href="register.jsp">Create an Account</a>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
</div>
<!--account-end-->

<%@ include file = "footer.jsp" %>


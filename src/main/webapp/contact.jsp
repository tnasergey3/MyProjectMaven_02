<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 28.11.2017
  Time: 03:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file = "header.jsp" %>

<!--start-breadcrumbs-->
<div class="breadcrumbs">
    <div class="container">
        <div class="breadcrumbs-main">
            <ol class="breadcrumb">
                <li><a href="index.jsp">Home</a></li>
                <li class="active">Contact</li>
            </ol>
        </div>
    </div>
</div>
<!--end-breadcrumbs-->
<!--contact-start-->
<div class="contact">
    <div class="container">
        <div class="contact-top heading">
            <h2>CONTACT</h2>
        </div>
        <div class="contact-text">
            <div class="col-md-3 contact-left">
                <div class="address">
                    <h5>Address</h5>
                    <p>The company name,
                        <span>Lorem ipsum dolor,</span>
                        Glasglow Dr 40 Fe 72.</p>
                </div>
                <div class="address">
                    <h5>Address1</h5>
                    <p>Tel:1115550001,
                        <span>Fax:190-4509-494</span>
                        Email: <a href="mailto:example@email.com">contact@example.com</a></p>
                </div>
            </div>
            <div class="col-md-9 contact-right">
                <form>
                    <input type="text" placeholder="Name">
                    <input type="text" placeholder="Phone">
                    <input type="text"  placeholder="Email">
                    <textarea placeholder="Message" required=""></textarea>
                    <div class="submit-btn">
                        <input type="submit" value="SUBMIT">
                    </div>
                </form>
            </div>
            <div class="clearfix"></div>
        </div>
    </div>
</div>
<!--contact-end-->
<!--map-start-->
<div class="map">
    <iframe src="https://www.google.com/maps/embed?pb=!1m10!1m8!1m3!1d9934.561719626823!2d31.2926208!3d51.5014656!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sru!2sua!4v1511840215861" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
</div>
<!--map-end-->

<%@ include file = "footer.jsp" %>

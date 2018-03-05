<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 04.03.2018
  Time: 4:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Session Attribute</title>
</head>
<body>
Role: ${role}
<br /><hr />
Counter: ${counter}
<br /><hr />
MaxInactiveInterval: ${pageContext.session.maxInactiveInterval}<br/>
ID session: ${pageContext.session.id}<br/>
Lifecycle: ${lifecycle}<br/>
<a href="index.jsp">Back to index.jsp</a>
</body>
</html>

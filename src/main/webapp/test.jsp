<%-- 
    Document   : test
    Created on : Aug 26, 2021, 8:45:04 PM
    Author     : garre
--%>
<%
String id = request.getParameter("id");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <h1>Hello World!</h1>
        <input type="text" value="<%=id%>"><%=id%><br>
    </body>
</html>

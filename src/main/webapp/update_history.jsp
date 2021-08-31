

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@include file="components/message.jsp" %>
<%! String driverName = "com.mysql.jdbc.Driver";%>
<%!String url = "jdbc:mysql://172.20.29.71:3306/mycart";%>
<%!String user = "admin";%>
<%!String psw = "ordering";%>

<%
String id = request.getParameter("id");
String quantity=request.getParameter("quantity");

String locations=request.getParameter("locations");

if(id != null)
{
Connection con = null;
PreparedStatement ps = null;
int personID = Integer.parseInt(id);
try
{
Class.forName(driverName);
con = DriverManager.getConnection(url,user,psw);
String sql="Update OrderHistory set id=?,quantity=? where id="+id;
ps = con.prepareStatement(sql);
ps.setString(1,id);
ps.setString(2, quantity);

int i = ps.executeUpdate();
if(i > 0)
{
session.setAttribute("message", "Order updated successfully!");
response.sendRedirect("past_orders_page.jsp?id="+locations);
}
else
{
session.setAttribute("message", "There was a problem updating the order.");
response.sendRedirect("past_orders_page.jsp");
}
}
catch(SQLException sql)
{
request.setAttribute("error", sql);
out.println(sql);
}
}
%>


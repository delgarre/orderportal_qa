

<%@page import="com.learn.mycart.mail.AlternateItemsList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@include file="components/message.jsp" %>
<%! String driverName = "com.mysql.jdbc.Driver";%>
<%!String url = "jdbc:mysql://172.20.29.71:3306/mycart";%>
<%!String user = "admin";%>
<%!String psw = "ordering";%>

<%
String id = request.getParameter("id");

String stat="1";


if(id != null)
{
Connection con = null;
PreparedStatement ps = null;
int personID = Integer.parseInt(id);
try
{
Class.forName(driverName);
con = DriverManager.getConnection(url,user,psw);
String sql="Update Item set id=?,stat=? where id="+id;
ps = con.prepareStatement(sql);
ps.setString(1,id);
ps.setString(2, stat);

int i = ps.executeUpdate();
if(i > 0)
{
session.setAttribute("message", "Item set to active!");
response.sendRedirect("item_list.jsp");

}
else
{
session.setAttribute("message", "There was a problem reactivating the item.");
response.sendRedirect("item_list.jsp");
}
}
catch(SQLException sql)
{
request.setAttribute("error", sql);
out.println(sql);
}
}
%>


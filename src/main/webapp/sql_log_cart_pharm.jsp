<%@page import="java.sql.*,java.util.*" %>
<%@include file="components/message.jsp" %>

<%
String query = request.getParameter("id");




try
{

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://172.20.29.71:3306/mycart", "admin", "ordering");
Statement st=conn.createStatement();
int i=st.executeUpdate("insert into SqlLog(add_to_cart)values('"+query+"')");

response.sendRedirect("items_pharm.jsp");
}
catch(Exception e)
{
session.setAttribute("message", "error adding log");
response.sendRedirect("items_pharm.jsp");
System.out.print(e);
e.printStackTrace();
}
%>




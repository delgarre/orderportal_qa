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
System.out.println("Query logged successfully");
response.sendRedirect("null_check.jsp");
}
catch(Exception e)
{
session.setAttribute("message", "error adding log");
System.out.println("Error logging query");
response.sendRedirect("items.jsp");
System.out.print(e);
e.printStackTrace();
}
%>




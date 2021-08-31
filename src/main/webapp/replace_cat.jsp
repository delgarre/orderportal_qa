<%@page import="java.sql.*,java.util.*" %>
<%@include file="components/message.jsp" %>

<%
String categoryTitle = request.getParameter("cat");




try
{

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://172.20.29.71:3306/mycart", "admin", "ordering");
Statement st=conn.createStatement();
int i=st.executeUpdate("update mycart.Category set categoryTitle = REPLACE(categoryTitle,'&','AND') where categoryTitle='"+categoryTitle+"'");
session.setAttribute("message", "Category added successfully...");
response.sendRedirect("categories.jsp");
}
catch(Exception e)
{
session.setAttribute("message", "Error replacing possible & in location type. Please check location to make sure & do not exist");
response.sendRedirect("categories.jsp");
System.out.print(e);
e.printStackTrace();
}
%>




<%@page import="java.sql.*,java.util.*" %>
<%@include file="components/message.jsp" %>

<%
String itemNumber = request.getParameter("itemNumber");




try
{

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://172.20.29.71:3306/mycart", "admin", "ordering");
Statement st=conn.createStatement();
int i=st.executeUpdate("update mycart.Item set locationType = REPLACE(REPLACE(locationType,', ',','),' ,',',') where itemNumber='"+itemNumber+"'");
session.setAttribute("message", "Item added successfully...");
response.sendRedirect("add_item_page.jsp");
}
catch(Exception e)
{
session.setAttribute("message", "Error replacing possible spaces in location type. Please check location to make sure spaces do not exist");
response.sendRedirect("add_item_page.jsp");
System.out.print(e);
e.printStackTrace();
}
%>




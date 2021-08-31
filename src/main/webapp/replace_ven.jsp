<%@page import="java.sql.*,java.util.*" %>
<%@include file="components/message.jsp" %>

<%
String vendorName = request.getParameter("ven");




try
{

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://172.20.29.71:3306/mycart", "admin", "ordering");
Statement st=conn.createStatement();
int i=st.executeUpdate("update mycart.Vendor set vendorName = REPLACE(vendorName,'&','AND') where vendorName='"+vendorName+"'");
session.setAttribute("message", "Vendor added successfully...");
response.sendRedirect("vendors.jsp");
}
catch(Exception e)
{
session.setAttribute("message", "Error replacing possible & in the vendor. Please check vendor to make sure & do not exist");
response.sendRedirect("vendors.jsp");
System.out.print(e);
e.printStackTrace();
}
%>




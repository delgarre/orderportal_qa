<%@page import="java.sql.*,java.util.*" %>
<%@include file="components/message.jsp" %>

<%
String companyName = request.getParameter("companyName");

String type = request.getParameter("type");

String code = request.getParameter("code");

String status = "ACTIVE";



try
{

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://172.20.29.71:3306/mycart", "admin", "ordering");
Statement st=conn.createStatement();
int i=st.executeUpdate("insert into Company(companyName,type, status, companyCode)values(upper('"+companyName+"'),upper('"+type+"'), '"+status+"', upper('"+code+"'))");
session.setAttribute("message", "Location added successfully!");
response.sendRedirect("companies.jsp");
}
catch(Exception e)
{
session.setAttribute("message", "error adding location");
response.sendRedirect("companies.jsp");
System.out.print(e);
e.printStackTrace();
}
%>




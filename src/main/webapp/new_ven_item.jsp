<%@page import="java.sql.*,java.util.*" %>
<%@include file="components/message.jsp" %>

<%
String vendorName = request.getParameter("vendorName");




try
{

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://172.20.29.71:3306/mycart", "admin", "ordering");
Statement st=conn.createStatement();

String strQuery = "SELECT COUNT(*) FROM Vendor where vendorName='"+vendorName+"'";
ResultSet rs = st.executeQuery(strQuery);
rs.next();
String Countrow = rs.getString(1);
out.println(Countrow);
if(Countrow.equals("0")){
int i=st.executeUpdate("insert into Vendor(vendorName)values(upper('"+vendorName+"'))");
session.setAttribute("message", "Vendor added successfully!");
response.sendRedirect("add_item_page.jsp");
}

else{
session.setAttribute("message", "Vendor already exists!");
response.sendRedirect("add_item_page.jsp");
}

}
catch(Exception e)
{

session.setAttribute("message", "error adding vendor");
response.sendRedirect("add_item_page.jsp");
System.out.print(e);
e.printStackTrace();
}
%>




<%@page import="com.learn.mycart.mail.JavaMailUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.*,java.util.*" %>
<%@page import="java.util.Date"%>
<%@page import= "java.time.LocalDate"%>
<%@page import= "java.time.LocalDateTime"%>
<%@page import= "java.time.format.DateTimeFormatter"%>
<%@include file="components/message.jsp" %>
<%



try
{

    
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://172.20.29.71:3306/mycart", "admin", "ordering");
Statement st=conn.createStatement();

int i=st.executeUpdate("UPDATE mycart.Approve INNER JOIN  mycart.Item ON mycart.Approve.itemNumber = mycart.Item.itemNumber SET mycart.Approve.unitOfMeasure = mycart.Item.unitOfMeasure, mycart.Approve.alternateItem   = mycart.Item.alternateItem, mycart.Approve.manufacturer  = mycart.Item.manufacturer, mycart.Approve.manufacturerNum  = mycart.Item.manufacturerNum where (mycart.Approve.unitOfMeasure = 'null' or mycart.Approve.alternateItem = 'null' or mycart.Approve.manufacturer = 'null' or mycart.Approve.manufacturerNum  = 'null' )");
        
        
response.sendRedirect("items.jsp");
session.setAttribute("message", "Cart Item added!");



}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}
%>

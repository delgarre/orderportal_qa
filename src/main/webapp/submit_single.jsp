<%@page import="com.learn.mycart.mail.SingleSubmit"%>
<%@page import="com.learn.mycart.entities.Company"%>
<%@page import="com.learn.mycart.mail.JavaMailUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.*,java.util.*" %>
<%@page import="java.util.Date"%>
<%@include file="components/message.jsp" %>
<%
String id= request.getParameter("id");

LocalDateTime ldt = LocalDateTime.now();
DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM/dd/yyyy");
String date = dtf.format(ldt);


try
{

    
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://172.20.29.71:3306/mycart", "admin", "ordering");
Statement st=conn.createStatement();

int i=st.executeUpdate("insert into OrderHistory(itemNumber, aPrice, date, locations, cName, quantity, photo, cTitle, pDesc, manufacturer, manufacturerNum, unitOfMeasure, vTitle, alternateItem, department, orderId) select itemNumber, aPPrice, '"+date+"', locations, name, quantity, photo, cTitle, pDesc, manufacturer, manufacturerNum, unitOfMeasure, vTitle, alternateItem, department, orderId from Orders where id = '"+id+"'");

//SingleSubmit.sendMail("diane.madonna@dseincorporated.com", itemNumber, pDesc, vTitle, price, name, locations, alt, quantity);

response.sendRedirect("n.jsp?id="+id);
session.setAttribute("message", "Item approved!");
}
catch(Exception e)
{
out.print(e);
e.printStackTrace();
}
%>

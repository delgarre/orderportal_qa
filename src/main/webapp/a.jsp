<%@page import="com.learn.mycart.mail.JavaMailUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.*,java.util.*" %>
<%@page import="java.util.Date"%>
<%@include file="components/message.jsp" %>
<%
String id = request.getParameter("locations");
LocalDateTime ldt = LocalDateTime.now();
DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM/dd/yyyy");
String date = dtf.format(ldt);

Date now = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss.SSS");
    String loginTime = sdf.format(now);



try
{

    
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://172.20.29.71:3306/mycart", "admin", "ordering");
Statement st=conn.createStatement();
String strQuery = "SELECT COUNT(*) FROM OrderHistory WHERE date='"+date+"' and locations = '"+id+"'";
ResultSet rs = st.executeQuery(strQuery);
rs.next();
String Countrow = rs.getString(1);
out.println(Countrow);
if(Countrow.equals("0")){
    String count = Countrow;
int i=st.executeUpdate("insert into OrderHistory(itemNumber, aPrice, date, locations, cName, quantity, photo, cTitle, pDesc, manufacturer, manufacturerNum, unitOfMeasure, vTitle, log, orderId, alternateItem, department) select itemNumber, aPPrice, '"+date+"', locations, name, quantity, photo, cTitle, pDesc, manufacturer, manufacturerNum, unitOfMeasure, vTitle, '"+loginTime+"', orderId, alternateItem, department from Orders where locations = '"+id+"'"
        + " and status = 'Not Approved'");

session.setAttribute("message", "Order approved successfully!");
response.sendRedirect("l.jsp?id="+id);
}
else{
    //String count = Countrow;
response.sendRedirect("a_orders.jsp?id="+id);
session.setAttribute("message", "order already exist for this month!");
//out.println(count);
//out.println(ddMMyyyyToday);
//out.println(date);
//out.println(user_id);
}
}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}
%>

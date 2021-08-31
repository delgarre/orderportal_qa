<%@page import="com.learn.mycart.mail.JavaMailUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.*,java.util.*" %>
<%@page import="java.util.Date"%>
<%@include file="components/message.jsp" %>
<%

String price=request.getParameter("price");
String quantity=request.getParameter("quantity");
String name = request.getParameter("name");
int user_id = Integer.parseInt(request.getParameter("user_id"));
String itemNumber = request.getParameter("itemNumber");
String locations = request.getParameter("locations");
Date today = new Date();
SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("MM/dd/yyyy");
String ddMMyyyyToday = DATE_FORMAT.format(today);
String stat = "Not Approved";
String photo = request.getParameter("photo");
String uom = request.getParameter("uom");
String man = request.getParameter("man");
String manNum = request.getParameter("mannum");
String cTitle = request.getParameter("cTitle");
String vTitle = request.getParameter("vTitle");
String pDesc = request.getParameter("pDesc");
String alternateItem = request.getParameter("alt");
String oid = request.getParameter("oid");
String department = request.getParameter("department");

try
{

    
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://172.20.29.71:3306/mycart", "admin", "ordering");
Statement st=conn.createStatement();

int i=st.executeUpdate("insert into Orders(date,locations, itemNumber,aPPrice, quantity, user_id, status, name, photo, unitOfMeasure, manufacturer, manufacturerNum, pDesc, cTitle, vTitle, alternateItem, orderId, department)values('"+ddMMyyyyToday+"','"+locations+"','"+itemNumber+"','"+price+"','"+quantity+"','"+user_id+"', '"+stat+"', '"+name+"', '"+photo+"','"+uom+"', '"+man+"', '"+manNum+"', '"+pDesc+"','"+cTitle+"','"+vTitle+"','"+alternateItem+"', '"+oid+"', '"+department+"')");

//JavaMailUtil.sendMail("diane.madonna@dseincorporated.com", locations);
response.sendRedirect("n_a_orders.jsp?id="+locations+"&oid="+oid);
session.setAttribute("message", "Item added to order!");
}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}
%>

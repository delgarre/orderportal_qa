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
Calendar cal = new GregorianCalendar();
		//cal.setTime(today);
		cal.add(Calendar.DAY_OF_MONTH, -30);
		Date today30 = cal.getTime();
SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("MM/dd/yyyy");
String ddMMyyyyToday = DATE_FORMAT.format(today30);
String name = request.getParameter("name");
String user_id = request.getParameter("user_id");
String code = request.getParameter("code");
String locations = request.getParameter("loc");

double o = Math.random()*200;

double orderId = Math.random() + (o * 500);


int x = (int) orderId;
String oid = code+x;
try
{

    
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://172.20.29.71:3306/mycart", "admin", "ordering");
Statement st=conn.createStatement();

String strQuery = "SELECT COUNT(*) FROM Orders WHERE status ='Not Approved' and locations = '"+locations+"'";
ResultSet rs = st.executeQuery(strQuery);
rs.next();
String Countrow = rs.getString(1);
out.println(Countrow);

if(Countrow.equals("0")){
    String count = Countrow;
int i = st.executeUpdate("insert into Orders(itemNumber, aPPrice, date, locations, name, quantity, user_id, photo, status, cTitle, pDesc, manufacturer, manufacturerNum, unitOfMeasure, vTitle, alternateItem, orderId, department) select itemNumber, price, date, locations, name, quantity, user_id, photo, stat, cTitle, pDesc, manufacturer, manufacturerNum, unitOfMeasure, vTitle, alternateItem, '"+oid+"', department from Approve where locations = '"+locations+"' and stat='Not Approved'");
response.sendRedirect("m_p.jsp?id="+user_id);
session.setAttribute("message", "Order submitted successfully!");
//out.println(count);
//out.println("yay");

}

else{
    //String count = Countrow;
response.sendRedirect("l_pending_orders_pharm.jsp?id="+user_id);
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

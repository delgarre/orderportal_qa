<%@page import="com.learn.mycart.mail.JavaMailUtil"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
String location = request.getParameter("id");
String sql = "SELECT User.user_email, OrderHistory.cName, OrderHistory.locations "
        + "FROM OrderHistory "
        + "INNER JOIN User ON OrderHistory.cName=User.user_Name "
        + "and OrderHistory.locations = '"+location+"'";
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://172.20.29.71:3306/";
String database = "mycart";
String userid = "admin";
String password = "ordering";
try {
Class.forName(driver);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<%
try{
connection = DriverManager.getConnection(connectionUrl+database, userid, password);
statement=connection.createStatement();
String sql2 = "SELECT User.user_email, OrderHistory.cName, OrderHistory.locations "
        + "FROM OrderHistory "
        + "INNER JOIN User ON OrderHistory.cName=User.user_Name "
        + "and OrderHistory.locations = '"+location+"'";
resultSet = statement.executeQuery(sql2);
while(resultSet.next()){
    String email = resultSet.getString("user_email");
   JavaMailUtil.sendMail(email, location);
   response.sendRedirect("orders.jsp");
   session.setAttribute("message", "Order for "+location+" approved!");
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
//session.setAttribute("message", "Error approving order for "+location);
}


%>

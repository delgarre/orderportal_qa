<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    String email = request.getParameter("email");
    String password= request.getParameter("password");
    String name = request.getParameter("name");
    String location = request.getParameter("location");
    Date now = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss.SSS");
    String loginTime = sdf.format(now);
  try
{  
    
Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://172.20.29.71:3306/mycart", "admin", "ordering");
                Statement st=conn.createStatement();
                int s=st.executeUpdate("insert into LoginLog(name, email, loginTime)values('"+name+"','"+email+"', '"+loginTime+"')");
                response.sendRedirect("login.jsp?email="+email+"password="+password+"&location="+location);
}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}
  


%>

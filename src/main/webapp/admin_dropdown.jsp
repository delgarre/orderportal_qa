<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Select Location</title>
<%@include file="components/common_css_js.jsp" %>
</head>
<body>
    
    <%@include file="components/navbar.jsp" %>
<%! String driverName = "com.mysql.jdbc.Driver";%>
<%!String url = "jdbc:mysql://172.20.29.71:3306/mycart";%>
<%!String user = "admin";%>
<%!String psw = "ordering";%>
<form method="post" action="DropDownServlet">
<%
String id = request.getParameter("id");
Connection con = null;
PreparedStatement ps = null;
try
{
Class.forName(driverName);
con = DriverManager.getConnection(url,user,psw);
String sql = "SELECT * FROM Test where user_id = " +id;
ps = con.prepareStatement(sql);
ResultSet rs = ps.executeQuery(); 
%>
<p>Select Location :
<select>
<%
while(rs.next())
{
String cname = rs.getString("comp_name"); 
%>
<option value="<%=cname %>"><%=cname %></option>
<%
}
%>
</select>
</p>
<input type="submit" value="submit">
<%
}
catch(SQLException sqe)
{ 
out.println(sqe);
}
%>
</form>
</body>
</html>
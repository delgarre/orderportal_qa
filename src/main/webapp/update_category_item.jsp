
<%@ page import="java.sql.*" %>

<%@page import="com.learn.mycart.entities.User"%>
<%@include file="components/message.jsp" %>
<%! String driverName = "com.mysql.jdbc.Driver";%>
<%!String url = "jdbc:mysql://172.20.29.71:3306/mycart";%>
<%!String user = "admin";%>
<%!String psw = "ordering";%>
<%
User user1 = (User)session.getAttribute("current-user");
    
    
    if(user1==null){
        session.setAttribute("message", "You are not logged in!");
        response.sendRedirect("index.jsp");
        return;
    }
    
        
    else 
    {
        if(user1.getUserType().equals("normal"))
        {
            session.setAttribute("message", "Admin level required!");
            response.sendRedirect("index.jsp");
            return;
        }
    }
%>

<%
String categoryTitle = request.getParameter("categoryTitle");
String cat=request.getParameter("cat");

if(categoryTitle != null)
{
Connection con = null;
PreparedStatement ps = null;

try
{
Class.forName(driverName);
con = DriverManager.getConnection(url,user,psw);
String sql="Update Item set cTitle=upper(?) where cTitle='"+cat+"'";

ps = con.prepareStatement(sql);
ps.setString(1,categoryTitle);

int i = ps.executeUpdate();
if(i > 0)
{
session.setAttribute("message", "Category updated successfully!");
response.sendRedirect("categories.jsp");
}
else
{
session.setAttribute("message", "There was a problem updating the cateory.");
response.sendRedirect("categories.jsp");
}
}
catch(SQLException sql)
{
request.setAttribute("error", sql);
out.println(sql);
}
}
%>

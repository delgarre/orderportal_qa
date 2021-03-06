
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


String comp_name = request.getParameter("comp_name");
String locationType = request.getParameter("locationType");

if(comp_name != null)
{
Connection con = null;
PreparedStatement ps = null;

try
{
Class.forName(driverName);
con = DriverManager.getConnection(url,user,psw);
String sql="Update UserLocation set type=? where type = '"+locationType+"'";
ps = con.prepareStatement(sql);
ps.setString(1,comp_name);

int i = ps.executeUpdate();
if(i > 0)
{
session.setAttribute("message", "Location type changed successfully!");
response.sendRedirect("update_user_l_t.jsp?comp_name="+comp_name+"&locationType="+locationType);
}
else
{
    
session.setAttribute("message", "There was a problem updating the user location.");
System.out.println();
response.sendRedirect("type.jsp");
}
}
catch(SQLException sql)
{
request.setAttribute("message", sql);
out.println(sql);
}
}
%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.learn.mycart.entities.User"%>
<%@page import="com.learn.mycart.entities.Company"%>
<%
  User user = (User)session.getAttribute("current-user");
    if(user==null){
        session.setAttribute("message", "You are not logged in!");
        response.sendRedirect("index.jsp");
        return;
    }
    else
    {
        if(user.getUserType().equals("normal"))
        {
            session.setAttribute("message", "Admin level required!");
            response.sendRedirect("index.jsp");
            return;
        }
    }
%>

<%
String id = request.getParameter("id");
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
String sql ="select * from Notice where id="+id;
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Message</title>
        <%@include file="components/common_css_js.jsp" %>
        
        
<script>
function goBack(){
        window.history.back();
    } 
    
</script>
    </head>
    <body>
        
        <h1>Edit message</h1>
        <div class="container"> 
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <form method="post" action="update_notice.jsp">
                        <input type="hidden" name="mid" value="<%=resultSet.getString("id") %>">
                        <textarea style="height: 100px" name="note" placeholder="Enter message" spellcheck="true">
                            <%=resultSet.getString("message") %>
                        </textarea>
                        <input type="submit" class="btn btn-success">
                    </form>
                </div>
            </div>
        </div>    
        
        
        
 <%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
    </body>
</html>

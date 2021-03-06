<%@page import="com.learn.mycart.entities.User"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

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
String sql ="select * from Category where categoryId = "+id;
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
    String categoryTitle = resultSet.getString("categoryTitle");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Category</title>
        
<script>
function goBack(){
        window.history.back();
    } 
    
</script>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
         <div class="container"> 
            <div class="row">
                 <div class="col-md-6 offset-md-3">
                  <br>
                  <button class="btn btn-warning" onclick="goBack()">GO BACK</button>
                      <br>
                      
                      <div class="card">
                          <div class="card-header custom-bg text-white">
                            <h1>MAKE CHANGES!</h1>
                      </div>
                          <div class="card-body">
            <form method="POST" action="update_category.jsp">
                
            <input type="hidden" name="catId" value="<%=resultSet.getString("categoryId") %>">
            <div class="form-group">
                       <label for="catTitle">Location:</label>
           
            <input type="text" name="catTitle" value="<%=categoryTitle%>" id="catTitle">
            </div>
            <input type="hidden" value="<%=categoryTitle%>" name="cat">
            <div class="container text-center">
            <input type="submit" class="btn btn-info" value="SAVE CHANGES" onclick="return confirm('Are you sure?');">
            </div>
            </form>
                          </div>
                      </div>
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

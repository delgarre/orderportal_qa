
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
String sql ="select * from Item where itemNumber = '"+id+"'";
resultSet = statement.executeQuery(sql);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Photo Upload Page</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
                <%@include file="components/navbar.jsp" %>
         <h3>File Upload:</h3>
      Select a photo to upload for item number: <%=id%> <br />
      <form action = "UploadServlet" method = "post" enctype = "multipart/form-data">
            <%
            while(resultSet.next()){
                
                        String Id = resultSet.getString("id");
            %>
         <input type = "file" name = "file" size = "50" />
         
         <br />
         
         <input type="hidden" value="<%=Id%>" name="id" id="id"/>
         <input type = "submit" value = "Upload File" />

        
         <%
             }
         
         %>
      </form>
      
      

<%

connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
    </body>
</html>

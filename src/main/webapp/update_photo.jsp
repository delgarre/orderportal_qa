<%-- 
    Document   : add_item_page
    Created on : Jan 19, 2021, 2:11:52 PM
    Author     : garre
--%>

<%@page import="com.learn.mycart.entities.UOM"%>
<%@page import="com.learn.mycart.dao.UOMDao"%>
<%@page import="com.learn.mycart.entities.CPT"%>
<%@page import="com.learn.mycart.dao.CptDAO"%>
<%@page import="com.learn.mycart.entities.Manufacturers"%>
<%@page import="com.learn.mycart.dao.ManDAO"%>
<%@page import="com.learn.mycart.entities.Vendor"%>
<%@page import="com.learn.mycart.dao.VendorDao"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.entities.User"%>
<%@page import="com.learn.mycart.dao.CompanyDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.entities.Company"%>

<%
    Company company1 = (Company)session.getAttribute("location");
    
    
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
String sql ="select * from Item where id = "+id;
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
String itemNumber = resultSet.getString("itemNumber");
String cpt = resultSet.getString("cpt");
String cTitle = resultSet.getString("cTitle");
String vTitle = resultSet.getString("vTitle");
String manufacturer = resultSet.getString("manufacturer");


%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Item</title>
        <%@include file="components/common_css_js.jsp" %>
        

<script>
function goBack(){
        window.history.back();
    } 
    
</script>
<style>
.center {
  margin: auto;
  width: 60%;
  border: navy;
  padding: 10px;
}
</style>
    </head>
    <body>
         <%@include file="components/navbar.jsp" %>
         <div class="center">
             <%@include file="components/message.jsp" %>
        <h1>MANAGE INVENTORY:</h1>
        <a href="item_list.jsp?itemNumber=<%=itemNumber%>">
        <button class="btn btn-info">ITEMS LIST</button>
       
        </a>
        <a href="update_product_page.jsp?id=<%= id%>&code=<%=cpt%>&cTitle=<%=cTitle%>&vTitle=<%=vTitle%>&man=<%=manufacturer%>">
                        <button class="btn btn-outline-warning">GO BACK</button>
         </a>
         <form action="UpdatePhoto" method="post" enctype="multipart/form-data">
             <input type="hidden" name="id" value="<%=resultSet.getString("id") %>">

                    
                                        <!-- photo -->
                    <div class="form-group">
                        <label for="image">Select Image:</label>
                        <input type="text" class="form-control" value="<%=resultSet.getString("photo")%>"/>
                    </div>
                    
                        <div class="form-group">
                        <input type="file" id="file" name="file" />
                    </div>

                    
                    
                <%
}
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>

              <!--submit button-->
                    <div class="container text-center">
                        <button onclick="return confirm('Are you sure?');" class="btn btn-outline-success">SAVE CHANGES</button>
                        
                    </div>
                    
                  
         </form>


         </div>
    </body>
</html>

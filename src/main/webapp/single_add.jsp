<%@page import="com.learn.mycart.entities.Notice"%>
<%@page import="com.learn.mycart.dao.NoticeDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.dao.ItemDao"%>
<%@page import="com.learn.mycart.entities.Item"%>
<%@page import="com.learn.mycart.dao.LocationTypeDao"%>
<%@page import="com.learn.mycart.entities.LocationType"%>
<%@page import="com.learn.mycart.entities.Company"%>
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
String name = request.getParameter("id");
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
String sql ="Select * from Item";

resultSet = statement.executeQuery(sql);

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Items</title>
        <%@include file="components/common_css_js.jsp" %>
        
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});


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
          
        <div class="col-md-8">
            <div div class="table-responsive-sm mt-3">
        <div>
                 <button class="btn btn-warning" onclick="goBack()">Go Back</button>
                 <br>
          <input id="myInput" type="text" placeholder="Search..">
          
    
                </div>
                <div>
                    <h3>ADD AN ITEM FOR: <%=name%></h3>
                </div>
        
            <table class="table table-bordered ">
                <thead>
                <tr>
                

                <th>IMAGE</th>
                <th>ITEM NUMBER</th>
                <th>DESCRIPTION</th>
                <th>VENDOR</th>
                <th>UOM</th>



                <th>QUANTITY PER UOM</th>
              
                 <th>COST</th>

                <th>MANUFACTURER</th>
            
                <th>CPT</th>
                <th>NDC</th>
                
                
                <th>ACTIONS</th>
                </tr>
                </thead>
                <tbody id="myTable">
                <%
                    while(resultSet.next()){
                        ;
                        Integer id = resultSet.getInt("id");
                        
                        String price = resultSet.getString("price");
                        String quantity = resultSet.getString("quantity");
                        String photo = resultSet.getString("photo");
                        String itemNumber = resultSet.getString("ItemNumber");
                        String vendor = resultSet.getString("vTitle");
                        String desc = resultSet.getString("pDesc");
                        String unit = resultSet.getString("unitOfMeasure");
                        String man = resultSet.getString("manufacturer");
                        String manNum = resultSet.getString("manufacturerNum");
                        String cpt = resultSet.getString("cpt");
                        String ndc = resultSet.getString("ndc");
                        String alt = resultSet.getString("alternateItem");
                    %>
                
                <tr>
                    <td>
                        <img style="max-width: 125px" src="image/<%=photo%>" alt="user_icon">
                    </td>
                    <td><%= itemNumber%></td>
                    <td><%=desc%></td>
                    <td><%=vendor%></td>
                    <td><%=unit%></td>
                    <td><%= quantity%></td>
                    <td><span>$<%= price%></span></td>
                    
                    <td><%=man%></td>
                    <td><%=cpt%></td>
                    <td><%=ndc%></td>
                    
                    
                    
                   
                    <td>
                        <a href="s.jsp?id=<%= id%>">
                    <button class="btn btn-outline-success">ADD TO CART</button>
                    </a>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
            </div>
        </div>
            
<%

connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
    </body>
</html>

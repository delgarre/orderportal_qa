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
    String orderId = request.getParameter("oid");
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
String sql ="select * from OrderHistory where locations = '"+id+"' and date = '"+session.getAttribute("date")+"'";
resultSet = statement.executeQuery(sql);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pending Orders</title>
        <%@include file="components/common_css_js.jsp" %>
        
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
   // Quick and simple export target #table_id into a csv
function download_table_as_csv(table_id, separator = ',') {
    // Select rows from table_id
    var rows = document.querySelectorAll('table#' + table_id + ' tr');
    // Construct csv
    var csv = [];
    for (var i = 0; i < rows.length; i++) {
        var row = [], cols = rows[i].querySelectorAll('td, th');
        for (var j = 0; j < cols.length; j++) {
            // Clean innertext to remove multiple spaces and jumpline (break csv)
            var data = cols[j].innerText.replace(/(\r\n|\n|\r)/gm, '').replace(/(\s\s)/gm, ' ')
            // Escape double-quote with double-double-quote (see https://stackoverflow.com/questions/17808511/properly-escape-a-double-quote-in-csv)
            data = data.replace(/"/g, '""');
            // Push escaped string
            row.push('"' + data + '"');
        }
        csv.push(row.join(separator));
    }
    var csv_string = csv.join('\n');
    // Download it
    var filename = 'export_' + table_id + '_' + new Date().toLocaleDateString() + '.csv';
    var link = document.createElement('a');
    link.style.display = 'none';
    link.setAttribute('target', '_blank');
    link.setAttribute('href', 'data:text/csv;charset=utf-8,' + encodeURIComponent(csv_string));
    link.setAttribute('download', filename);
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

//this will hide message after 3 seconds
            setTimeout(function(){
            $("#error").hide();
            },3000)
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
    <%
    Date today = new Date();
    SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd-MM-yyyy");
    String ddMMyyyyToday = DATE_FORMAT.format(today);
    %>
    <body>
           <%@include file="components/navbar.jsp" %>
        <h1>ORDER HISTORY FOR <%=id%>:</h1>
        <div class="center">
                   <div id="error" class="container-fluid mt-3">
                <%@include file="components/message.jsp" %>
                </div>
            <a href="#" onclick="download_table_as_csv('my_id_table_to_export');">
                    <button class="btn btn-info">
                    DOWNLOAD AS CSV
                    </button>
            </a><br>
            <a href="history_items_list.jsp?loc=<%=id%>&oid=<%=orderId%>">
                <button class="btn btn-primary">ADD ITEM</button>
            </a><br>
            <br>
            <table id="my_id_table_to_export" class="table table-bordered ">
                <thead>  
                <tr>
                    <th>ORDER #</th>
                    <th>PHOTO</th>
                    
                    <th>APPROVAL DATE</th>
                    <th>ITEM NUMBER</th>
                    <th>DESCRIPTION</th>
                    <th>COST</th>
                    <th>QUANTITY ORDERED</th>
                    <th>ALTERNATE ITEM</th>
                    <th>ORDERED BY</th>
                    <th>DEPARTMENT</th>
                    <th>LOCATION</th>
                    <th>VENDOR</th>
                    
                    <th>ACTION</th>
                </tr>
                </thead>
                <tbody id="myTable">
                <tr>
                   <%
                    while(resultSet.next()){
                        ;
                        String oId = resultSet.getString("id");
                        String cName = resultSet.getString("cName");
                        String photo = resultSet.getString("photo");
                        String itemNumber = resultSet.getString("ItemNumber");
                        String date = resultSet.getString("date");
                        String quantity = resultSet.getString("quantity");
                        String pDesc = resultSet.getString("pDesc");
                        String vTitle = resultSet.getString("vTitle");
                        String price = resultSet.getString("aPrice");
                        String locations = resultSet.getString("locations");
                        String alt = resultSet.getString("alternateItem");
                        String department = resultSet.getString("department");
                         String oid = resultSet.getString("orderId");
                    %>
                    
                    <td><%=oid%></td>
                   
                    <td>
                        <img style="max-width: 125px" src="image/<%=photo%>" alt="user_icon">
                           
                    </td>
                    
                    <td><%=date%></td>
                    <td><%=itemNumber%></td>
                    <td><%=pDesc%></td>
                    <td><span>$<%=price%></span></td>
                    <td><%=quantity%></td>
                    <td><%=alt%></td>
                    <td><%=cName%></td>
                    <td><%=department%></td>
                    <td><%=locations%></td>
                    
                    <td><%=vTitle%></td>
                    <td>  <a href="update_history_page.jsp?id=<%= oId%>">
                    <button class="btn btn-outline-success">UPDATE ORDER</button>
                        </a>
                    <a href="delete_history_order.jsp?id=<%=oId%>&locations=<%=id%>" onclick="return confirm('Are you sure?');">
                        <button class="btn btn-danger">DELETE ITEM</button>
                    </a>
                    </td>

                    
                    
                    
                </tr>
                <%
                    }
                    
            
                %>
                </tbody>
            </table>
        
        </div>
<%
connection.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
    </body>
</html>
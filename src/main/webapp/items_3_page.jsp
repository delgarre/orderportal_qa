
<%@page import="java.sql.DriverManager"%>

<%@page import="com.learn.mycart.entities.User"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

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

String itemNumber1 = request.getParameter("itemNumber1");
String itemNumber2 = request.getParameter("itemNumber2");
String itemNumber3 = request.getParameter("itemNumber3");

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
String sql ="select * from Item where itemNumber = '"+itemNumber1+"' or itemNumber = '"+itemNumber2+"' or itemNumber ='"+itemNumber3+"'";
resultSet = statement.executeQuery(sql);

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Excel Report</title>
        <%@include file="components/common_css_js.jsp" %>
        
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
</script>        
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <h2>Report:</h2>
                <a href="#" onclick="download_table_as_csv('my_id_table_to_export');">
                    <button class="btn btn-info">
                    Download as CSV
                    </button>
                </a>
        <div class="container-fluid">
        <table id="my_id_table_to_export" class="table table-bordered">
            <tr>
               
                <th>Item Number</th>
                <th>Description</th> 
                <th>Vendor</th>
                <th>Unit Of Measure</th>
                <th>QTY/UOM</th>
                <th>Price</th>

                
                <th>Manufacturer</th>
                <th>Manufacturer Number</th>
                <th>CPT</th>
                <th>NDC</th>
            </tr>
            <%
            while(resultSet.next()){
                String item = resultSet.getString("itemNumber");
                String quantity = resultSet.getString("quantity");
                String uom = resultSet.getString("unitOfMeasure");
                String price = resultSet.getString("price");
                String vendor = resultSet.getString("vTitle");
                String man = resultSet.getString("manufacturer");
                String cpt = resultSet.getString("cpt");
                String ndc = resultSet.getString("ndc");
                String desc = resultSet.getString("pDesc");
                String manNum = resultSet.getString("manufacturerNum");
            %>
            <tr>
              
                <td><%=item%></td>
                <td><%=desc%></td> 
                <td><%=vendor%></td>
                <td><%=uom%></td>
                <td><%=quantity%></td>
                <td><span>$<%=price%></span></td>
              
                
                <td><%=man%></td>
                <td><%=manNum%></td>
                <td><%=cpt%></td>
                <td><%=ndc%></td>
            </tr>
            <%
                }
            %>
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


<%@page import="java.sql.DriverManager"%>

<%@page import="com.learn.mycart.entities.User"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.time.format.DateTimeFormatter"%>

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
String vendor1 = request.getParameter("vendor1");
String vendor2 = request.getParameter("vendor2");

String location1 = request.getParameter("location1");
String location2 = request.getParameter("location2");

String itemNumber1 = request.getParameter("itemNumber1");
String itemNumber2 = request.getParameter("itemNumber2");

String begin = request.getParameter("begin");
String end = request.getParameter("end");



DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM/dd/yyyy");
//String date1 = dtf.format(begin);


//String date2 = dtf.format(end);

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
String sql ="select * from OrderHistory where (date BETWEEN '"+begin+"' AND '"+end+"') or  (locations = '"+location1+"' or locations = '"+location2+"') or (vTitle = '"+vendor1+"' or vTitle = '"+vendor2+"') or (itemNumber = '"+itemNumber1+"' or itemNumber = '"+itemNumber2+"') order by date desc";
resultSet = statement.executeQuery(sql);

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Excel Report</title>
        <%@include file="components/common_css_js.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>

    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/webcamjs/1.0.25/webcam.js">
        </script>
        
<script type="text/javascript" src="jspdf.debug.js"></script>
        <script type="text/javascript">
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

<style>

table.table-fit {
    width: auto !important;
    table-layout: auto !important;
}
table.table-fit thead th, table.table-fit tfoot th {
    width: auto !important;
}
table.table-fit tbody td, table.table-fit tfoot td {
    width: auto !important;
}

table {
  border-collapse: collapse;
  width: 100%;
}

th, td {
  text-align: left;
  padding: 8px;
}


</style>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <h2>Report:</h2>
    
        <div class="container-fluid">
            <div id="orders">
      
                <a href="#" onclick="download_table_as_csv('my_id_table_to_export');">
                    <button class="btn btn-info">
                    Download as CSV
                    </button>
                </a>
        <table class="table table-bordered table-fit">
            <tr>
                <th>Date</th>
                <th>Desc</th>
                <th>Item #</th>
                <th>Vendor</th>
                <th>QTY</th>
                <th>Cost</th>
          
                <th>Loc</th>
                
              
            </tr>
            <%
            while(resultSet.next()){
                String item = resultSet.getString("itemNumber");
                String quantity = resultSet.getString("quantity");
                String date = resultSet.getString("date");
                String price = resultSet.getString("aPrice");
                String vendor = resultSet.getString("vTitle");
                String cName = resultSet.getString("cName");
                String uom = resultSet.getString("unitOfMeasure");
                String loc = resultSet.getString("locations");
                String desc = resultSet.getString("pDesc");
            %>
            <tr>
                <td><%=date%></td>
                <td><%=desc%></td>
                <td><%=item%></td>
                <td><%=quantity%></td>
                <td><span>$<%=price%></span></td>
             
                <td><%=loc%></td>
                
             
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

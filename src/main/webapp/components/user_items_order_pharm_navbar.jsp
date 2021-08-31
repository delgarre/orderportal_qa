<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.learn.mycart.entities.User"%>

<%@page import="com.learn.mycart.entities.Company"%>
<%@page import="com.learn.mycart.entities.LocationType"%>
<%
    User user1 = (User)session.getAttribute("current-user");

    
    
   // LocationType locationType = (LocationType)session.getAttribute("location");
String ids = request.getParameter("id");
String drivers = "com.mysql.jdbc.Driver";
String connectionUrls = "jdbc:mysql://172.20.29.71:3306/";
String databases = "mycart";
String userids = "admin";
String passwords = "ordering";
try {
Class.forName(drivers);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connections = null;
 

try{
connections = DriverManager.getConnection(connectionUrls+databases, userids, passwords);
Statement st=connections.createStatement();
//String sqls ="select COUNT(*) from Approve where user_id ='"+user1.getUserId()+"' and stat = 'Not Approved' and locations = '"+company.getCompanyName()+"' ";


%>


<nav class="navbar navbar-expand-lg navbar-dark custom-bg">
    <div class="container">
        <a class="navbar-brand" href="#">Ordering Portal</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="user_page.jsp">Home <span class="sr-only">(current)</span></a>
      </li>
      <%
//      ResultSet rs = st.executeQuery(sqls);
//rs.next();
//String Countrow = rs.getString(1);
    %>
      <li class="nav-item active">
          <!--<a class="nav-link" href="l_pending_orders.jsp">Cart <span>()</span></a>-->
      </li>
      
      <%
      
connections.close();
} catch (Exception e) {
e.printStackTrace();
}
      %>
      <!--
      <li>
          <a class="nav-link" href="user_orders.jsp">Past Orders <span class="sr-only">(current)</span></a>
      </li>
      -->
    </ul>
      <ul class="navbar-nav ml-auto">
          
         
           <li class="nav-item active">
              <a href="dropdown.jsp?id=<%= user1.getUserId()%>"></a>
           </li>
                 
          
          
          <%
              if(user1==null)
              {
          %>
                   <li class="nav-item active">
                    <a class="nav-link" href="login.jsp">Login </a>
                   </li>
      
                   
                  
           <%
              }
              else
              {
           %> 
           
          
           
           
            <li class="nav-item active">
                <a class="nav-link" href="user_page.jsp"><%= user1.getUserName()%> </a>
            </li>

            <li class="nav-item active">
                <a class="nav-link" href="LogoutServlet">Logout </a>
            </li>
           
           <%      
              }
           %>
          
         
      </ul>
    
  </div>
    </div>
</nav>


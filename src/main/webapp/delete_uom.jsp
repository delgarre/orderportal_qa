

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*" %>
<%
    String id = request.getParameter("id");
  
    try{
        
    Class.forName("com.mysql.jdbc.Driver");
    
    Connection conn = DriverManager.getConnection("jdbc:mysql://172.20.29.71:3306/mycart", "admin", "ordering");
    
    Statement st = conn.createStatement();
    
    int i = st.executeUpdate("DELETE FROM UOM WHERE id="+id);
    session.setAttribute("message", "Measurement deleted successfully!");
    response.sendRedirect("uom.jsp");
    }
    catch(Exception e)
    {
        System.out.println();
        e.printStackTrace();
        session.setAttribute("message", "error deleted measurement!");
        response.sendRedirect("uom.jsp");
    }
    %>
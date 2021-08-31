
<%@page import="com.learn.mycart.entities.Company"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.util.*" %>
<%
    String id = request.getParameter("id");
    String loc = request.getParameter("loc");
    try{
        
    Class.forName("com.mysql.jdbc.Driver");
    
    Connection conn = DriverManager.getConnection("jdbc:mysql://172.20.29.71:3306/mycart", "admin", "ordering");
    
    Statement st = conn.createStatement();
    
    int i = st.executeUpdate("DELETE FROM `mycart`.`Approve` WHERE (`id` = '"+id+"')");
    session.setAttribute("message", "Order Item deleted successfully!");
    response.sendRedirect("o_orders.jsp?id="+loc);
    
    }
    catch(Exception e)
    {
        System.out.println();
        e.printStackTrace();
        session.setAttribute("message", "error deleted item from cart!");
    response.sendRedirect("open.jsp");
    }
    %>
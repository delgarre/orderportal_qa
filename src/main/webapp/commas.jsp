<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%
List<String> loc = new ArrayList<>();
List<String> var = new ArrayList<>();

String location[]=request.getParameterValues("location");
                for(int i=0;i < location.length; i++){
                    String s=String.valueOf(location[i]);
                        loc.add(s);
                        var.add("or = '" + s+"'");
                }
               
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
        Iterator<String> crunchifyIterator = loc.iterator();
        while (crunchifyIterator.hasNext()) {
         %>
         <p><%=crunchifyIterator.next()%></p>
           <%
        }
        %>
        <%
        Iterator<String> or = var.iterator();
        
        while(or.hasNext()){
        %>
        <p><%=or.next()%></p>
        <%
            }
        %>
        <input type="text" value="<%=loc.get(0)%>">
    </body>
</html>

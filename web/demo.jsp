<%-- 
    Document   : demo
    Created on : Feb 25, 2025, 9:38:46 AM
    Author     : dvdung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
        ResultSet rsSub= (ResultSet)request.getAttribute("rsSub");
    %>
    <body>
        <form action="cv" method="post">
            <div class="input-group">
                                            <label>Subject</label>
                                            <select name="Subject" id="Subject">
                                                <% if (rsSub != null) {
                                                        while (rsSub.next()) {%>
                                                <option value="<%=rsSub.getInt(1)%>"><%=rsSub.getString(2)%></option>
                                                <%  }
                                                } else { %>
                                                <option value="">No subjects available</option>
                                                <% }%>
                                            </select>
                                        </div>
        </form>
    </body>
</html>

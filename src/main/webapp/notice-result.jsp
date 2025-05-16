<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Notice Result</title>
</head>
<body>
    <%
    String status = request.getParameter("status");
    if ("success".equals(status)) {
    %>
        <h1>Notice Added Successfully!</h1>
        <p><a href="notices.jsp">Back to Notices</a></p>
    <%
    } else if ("error".equals(status)) {
    %>
        <h1>Error Adding Notice</h1>
        <p>Something went wrong while adding the notice. Please try again.</p>
        <p><a href="notices.jsp">Back to Notices</a></p>
    <%
    } else {
    %>
        <p>Unknown status.</p>
        <p><a href="notices.jsp">Back to Notices</a></p>
    <%
    }
    %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error Page</title>
</head>
<body>
    <h1>Error Page</h1>
    
    <% String errorType = request.getParameter("errorType"); %>
    
    <% if ("unknownRole".equals(errorType)) { %>
        <p style="color: red;">Unknown user role. Please contact support.</p>
    <% } else if ("loginFailed".equals(errorType)) { %>
        <p style="color: red;">Login failed. Please check your email and password.</p>
    <% } else { %>
        <p style="color: red;">An unknown error occurred. Please try again later.</p>
    <% } %>
</body>
</html>

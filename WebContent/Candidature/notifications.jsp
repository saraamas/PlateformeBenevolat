<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<!-- Affichage des notifications avec date -->
<html>
<head>
    <title>Notifications</title>
</head>
<body>
    <h2>Notifications</h2>
    <c:forEach var="notification" items="${notifications}">
        <p>${notification}</p>
    </c:forEach>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Benevole Home Page</title>
    <!-- Add your stylesheets, scripts, or other head elements here -->
</head>
<body>
    <h1>Welcome<a href="${pageContext.request.contextPath}/ProfileManaging?action=view"> ${requestScope.userPrenom} ${requestScope.userNom}!</a></h1>
    <!-- You can use ${requestScope.userType} or any other attributes set in the servlet -->
    <!-- Add content specific to the benevole home page -->
    <!-- Add links, buttons, or other elements as needed -->

    <a href="${pageContext.request.contextPath}/logoutServlet">Déconnexion</a><br>
    <a href="${pageContext.request.contextPath}/ProfileManaging?action=update">Profile Settings</a><br>

    <a href="eventServlet?action=view">Voir tous les evenements</a><br>
    <a href="candidatureServlet?action=view">Mes Candidatures</a><br>
    <a href="candidatureServlet?action=viewNotifications">Voir les notifications</a><br>


</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Home Page</title>
    <!-- Add your stylesheets, scripts, or other head elements here -->
</head>
<body>
    <h1>Welcome<a href="ProfileManaging?action=view"> ${requestScope.userNom}</a>!</h1>
    <!-- You can use ${requestScope.userType} or any other attributes set in the servlet -->
    <!-- Add content specific to the admin home page -->
    <!-- Add links, buttons, or other elements as needed -->

    <a href="${pageContext.request.contextPath}/logoutServlet">Déconnexion</a><br>
    <a href="<%= request.getContextPath() %>/update-adminAssociationProfile.jsp">Profile Settings</a><br>
    <a href="${pageContext.request.contextPath}/eventServlet?action=create">Créer un nouvel événement</a><br>
    <a href="eventServlet?action=view">Voir tous les evenements</a><br>
	<a href="candidatureServlet?action=view">Candidatures</a><br>
	

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mes Candidatures</title>
</head>
<body>

<h2>Mes Candidatures</h2>

<c:forEach var="candidature" items="${candidatureList}">
    <div>
        <p>Lettre de Motivation: ${candidature.lettreMotivation}</p>
        <p>Statut: ${candidature.statut}</p>
        <p>Event: <a href="eventServlet?action=details&idEvent=${candidature.event.idEvent}">${candidature.event.titre}</a></p>
    </div>
    <hr>
</c:forEach>

</body>
</html>

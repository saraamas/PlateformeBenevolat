<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Candidatures</title>
</head>
<body>

<h2>Liste des Candidatures</h2>

<c:forEach var="candidature" items="${candidatureList}">
    <div>
        <p>ID Candidature: ${candidature.idCandidature}</p>
        <p>Lettre de Motivation: ${candidature.lettreMotivation}</p>
        <p>Statut: ${candidature.statut}</p>
        <p>Benevole: ${candidature.benevole.nom}</p>
        <p>Event: ${candidature.event.titre}</p>
        <!-- Add other relevant details -->

        <!-- Add buttons or links for further actions -->
        <a href="candidatureServlet?action=traiter&candidatureId=${candidature.idCandidature}&decision=accepte">Accepter</a>
        <a href="candidatureServlet?action=traiter&candidatureId=${candidature.idCandidature}&decision=refuse">Refuser</a>
    </div>
    <hr>
</c:forEach>

</body>
</html>

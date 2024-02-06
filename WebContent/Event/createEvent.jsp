<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.JAVA.Beans.User" %>


<html>
<head>
    <meta charset="UTF-8">
    <title>Créer un événement</title>
</head>
<body>

<h2>Créer un nouvel événement</h2>

<c:choose>
    <c:when test="${sessionScope.user ne null}">
	<form action="${pageContext.request.contextPath}/eventServlet?action=create" method="post" enctype="multipart/form-data">
  
            <label for="titre">Titre:</label>
            <input type="text" id="titre" name="titre" required><br>

            <label for="description">Description:</label>
            <textarea id="description" name="description" required></textarea><br>

            <label for="categorie">Catégorie:</label>
            <input type="text" id="categorie" name="categorie" required><br>

            <label for="dateDebut">Date de début:</label>
            <input type="text" id="dateDebut" name="dateDebut" placeholder="YYYY-MM-DD" required><br>

            <label for="dateFin">Date de fin:</label>
            <input type="text" id="dateFin" name="dateFin" placeholder="YYYY-MM-DD" required><br>

            <label for="lieu">Lieu:</label>
            <input type="text" id="lieu" name="lieu" required><br>

            <label for="picture">Image:</label>
            <input type="file" id="picture" name="picture" accept="image/*" ><br>

            <input type="submit" value="Créer">
        </form>
    </c:when>
    <c:otherwise>
        <p>Vous devez être connecté pour créer un événement.</p>
    </c:otherwise>
</c:choose>

<a href="${pageContext.request.contextPath}/eventServlet?action=view">Retour à la liste des événements</a>

</body>
</html>

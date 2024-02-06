<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Event</title>
</head>
<body>

<h2>Mise à jour de l'événement</h2>

<c:if test="${not empty event}">
    <form action="eventServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="idEvent" value="${event.idEvent}">
        
        <label for="titre">Titre:</label>
        <input type="text" name="titre" value="${event.titre}" required><br>
        
        <label for="description">Description:</label>
        <textarea name="description" rows="4" required>${event.description}</textarea><br>
        
        <label for="categorie">Catégorie:</label>
        <input type="text" name="categorie" value="${event.categorie}" required><br>
        
        <label for="dateDebut">Date de début:</label>
        <input type="text" name="dateDebut" value="${event.dateDebut}" required><br>
        
        <label for="dateFin">Date de fin:</label>
        <input type="text" name="dateFin" value="${event.dateFin}" required><br>
        
        <label for="lieu">Lieu:</label>
        <input type="text" name="lieu" value="${event.lieu}" required><br>

        <!-- Ajoutez ici les champs nécessaires pour la mise à jour -->

        <label for="picture">Image:</label>
        <input type="file" name="picture"><br>

        <input type="submit" value="Mettre à jour">
    </form>
</c:if>

<a href="eventServlet?action=view">Voir tous les evenements</a>
</body>
</html>

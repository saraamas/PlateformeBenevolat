<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Details</title>
</head>
<body>
    <h1>Event Details</h1>
    
    <c:if test="${not empty eventDetails}">
        <p>Title: ${eventDetails.titre}</p>
        <p>Createur: ${eventDetails.adminAssociation.nom}</p>
        <p>Description: ${eventDetails.description}</p>
        <p>Category: ${eventDetails.categorie}</p>
        <p>Start Date: ${eventDetails.dateDebut}</p>
        <p>End Date: ${eventDetails.dateFin}</p>
        <p>Location: ${eventDetails.lieu}</p>
        
        <c:if test="${not empty eventDetails.pictureBase64}">
            <img src="data:image/jpeg;base64,${eventDetails.pictureBase64}" alt="Event Picture">
        </c:if>
    </c:if>
    
    <!-- Formulaire pour ajouter un nouvel avis -->
    <form action="AvisServlet" method="post">
        <input type="hidden" name="action" value="addAvis">
        <input type="hidden" name="eventId" value="${event.idEvent}">

        <label for="commentaire">Commentaire:</label>
        <textarea name="commentaire" id="commentaire" required></textarea>

        <label for="reactionId">Réaction:</label>
        <select name="reactionId" id="reactionId" required>
            <option value="${Avis.REACTION_LIKE}">Like</option>
            <option value="${Avis.REACTION_LOVE}">Love</option>
            <option value="${Avis.REACTION_HAHA}">Haha</option>
            <!-- Ajoutez d'autres options si nécessaire -->
        </select>

        <input type="submit" value="Ajouter Avis">
    </form>
    
    <!-- Afficher la liste des avis -->
    <h3>Avis</h3>
    <c:forEach var="avis" items="${avisList}">
        <p>${getUserName.getUserName(user)} - ${avis.commentaire} - ${avis.timestamp}</p>
    </c:forEach>

    
    
    <p><a href="eventServlet?action=view">Back to Events</a></p>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.JAVA.Beans.Avis" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Details</title>
    <style>
    /* Style du cadre autour des commentaires */
    .comment-box {
        border: 1px solid #ddd; /* Bordure grise */
        border-radius: 5px; /* Coins arrondis */
        padding: 10px; /* Espace à l'intérieur du cadre */
        margin-bottom: 15px; /* Marge en bas pour séparer les commentaires */
    }

    /* Style pour la réaction */
    .reaction {
        font-weight: bold; /* Texte en gras */
        color: #365899; /* Couleur bleue similaire à Facebook */
    }

    /* Style pour le timestamp */
    .timestamp {
        font-size: 0.8em; /* Taille de police plus petite */
        color: #888; /* Couleur grise pour le timestamp */
        margin-left: 10px; /* Marge à gauche pour séparer le timestamp de la réaction */
    }
     /* Styles de formulaire */
    .add-comment-form {
        margin-top: 20px;
    }

    .add-comment-form label {
        display: block;
        margin-bottom: 5px;
    }

    .add-comment-form textarea {
        width: 100%;
        padding: 5px;
        margin-bottom: 10px;
    }

    .add-comment-form select {
        padding: 5px;
        margin-bottom: 10px;
    }
</style>
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
        
       <img src="data:image/jpeg;base64,${base64Photo}" alt="Event Picture">
    </c:if>
    
    <!-- Formulaire pour ajouter un nouvel avis -->
	<form action="AvisServlet" method="post" class="add-comment-form">
	    <input type="hidden" name="action" value="addAvis">
	    <input type="hidden" name="eventId" value="${eventDetails.idEvent}">
	
	    <label for="commentaire">Commentaire:</label>
	    <textarea name="commentaire" id="commentaire" required></textarea>
	
	   <label for="reactionId">Réaction:</label>
    <select name="reactionId" idit="reactionId" required>
        <option value="">Sélectionner une réaction</option> <!-- Option vide pour forcer la sélection -->
        <option value="${Avis.REACTION_LIKE}">Like</option>
        <option value="${Avis.REACTION_LOVE}">Love</option>
        <option value="${Avis.REACTION_HAHA}">Haha</option>
        <option value="${Avis.REACTION_WOW}">Wow</option>
        <option value="${Avis.REACTION_SAD}">Sad</option>
        <option value="${Avis.REACTION_ANGRY}">Angry</option>
        <!-- Ajoutez d'autres options si nécessaire -->
    </select>
	
	    <input type="submit" value="Ajouter Avis">
	</form>
    
    <!-- Afficher la liste des avis -->
<c:forEach var="avis" items="${avisList}">
    <div class="comment-box">
        <p>
        	<span class="user-name">${AvisServlet.getUserName(avis.user)}</span>
            <span class="reaction">${avis.reactionId}</span> <!-- Affichage de la réaction -->
            <span class="timestamp">${avis.timestamp}</span><!-- Affichage du timestamp -->
        </p>
        <p>${avis.commentaire}</p> <!-- Affichage du commentaire -->
    </div>
</c:forEach>

    
    
    <p><a href="eventServlet?action=view">Back to Events</a></p>
</body>
</html>

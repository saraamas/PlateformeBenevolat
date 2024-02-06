<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.JAVA.Beans.Event" %>
<%@ page import="com.JAVA.Beans.AdminAssociation" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Events</title>
</head>
<body>

<h2>Liste des événements</h2>

<!-- Barre de recherche -->
<form action="eventServlet" method="get">
	<input type="hidden" name="action" value="search">
    <label for="searchCategory">Rechercher par catégorie:</label>
    <input type="text" id="searchCategory" name="searchCategory">
    <input type="submit" value="search">
</form>

<c:if test="${not empty allEvents}">
    <c:forEach var="event" items="${allEvents}">
        <div style="border: 1px solid #ccc; padding: 10px; margin-bottom: 10px;">
            <h3><a href="${pageContext.request.contextPath}/AvisServlet?eventId=${event.idEvent}">${event.titre}</a></h3>
            <p><strong>Createur:</strong><a href="${pageContext.request.contextPath}/ProfileManaging?action=view&userIdToShow=${event.adminAssociation.idUtilisateur}">${event.adminAssociation.nom}</a></p>
            <p><strong>Catégorie:</strong> ${event.categorie}</p>
            <p><strong>Description:</strong> ${event.description}</p>
            <p><strong>Date de début:</strong> ${event.dateDebut}</p>
            <p><strong>Date de fin:</strong> ${event.dateFin}</p>
            <p><strong>Lieu:</strong> ${event.lieu}</p>

            <!-- Afficher l'image si elle existe -->
            <c:if test="${not empty event.picture}">
                <img src="data:image/jpg;base64,${event.pictureBase64}" alt="Event Image" style="max-width: 200px; max-height: 200px;">
            </c:if>

            <!-- Afficher le nom de l'administrateur de l'association -->
   

            <c:if test="${user ne null && user.idUtilisateur eq event.getAdminAssociation().getIdUtilisateur()}">
 
                <form action="eventServlet" method="get" style="display: inline;">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="idEvent" value="${event.idEvent}">
                    <input type="submit" value="Update">
                </form>

                <form action="eventServlet" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="idEvent" value="${event.idEvent}">
                    <input type="submit" value="Delete">
                </form>
            </c:if>
            
      	<c:if test="${user ne null && user.role eq 'benevole'}">
    		<a href="${pageContext.request.contextPath}/candidatureServlet?action=create&benevoleId=${user.idUtilisateur}&eventId=${event.idEvent}">Deposer Candidature</a>
		</c:if>
      	
        </div>
    </c:forEach>
</c:if>

<c:if test="${empty allEvents}">
    <p>Aucun événement disponible.</p>
</c:if>


</body>
</html>

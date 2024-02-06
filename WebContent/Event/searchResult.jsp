<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
    <!-- Add any additional meta tags, stylesheets, or scripts here -->
</head>
<body>

<h2>Search Results</h2>

<c:if test="${not empty eventsByCategory}">
    <c:forEach var="event" items="${eventsByCategory}">
        <div style="border: 1px solid #ccc; padding: 10px; margin-bottom: 10px;">
            <h3><a href="eventServlet?action=details&idEvent=${event.idEvent}">${event.titre}</a></h3>
            <p><strong>Category:</strong> ${event.categorie}</p>
            <p><strong>Description:</strong> ${event.description}</p>
            <p><strong>Start Date:</strong> ${event.dateDebut}</p>
            <p><strong>End Date:</strong> ${event.dateFin}</p>
            <p><strong>Location:</strong> ${event.lieu}</p>

            <!-- Display the image if it exists -->
            <c:if test="${not empty event.picture}">
                <img src="data:image/jpg;base64,${event.pictureBase64}" alt="Event Image" style="max-width: 200px; max-height: 200px;">
            </c:if>

            <!-- Add other details if necessary -->

            <!-- Add the link to return to events -->
            <p><a href="eventServlet?action=view">Back to Events</a></p>
        </div>
    </c:forEach>
</c:if>

<c:if test="${empty eventsByCategory}">
    <p>No events found for the specified category.</p>
    <!-- Add the link to return to events -->
    <p><a href="eventServlet?action=view">Back to Events</a></p>
</c:if>

</body>
</html>

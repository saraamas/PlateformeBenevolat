<%@ page import="com.JAVA.Beans.Benevole" %>
<%@ page import="com.JAVA.Beans.User" %>
<%@ page import="com.JAVA.Beans.AdminAssociation" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${not empty user and user.role eq 'benevole'}">
    <html>
    <head>
        <title>Benevole Profile</title>
    </head>
    <body>

        <h2>Benevole Profile</h2>
        <!-- Display common fields -->
        Email: ${user.email}<br>
        Role: ${user.role}<br>

        <!-- Display current profile picture -->
        <c:choose>
		    <c:when test="${not empty base64Photo}">
		        <img src="data:image/png;base64,${base64Photo}" alt="Profile Picture" width="100"><br>
		    </c:when>
		    <c:otherwise>
		        <!-- Display a placeholder image when photoProfil is null -->
		        <img src="images/placeholder-image.jpg" alt="No Image" width="100"><br>
		    </c:otherwise>
		</c:choose>

        <!-- Display Benevole-specific fields -->
        Nom: ${benevole.nom}<br>
        Prenom: ${benevole.prenom}<br>
        Titre Professionnel: ${benevole.titreProfessionnel}<br>
        Resume: ${benevole.resume}<br>
        <label for="sexe">Sexe :</label>
        <input type="text" id="sexe" name="sexe" value="${benevole.sexe}" readonly><br>
        <label for="dateNaissance">Date de Naissance :</label>
        <input type="text" id="dateNaissance" name="dateNaissance" value="${benevole.dateNaissance}" readonly><br>
        <label for="age">Âge :</label>
        <input type="text" id="age" name="age" value="${benevole.age}" readonly><br>
	
        <!-- Display associations -->
        <h3>Associations</h3>
        <c:forEach var="association" items="${benevole.associations}">
            ${association.nom} - ${association.secteurActivite}<br>
            <!-- Add more fields as needed -->
        </c:forEach>

    </body>
    </html>
</c:if>

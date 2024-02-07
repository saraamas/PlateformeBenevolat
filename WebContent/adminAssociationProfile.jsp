<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.JAVA.Beans.AdminAssociation" %>
<%@ page import="com.JAVA.Beans.Benevole" %>
<%@ page import="java.util.Base64" %>

<!DOCTYPE html>
<html>
<head>
    <title>AdminAssociation Profile</title>
</head>
<body>

    <h2>AdminAssociation Profile</h2>
    <!-- Display common fields -->
    Email: ${user.email}<br>

    <!-- Display current profile picture -->
    <c:if test="${not empty user.photoProfil}">
        <img src="data:image/png;base64,${Base64.getEncoder().encodeToString(user.photoProfil)}" alt="Profile Picture" width="100"><br>
    </c:if>
    <c:if test="${empty user.photoProfil}">
        <!-- Display a placeholder image when photoProfil is null -->
        <img src="images/placeholder-image.jpg" alt="No Image" width="100"><br>
    </c:if>

    <!-- Cast to AdminAssociation to access specific fields -->
    Nom: ${admin.nom}<br>
    Description: ${admin.description}<br>
    Secteur d'Activite: ${admin.secteurActivite}<br>
    Site Web: ${admin.siteWeb}<br>
    Adresse: ${admin.adresse}<br>
    Phone: ${admin.phone}<br>
    Ville: ${admin.ville}<br>

    <!-- Display adherents (members) -->
    <h3>Adherents</h3>
    <c:forEach var="adherent" items="${admin.adherents}">
        ${adherent.nom} ${adherent.prenom}<br>
        <!-- Add more fields as needed -->
    </c:forEach>

</body>
</html>

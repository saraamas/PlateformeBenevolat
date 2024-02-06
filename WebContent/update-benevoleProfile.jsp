<%@ page import="com.JAVA.Beans.Benevole" %>
<%@ page import="com.JAVA.Beans.User" %>
<%@ page import="com.JAVA.DAO.BenevoleDAO" %>
<%@ page import="com.JAVA.DAO.BenevoleDAOImpl" %>
<%@ page import="com.JAVA.DAO.DAOFactory" %>
<%@ page import="java.util.Base64" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Benevole Profile</title>
    <style>
        /* Add your CSS styles here for better presentation */
    </style>
</head>
<body>

    <h2>Benevole Profile</h2>
    <c:if test="${not empty user and user.role eq 'benevole'}">
        <form action="ProfileManaging" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="update">

            <!-- Display common fields -->
            Email: ${user.email}<br>

            <!-- Display new password fields -->
            Mot de Passe: <input type="password" name="motDePasse"><br>
            Confirmer Mot de Passe: <input type="password" name="confirmMotDePasse"><br>

            Role: ${user.role}<br>

            <!-- Display current profile picture -->
            <c:choose>
                <c:when test="${not empty user.photoProfil}">
                    <img src="data:image/png;base64,${base64Photo}" alt="Profile Picture" width="100"><br>
                </c:when>
                <c:otherwise>
                    <!-- Display a placeholder image when photoProfil is null -->
                    <img src="images/placeholder-image.jpg" alt="No Image" width="100"><br>
                </c:otherwise>
            </c:choose>

            <!-- Allow uploading a new profile picture -->
            Upload Profile Picture: <input type="file" name="photoProfil"/><br>

            <!-- Checkbox to delete profile picture -->
            Delete Profile Picture: <input type="checkbox" name="deletePhotoProfil"><br>

            <!-- Display Benevole-specific fields -->
            Nom: <input type="text" name="nom" value="${benevole.nom}"><br>
            Prenom: <input type="text" name="prenom" value="${benevole.prenom}"><br>
            Sexe: <select name="sexe">
				    <option value="Femme" ${benevole.sexe == 'Femme' ? 'selected' : ''}>Femme</option>
				    <option value="Homme" ${benevole.sexe == 'Homme' ? 'selected' : ''}>Homme</option>
				    <option value="Autre" ${benevole.sexe == 'Autre' ? 'selected' : ''}>Autre</option>
				</select><br>
            Titre Professionnel: <input type="text" name="titreProfessionnel" value="${benevole.titreProfessionnel}"><br>
            Resume: <input type="text" name="resume" value="${benevole.resume}"><br>
            Date de Naissance: <input type="text" name="dateNaissance" value="${benevole.dateNaissance}"><br>

            <input type="submit" value="Update Profile">
        </form>
    </c:if>

</body>
</html>

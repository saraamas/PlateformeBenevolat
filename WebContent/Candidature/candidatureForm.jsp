<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Déposer une Candidature</title>
    <style>
    .input-container {
        display: inline-block;
        margin-right: 20px; /* Adjust the margin as needed */
    }
</style>
</head>
<body>

<h2>Déposer une Candidature</h2>

<form action="candidatureServlet" method="post">
    <input type="hidden" name="action" value="deposer">

    <label for="lettreMotivation">Lettre de motivation:</label>
    <textarea name="lettreMotivation" rows="4" required></textarea><br>
    
	<label for="eventName">Event Name:</label>
	<input type="text" name="eventName" value="${eventName}" readonly><br>
	
	<label for="adminassociationName"> Association Name:</label>
	<input type="text" name="adminassociationName" value="${adminassociationName}" readonly><br>
	
	<label for="benevole">Benevole :</label>
	<label for="nom">Nom :</label>
	<div class="input-container">
	    <input type="text" id="nom" name="nom" value="${benevoleName}" readonly>
	</div>
	
	<label for="prenom">Prenom :</label>
	<div class="input-container">
	    <input type="text" id="prenom" name="prenom" value="${benevolePrenom}" readonly>
	</div><br>
	
    <input type="submit" value="Déposer la Candidature">
</form>

<a href="candidatureServlet?action=view">Retour à la liste des candidatures</a>

</body>
</html>

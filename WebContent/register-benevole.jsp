<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Benevole Registration</title>
</head>
<body>
    <h2>Inscription en tant que Benevole</h2>
    <form action="register-benevole" method="post">
    
       <!-- <input type="hidden" name="userId" value="${param.userId}"> -->
        
        <label>Additional Benevole Information:</label><br>
        <label for="nom">Nom:</label>
        <input type="text" id="nom" name="nom" required><br>

        <label for="prenom">Prénom:</label>
        <input type="text" id="prenom" name="prenom" required><br>
        <!-- New fields for gender and date of birth -->
        <label for="gender">Sexe :</label>
        <select id="gender" name="gender">
            <option value="male">Homme</option>
            <option value="female">Femme</option>
            <option value="other">Autre</option>
        </select><br>

        <label for="dateNaissance">Date de naissance :</label>
		<input type="date" id="dateNaissance" name="dateNaissance"><br>

        <label for="titreProfessionnel">Titre Professionnel:</label>
        <input type="text" id="titreProfessionnel" name="titreProfessionnel"><br>

        <label for="resume">Résumé:</label>
        <textarea id="resume" name="resume" rows="4" cols="50"></textarea><br>
        

        <!-- Bouton de soumission -->
        

        <input type="submit" value="Complete Registration">
    </form>
</body>
</html>

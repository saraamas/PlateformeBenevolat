
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Association Registration</title>
</head>
<body>

    <h2>Inscription en tant qu'Administrateur d'Association</h2>

    <form action="register-adminassociation" method="post">


        <label for="nom">Nom de l'Association:</label>
        <input type="text" id="nom" name="nom" required><br>

        <label for="description">Description:</label>
        <textarea id="description" name="description" rows="4" cols="50"></textarea><br>

        <label for="secteurActivite">Secteur d'Activité:</label>
        <input type="text" id="secteurActivite" name="secteurActivite"><br>

        <label for="siteWeb">Site Web:</label>
        <input type="text" id="siteWeb" name="siteWeb"><br>

        <label for="adresse">Adresse:</label>
        <input type="text" id="adresse" name="adresse"><br>

        <label for="phone">Téléphone:</label>
        <input type="text" id="phone" name="phone"><br>

        <label for="ville">Ville:</label>
        <input type="text" id="ville" name="ville"><br>

        <!-- Bouton de soumission -->
        <input type="submit" value="S'inscrire en tant qu'Admin Association">

    </form>

</body>
</html>

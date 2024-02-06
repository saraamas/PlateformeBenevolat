<%@ page import="com.JAVA.Beans.AdminAssociation" %>
<%@ page import="com.JAVA.Beans.Benevole" %>

<%@ page import="com.JAVA.Beans.User" %>
<%@ page import="com.JAVA.DAO.AdminAssociationDAO" %>
<%@ page import="com.JAVA.DAO.AdminAssociationDAOImpl" %>
<%@ page import="com.JAVA.DAO.DAOFactory" %>
<%@ page import="java.util.Base64" %>

<%
    User user = (User) session.getAttribute("user");

    if (user != null && user.getRole().equals(User.UserRole.adminassociation)) {
        AdminAssociationDAO adminAssociationDAO = new AdminAssociationDAOImpl(DAOFactory.getInstance());
        AdminAssociation admin = adminAssociationDAO.getAdminAssociationById(user.getIdUtilisateur());
%>
        <!DOCTYPE html>
        <html>
        <head>
            <title>AdminAssociation Profile</title>
        </head>
        <body>

            <h2>AdminAssociation Profile</h2>
            <!-- Display common fields -->
            Email: <%= user.getEmail() %><br>
            Role: <%= user.getRole() %><br>

            <!-- Display current profile picture -->
            <% if (user != null && user.getPhotoProfil() != null) {
                String base64Photo = Base64.getEncoder().encodeToString(user.getPhotoProfil());
            %>
                <img src="data:image/png;base64,<%= base64Photo %>" alt="Profile Picture" width="100"><br>
            <% } else { %>
                <!-- Display a placeholder image when photoProfil is null -->
                <img src="images/placeholder-image.jpg" alt="No Image" width="100"><br>
            <% } %>

            <!-- Cast to AdminAssociation to access specific fields -->
            Nom: <%= admin.getNom() %><br>
            Description: <%= admin.getDescription() %><br>
            Secteur d'Activite: <%= admin.getSecteurActivite() %><br>
            Site Web: <%= admin.getSiteWeb() %><br>
            Adresse: <%= admin.getAdresse() %><br>
            Phone: <%= admin.getPhone() %><br>
            Ville: <%= admin.getVille() %><br>
        	
        	<!-- Display adherents (members) -->
			<h3>Adherents</h3>
			<% for (Benevole adherent : admin.getAdherents()) { %>
			    <%= adherent.getNom() %> <%= adherent.getPrenom() %><br>
			    <!-- Add more fields as needed -->
			<% } %>
        	

        </body>
        </html>
<%
    }
%>

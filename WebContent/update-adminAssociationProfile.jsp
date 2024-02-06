<%@ page import="com.JAVA.Beans.AdminAssociation" %>
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
<% System.out.println("User Attributes: " + user); %>

            <h2>AdminAssociation Profile</h2>
            <form action="ProfileManaging" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="update">
            
                 <!-- Display common fields -->
                Email: <%= user.getEmail() %><br>
                 <!-- Display new password fields -->
       			Mot de Passe: <input type="password" name="motDePasse"><br>
				Confirmer Mot de Passe: <input type="password" name="confirmMotDePasse"><br>
 				Role: <%= user.getRole() %><br>
                

        
			<!-- Display current profile picture -->
			<% if ( user!= null && user.getPhotoProfil() != null) {
			    String base64Photo = Base64.getEncoder().encodeToString(user.getPhotoProfil());
			%>
			    <img src="data:image/png;base64,<%= base64Photo %>" alt="Profile Picture" width="100"><br>
			<% } else { %>
			    <!-- Display a placeholder image when photoProfil is null -->
			    <img src="images/placeholder-image.jpg" alt="No Image" width="100"><br>
			<% } %>
			
		        <!-- Allow uploading a new profile picture -->
		        Upload Profile Picture: <input type="file" name="photoProfil"/><br>
		
		        <!-- Checkbox to delete profile picture -->
		        Delete Profile Picture: <input type="checkbox" name="deletePhotoProfil"><br>
		        
                <!-- Cast to AdminAssociation to access specific fields -->
                Nom: <input type="text" name="nom" value="<%= admin.getNom() %>"><br>
                Description: <input type="text" name="description" value="<%= admin.getDescription() %>"><br>
                Secteur d'Activite: <input type="text" name="secteurActivite" value="<%= admin.getSecteurActivite() %>"><br>
                Site Web: <input type="text" name="siteWeb" value="<%= admin.getSiteWeb() %>"><br>
                Adresse: <input type="text" name="adresse" value="<%= admin.getAdresse() %>"><br>
                Phone: <input type="text" name="phone" value="<%= admin.getPhone() %>"><br>
                Ville: <input type="text" name="ville" value="<%= admin.getVille() %>"><br>

		        


                <input type="submit" value="Update Profile">
            </form>

        </body>
        </html>
<%
    }
%>

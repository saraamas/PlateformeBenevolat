package com.JAVA.Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.JAVA.Beans.AdminAssociation;
import com.JAVA.Beans.User;
import com.JAVA.DAO.AdminAssociationDAOImpl;
import com.JAVA.DAO.DAOFactory;

/**
 * Servlet implementation class RegisterAdminAssociationServlet
 */
@WebServlet("/register-adminassociation")
public class RegisterAdminAssociationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Initialize your DAO with a proper DAOFactory
        AdminAssociationDAOImpl adminAssociationDAO = new AdminAssociationDAOImpl(DAOFactory.getInstance());

        String nom = request.getParameter("nom");
        String description = request.getParameter("description");
        String secteurActivite = request.getParameter("secteurActivite");
        String siteWeb = request.getParameter("siteWeb");
        String adresse = request.getParameter("adresse");
        String phone = request.getParameter("phone");
        String ville = request.getParameter("ville");

        // Basic input validation
        if (nom == null || description == null || secteurActivite == null || siteWeb == null || adresse == null
                || phone == null || ville == null || nom.isEmpty() || description.isEmpty() || secteurActivite.isEmpty()
                || siteWeb.isEmpty() || adresse.isEmpty() || phone.isEmpty() || ville.isEmpty()) {
            // Redirect to an error page or display an error message
            response.sendRedirect("error.jsp");
            return;
        }

        // Get the user object from the session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Create an AdminAssociation object
        AdminAssociation adminAssociation = new AdminAssociation();
        adminAssociation.setIdUtilisateur(user.getIdUtilisateur());
        adminAssociation.setNom(nom);
        adminAssociation.setDescription(description);
        adminAssociation.setSecteurActivite(secteurActivite);
        adminAssociation.setSiteWeb(siteWeb);
        adminAssociation.setAdresse(adresse);
        adminAssociation.setPhone(phone);
        adminAssociation.setVille(ville);

        // Call the DAO method to add the admin association
        int adminAssociationId = adminAssociationDAO.addAdminAssociation(adminAssociation);

        if (adminAssociationId > 0) {
            // Registration successful
        	// Set attributes to be accessed in the JSP
            request.setAttribute("userNom", adminAssociation.getNom());
            request.setAttribute("userType", "AdminAssociation");

            // Redirect to a success page
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin_home.jsp");
            dispatcher.forward(request, response);
        } else {
            // Registration failed
            // Redirect to an error page or display an error message
            response.sendRedirect("error.jsp");
        }
    }
}

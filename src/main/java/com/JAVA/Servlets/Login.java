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
import com.JAVA.Beans.Benevole;
import com.JAVA.Beans.User;
import com.JAVA.Beans.UserFactory;
import com.JAVA.DAO.AdminAssociationDAOImpl;
import com.JAVA.DAO.BenevoleDAO;
import com.JAVA.DAO.BenevoleDAOImpl;
import com.JAVA.DAO.DAOFactory;
import com.JAVA.DAO.UserDAO;
import com.JAVA.DAO.UserDAOImpl;

@WebServlet("/login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAOImpl(DAOFactory.getInstance());

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Debugging message for authentication attempt
        System.out.println("Attempting authentication for email: " + email);

        // Perform authentication using UserDAOImpl
        User user = userDAO.auth(email, password);

        if (user != null) {
            // Authentication successful
            System.out.println("Authentication successful for user: " + user.getEmail());
            System.out.println("Authentication successful for user: " + user.getIdUtilisateur());
            int idUser=user.getIdUtilisateur();
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Set attributes based on user role for access in JSP
            if (user.getRole() == User.UserRole.benevole) {
            	
            	// Assuming you have an instance of BenevoleDAOImpl or another class that implements BenevoleDAO
            	BenevoleDAO benevoleDAO = new BenevoleDAOImpl(DAOFactory.getInstance()); // You might need to adjust this line based on your actual implementation

            	// Now you can use the instance to call getBenevoleById
            	Benevole existingBenevole = benevoleDAO.getBenevoleById(idUser);
                System.out.println("Benevole Existing: " + existingBenevole);
                
                // Use UserFactory to create a Benevole object
                Benevole benevole = (Benevole) UserFactory.createUser(user.getRole(), email, password /* other parameters */);
                System.out.println("Benevole New: " + benevole);

                // Set attributes for nom and prenom using the values from existingBenevole
                benevole.setNom(existingBenevole.getNom());
                benevole.setPrenom(existingBenevole.getPrenom());
               

                // Set attributes for nom and prenom directly
                request.setAttribute("userNom", benevole.getNom());
                request.setAttribute("userPrenom", benevole.getPrenom());

                RequestDispatcher dispatcher = request.getRequestDispatcher("benevole_home.jsp");
                dispatcher.forward(request, response);
            } else if (user.getRole() == User.UserRole.adminassociation) {
            	// Assuming you have an instance of AdminAssociationDAOImpl or another class that implements AdminAssociationDAO
                AdminAssociationDAOImpl adminAssociationDAO = new AdminAssociationDAOImpl(DAOFactory.getInstance());

                // Now you can use the instance to call getAdminAssociationById
                AdminAssociation existingAdminAssociation = adminAssociationDAO.getAdminAssociationById(idUser);
                System.out.println("AdminAssociation Existing: " + existingAdminAssociation);

                // Use UserFactory to create an AdminAssociation object
                AdminAssociation adminAssociation = (AdminAssociation) UserFactory.createUser(user.getRole(), email, password /* other parameters */);
                System.out.println("AdminAssociation New: " + adminAssociation);

                // Set attributes for nom using the values from existingAdminAssociation
                adminAssociation.setNom(existingAdminAssociation.getNom());

                System.out.println("AdminAssociation nom: " + adminAssociation.getNom());
                
                request.setAttribute("userNom", adminAssociation.getNom());
                
                session.setAttribute("adminAssociation", existingAdminAssociation);

                //request.setAttribute("userType", "AdminAssociation");
                RequestDispatcher dispatcher = request.getRequestDispatcher("admin_home.jsp");
                dispatcher.forward(request, response);
            } else {
                // Handle other roles or redirect to an error page
                response.sendRedirect("error.jsp?errorType=unknownRole");
            }
        } else {
            // Authentication failed
            System.out.println("Authentication failed for email: " + email);

            // Redirect to a login error page or display an error message
            response.sendRedirect("error.jsp?errorType=loginFailed");
        }
    }
}
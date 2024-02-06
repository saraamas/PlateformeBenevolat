package com.JAVA.Servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.JAVA.Beans.User;
import com.JAVA.Beans.User.UserRole;
import com.JAVA.DAO.DAOFactory;
import com.JAVA.DAO.UserDAO;
import com.JAVA.DAO.UserDAOImpl;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Initialize your DAO with a proper DAOFactory
        UserDAO userDAO = new UserDAOImpl(DAOFactory.getInstance());

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String roleString = request.getParameter("role");
        String confirmPassword = request.getParameter("confirmPassword");

        // Basic input validation
        if (email == null || password == null || confirmPassword == null || roleString == null
                || !password.equals(confirmPassword) || email.isEmpty() || password.isEmpty()) {
            // Redirect to an error page or display an error message
            response.sendRedirect("error.jsp");
            return;
        }

        // Convert the role string to UserRole enum
        UserRole role = UserRole.valueOf(roleString);

        // Create a User object
        User user = new User();
        user.setEmail(email);
        user.setMotDePasse(password);
        user.setRole(role);

        int userId = userDAO.addUser(user);

        if (userId > 0) {
            // Registration successful
            // Store the user object in the session
            HttpSession session = request.getSession();
            user.setIdUtilisateur(userId);
            session.setAttribute("user", user);

            // Debug statements
            System.out.println("Debug Information - User ID in session: " + user.getIdUtilisateur());
            System.out.println("Debug Information - User Object in session: " + session.getAttribute("user"));

            if (role == UserRole.benevole) {
                // Redirect to benevole registration page
                response.sendRedirect("register-benevole.jsp");
            } else if (role == UserRole.adminassociation) {
                // Redirect to adminassociation registration page
                response.sendRedirect("register-adminassociation.jsp");
            } 
        } else {
            // Registration failed
            // Redirect to an error page or display an error message
            response.sendRedirect("error.jsp");
        }
    }
}

package com.JAVA.Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;

import com.JAVA.Beans.Benevole;
import com.JAVA.Beans.User;
import com.JAVA.DAO.BenevoleDAOImpl;
import com.JAVA.DAO.DAOFactory;

@WebServlet("/register-benevole")
public class RegisterBenevoleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Initialize your DAO with a proper DAOFactory
        BenevoleDAOImpl benevoleDAO = new BenevoleDAOImpl(DAOFactory.getInstance());

        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String sexe = request.getParameter("sexe");
        String dateNaissanceString = request.getParameter("dateNaissance");
        String titreProfessionnel = request.getParameter("titreProfessionnel");
        String resume = request.getParameter("resume");

        // Basic input validation
        if (nom == null || prenom == null || titreProfessionnel == null || resume == null || nom.isEmpty() || prenom.isEmpty() || titreProfessionnel.isEmpty() || resume.isEmpty()
                ) {
            // Redirect to an error page or display an error message
            response.sendRedirect("error.jsp");
            return;
        }

        // Get the user object from the session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Create a Benevole object
        Benevole benevole = new Benevole();
        benevole.setIdUtilisateur(user.getIdUtilisateur());
        benevole.setNom(nom);
        benevole.setPrenom(prenom);
        benevole.setSexe(sexe);
        if (dateNaissanceString != null && !dateNaissanceString.isEmpty()) {
            LocalDate dateNaissance = LocalDate.parse(dateNaissanceString); // Ajustez le format de parsing de la date si nécessaire
            benevole.setDateNaissance(dateNaissance);
        }
        benevole.setTitreProfessionnel(titreProfessionnel);
        benevole.setResume(resume);

        // Call the DAO method to add the benevole
        int benevoleId = benevoleDAO.addBenevole(benevole);

        if (benevoleId > 0) {
            // Registration successful
        	// Set attributes to be accessed in the JSP
            request.setAttribute("userNom", benevole.getNom());
            request.setAttribute("userPrenom", benevole.getPrenom());
            request.setAttribute("userType", "Benevole");

            // Redirect to a success page
            RequestDispatcher dispatcher = request.getRequestDispatcher("benevole_home.jsp");
            dispatcher.forward(request, response);
        } else {
            // Registration failed
            // Redirect to an error page or display an error message
            response.sendRedirect("error.jsp");
        }
    }
}

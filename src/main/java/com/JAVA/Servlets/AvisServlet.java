package com.JAVA.Servlets;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import com.JAVA.Beans.AdminAssociation;
import com.JAVA.Beans.Avis;
import com.JAVA.Beans.Benevole;
import com.JAVA.Beans.Event;
import com.JAVA.Beans.User;
import com.JAVA.DAO.AdminAssociationDAO;
import com.JAVA.DAO.AvisDAO;
import com.JAVA.DAO.BenevoleDAO;
import com.JAVA.DAO.DAOFactory;
import com.JAVA.DAO.EventDAO;
import com.JAVA.DAO.UserDAO;

/**
 * Servlet implementation class AvisServlet
 * 
 */
@FunctionalInterface
interface UserNameGetter {
    String getUserName(User user);
}

@WebServlet("/AvisServlet")
public class AvisServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private AvisDAO avisDAO;
    private EventDAO eventDAO;
    private UserDAO userDAO;
    private AdminAssociationDAO adminAssociationDAO;
    private BenevoleDAO benevoleDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        avisDAO = DAOFactory.getInstance().getAvisDAO();
        eventDAO = DAOFactory.getInstance().getEventDAO();
        userDAO = DAOFactory.getInstance().getUserDAO();
        adminAssociationDAO = DAOFactory.getInstance().getAdminAssociationDAO();
        benevoleDAO = DAOFactory.getInstance().getBenevoleDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	try {
    		int eventId = Integer.parseInt(request.getParameter("eventId"));

            // Récupérer les détails de l'événement et les avis
            Event event = eventDAO.getEventById(eventId);
            List<Avis> avisList = avisDAO.getAvisByEvent(eventId);

            // Définir les attributs pour JSP
            request.setAttribute("event", event);
            request.setAttribute("avisList", avisList);
            // Créer une instance de l'interface fonctionnelle
            UserNameGetter userNameGetter = this::getUserName;

            // Ajouter la méthode getUserName à la requête pour y accéder depuis la JSP
            request.setAttribute("getUserName", userNameGetter);


            // Transférer vers la JSP des détails de l'événement
            request.getRequestDispatcher("Event/eventDetails.jsp").forward(request, response);

        } catch (SQLException e) {
            // Gérer l'exception ici
            e.printStackTrace(); // Ou utilisez un autre moyen pour gérer l'erreur
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "addAvis":
                addAvis(request, response);
                break;
            // Ajoutez des conditions pour d'autres actions si nécessaire
            default:
                // Redirige vers la page des avis par défaut en cas d'action non reconnue
            	try {
            		 int eventId = Integer.parseInt(request.getParameter("eventId"));
                     showEventDetailsPage(request, response, eventId);
                } catch (SQLException e) {
                    // Gérer l'exception ici
                    e.printStackTrace(); // Ou utilisez un autre moyen pour gérer l'erreur
                }
                break;
        }
    }

    private void showEventDetailsPage(HttpServletRequest request, HttpServletResponse response, int eventId)
            throws ServletException, IOException, SQLException {
        // Récupérer les détails de l'événement et les avis
        Event event = eventDAO.getEventById(eventId);
        List<Avis> avisList = avisDAO.getAvisByEvent(eventId);

        // Définir les attributs pour JSP
        request.setAttribute("event", event);
        request.setAttribute("avisList", avisList);

        // Transférer vers la JSP des détails de l'événement
        request.getRequestDispatcher("Event/eventDetails.jsp").forward(request, response);
    }

    private void addAvis(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        String commentaire = request.getParameter("commentaire");
        Event event = eventDAO.getEventById(eventId);
        

        // Create a new Avis object
        Avis avis = new Avis();
        avis.setEvent(event);
        avis.setCommentaire(commentaire);
        avis.setReactionId(Integer.parseInt(request.getParameter("reactionId")));

        // Set the timestamp
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        avis.setTimestamp(timestamp);
        
        // Retrieve user from the session
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            avis.setUser(user);
        }

        // Add the avis to the database
        try {
			avisDAO.ajouterAvis(avis);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        // Redirect back to the avis page
        response.sendRedirect("AvisServlet?eventId=" + eventId);
    }
    
    
    private AdminAssociation getAdminAssociationById(int adminId) {
        return adminAssociationDAO.getAdminAssociationById(adminId);
    }

    private Benevole getBenevoleById(int benevoleId) {
        return benevoleDAO.getBenevoleById(benevoleId);
    }

    private String getUserName(User user) {
        if (user != null) {
            if (user.getRole().equals(User.UserRole.adminassociation)) {
                AdminAssociation admin = getAdminAssociationById(user.getIdUtilisateur());
                return admin != null ? admin.getNom() : "";
            } else if (user.getRole().equals(User.UserRole.benevole)) {
                Benevole benevole = getBenevoleById(user.getIdUtilisateur());
                return benevole != null ? benevole.getNom() + " " + benevole.getPrenom() : "";
            }
        }
        return "";
    }

}

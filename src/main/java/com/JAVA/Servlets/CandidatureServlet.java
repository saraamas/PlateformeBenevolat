package com.JAVA.Servlets;

import java.io.IOException;

import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.JAVA.Beans.AdminAssociation;
import com.JAVA.Beans.Benevole;
import com.JAVA.Beans.Candidature;
import com.JAVA.Beans.Event;
import com.JAVA.Beans.User;
import com.JAVA.DAO.AdminAssociationDAO;
import com.JAVA.DAO.BenevoleDAO;
import com.JAVA.DAO.CandidatureDAO;
import com.JAVA.DAO.CandidatureDAOImpl;
import com.JAVA.DAO.DAOFactory;
import com.JAVA.DAO.EventDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class CandidatureServlet
 */
@WebServlet("/candidatureServlet")
public class CandidatureServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CandidatureDAO candidatureDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize your CandidatureDAO here (you may use a DAOFactory or another method)
        candidatureDAO = DAOFactory.getInstance().getCandidatureDAO();
        // Création de la liste des notifications si elle n'existe pas encore
        List<String> notifications = new ArrayList<>();
           }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "create":
                showCandidatureForm(request, response);
                break;
            case "view":
                viewCandidatures(request, response);
                break;
            case "traiter":
                traiterCandidature(request, response);
                break;
            case "viewNotifications":
                viewNotifications(request, response);
                break;
            default:
                // Handle other actions if needed
                response.sendRedirect(request.getContextPath() + "/error.jsp");
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "traiter":
                    traiterCandidature(request, response);
                    break;
                case "deposer":
                    deposerCandidature(request, response);
                    break;
                case "view":
                    viewCandidatures(request, response);
                    break;
            }
        }
    }

    private void viewNotifications(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérez les notifications depuis la session ou la portée de requête
        List<String> notifications = (List<String>) request.getSession().getAttribute("notifications");

        // Vous pouvez également transmettre les notifications à la page d'accueil s'il y a lieu
        request.setAttribute("notifications", notifications);

        // Rediriger vers la page d'accueil
        request.getRequestDispatcher("/Candidature/notifications.jsp").forward(request, response);
    }

    // Ajouter cette méthode à votre servlet
    private void sendNotificationToBenevole(Benevole benevole, String notificationMessage, PrintWriter out) {
        // Construire le message de notification
        String notification = "Notification pour vous, cher(e) " + benevole.getNom() + ": " + notificationMessage;

        // Écrire la notification dans la réponse
        out.println("<html><body>");
        out.println("<h1>Notification</h1>");
        out.println("<p>" + notification + "</p>");
        out.println("</body></html>");

        // Vous pouvez également enregistrer la notification dans la base de données ou un autre système de stockage pour suivre l'historique des notifications
    }

    private void traiterCandidature(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int candidatureId = Integer.parseInt(request.getParameter("candidatureId"));
            String decision = request.getParameter("decision");

            Candidature candidature = candidatureDAO.getCandidatureById(candidatureId);

            if (candidature != null) {
                // Traiter la candidature
                ((CandidatureDAOImpl) candidatureDAO).traiterCandidature(candidature, decision);

                // Ajouter la notification avec la date à la session de l'utilisateur
                addNotificationToSession("Candidature #" + candidatureId + " " + decision, request);

                // Si la décision est "accepte", notifier le bénévole
                if ("accepte".equals(decision)) {
                    // Récupérer le bénévole associé à la candidature
                    Benevole benevole = candidature.getBenevole();
                    // Récupérer le writer de réponse
                    PrintWriter out = response.getWriter();

                    // Notifier le bénévole
                    sendNotificationToBenevole(benevole, "Votre candidature a été acceptée pour l'événement #" + candidature.getEvent().getIdEvent(), out);
                }

                // Rediriger vers la vue des candidatures
                request.getRequestDispatcher("/candidatureServlet?action=view").forward(request, response);
            } else {
                // Gérer le cas où la candidature n'est pas trouvée
                response.sendRedirect(request.getContextPath() + "/error.jsp");
            }
        } catch (Exception e) {
            System.out.println("Error in traiterCandidature method: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }


    // Ajouter la notification à la session de l'utilisateur
    private void addNotificationToSession(String notification, HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<String> notifications = (List<String>) session.getAttribute("notifications");
        if (notifications == null) {
            notifications = new ArrayList<>();
            session.setAttribute("notifications", notifications);
        }
        notifications.add(notification);
    }

    // Accéder aux notifications depuis la session de l'utilisateur
    private List<String> getNotificationsFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<String> notifications = (List<String>) session.getAttribute("notifications");
        return notifications != null ? notifications : new ArrayList<>();
    }

    private void showCandidatureForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve user, benevoleId, and eventId from the request
            User user = (User) request.getSession().getAttribute("user");
            HttpSession session = request.getSession();
            int benevoleId = Integer.parseInt(request.getParameter("benevoleId"));
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            session.setAttribute("benevoleId", benevoleId);
            session.setAttribute("eventId", eventId);
            // Retrieve the Benevole, Event, and Adminassociation using getById methods
            BenevoleDAO benevoleDAO = DAOFactory.getInstance().getBenevoleDAO();
            EventDAO eventDAO = DAOFactory.getInstance().getEventDAO();

            Benevole benevole = benevoleDAO.getBenevoleById(benevoleId);
            Event event = eventDAO.getEventById(eventId);

            // Retrieve Adminassociation using the ID from the Event
            AdminAssociation adminassociation = event.getAdminAssociation();

            // Set retrieved objects in the session for later use in the JSP
            // Set benevoleId and eventId in the request attributes
            request.setAttribute("benevoleId", benevoleId);
            request.setAttribute("eventId", eventId);
            setSessionAttributes(request.getSession(), user, benevole, event, adminassociation);

            // Forward to the candidature form JSP
            request.getRequestDispatcher("/Candidature/candidatureForm.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // Handle the case where benevoleId or eventId is not a valid integer
            e.printStackTrace();  // Log the exception or handle it accordingly
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Handle other exceptions appropriately
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    private void setSessionAttributes(HttpSession session, User user, Benevole benevole, Event event, AdminAssociation adminassociation) {
        session.setAttribute("benevoleName", benevole.getNom());
        session.setAttribute("benevolePrenom", benevole.getPrenom());
        session.setAttribute("eventName", event.getTitre());
        session.setAttribute("adminassociationName", adminassociation.getNom());
        session.setAttribute("user", user);

    }

    private void deposerCandidature(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve form data
            String lettreMotivation = request.getParameter("lettreMotivation");
            // Retrieve other form fields as needed
            System.out.println("Lettre de Motivation: " + lettreMotivation);

            // Retrieve the Benevole, Event, and Adminassociation using getById methods
            HttpSession session = request.getSession();
            int benevoleId = (int) session.getAttribute("benevoleId");
            int eventId = (int) session.getAttribute("eventId");

            BenevoleDAO benevoleDAO = DAOFactory.getInstance().getBenevoleDAO();
            EventDAO eventDAO = DAOFactory.getInstance().getEventDAO();

            Benevole benevole = benevoleDAO.getBenevoleById(benevoleId);
            Event event = eventDAO.getEventById(eventId);

            // Create a new Candidature object
            Candidature newCandidature = new Candidature();

            // Debugging: Print values to console
            System.out.println("lettreMotivation: " + lettreMotivation);
            System.out.println("event: " + event);
            System.out.println("benevole: " + benevole);

            // Set the Lettre, Event, Benevole for the new candidature
            newCandidature.setLettreMotivation(lettreMotivation);
            newCandidature.setEvent(event);
            newCandidature.setBenevole(benevole);

            // Debugging: Print the new candidature details
            System.out.println("New Candidature details: " + newCandidature);

            // Use CandidatureDAO to save the new candidature
            candidatureDAO.addCandidature(newCandidature);

            System.out.println("Candidature added successfully");

            // Redirect to the candidature list page or another appropriate page
            request.getRequestDispatcher("/candidatureServlet?action=view").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions appropriately
            System.out.println("Error in deposerCandidature method: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    private void viewCandidatures(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve user from the session
            User user = (User) request.getSession().getAttribute("user");

            // Retrieve all candidatures based on user type
            List<Candidature> candidatureList = new ArrayList<>();

            if (user != null) {
                if (user.getRole() == User.UserRole.adminassociation) {
                    candidatureList = candidatureDAO.getAllCandidaturesForAdminAssociation(user.getIdUtilisateur());
                    // Set other attributes specific to adminAssociation, if needed
                } else if (user.getRole() == User.UserRole.benevole) {
                    candidatureList = candidatureDAO.getAllCandidaturesForBenevole(user.getIdUtilisateur());
                    // Set other attributes specific to benevole, if needed
                }
            }

            // Set the candidatureList attribute in the request
            request.setAttribute("candidatureList", candidatureList);
            // Forward to the appropriate JSP based on user type
            String jspPath = "/Candidature/candidatureList-" + user.getRole().toString() + ".jsp";
            request.getRequestDispatcher(jspPath).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions appropriately
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }

    // Add other methods for different actions if needed

}

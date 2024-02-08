package com.JAVA.Servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.JAVA.Beans.AdminAssociation;
import com.JAVA.Beans.Benevole;
import com.JAVA.Beans.Candidature;
import com.JAVA.Beans.Event;
import com.JAVA.DAO.AdminAssociationDAO;
import com.JAVA.DAO.BenevoleDAO;
import com.JAVA.DAO.CandidatureDAO;
import com.JAVA.DAO.DAOFactory;
import com.JAVA.DAO.EventDAO;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private AdminAssociationDAO adminAssociationDAO;
    private CandidatureDAO candidatureDAO;
    private EventDAO eventDAO;
    @Override
    public void init() throws ServletException {
        super.init();
        DAOFactory daoFactory = DAOFactory.getInstance();
        adminAssociationDAO = daoFactory.getAdminAssociationDAO();
        candidatureDAO = daoFactory.getCandidatureDAO();
        eventDAO = daoFactory.getEventDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	// Récupération de la session
        HttpSession session = request.getSession();
        // Récupération de l'association d'administrateurs depuis la session
        AdminAssociation adminAssociation = (AdminAssociation) session.getAttribute("adminAssociation");

        // Vérification si l'association d'administrateurs est connectée
        if (adminAssociation == null) {
            // Redirection vers la page de connexion si elle n'est pas connectée
            response.sendRedirect("login.jsp");
            return;
        }

        // Récupération de la liste des bénévoles associés à l'association
        List<Benevole> benevoles = adminAssociation.getAdherents();
        System.out.println("Benevoles: " + benevoles);

        if (benevoles != null) {
            request.setAttribute("benevolesCount", benevoles.size());
            System.out.println("BenevolesCount: " + benevoles.size());
        } else {
            // Gérer le cas où la liste de bénévoles est nulle
            // Par exemple, définir la taille à zéro ou afficher un message d'erreur
            request.setAttribute("benevolesCount", 0);
            System.out.println("La liste de bénévoles est nulle.");
        }

        //1- Récupération de la liste des candidatures en attente pour l'association d'administrateurs
        List<Candidature> candidaturesEnAttente = candidatureDAO.getAllCandidaturesForAdminAssociation(adminAssociation.getIdUtilisateur());
        int candidaturesEnAttenteCount = getCandidaturesEnAttenteCount(candidaturesEnAttente);
        request.setAttribute("candidaturesEnAttenteCount", candidaturesEnAttenteCount);

        // 2-Calcul du nombre de bénévoles de chaque sexe
        int maleCount = getBenevolesCountBySexe(benevoles, "Homme");
        int femaleCount = getBenevolesCountBySexe(benevoles, "Femme");
        // Stockage des nombres de bénévoles de chaque sexe dans les attributs de la requête
        request.setAttribute("maleCount", maleCount);
        request.setAttribute("femaleCount", femaleCount);

        // Récupération de la liste des événements associés à l'association d'administrateurs
        List<Event> events = eventDAO. getAllEventsForAdmin(adminAssociation.getIdUtilisateur());
        // Compter le nombre d'événements
        int numberOfEvents = events.size();
        request.setAttribute("numberOfEvents", numberOfEvents);

        
        
     // 2- Chart pour event par nbr benevoles
     // Création d'une liste pour stocker les données des événements et le nombre de candidatures acceptées pour chaque événement
     List<Map<String, Object>> eventsData = new ArrayList<>();
     for (Event event : events) {
         int candidaturesAccepteesCount = candidatureDAO.getCandidaturesAccepteesCountForEvent(event.getIdEvent());
         // Création d'une map pour stocker l'ID de l'événement et le nombre de candidatures acceptées
         Map<String, Object> eventData = new HashMap<>();
         eventData.put("eventTitle", event.getTitre());
         eventData.put("candidaturesAccepteesCount", candidaturesAccepteesCount);
         // Ajout des données de l'événement à la liste
         eventsData.add(eventData);
     }

     // Création d'une chaîne JSON pour stocker les données des événements
     StringBuilder eventsDataJson = new StringBuilder("[");
     for (int i = 0; i < eventsData.size(); i++) {
         Map<String, Object> eventMap = eventsData.get(i);
         eventsDataJson.append("{\"eventTitle\":\"")
                       .append(eventMap.get("eventTitle"))
                       .append("\",\"candidaturesAccepteesCount\":")
                       .append(eventMap.get("candidaturesAccepteesCount"))
                       .append("}");

         // Ajout d'une virgule pour séparer les objets JSON, sauf pour le dernier
         if (i < eventsData.size() - 1) {
             eventsDataJson.append(",");
         }
     }
     eventsDataJson.append("]");

     // Stockage de la chaîne JSON dans les attributs de la requête
     request.setAttribute("eventsDataJson", eventsDataJson.toString());
     
     
     // 3- Chart Event par categorie
     // Création d'une carte pour stocker le nombre d'événements par catégorie
     Map<String, Integer> eventsByCategory = new HashMap<>();

  // Parcours des événements pour compter les événements par catégorie
  for (Event event : events) {
      String category = event.getCategorie();
      eventsByCategory.put(category, eventsByCategory.getOrDefault(category, 0) + 1);
  }

  // Convertir les données de la carte en listes pour le graphique
  List<String> categoriesWithQuotes = new ArrayList<>();
  List<Integer> eventCounts = new ArrayList<>();

  // Ajouter les catégories avec des quotes ('') à la liste des catégories
  for (String category : eventsByCategory.keySet()) {
      categoriesWithQuotes.add("'" + category + "'");
      eventCounts.add(eventsByCategory.get(category));
  }

  // Stocker les données dans les attributs de la requête
  request.setAttribute("categories", categoriesWithQuotes);
  request.setAttribute("eventCounts", eventCounts);


     // Redirection vers la page dashboard.jsp pour afficher les données
     RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
     dispatcher.forward(request, response);


    }

    private int getCandidaturesEnAttenteCount(List<Candidature> candidatures) {
        // Filtrage des candidatures en attente
        long candidaturesEnAttenteCount = candidatures.stream()
                .filter(candidature -> "en attente".equals(candidature.getStatut()))
                .count();
        
        return (int) candidaturesEnAttenteCount;
    }


    private int getBenevolesCountBySexe(List<Benevole> benevoles, String sexe) {
        int count = 0;
        for (Benevole benevole : benevoles) {
            if (sexe.equals(benevole.getSexe())) {
                count++;
            }
        }
        return count;
    }

    private List<Event> getAllEvents() {
        return null; // Placeholder
    }

    private int getBenevolesCountByEvent(int eventId) {
        return 0; // Placeholder
    }
}

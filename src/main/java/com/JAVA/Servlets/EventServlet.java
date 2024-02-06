package com.JAVA.Servlets;

import com.JAVA.Beans.AdminAssociation;

import com.JAVA.Beans.Event;


import com.JAVA.Beans.User;
import com.JAVA.DAO.DAOException;
import com.JAVA.DAO.DAOFactory;
import com.JAVA.DAO.EventDAO;
import com.JAVA.DAO.AdminAssociationDAO;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Base64;
import java.util.List;

@WebServlet("/eventServlet")
@MultipartConfig
public class EventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EventDAO eventDAO;
    private AdminAssociationDAO adminAssociationDAO;
    @Override
    public void init() throws ServletException {
        super.init();
        eventDAO = DAOFactory.getInstance().getEventDAO();
        adminAssociationDAO =DAOFactory.getInstance().getAdminAssociationDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "view"; // Action par défaut
        }

        switch (action) {
        case "view":
            try {
                viewEvents(request, response, user);
            } catch (ServletException | IOException | SQLException e) {
                e.printStackTrace();
            }
            break;
        case "create":
            showCreateForm(request, response);
            break;
        case "update":
            // Affichez le formulaire de mise à jour avec les détails de l'événement à mettre à jour
            showUpdateForm(request, response);
            break;
        case "details":
            try {
				showEventDetails(request, response, user);
			} catch (ServletException | IOException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            break;

        case "search":
            searchByCategory(request, response);
            break;
        default:
            try {
                viewEvents(request, response, user);
            } catch (ServletException | IOException | SQLException e) {
                e.printStackTrace();
            }
    }

    }

    private void searchByCategory(HttpServletRequest request, HttpServletResponse response)

            throws ServletException, IOException {
        // Get the category parameter from the request
        String category = request.getParameter("searchCategory");
        System.out.println("Category: " + category);

        // Check if the category is provided and not empty
        if (category != null && !category.isEmpty()) {
            try {
                // Call the DAO method to get events by category
                List<Event> eventsByCategory = eventDAO.getEventsByCategory(category);

                // Convert images to Base64
                for (Event event : eventsByCategory) {
                    byte[] pictureData = event.getPicture();
                    if (pictureData != null) {
                        String pictureBase64 = Base64.getEncoder().encodeToString(pictureData);
                        event.setPictureBase64(pictureBase64);
                    } else {
                        event.setPictureBase64("");
                    }
                }

                // Set the results in the request attribute
                request.setAttribute("eventsByCategory", eventsByCategory);
            } catch (DAOException | SQLException e) {
                e.printStackTrace(); // Handle the exception or log it
            }
        }

        // Forward to the search results JSP
        request.getRequestDispatcher("Event/searchResult.jsp").forward(request, response);
    }

    

	private void showEventDetails(HttpServletRequest request, HttpServletResponse response, User user)

            throws ServletException, IOException, SQLException {
        // Récupérer l'identifiant de l'événement depuis les paramètres de la requête
        String eventIdToShow = request.getParameter("idEvent");

        if (eventIdToShow != null && !eventIdToShow.isEmpty()) {
            try {
                // Convertir l'identifiant de l'événement en entier
                int idEvent = Integer.parseInt(eventIdToShow);

                // Récupérer l'événement à partir de la base de données
                Event eventDetails = eventDAO.getEventById(idEvent);

                if (eventDetails != null) {
                    // Convertir l'image en Base64 si elle existe
                    byte[] pictureData = eventDetails.getPicture();
                    if (pictureData != null) {
                        String pictureBase64 = Base64.getEncoder().encodeToString(pictureData);
                        eventDetails.setPictureBase64(pictureBase64);
                    } else {
                        eventDetails.setPictureBase64("");
                    }

                    // Mettre l'événement détaillé dans les attributs de la requête
                    request.setAttribute("eventDetails", eventDetails);

                    // Rediriger vers la page qui affiche les détails de l'événement
                    request.getRequestDispatcher("Event/eventDetails.jsp").forward(request, response);
                } else {
                    // Gérer le cas où l'événement n'a pas été trouvé dans la base de données
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Les détails de l'événement n'ont pas été trouvés.");
                }
            } catch (NumberFormatException | DAOException e) {
                // Gérer les exceptions liées à la conversion ou à l'accès à la base de données
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Une erreur s'est produite lors de la récupération des détails de l'événement.");
            }
        } else {
            // Gérer le cas où l'identifiant de l'événement n'est pas fourni
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "L'identifiant de l'événement pour les détails n'a pas été fourni.");
        }
    }

	private void showUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String eventIdToUpdate = request.getParameter("idEvent");
	    if (eventIdToUpdate != null && !eventIdToUpdate.isEmpty()) {
	        try {
	            int idEvent = Integer.parseInt(eventIdToUpdate);
	            Event eventToUpdate = eventDAO.getEventById(idEvent);

	            if (eventToUpdate != null) {
	                // Set event details in the request attribute
	                request.setAttribute("event", eventToUpdate);

	                // Forward to the update form JSP
	                request.getRequestDispatcher("Event/updateEvent.jsp").forward(request, response);
	            } else {
	                // Handle the case where the event is not found
	                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Event not found.");
	            }
	        } catch (NumberFormatException | DAOException e) {
	            // Handle exceptions
	            e.printStackTrace();
	            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred.");
	        }
	    } else {
	        // Handle the case where the event ID is not provided
	        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Event ID not provided.");
	    }
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        System.out.println("Action received: " + action); // Add this line for debugging

        switch (action) {
        case "create":
            try {
                createEvent(request, response, user);
            } catch (ServletException | IOException | SQLException e) {
                e.printStackTrace();
            }
            break;
        case "update":
            try {
				updateEvent(request, response);
			} catch (ServletException | IOException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            break;
        case "delete":
            try {
                deleteEvent(request, response);
            } catch (ServletException | IOException e) {
                e.printStackTrace();
            }
            break;
        // Ajoutez d'autres conditions pour d'autres actions si nécessaire
    }
 
    }

	private void updateEvent(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException, SQLException {
	    try {
	        String eventIdToUpdate = request.getParameter("idEvent");

	        if (eventIdToUpdate == null || eventIdToUpdate.isEmpty()) {
	            
	            return;
	        }

	        int idEvent = Integer.parseInt(eventIdToUpdate);
	        Event eventToUpdate = eventDAO.getEventById(idEvent);

	        if (eventToUpdate == null) {
	            
	            return;
	        }

	        String title = request.getParameter("titre");
	        String description = request.getParameter("description");
	        Part picturePart = request.getPart("picture");
	        String category = request.getParameter("categorie");
	        String dateStart = request.getParameter("dateDebut");
	        String dateEnd = request.getParameter("dateFin");
	        String location = request.getParameter("lieu");

	        eventToUpdate.setTitre(title);
	        eventToUpdate.setDescription(description);
	        eventToUpdate.setCategorie(category);
	        eventToUpdate.setDateDebut(dateStart);
	        eventToUpdate.setDateFin(dateEnd);
	        eventToUpdate.setLieu(location);

	        if (picturePart != null && picturePart.getSize() > 0) {
	            // Check if the picture size is within the allowed limit (adjust the limit accordingly)
	            int maxSizeInBytes = 1024 * 1024 ; // 1MB, adjust as needed
	            if (picturePart.getSize() > maxSizeInBytes) {
	                // Handle the case where the picture size is too large
	                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Picture size is too large. Maximum allowed size: " + maxSizeInBytes + " bytes.");
	                return;
	            }

	            byte[] pictureBytes = new byte[(int) picturePart.getSize()];
	            picturePart.getInputStream().read(pictureBytes);
	            eventToUpdate.setPicture(pictureBytes);
	        }

	        eventDAO.updateEvent(eventToUpdate);

	        response.sendRedirect(request.getContextPath() + "/eventServlet?action=view");
	    } catch (NumberFormatException | DAOException e) {
	        handleException(response, "Une erreur s'est produite lors de la mise à jour de l'événement.", e);
	    } catch (IOException | ServletException e) {
	        handleException(response, "Une erreur s'est produite lors du traitement de la requête.", e);
	    } catch (Exception e) {
	        handleException(response, "Une erreur inattendue s'est produite.", e);
	    }
	}


	private void handleException(HttpServletResponse response, String errorMessage, Exception e)
	        throws ServletException, IOException {
	    e.printStackTrace();
	    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, errorMessage);
	}


	private void createEvent(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        String title = request.getParameter("titre");
        String description = request.getParameter("description");
        Part picturePart = request.getPart("picture");
        String category = request.getParameter("categorie");
        String dateStart = request.getParameter("dateDebut");
        String dateEnd = request.getParameter("dateFin");
        String location = request.getParameter("lieu");
        
        AdminAssociation createur=adminAssociationDAO.getAdminAssociationById(user.getIdUtilisateur());
        Event newEvent = new Event();
        newEvent.setTitre(title);
        newEvent.setDescription(description);
        newEvent.setCategorie(category);
        newEvent.setDateDebut(dateStart);
        newEvent.setDateFin(dateEnd);
        newEvent.setLieu(location);
        newEvent.setAdminAssociation(createur);

        if (picturePart != null && picturePart.getSize() > 0) {
            // Check if the picture size is within the allowed limit (adjust the limit accordingly)
            int maxSizeInBytes = 1024 * 1024; // 1MB, adjust as needed
            if (picturePart.getSize() > maxSizeInBytes) {
                // Handle the case where the picture size is too large
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Picture size is too large. Maximum allowed size: " + maxSizeInBytes + " bytes.");
                return;
            }

            try (InputStream inputStream = picturePart.getInputStream()) {
                // Convert InputStream to byte array
                byte[] pictureBytes = inputStream.readAllBytes();
                System.out.println("Picture size: " + pictureBytes.length);

                // Convert picture to Base64
                String pictureBase64 = Base64.getEncoder().encodeToString(pictureBytes);
                newEvent.setPictureBase64(pictureBase64);

                // Set the raw byte array as well
                newEvent.setPicture(pictureBytes);
            } catch (IOException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the picture.");
                return;
            }
        }

        try {
            eventDAO.createEvent(newEvent);
        } catch (DAOException e) {
            e.printStackTrace();
            // Gérez l'exception ou enregistrez-la
        }

        response.sendRedirect(request.getContextPath() + "/eventServlet?action=view");
    }

    private void viewEvents(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException, SQLException {
        try {
            List<Event> allEvents = eventDAO.getAllEvents();

            // Convert images to Base64
            for (Event event : allEvents) {
                byte[] pictureData = event.getPicture();
                // Dans votre servlet, avant de transférer à la JSP
                System.out.println("AdminAssociation nom: " + event.getAdminAssociation().getNom());

                if (pictureData != null) {
                    String pictureBase64 = Base64.getEncoder().encodeToString(pictureData);
                    event.setPictureBase64(pictureBase64);
                } else {
                    event.setPictureBase64("");
                }
            }

            request.setAttribute("allEvents", allEvents);
        } catch (DAOException e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("Event/events.jsp").forward(request, response);
    }


    

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Opérations supplémentaires avant de transférer au formulaire de création
        request.getRequestDispatcher("Event/createEvent.jsp").forward(request, response);
    }
    

    private void deleteEvent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventIdToDelete = request.getParameter("idEvent");
        if (eventIdToDelete != null && !eventIdToDelete.isEmpty()) {
            try {
                int idEvent = Integer.parseInt(eventIdToDelete);
                eventDAO.deleteEvent(idEvent);
            } catch (NumberFormatException | SQLException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/eventServlet?action=view");
    }


}

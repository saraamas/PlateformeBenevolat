package com.JAVA.DAO;

import com.JAVA.Beans.AdminAssociation;
import com.JAVA.Beans.Event;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class EventDAOImpl implements EventDAO {

    private DAOFactory daoFactory;
    private AdminAssociationDAO adminAssociationDAO;  // Add this line


    // Constructor
    public EventDAOImpl(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
        this.adminAssociationDAO = daoFactory.getAdminAssociationDAO();  // Initialize it in the constructor

    }

    @Override
    public void createEvent(Event event) throws SQLException {
        // Vérifier l'existence de l'utilisateur avant d'insérer l'événement
        if (!userExists(event.getAdminAssociation().getIdUtilisateur())) {
            throw new SQLException("Creating event failed. User with ID " + event.getAdminAssociation().getIdUtilisateur() + " does not exist.");
        }

        final String SQL_INSERT = "INSERT INTO event (titre, description, categorie, dateDebut, dateFin, lieu, createurId, picture) " +
                                   "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection connection = daoFactory.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS)
        ) {
            preparedStatement.setString(1, event.getTitre());
            preparedStatement.setString(2, event.getDescription());
            preparedStatement.setString(3, event.getCategorie());
            preparedStatement.setString(4, event.getDateDebut());
            preparedStatement.setString(5, event.getDateFin());
            preparedStatement.setString(6, event.getLieu());
            preparedStatement.setInt(7, event.getAdminAssociation().getIdUtilisateur());  // Utiliser event.getUser().getIdUtilisateur() pour obtenir l'ID
            preparedStatement.setBytes(8, event.getPicture());

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating event failed, no rows affected.");
            }

            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    event.setIdEvent(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating event failed, no ID obtained.");
                }
            }

            // Ajoutez des logs de débogage pour suivre l'exécution
            System.out.println("Event created successfully with ID: " + event.getIdEvent());


        } catch (SQLException e) {
        	e.printStackTrace();
            throw e;  // Propager l'exception après le rollback
        }
    }



    // Méthode privée pour valider l'existence de l'utilisateur
    private boolean userExists(int userId) throws SQLException {
        final String SQL_SELECT_USER = "SELECT idUtilisateur FROM adminassociation WHERE idUtilisateur = ?";

        try (
                Connection connection = daoFactory.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SQL_SELECT_USER)
        ) {
            preparedStatement.setInt(1, userId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                return resultSet.next(); // Si le resultSet a au moins une ligne, l'utilisateur existe
            }
        }
    }

    @Override
    public void updateEvent(Event event) throws SQLException {
        final String SQL_UPDATE = "UPDATE event SET titre=?, description=?, categorie=?, dateDebut=?, dateFin=?, lieu=?, picture=? " +
                                   "WHERE idEvent=?";

        try (
                Connection connection = daoFactory.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SQL_UPDATE)
        ) {
            preparedStatement.setString(1, event.getTitre());
            preparedStatement.setString(2, event.getDescription());
            preparedStatement.setString(3, event.getCategorie());
            preparedStatement.setString(4, event.getDateDebut());
            preparedStatement.setString(5, event.getDateFin());
            preparedStatement.setString(6, event.getLieu());
            preparedStatement.setBytes(7, event.getPicture());
            preparedStatement.setInt(8, event.getIdEvent());

            preparedStatement.executeUpdate();
        }
    }

    @Override
    public void deleteEvent(int idEvent) throws SQLException {
        final String SQL_DELETE = "DELETE FROM event WHERE idEvent=?";

        try (
                Connection connection = daoFactory.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SQL_DELETE)
        ) {
            preparedStatement.setInt(1, idEvent);
            preparedStatement.executeUpdate();
        }
    }

    @Override
    public List<Event> getAllEvents() throws DAOException {
    	List<Event> eventsList = new ArrayList<>();
        final String SQL_SELECT_ALL = "SELECT * FROM event";

        try (
            Connection connection = daoFactory.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SQL_SELECT_ALL);
            ResultSet resultSet = preparedStatement.executeQuery()
        ) {
            while (resultSet.next()) {
                Event event = mapResultSetToEvent(resultSet);
                eventsList.add(event);
            }
        } catch (SQLException e) {
            // Log the exception for debugging
            e.printStackTrace();
            throw new DAOException(e);
        }

        // Log the number of events retrieved for debugging
        System.out.println("Number of events retrieved: " + eventsList.size());

        return eventsList;
    }


    @Override
    public List<Event> getEventsByCategory(String category) throws SQLException {
        List<Event> events = new ArrayList<>();
        final String SQL_SELECT_BY_CATEGORY = "SELECT * FROM event WHERE categorie=?";

        try (
                Connection connection = daoFactory.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SQL_SELECT_BY_CATEGORY)
        ) {
            preparedStatement.setString(1, category);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Event event = mapResultSetToEvent(resultSet);
                    events.add(event);
                }
            }
        }

        return events;
    }

    private Event mapResultSetToEvent(ResultSet resultSet) throws SQLException {
        Event event = new Event();
        event.setIdEvent(resultSet.getInt("idEvent"));
        event.setTitre(resultSet.getString("titre"));
        event.setDescription(resultSet.getString("description"));
        event.setCategorie(resultSet.getString("categorie"));
        event.setDateDebut(resultSet.getString("dateDebut"));
        event.setDateFin(resultSet.getString("dateFin"));
        event.setLieu(resultSet.getString("lieu"));

        // Récupération de l'ID utilisateur
        int createurId = resultSet.getInt("createurId");

        // Appel à la méthode pour récupérer l'objet AdminAssociation complet
        AdminAssociation createur = adminAssociationDAO.getAdminAssociationById(createurId);

        // Attribution de l'objet AdminAssociation à l'attribut adminAssociation
        event.setAdminAssociation(createur);


        event.setPicture(resultSet.getBytes("picture"));
        return event;
    }
    
    @Override
    public Event getEventById(int idEvent) throws DAOException {
        final String SQL_SELECT_BY_ID = "SELECT * FROM event WHERE idEvent = ?";
        Event event = null;

        try (Connection connection = daoFactory.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL_SELECT_BY_ID)) {

            preparedStatement.setInt(1, idEvent);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    event = mapResultSetToEvent(resultSet);
                }
            }

        } catch (SQLException e) {
            throw new DAOException("Error while trying to get event by ID", e);
        }

        return event;
    }

    @Override
    public List<Event> getAllEventsForAdmin(int idCreateur) throws DAOException {
        List<Event> eventsList = new ArrayList<>();
        final String SQL_SELECT_BY_CREATOR = "SELECT * FROM event WHERE createurId = ?";

        try (
            Connection connection = daoFactory.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SQL_SELECT_BY_CREATOR)
        ) {
            preparedStatement.setInt(1, idCreateur);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Event event = mapResultSetToEvent(resultSet);
                    eventsList.add(event);
                }
            }
        } catch (SQLException e) {
            // Log the exception for debugging
            e.printStackTrace();
            throw new DAOException(e);
        }

        // Log the number of events retrieved for debugging
        System.out.println("Number of events retrieved for admin with ID " + idCreateur + ": " + eventsList.size());

        return eventsList;
    }


}

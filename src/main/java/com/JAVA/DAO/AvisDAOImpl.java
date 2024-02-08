package com.JAVA.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.JAVA.Beans.Avis;
import com.JAVA.Beans.Event;
import com.JAVA.Beans.User;

public class AvisDAOImpl implements AvisDAO {
	
    private DAOFactory daoFactory;
    private UserDAO userDAO;
    private EventDAO eventDAO;
    
    
    // Constructor

	public AvisDAOImpl(DAOFactory daoFactory) {
		this.daoFactory = daoFactory;
		this.userDAO = daoFactory.getUserDAO();
		this.eventDAO = daoFactory.getEventDAO();
	}

	// Méthode pour mapper un ResultSet à un objet Avis
    private Avis mapResultSetToAvis(ResultSet resultSet) throws SQLException {
        Avis avis = new Avis();
        avis.setIdAvis(resultSet.getInt("idAvis"));
        avis.setCommentaire(resultSet.getString("commentaire"));
        avis.setReactionId(resultSet.getInt("reactionId"));
        avis.setTimestamp(resultSet.getTimestamp("timestamp")); // Set timestamp

        // Utilisez votre DAO d'utilisateur pour obtenir l'utilisateur associé à l'avis
        User user = userDAO.getUserById(resultSet.getInt("userId"));
        avis.setUser(user);

        // Utilisez votre DAO d'événement pour obtenir l'événement associé à l'avis
        Event event = eventDAO.getEventById(resultSet.getInt("eventId"));
        avis.setEvent(event);

        return avis;
    }

	@Override
	public void ajouterAvis(Avis avis) throws SQLException {
		String SQL_INSERT = "INSERT INTO avis (commentaire, reactionId, userId, eventId, timestamp) VALUES (?, ?, ?, ?, ?)";
	    try (Connection connection = daoFactory.getConnection();
	            PreparedStatement statement = connection.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS)) {
	        statement.setString(1, avis.getCommentaire());
	        statement.setInt(2, avis.getReactionId());
	        statement.setInt(3, avis.getUser().getIdUtilisateur());
	        statement.setInt(4, avis.getEvent().getIdEvent());
	        statement.setTimestamp(5, avis.getTimestamp());

	        int affectedRows = statement.executeUpdate();

	        if (affectedRows == 0) {
	            throw new SQLException("Creating avis failed, no rows affected.");
	        }

	        try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
	            if (generatedKeys.next()) {
	                avis.setIdAvis(generatedKeys.getInt(1));
	            } else {
	                throw new SQLException("Creating avis failed, no ID obtained.");
	            }
	        }
	    }

	}

	@Override
	public List<Avis> getAvisByEvent(int eventId) throws SQLException {
		List<Avis> avisList = new ArrayList<>();
        String SQL_SELECT_BY_EVENT = "SELECT * FROM avis WHERE eventId = ?";
        try (Connection connection = daoFactory.getConnection();
                PreparedStatement statement = connection.prepareStatement(SQL_SELECT_BY_EVENT)) {
            statement.setInt(1, eventId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Avis avis = mapResultSetToAvis(resultSet);
                    avisList.add(avis);
                }
            }
        }
        return avisList;
    
	}
	
	 @Override
	    public void deleteAvis(int avisId) throws SQLException {
	        String SQL_DELETE = "DELETE FROM avis WHERE idAvis = ?";
	        try (Connection connection = daoFactory.getConnection();
	                PreparedStatement statement = connection.prepareStatement(SQL_DELETE)) {
	            statement.setInt(1, avisId);
	            statement.executeUpdate();
	        }
	    }

}

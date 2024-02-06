package com.JAVA.DAO;

import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.JAVA.Beans.Benevole;
import com.JAVA.Beans.Candidature;
import com.JAVA.Beans.Event;


public class CandidatureDAOImpl implements CandidatureDAO {
    private DAOFactory daoFactory;

	public CandidatureDAOImpl(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
	}
	
	// Helper method to convert a ResultSet row to a Candidature object
	private Candidature mapResultSetToCandidature(ResultSet resultSet) throws SQLException {
	    Candidature candidature = new Candidature();
	    candidature.setIdCandidature(resultSet.getInt("idCandidature"));
	    candidature.setLettreMotivation(resultSet.getString("lettreMotivation"));
	    candidature.setStatut(resultSet.getString("statut"));

	    // Retrieve Event
	    EventDAO eventDAO = new EventDAOImpl(daoFactory); // Adjust based on your actual implementation
	    Event event = eventDAO.getEventById(resultSet.getInt("event_id"));
	    candidature.setEvent(event);

	    // Retrieve Benevole
	    BenevoleDAO benevoleDAO = new BenevoleDAOImpl(daoFactory); // Adjust based on your actual implementation
	    Benevole benevole = benevoleDAO.getBenevoleById(resultSet.getInt("benevole_id"));
	    candidature.setBenevole(benevole);

	    return candidature;
	}
	
	public void traiterCandidature(Candidature candidature, String decision) {
        // Assume que decision peut être "accepte" ou "refuse"
        if ("accepte".equals(decision) || "refuse".equals(decision)) {
            candidature.changerStatut(decision);
            updateCandidature(candidature); // Méthode d'update dans le DAO
        } else {
            // Logique de gestion d'une décision non valide
            System.out.println("Décision non valide : " + decision);
        }
    }



	@Override
	public Candidature getCandidatureById(int idCandidature) {
		try (Connection connection = daoFactory.getConnection();
	             PreparedStatement statement = connection.prepareStatement("SELECT * FROM candidature WHERE idCandidature = ?")) {
	            statement.setInt(1, idCandidature);

	            try (ResultSet resultSet = statement.executeQuery()) {
	                if (resultSet.next()) {
	                    return mapResultSetToCandidature(resultSet);
	                }
	            }
	        } catch (SQLException e) {
	            // Handle exceptions appropriately
	            e.printStackTrace();
	        }
	        return null;
	}

	@Override
	public List<Candidature> getAllCandidatures() {
		List<Candidature> candidatures = new ArrayList<>();

        try (Connection connection = daoFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement("SELECT * FROM candidature");
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Candidature candidature = mapResultSetToCandidature(resultSet);
                candidatures.add(candidature);
            }
        } catch (SQLException e) {
            // Handle exceptions appropriately
            e.printStackTrace();
        }

        return candidatures;
	}

	@Override
    public List<Candidature> getAllCandidaturesForAdminAssociation(int adminAssociationId) {
        List<Candidature> candidatures = new ArrayList<>();

        try (Connection connection = daoFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT * FROM candidature WHERE event_id IN (SELECT idEvent FROM event WHERE createurId = ?)")) {
            statement.setInt(1, adminAssociationId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Candidature candidature = mapResultSetToCandidature(resultSet);
                    candidatures.add(candidature);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return candidatures;
    }

    @Override
    public List<Candidature> getAllCandidaturesForBenevole(int benevoleId) {
        List<Candidature> candidatures = new ArrayList<>();
        System.out.println("Benevole ID: " + benevoleId);
        try (Connection connection = daoFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT * FROM candidature WHERE benevole_id = ?")) {
            statement.setInt(1, benevoleId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Candidature candidature = mapResultSetToCandidature(resultSet);
                    candidatures.add(candidature);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return candidatures;
    }
	@Override
	public void addCandidature(Candidature candidature) {
		try (Connection connection = daoFactory.getConnection();
	             PreparedStatement statement = connection.prepareStatement(
	                     "INSERT INTO candidature (lettreMotivation, statut, event_id, benevole_id) VALUES (?, ?, ?, ?)")) {
	            statement.setString(1, candidature.getLettreMotivation());
	            statement.setString(2, candidature.getStatut());
	            statement.setInt(3, candidature.getEvent().getIdEvent());
	            statement.setInt(4, candidature.getBenevole().getIdUtilisateur());

	            statement.executeUpdate();
	        } catch (SQLException e) {
	            // Handle exceptions appropriately
	            e.printStackTrace();
	        }
	}

	@Override
	public void updateCandidature(Candidature candidature) {
		try (Connection connection = daoFactory.getConnection();
	             PreparedStatement statement = connection.prepareStatement(
	                     "UPDATE candidature SET lettreMotivation=?, statut=?, event_id=?, benevole_id=? WHERE idCandidature=?")) {
	            statement.setString(1, candidature.getLettreMotivation());
	            statement.setString(2, candidature.getStatut());
	            statement.setInt(3, candidature.getEvent().getIdEvent());
	            statement.setInt(4, candidature.getBenevole().getIdUtilisateur());
	            statement.setInt(5, candidature.getIdCandidature());

	            statement.executeUpdate();
	        } catch (SQLException e) {
	            // Handle exceptions appropriately
	            e.printStackTrace();
	        }
		
	}

	@Override
	public void deleteCandidature(int idCandidature) {
		try (Connection connection = daoFactory.getConnection();
	             PreparedStatement statement = connection.prepareStatement("DELETE FROM candidature WHERE idCandidature=?")) {
	            statement.setInt(1, idCandidature);

	            statement.executeUpdate();
	        } catch (SQLException e) {
	            // Handle exceptions appropriately
	            e.printStackTrace();
	        }
	}



}

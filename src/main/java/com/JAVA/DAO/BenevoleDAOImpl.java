package com.JAVA.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.JAVA.Beans.AdminAssociation;
import com.JAVA.Beans.Benevole;
import com.JAVA.Beans.User;
import com.JAVA.Beans.User.UserRole;

public class BenevoleDAOImpl extends UserDAOImpl implements BenevoleDAO {
	 // Constructeur prenant une fabrique DAO comme argument
    public BenevoleDAOImpl(DAOFactory daoFactory) {
        // Appel du constructeur de la classe parente avec le même paramètre
        super(daoFactory);
    }
    protected static Benevole mapBenevole(ResultSet resultSet) throws SQLException {
        Benevole benevole = new Benevole();
        
        benevole.setIdUtilisateur(resultSet.getInt("idUtilisateur"));
        benevole.setNom(resultSet.getString("nom"));
        benevole.setPrenom(resultSet.getString("prenom"));
        benevole.setTitreProfessionnel(resultSet.getString("titreProfessionnel"));
        benevole.setResume(resultSet.getString("resume"));
        benevole.setSexe(resultSet.getString("sexe"));
        // Mappage de la date de naissance
        Date dateNaissance = resultSet.getDate("dateNaissance");
        if (dateNaissance != null) {
            benevole.setDateNaissance(dateNaissance.toLocalDate());
        }

        // Charger les associations du bénévole en utilisant le DAO
        BenevoleDAOImpl benevoleDAO = new BenevoleDAOImpl(daoFactory);
        List<AdminAssociation> associations = benevoleDAO.loadAssociations(benevole.getIdUtilisateur());
        benevole.setAssociations(associations);
        return benevole;
    }

    @Override
    public List<AdminAssociation> loadAssociations(int benevoleId) {
    	 List<AdminAssociation> associations = new ArrayList<>();

         final String SQL_SELECT_ASSOCIATIONS = "SELECT adminassociation.* " +
                 "FROM adminassociation " +
                 "JOIN Benevole_Association ON adminassociation.idUtilisateur = Benevole_Association.association_id " +
                 "WHERE Benevole_Association.benevole_id = ?";

         try (Connection connection = daoFactory.getConnection();
              PreparedStatement preparedStatement = initRequestPrepare(connection, SQL_SELECT_ASSOCIATIONS, benevoleId);
              ResultSet resultSet = preparedStatement.executeQuery()) {

             while (resultSet.next()) {
                 AdminAssociation association = AdminAssociationDAOImpl.mapAdminAssociation(resultSet);
                 associations.add(association);
             }
         } catch (SQLException e) {
             throw new DAOException("Error loading associations for Benevole from the database", e);
         }

         return associations;
    }
    private static PreparedStatement initRequestPrepare(Connection connection, String sql, Object... objects)
            throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        for (int i = 0; i < objects.length; i++) {
            preparedStatement.setObject(i + 1, objects[i]);
        }
        return preparedStatement;
    }

	@Override
	public int addUser(User user) {
		// Appelez la méthode addUser de la classe parente UserDAOImpl
        return super.addUser(user);
	}

	@Override
	public int addBenevole(Benevole benevole) {
		 final String SQL_INSERT = "INSERT INTO benevole (idUtilisateur, nom, prenom, titreProfessionnel, resume,sexe ,dateNaissance) VALUES ( ?, ?, ?, ?, ?,?,?)";

		    try (Connection connection = daoFactory.getConnection();
		            // Utilisation de try-with-resources pour garantir la fermeture des ressources
		            PreparedStatement preparedStatement = initRequestPrepare(connection, SQL_INSERT,
		                    benevole.getIdUtilisateur(),
		                    benevole.getNom(),
		                    benevole.getPrenom(),
		                    benevole.getTitreProfessionnel(),
		                    benevole.getResume(),
		                    benevole.getSexe(),
		                    Date.valueOf(benevole.getDateNaissance())
		                    )) {

		        preparedStatement.executeUpdate();

		        // Aucune vérification ou récupération spéciale nécessaire ici

		        return benevole.getIdUtilisateur(); // Retournez l'ID de l'utilisateur
		    } catch (SQLException e) {
		        throw new DAOException("Error adding Volunteer to the database", e);
		    }
	}
	@Override
	public void addAssociationToBenevole(Benevole benevole, AdminAssociation association) {
	    final String SQL_INSERT_ASSOCIATION = "INSERT INTO Benevole_Association (benevole_id, association_id) VALUES (?, ?)";

	    try (Connection connection = daoFactory.getConnection();
	         PreparedStatement preparedStatement = initRequestPrepare(connection, SQL_INSERT_ASSOCIATION,
	                 benevole.getIdUtilisateur(),
	                 association.getIdUtilisateur())) {

	        preparedStatement.executeUpdate();
	    } catch (SQLException e) {
	        throw new DAOException("Error adding association to the database", e);
	    }
	}


    @Override
	public Benevole getBenevoleById(int benevoleId) {
	    final String SQL_SELECT_BY_ID = "SELECT * FROM benevole WHERE idUtilisateur = ?";

	    try (Connection connection = daoFactory.getConnection();
	         PreparedStatement preparedStatement = initRequestPrepare(connection, SQL_SELECT_BY_ID, benevoleId);
	         ResultSet resultSet = preparedStatement.executeQuery()) {

	        if (resultSet.next()) {
	            Benevole benevole = mapBenevole(resultSet);
	            System.out.println("Benevole found: " + benevole);
	            return benevole;
	        }
	    } catch (SQLException e) {
	        throw new DAOException("Error retrieving Benevole from the database", e);
	    }

	    System.out.println("No Benevole found for idUtilisateur: " + benevoleId);
	    return null;
	}
    @Override
    public void updateBenevole(Benevole benevole) throws DAOException {
    	final String SQL_UPDATE_BENEVOLE = "UPDATE benevole SET nom=?, prenom=?, titreProfessionnel=?, resume=? ,sexe=? ,dateNaissance=? WHERE idUtilisateur=?";

        try (Connection connection = daoFactory.getConnection();
             PreparedStatement preparedStatement = initRequestPrepare(connection, SQL_UPDATE_BENEVOLE,
                     benevole.getNom(), benevole.getPrenom(), benevole.getTitreProfessionnel(), benevole.getResume(),benevole.getSexe(),
                     Date.valueOf(benevole.getDateNaissance()),
                     benevole.getIdUtilisateur())) {

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new DAOException("Error updating Benevole in the database", e);
        }
    }


	@Override
	public User getUserById(int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> getAllUsers() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateUser(User user) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteUser(int userId) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean checkLogin(String identifier, String password) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public User getUserByEmail(String email) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> getUsersByRole(UserRole role) {
		// TODO Auto-generated method stub
		return null;
	}



	@Override
	public List<Benevole> getAllBenevoles() {
		// TODO Auto-generated method stub
		return null;
	}

}

package com.JAVA.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.JAVA.Beans.AdminAssociation;
import com.JAVA.Beans.Benevole;
import com.JAVA.Beans.User;
import com.JAVA.Beans.User.UserRole;

public class AdminAssociationDAOImpl extends UserDAOImpl implements AdminAssociationDAO {

	    // Constructeur prenant une fabrique DAO comme argument
	    public AdminAssociationDAOImpl(DAOFactory daoFactory) {
	        // Appel du constructeur de la classe parente avec le même paramètre
	        super(daoFactory);
	    }

	    
	    public static AdminAssociation mapAdminAssociation(ResultSet resultSet) throws SQLException {
	        AdminAssociation adminAssociation = new AdminAssociation();

	        // Mapping des colonnes spécifiques à la table adminassociation
	        adminAssociation.setIdUtilisateur(resultSet.getInt("idUtilisateur"));
	        adminAssociation.setNom(resultSet.getString("nom"));
	        adminAssociation.setDescription(resultSet.getString("description"));
	        adminAssociation.setSecteurActivite(resultSet.getString("secteurActivite"));
	        adminAssociation.setSiteWeb(resultSet.getString("siteWeb"));
	        adminAssociation.setAdresse(resultSet.getString("adresse"));
	        adminAssociation.setPhone(resultSet.getString("phone"));
	        adminAssociation.setVille(resultSet.getString("ville"));

	        // Vous pouvez également mapper les colonnes de la table utilisateur si nécessaire
	        // adminAssociation.setEmail(resultSet.getString("email"));
	        // adminAssociation.setMotDePasse(resultSet.getString("motDePasse"));
	        // adminAssociation.setRole(User.UserRole.valueOf(resultSet.getString("role")));
	        
	        List<Benevole> benevoles = loadBenevoles(adminAssociation.getIdUtilisateur());
	        adminAssociation.setAdherents(benevoles);
	        return adminAssociation;
	    }
	    
	    private static List<Benevole> loadBenevoles(int associationId) {
	        List<Benevole> benevoles = new ArrayList<>();

	        final String SQL_SELECT_BENEVOLES = "SELECT benevole.* " +
	                "FROM benevole " +
	                "JOIN Benevole_Association ON benevole.idUtilisateur = Benevole_Association.benevole_id " +
	                "WHERE Benevole_Association.association_id = ?";

	        try (Connection connection = daoFactory.getConnection();
	             PreparedStatement preparedStatement = initRequestPrepare(connection, SQL_SELECT_BENEVOLES, associationId);
	             ResultSet resultSet = preparedStatement.executeQuery()) {

	            while (resultSet.next()) {
	                Benevole benevole = BenevoleDAOImpl.mapBenevole(resultSet);
	                benevoles.add(benevole);
	            }
	        } catch (SQLException e) {
	            throw new DAOException("Error loading benevoles for AdminAssociation from the database", e);
	        }

	        return benevoles;
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
	    public int addUser(User user) throws DAOException {
	        // Appelez la méthode addUser de la classe parente UserDAOImpl
	        return super.addUser(user);
	    }

	    // Méthode pour ajouter un administrateur d'association
	    @Override
	    public int addAdminAssociation(AdminAssociation adminAssociation) throws DAOException {
	        final String SQL_INSERT = "INSERT INTO adminassociation (idUtilisateur, nom, description, secteurActivite, siteWeb, adresse, phone, ville) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

	        try (Connection connection = daoFactory.getConnection();
	             // Utilisation de try-with-resources pour garantir la fermeture des ressources
	             PreparedStatement preparedStatement = initRequestPrepare(connection, SQL_INSERT,
	                     adminAssociation.getIdUtilisateur(),
	                     adminAssociation.getNom(),
	                     adminAssociation.getDescription(),
	                     adminAssociation.getSecteurActivite(),
	                     adminAssociation.getSiteWeb(),
	                     adminAssociation.getAdresse(),
	                     adminAssociation.getPhone(),
	                     adminAssociation.getVille())) {

	            preparedStatement.executeUpdate();

	            // Aucune vérification ou récupération spéciale nécessaire ici

	            return adminAssociation.getIdUtilisateur(); // Retournez l'ID de l'utilisateur
	        } catch (SQLException e) {
	            throw new DAOException("Error adding AdminAssociation to the database", e);
	        }
	    }

	    @Override
	    public void updateAdminAssociation(AdminAssociation admin) throws DAOException {
	        final String SQL_UPDATE_ADMIN = "UPDATE adminassociation SET nom=?, description=?, secteurActivite=?, siteWeb=?, adresse=?, phone=?, ville=? WHERE idUtilisateur=?";

	        try (Connection connection = daoFactory.getConnection();
	             PreparedStatement preparedStatement = initRequestPrepare(connection, SQL_UPDATE_ADMIN,
	                     admin.getNom(), admin.getDescription(), admin.getSecteurActivite(), admin.getSiteWeb(),
	                     admin.getAdresse(), admin.getPhone(), admin.getVille(), admin.getIdUtilisateur())) {
	            preparedStatement.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	            throw new DAOException("Error updating AdminAssociation in the database", e);
	        }
	    }
	    
	    @Override
	    public void addBenevoleToAssociation(AdminAssociation association, Benevole benevole) {
	        final String SQL_INSERT_ASSOCIATION = "INSERT INTO Benevole_Association (benevole_id, association_id) VALUES (?, ?)";

	        try (Connection connection = daoFactory.getConnection();
	             PreparedStatement preparedStatement = initRequestPrepare(connection, SQL_INSERT_ASSOCIATION,
	                     benevole.getIdUtilisateur(),
	                     association.getIdUtilisateur())) {

	            preparedStatement.executeUpdate();
	        } catch (SQLException e) {
	            throw new DAOException("Error adding benevole to the association in the database", e);
	        }
	    }
	    
	    @Override
	    public List<Benevole> getAllBenevolesForAssociation(int associationId) {
	        return loadBenevoles(associationId);
	    }

	    @Override
	    public void removeBenevoleFromAssociation(AdminAssociation association, Benevole benevole) {
	        final String SQL_DELETE_ASSOCIATION = "DELETE FROM Benevole_Association WHERE benevole_id = ? AND association_id = ?";

	        try (Connection connection = daoFactory.getConnection();
	             PreparedStatement preparedStatement = initRequestPrepare(connection, SQL_DELETE_ASSOCIATION,
	                     benevole.getIdUtilisateur(),
	                     association.getIdUtilisateur())) {

	            preparedStatement.executeUpdate();
	        } catch (SQLException e) {
	            throw new DAOException("Error removing benevole from the association in the database", e);
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
	public AdminAssociation getAdminAssociationById(int adminAssociationId) {
	    final String SQL_SELECT_BY_ID = "SELECT * FROM adminassociation WHERE idUtilisateur = ?";

	    try (Connection connection = daoFactory.getConnection();
	         // Using try-with-resources to ensure resource closure
	         PreparedStatement preparedStatement = initRequestPrepare(connection, SQL_SELECT_BY_ID, adminAssociationId);
	         ResultSet resultSet = preparedStatement.executeQuery()) {

	        if (resultSet.next()) {
	            return mapAdminAssociation(resultSet);
	        }
	    } catch (SQLException e) {
	        throw new DAOException("Error retrieving AdminAssociation from the database", e);
	    }

	    System.out.println("No AdminAssociation found for idUtilisateur: " + adminAssociationId);
	    return null;
	}


	@Override
	public List<AdminAssociation> getAllAdminAssociations() {
		// TODO Auto-generated method stub
		return null;
	}

}

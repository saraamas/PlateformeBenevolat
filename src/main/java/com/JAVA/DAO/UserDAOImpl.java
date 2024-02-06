package com.JAVA.DAO;

import java.sql.Connection;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import com.JAVA.Beans.User;
import com.JAVA.Beans.User.UserRole;
public class UserDAOImpl implements UserDAO {
	
	protected static DAOFactory daoFactory;

    // Constructor
	public UserDAOImpl(DAOFactory daoFactory) {
        UserDAOImpl.daoFactory = daoFactory;
    }
    private static User mapUser(ResultSet resultSet) throws SQLException {
        User user = new User();
        user.setIdUtilisateur(resultSet.getInt("idUtilisateur"));
        user.setMotDePasse(resultSet.getString("motDePasse"));
        user.setPhotoProfil(resultSet.getBytes("photoProfil"));
        user.setEmail(resultSet.getString("email"));
        user.setRole(User.UserRole.valueOf(resultSet.getString("role")));  
        

        return user;
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
    	
    	if (!isEmailUnique(user.getEmail())) {
            throw new DAOException("Email address is already registered.");
        }
        final String SQL_INSERT = "INSERT INTO user (email, motDePasse, photoProfil, role) VALUES (?, ?, ?, ?)";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = daoFactory.getConnection();
            // Specify Statement.RETURN_GENERATED_KEYS to retrieve auto-generated keys
            preparedStatement = connection.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS);

            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getMotDePasse());
            preparedStatement.setBytes(3, user.getPhotoProfil());
            preparedStatement.setString(4, user.getRole().name()); // Assuming role is an Enum

            preparedStatement.executeUpdate();

            // After insertion, retrieve the generated ID
            resultSet = preparedStatement.getGeneratedKeys();

            if (resultSet.next()) {
                int generatedId = resultSet.getInt(1);
                user.setIdUtilisateur(generatedId); // Set the ID in the User object
                return generatedId; // Return the generated ID
            } else {
                throw new DAOException("User ID could not be retrieved after insertion.");
            }
        } catch (SQLException e) {
            throw new DAOException("Error adding User to the database", e);
        } finally {
            // Close resources (result set, statement, and connection) in the reverse order of their creation
            // Handle closing resources in a try-catch block
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                // Handle exception or log if necessary
                e.printStackTrace();
            }
        }
    }
    
    @Override
    public User auth(String email, String password) {
        final String SQL_AUTHENTICATION = "SELECT * FROM user WHERE email = ? AND motDePasse = ?";
        
        try (Connection connection = daoFactory.getConnection();
                PreparedStatement preparedStatement = initRequestPrepare(connection, SQL_AUTHENTICATION, email, password);
                ResultSet resultSet = preparedStatement.executeQuery()) {
            
            if (resultSet.next()) {
                return mapUser(resultSet);
            }
        } catch (SQLException e) {
            // Log the exception
            e.printStackTrace();
        }
        return null;
    }



    private boolean isEmailUnique(String email) throws DAOException {
        final String SQL_CHECK_EMAIL = "SELECT COUNT(*) FROM user WHERE email = ?";

        try (Connection connection = daoFactory.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL_CHECK_EMAIL)) {
            preparedStatement.setString(1, email);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count == 0; // Si count est 0, l'e-mail est unique
                } else {
                    throw new DAOException("Error checking email uniqueness.");
                }
            }
        } catch (SQLException e) {
            throw new DAOException("Error checking email uniqueness.", e);
        }
    }


    @Override
    public User getUserById(int userId) {
        try (Connection connection = daoFactory.getConnection();
             PreparedStatement preparedStatement = initRequestPrepare(connection,
                     "SELECT * FROM user WHERE idUtilisateur = ?", userId);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            if (resultSet.next()) {
                return mapUser(resultSet);
            }
        } catch (SQLException e) {
            // Handle the exception
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (Connection connection = daoFactory.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM user");
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                users.add(mapUser(resultSet));
            }
        } catch (SQLException e) {
            // Handle the exception
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public void updateUser(User user) throws DAOException {
        final String SQL_UPDATE = "UPDATE user SET email=?, motDePasse=?, photoProfil=?, role=? WHERE idUtilisateur=?";

        try (Connection connection = daoFactory.getConnection();
             PreparedStatement preparedStatement = initRequestPrepare(connection, SQL_UPDATE,
                     user.getEmail(), user.getMotDePasse(), user.getPhotoProfil(), user.getRole().name(), user.getIdUtilisateur())) {
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new DAOException("Error updating User in the database", e);
        }
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

}

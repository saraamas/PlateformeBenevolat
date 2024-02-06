package com.JAVA.DAO;

import java.util.List;

import com.JAVA.Beans.User;
import com.JAVA.Beans.User.UserRole;

public interface UserDAO {
    int addUser(User user);
    User getUserById(int userId);
    List<User> getAllUsers();
    void updateUser(User user);
    void deleteUser(int userId);
    boolean checkLogin(String identifier, String password);
    User getUserByEmail(String email);
    List<User> getUsersByRole(UserRole role); // Ajout d'une méthode pour récupérer les utilisateurs par rôle
	User auth(String email, String password);

}

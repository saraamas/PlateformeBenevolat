

package com.JAVA.Beans;

import com.JAVA.Beans.User.UserRole;

public class UserFactory {

    public static User createUser(UserRole role, String email, String password /* other parameters */) {
        switch (role) {
            case benevole:
                Benevole benevole = new Benevole();
                benevole.setEmail(email);
                benevole.setMotDePasse(password);
                // Set Benevole-specific attributes
                // Add more setters as needed
                return benevole;
            case adminassociation:
                AdminAssociation adminAssociation = new AdminAssociation();
                adminAssociation.setEmail(email);
                adminAssociation.setMotDePasse(password);
                //adminAssociation.setPhotoProfil(photoProfil);
                // Set AdminAssociation-specific attributes
                // Add more setters as needed
                return adminAssociation;
            default:
                throw new IllegalArgumentException("Unsupported user role: " + role);
        }
    }
}

package com.JAVA.DAO;

import com.JAVA.Beans.AdminAssociation;
import com.JAVA.Beans.Benevole;

import java.util.List;

public interface AdminAssociationDAO extends UserDAO {
    int addAdminAssociation(AdminAssociation adminAssociation);
    AdminAssociation getAdminAssociationById(int adminAssociationId) ;
    List<AdminAssociation> getAllAdminAssociations();
    // Additional methods specific to AdminAssociation
    // ...
	void updateAdminAssociation(AdminAssociation admin) throws DAOException;
	boolean addBenevoleToAssociation(AdminAssociation association, Benevole benevole);
	List<Benevole> getAllBenevolesForAssociation(int associationId);
	void removeBenevoleFromAssociation(AdminAssociation association, Benevole benevole);
	List<Benevole> loadBenevoles(int associationId);
}

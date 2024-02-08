package com.JAVA.DAO;



import com.JAVA.Beans.AdminAssociation;
import com.JAVA.Beans.Benevole;

import java.util.List;

public interface BenevoleDAO extends UserDAO {
    int addBenevole(Benevole benevole);
    Benevole getBenevoleById(int benevoleId);

    List<Benevole> getAllBenevoles();
    List<AdminAssociation> loadAssociations(int benevoleId);
	void updateBenevole(Benevole benevole) throws DAOException;
	void addAssociationToBenevole(Benevole benevole, AdminAssociation association);
	List<Benevole> loadBenevolesForAssociation(int associationId);
}

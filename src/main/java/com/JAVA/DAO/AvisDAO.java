package com.JAVA.DAO;

import java.sql.SQLException;
import java.util.List;

import com.JAVA.Beans.Avis;

public interface AvisDAO {
	 void ajouterAvis(Avis avis) throws SQLException;
	 List<Avis> getAvisByEvent(int eventId) throws SQLException;
	 void deleteAvis(int avisId) throws SQLException;

}

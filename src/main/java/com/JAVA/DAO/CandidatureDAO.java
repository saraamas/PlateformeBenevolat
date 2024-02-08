package com.JAVA.DAO;

import java.util.List;

import com.JAVA.Beans.Candidature;

public interface CandidatureDAO {
	Candidature getCandidatureById(int idCandidature);
	
    List<Candidature> getAllCandidatures();

    void addCandidature(Candidature candidature);

    void updateCandidature(Candidature candidature);

    void deleteCandidature(int idCandidature);
    
    List<Candidature> getAllCandidaturesForAdminAssociation(int adminAssociationId);

    List<Candidature> getAllCandidaturesForBenevole(int benevoleId);


	int getCandidaturesEnAttenteCount();

	int getCandidaturesAccepteesCountForEvent(int eventId);

}

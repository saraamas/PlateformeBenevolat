package com.JAVA.Beans;

import java.util.List;

public class User {


    private int idUtilisateur;

    private String email;
    private String motDePasse;
    private byte[] photoProfil;
    private UserRole role;
    private List<Event> events;
    

	public User() {
		super();
	}

	
	
	


	/**
	 * @return the idUtilisateur
	 */
	public int getIdUtilisateur() {
		return idUtilisateur;
	}






	/**
	 * @param idUtilisateur the idUtilisateur to set
	 */
	public void setIdUtilisateur(int idUtilisateur) {
		this.idUtilisateur = idUtilisateur;
	}






	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}






	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}






	/**
	 * @return the motDePasse
	 */
	public String getMotDePasse() {
		return motDePasse;
	}






	/**
	 * @param motDePasse the motDePasse to set
	 */
	public void setMotDePasse(String motDePasse) {
		this.motDePasse = motDePasse;
	}






	/**
	 * @return the photoProfil
	 */
	public byte[] getPhotoProfil() {
		return photoProfil;
	}






	/**
	 * @param photoProfil the photoProfil to set
	 */
	public void setPhotoProfil(byte[] photoProfil) {
		this.photoProfil = photoProfil;
	}






	/**
	 * @return the role
	 */
	public UserRole getRole() {
		return role;
	}






	/**
	 * @param role the role to set
	 */
	public void setRole(UserRole role) {
		this.role = role;
	}






	public List<Event> getEvents() {
		return events;
	}






	public void setEvents(List<Event> events) {
		this.events = events;
	}






	public enum UserRole {
        adminassociation,
        benevole
    }






	
  
}


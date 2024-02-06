package com.JAVA.Beans;

import java.sql.Timestamp;

public class Avis {
    private int idAvis;
    private String commentaire;
    private int reactionId;
    private User user;
    private Event event;
    private Timestamp timestamp;
    

	/**
	 * @return the timestamp
	 */
	public Timestamp getTimestamp() {
		return timestamp;
	}
	/**
	 * @param timestamp the timestamp to set
	 */
	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}
	/**
	 * 
	 */
	public Avis() {
		super();
	}
	/**
	 * @return the idAvis
	 */
	public int getIdAvis() {
		return idAvis;
	}
	/**
	 * @param idAvis the idAvis to set
	 */
	public void setIdAvis(int idAvis) {
		this.idAvis = idAvis;
	}
	/**
	 * @return the commentaire
	 */
	public String getCommentaire() {
		return commentaire;
	}
	/**
	 * @param commentaire the commentaire to set
	 */
	public void setCommentaire(String commentaire) {
		this.commentaire = commentaire;
	}
	/**
	 * @return the reactionId
	 */
	public int getReactionId() {
		return reactionId;
	}
	/**
	 * @param reactionId the reactionId to set
	 */
	public void setReactionId(int reactionId) {
		this.reactionId = reactionId;
	}
	/**
	 * @return the user
	 */
	public User getUser() {
		return user;
	}
	/**
	 * @param user the user to set
	 */
	public void setUser(User user) {
		this.user = user;
	}
	/**
	 * @return the event
	 */
	public Event getEvent() {
		return event;
	}
	/**
	 * @param event the event to set
	 */
	public void setEvent(Event event) {
		this.event = event;
	}

    
}

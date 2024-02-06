package com.JAVA.Beans;

	public class Candidature {
	    private int idCandidature;
	    private String lettreMotivation;
	    private String statut;
	    private Event event;  // Référence à l'événement associé
	    private Benevole benevole;    // Référence au bénévole associé
		/**
		 * 
		 */

		// Constructeur
	    public Candidature() {
	        this.statut = "en attente"; // Valeur par défaut
	    }
		/**
		 * @return the idCandidature
		 */
		public int getIdCandidature() {
			return idCandidature;
		}
		/**
		 * @param idCandidature the idCandidature to set
		 */
		public void setIdCandidature(int idCandidature) {
			this.idCandidature = idCandidature;
		}
		/**
		 * @return the lettreMotivation
		 */
		public String getLettreMotivation() {
			return lettreMotivation;
		}
		/**
		 * @param lettreMotivation the lettreMotivation to set
		 */
		public void setLettreMotivation(String lettreMotivation) {
			this.lettreMotivation = lettreMotivation;
		}
		/**
		 * @return the statut
		 */
		public String getStatut() {
			return statut;
		}
		/**
		 * @param statut the statut to set
		 */
		public void setStatut(String statut) {
			this.statut = statut;
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
		/**
		 * @return the benevole
		 */
		public Benevole getBenevole() {
			return benevole;
		}
		/**
		 * @param benevole the benevole to set
		 */
		public void setBenevole(Benevole benevole) {
			this.benevole = benevole;
		}

	    // Constructeurs, getters, setters, et autres méthodes nécessaires
		public void changerStatut(String nouveauStatut) {
	        this.statut = nouveauStatut;
	    }
	}



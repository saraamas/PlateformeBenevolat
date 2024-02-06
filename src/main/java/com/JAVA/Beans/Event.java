package com.JAVA.Beans;

import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

public class Event {
    private int idEvent;
    private String titre;
    private String description;
    private String categorie;
    private String dateDebut;
    private String dateFin;
    private String lieu;
    private byte[] picture;
    private String pictureBase64;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "createurId") // Assurez-vous de remplacer "id_admin_association" par le nom réel de la colonne de clé étrangère

    private AdminAssociation adminAssociation;
    // Constructeur par défaut
    public Event() {
    }

    // Constructeur avec tous les champs
    public Event(int idEvent, String titre, String description, String categorie,
                 String dateDebut, String dateFin, String lieu) {
        this.idEvent = idEvent;
        this.titre = titre;
        this.description = description;
        this.categorie = categorie;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.lieu = lieu;

    }

    // Getters et setters
    public int getIdEvent() {
        return idEvent;
    }

    public void setIdEvent(int idEvent) {
        this.idEvent = idEvent;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public String getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(String dateDebut) {
        this.dateDebut = dateDebut;
    }

    public String getDateFin() {
        return dateFin;
    }

    public void setDateFin(String dateFin) {
        this.dateFin = dateFin;
    }

    public String getLieu() {
        return lieu;
    }

    public void setLieu(String lieu) {
        this.lieu = lieu;
    }


	public byte[] getPicture() {
		return picture;
	}

	public void setPicture(byte[] picture) {
		this.picture = picture;
	}

	public String getPictureBase64() {
		return pictureBase64;
	}

	public void setPictureBase64(String pictureBase64) {
		this.pictureBase64 = pictureBase64;
	}

	public AdminAssociation getAdminAssociation() {
        return adminAssociation;
    }

    public void setAdminAssociation(AdminAssociation adminAssociation) {
        this.adminAssociation = adminAssociation;
    }



}

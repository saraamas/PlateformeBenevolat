package com.JAVA.Beans;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
@Entity
@Table(name = "adminassociation")
public class AdminAssociation extends User{


    private String nom;
    private String description;
    private String secteurActivite;
    private String siteWeb;
    private String adresse;
    private String phone;
    private String ville;
    @ManyToMany(mappedBy = "associations")

    private List<Benevole> adherents;

	/**
	 * 
	 */
	public AdminAssociation() {
		super();
	}

	
	/**
	 * @return the nom
	 */
	public String getNom() {
		return nom;
	}
	/**
	 * @param nom the nom to set
	 */
	public void setNom(String nom) {
		this.nom = nom;
	}
	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * @return the secteurActivite
	 */
	public String getSecteurActivite() {
		return secteurActivite;
	}
	/**
	 * @param secteurActivite the secteurActivite to set
	 */
	public void setSecteurActivite(String secteurActivite) {
		this.secteurActivite = secteurActivite;
	}
	/**
	 * @return the siteWeb
	 */
	public String getSiteWeb() {
		return siteWeb;
	}
	/**
	 * @param siteWeb the siteWeb to set
	 */
	public void setSiteWeb(String siteWeb) {
		this.siteWeb = siteWeb;
	}
	/**
	 * @return the adresse
	 */
	public String getAdresse() {
		return adresse;
	}
	/**
	 * @param adresse the adresse to set
	 */
	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}
	/**
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}
	/**
	 * @param phone the phone to set
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}
	/**
	 * @return the ville
	 */
	public String getVille() {
		return ville;
	}
	/**
	 * @param ville the ville to set
	 */
	public void setVille(String ville) {
		this.ville = ville;
	}
	//
	public List<Benevole> getAdherents() {
        
        return adherents;
    }

    public void setAdherents(List<Benevole> adherents) {
        this.adherents = adherents;
    }

    public void addAdherent(Benevole benevole) {
        adherents.add(benevole);
    }

    
}


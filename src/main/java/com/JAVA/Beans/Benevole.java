package com.JAVA.Beans;

import java.time.LocalDate;
import java.time.Period;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.JoinTable;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Table;


@Entity
@Table(name = "benevole")

public class Benevole extends User{

    private String nom;
    private String prenom;
    private String titreProfessionnel;
    private String sexe ;
    private int age; // Champ pour stocker l'âge
    private LocalDate dateNaissance;
    private String resume;
    
    @ManyToMany
    @JoinTable(
        name = "Benevole_Association",
        joinColumns = @JoinColumn(name = "benevole_id"),
        inverseJoinColumns = @JoinColumn(name = "association_id")
    )
    private List<AdminAssociation> associations; // Liste des associations auxquelles le bénévole est associé
    
	/**
	 * 
	 */
	public Benevole() {
		super();
		// TODO Auto-generated constructor stub
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
	 * @return the prenom
	 */
	public String getPrenom() {
		return prenom;
	}
	/**
	 * @param prenom the prenom to set
	 */
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	/**
	 * @return the titreProfessionnel
	 */
	public String getTitreProfessionnel() {
		return titreProfessionnel;
	}
	/**
	 * @param titreProfessionnel the titreProfessionnel to set
	 */
	public void setTitreProfessionnel(String titreProfessionnel) {
		this.titreProfessionnel = titreProfessionnel;
	}
	/**
	 * @return the sexe
	 */
	public String getSexe() {
		return sexe;
	}


	/**
	 * @param sexe the sexe to set
	 */
	public void setSexe(String sexe) {
		this.sexe = sexe;
	}


	/**
	 * @return the resume
	 */
	public String getResume() {
		return resume;
	}
	/**
	 * @param resume the resume to set
	 */
	public void setResume(String resume) {
		this.resume = resume;
	}
	/**
	 * @return the List<AdminAssociation>
	 */
	 public List<AdminAssociation> getAssociations() {
	        return associations;
	    }

	 public void setAssociations(List<AdminAssociation> associations) {
	        this.associations = associations;
	    }
	 public LocalDate getDateNaissance() {
	        return dateNaissance;
	    }

	 public void setDateNaissance(LocalDate dateNaissance) {
	        this.dateNaissance = dateNaissance;
	        calculateAge(); // Mettez à jour l'âge lorsque la date de naissance est modifiée
	    }

	    public int getAge() {
	        return age;
	    }

	    private void calculateAge() {
	        if (dateNaissance != null) {
	            LocalDate currentDate = LocalDate.now();
	            Period period = Period.between(dateNaissance, currentDate);
	            this.age = period.getYears();
	        } else {
	            this.age = 0; // Ou une valeur par défaut appropriée si la date de naissance est null
	        }
	    }
    
    

}

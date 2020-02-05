package com.skilldistillery.armadasite.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Image {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "url")
	private String photoUrl;
	
	//RELATIONSHIPS
	
	@ManyToMany(mappedBy = "images")
	@JsonIgnore
	private List<Ship> ships;

	//CONSTRUCTORS
	
	public Image() {
		super();
	}

	public Image(int id, String photoUrl, List<Ship> ships) {
		super();
		this.id = id;
		this.photoUrl = photoUrl;
		this.ships = ships;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPhotoUrl() {
		return photoUrl;
	}

	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}

	public List<Ship> getShips() {
		return ships;
	}

	public void setShips(List<Ship> ships) {
		this.ships = ships;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result + ((photoUrl == null) ? 0 : photoUrl.hashCode());
		result = prime * result + ((ships == null) ? 0 : ships.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Image other = (Image) obj;
		if (id != other.id)
			return false;
		if (photoUrl == null) {
			if (other.photoUrl != null)
				return false;
		} else if (!photoUrl.equals(other.photoUrl))
			return false;
		if (ships == null) {
			if (other.ships != null)
				return false;
		} else if (!ships.equals(other.ships))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Image [id=" + id + ", photoUrl=" + photoUrl + "]";
	}
}

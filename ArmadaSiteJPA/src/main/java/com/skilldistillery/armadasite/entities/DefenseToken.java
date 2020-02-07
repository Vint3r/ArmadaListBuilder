package com.skilldistillery.armadasite.entities;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "defense_token")
public class DefenseToken {

	// FIELDS

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	private String effect;
	
	//RELATIONSHIPS
	
	@OneToMany(mappedBy = "defenseToken")
	@JsonIgnore
	private List<ShipDefenseToken> ships;
	
	@OneToOne
	@JoinColumn(name = "image_id")
	private Image image;
	
	@OneToMany(mappedBy = "defenseToken")
	@JsonIgnore
	private List<FighterDefenseToken> fighters;
	
	//CONSTRUCTORS
	
	public DefenseToken() {
		super();
	}

	public DefenseToken(int id, String name, String effect, List<ShipDefenseToken> ships, Image image, List<FighterDefenseToken> fighters) {
		super();
		this.id = id;
		this.name = name;
		this.effect = effect;
		this.ships = ships;
		this.image = image;
		this.fighters = fighters;
	}

	//METHODS
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEffect() {
		return effect;
	}

	public void setEffect(String effect) {
		this.effect = effect;
	}

	public List<ShipDefenseToken> getShips() {
		return ships;
	}

	public void setShips(List<ShipDefenseToken> ships) {
		this.ships = ships;
	}

	public Image getImage() {
		return image;
	}

	public void setImage(Image image) {
		this.image = image;
	}

	public List<FighterDefenseToken> getFighters() {
		return fighters;
	}

	public void setFighters(List<FighterDefenseToken> fighters) {
		this.fighters = fighters;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((effect == null) ? 0 : effect.hashCode());
		result = prime * result + id;
		result = prime * result + ((image == null) ? 0 : image.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
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
		DefenseToken other = (DefenseToken) obj;
		if (effect == null) {
			if (other.effect != null)
				return false;
		} else if (!effect.equals(other.effect))
			return false;
		if (id != other.id)
			return false;
		if (image == null) {
			if (other.image != null)
				return false;
		} else if (!image.equals(other.image))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
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
		return "DefenseToken [id=" + id + ", name=" + name + ", effect=" + effect + "]";
	}

}

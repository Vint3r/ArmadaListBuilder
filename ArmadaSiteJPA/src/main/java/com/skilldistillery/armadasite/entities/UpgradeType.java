package com.skilldistillery.armadasite.entities;

import java.util.ArrayList;
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
@Table(name = "upgrade_type")
public class UpgradeType {
	
	//FIELDS
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String type;
	
	//RELATIONSHIPS
	
	@OneToOne
	@JoinColumn(name = "image_id")
	private Image image;
	
	@OneToMany(mappedBy = "upgradeType")//
	@JsonIgnore
	private List<ShipUpgradeType> ships;
	
	//CONSTRUCTORS
	
	public UpgradeType() {
		super();
	}
	
	public UpgradeType(int id, String type, Image image) {
		super();
		this.id = id;
		this.type = type;
		this.image = image;
	}

	//METHODS
	
	public int getId() {
		return id;
	}

	public List<ShipUpgradeType> getShips() {
		return ships;
	}

	public void setShips(List<ShipUpgradeType> ships) {
		this.ships = ships;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public Image getImage() {
		return image;
	}

	public void setImage(Image image) {
		this.image = image;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result + ((image == null) ? 0 : image.hashCode());
		result = prime * result + ((ships == null) ? 0 : ships.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
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
		UpgradeType other = (UpgradeType) obj;
		if (id != other.id)
			return false;
		if (image == null) {
			if (other.image != null)
				return false;
		} else if (!image.equals(other.image))
			return false;
		if (ships == null) {
			if (other.ships != null)
				return false;
		} else if (!ships.equals(other.ships))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "UpgradeType [id=" + id + ", type=" + type + ", image=" + image + "]";
	}
	
	public void addUpgradeType(ShipUpgradeType ship) {
		if (ships == null) {
			ships = new ArrayList<>();
		}
		
		if (!ships.contains(ship)) {
			ships.add(ship);
			if (ship.getUpgradeType() != null) {
				ship.getUpgradeType().getShips().remove(ship);
			}
			ship.setUpgradeType(this);
		}
	}
	
	public void removeUpgradeType(ShipUpgradeType ship) {
		ship.setUpgradeType(null);
		if (ships != null) {
			ships.remove(ship);
		}
	}
}

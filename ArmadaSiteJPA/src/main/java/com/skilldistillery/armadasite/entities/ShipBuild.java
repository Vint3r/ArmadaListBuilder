package com.skilldistillery.armadasite.entities;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "ship_build")
public class ShipBuild {

	// FIELDS

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	// RELATIONSHIPS

	@OneToOne
	@JoinColumn(name = "ship_id")
	@JsonIgnoreProperties({"defenseTokens", "upgradeTypes"})
	private Ship ship;

	@ManyToMany
	@JoinTable(name = "upgrade_ship_build", joinColumns = @JoinColumn(name = "ship_build_id"), inverseJoinColumns = @JoinColumn(name = "upgrade_id"))
	private List<Upgrade> upgrades;
	
	@ManyToMany(mappedBy = "shipBuilds")
	@JsonIgnore
	private List<ListBuild> lists;

	// CONSTRUCTORS

	public ShipBuild() {
		super();
	}

	public ShipBuild(int id, Ship ship, List<Upgrade> upgrades) {
		super();
		this.id = id;
		this.ship = ship;
		this.upgrades = upgrades;
	}

	//METHODS
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<ListBuild> getLists() {
		return lists;
	}

	public void setLists(List<ListBuild> lists) {
		this.lists = lists;
	}

	public Ship getShip() {
		return ship;
	}

	public void setShip(Ship ship) {
		this.ship = ship;
	}

	public List<Upgrade> getUpgrades() {
		return upgrades;
	}

	public void setUpgrades(List<Upgrade> upgrades) {
		this.upgrades = upgrades;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result + ((lists == null) ? 0 : lists.hashCode());
		result = prime * result + ((ship == null) ? 0 : ship.hashCode());
		result = prime * result + ((upgrades == null) ? 0 : upgrades.hashCode());
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
		ShipBuild other = (ShipBuild) obj;
		if (id != other.id)
			return false;
		if (lists == null) {
			if (other.lists != null)
				return false;
		} else if (!lists.equals(other.lists))
			return false;
		if (ship == null) {
			if (other.ship != null)
				return false;
		} else if (!ship.equals(other.ship))
			return false;
		if (upgrades == null) {
			if (other.upgrades != null)
				return false;
		} else if (!upgrades.equals(other.upgrades))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ShipBuild [id=" + id + ", ship=" + ship + "]";
	}

}

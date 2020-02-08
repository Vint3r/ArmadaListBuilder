package com.skilldistillery.armadasite.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "hull_zone")
public class HullZone {
	
	//FIELDS
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private int shields;
	private String location;
	@Column(name = "as_red")
	private int asRed;
	@Column(name = "as_blue")
	private int asBlue;
	@Column(name = "as_black")
	private int asBlack;
	
	//RELATIONSHIPS
	
	@JsonIgnore
	@ManyToMany(mappedBy = "hullZones")//
	private List<Ship> ships;

	
	//CONSTRUCTORS
	
	public HullZone() {
		super();
	}


	public HullZone(int id, int shields, String location, int asRed, int asBlue, int asBlack, List<Ship> ships) {
		super();
		this.id = id;
		this.shields = shields;
		this.location = location;
		this.asRed = asRed;
		this.asBlue = asBlue;
		this.asBlack = asBlack;
		this.ships = ships;
	}

	//METHODS

	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getShields() {
		return shields;
	}


	public void setShields(int shields) {
		this.shields = shields;
	}


	public String getLocation() {
		return location;
	}


	public void setLocation(String location) {
		this.location = location;
	}


	public int getAsRed() {
		return asRed;
	}


	public void setAsRed(int asRed) {
		this.asRed = asRed;
	}


	public int getAsBlue() {
		return asBlue;
	}


	public void setAsBlue(int asBlue) {
		this.asBlue = asBlue;
	}


	public int getAsBlack() {
		return asBlack;
	}


	public void setAsBlack(int asBlack) {
		this.asBlack = asBlack;
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
		result = prime * result + asBlack;
		result = prime * result + asBlue;
		result = prime * result + asRed;
		result = prime * result + id;
		result = prime * result + ((location == null) ? 0 : location.hashCode());
		result = prime * result + shields;
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
		HullZone other = (HullZone) obj;
		if (asBlack != other.asBlack)
			return false;
		if (asBlue != other.asBlue)
			return false;
		if (asRed != other.asRed)
			return false;
		if (id != other.id)
			return false;
		if (location == null) {
			if (other.location != null)
				return false;
		} else if (!location.equals(other.location))
			return false;
		if (shields != other.shields)
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
		return "HullZone [id=" + id + ", shields=" + shields + ", location=" + location + ", asRed=" + asRed
				+ ", asBlue=" + asBlue + ", asBlack=" + asBlack + "]";
	}
	
	public void addShip(Ship ship) {
		if (ships == null) {
			ships = new ArrayList<>();
		}

		if (!ships.contains(ship)) {
			ships.add(ship);
			ship.addHullZone(this);
		}
	}

	public void removeShip(Ship ship) {
		if (ships != null && ships.contains(ship)) {
			ships.remove(ship);
			ship.removeHullZone(this);
		}
	}

}

package com.skilldistillery.armadasite.entities;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "ship_defense_token")
public class ShipDefenseToken {
	
	//FIELDS
	
	@EmbeddedId
	private ShipDefenseTokenId id;
	private int amount;
	
	//RELATIONSHIPS
	
	@ManyToOne
	@JsonIgnore
	@JoinColumn(name = "ship_id")
	@MapsId(value = "shipId")
	private Ship ship;
	
	@ManyToOne
	@JoinColumn(name = "defense_token_id")
	@MapsId(value = "defenseId")
	private DefenseToken defenseToken;
	
	//CONSTUCTORS
	
	public ShipDefenseToken() {
		super();
	}

	public ShipDefenseToken(ShipDefenseTokenId id, int amount, Ship ship, DefenseToken defenseToken) {
		super();
		this.id = id;
		this.amount = amount;
		this.ship = ship;
		this.defenseToken = defenseToken;
	}
	
	//METHODS

	public ShipDefenseTokenId getId() {
		return id;
	}

	public void setId(ShipDefenseTokenId id) {
		this.id = id;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public Ship getShip() {
		return ship;
	}

	public void setShip(Ship ship) {
		this.ship = ship;
	}

	public DefenseToken getDefenseToken() {
		return defenseToken;
	}

	public void setDefenseToken(DefenseToken defenseToken) {
		this.defenseToken = defenseToken;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + amount;
		result = prime * result + ((defenseToken == null) ? 0 : defenseToken.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((ship == null) ? 0 : ship.hashCode());
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
		ShipDefenseToken other = (ShipDefenseToken) obj;
		if (amount != other.amount)
			return false;
		if (defenseToken == null) {
			if (other.defenseToken != null)
				return false;
		} else if (!defenseToken.equals(other.defenseToken))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (ship == null) {
			if (other.ship != null)
				return false;
		} else if (!ship.equals(other.ship))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ShipDefenseToken [id=" + id + ", amount=" + amount + "]";
	}
	
}

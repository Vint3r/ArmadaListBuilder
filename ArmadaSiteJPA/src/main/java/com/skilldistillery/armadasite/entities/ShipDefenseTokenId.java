package com.skilldistillery.armadasite.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ShipDefenseTokenId implements Serializable {
	private static final long serialVersionUID = 1L;

	//FIELDS
	
	@Column(name = "ship_id")
	private int shipId;
	@Column(name = "defense_token_id")
	private int defenseId;

	//CONSTRUCTORS
	
	public ShipDefenseTokenId() {
		super();
	}

	public ShipDefenseTokenId(int shipId, int defenseId) {
		super();
		this.shipId = shipId;
		this.defenseId = defenseId;
	}

	//METHODS
	
	public int getShipId() {
		return shipId;
	}

	public void setShipId(int shipId) {
		this.shipId = shipId;
	}

	public int getDefenseId() {
		return defenseId;
	}

	public void setDefenseId(int defenseId) {
		this.defenseId = defenseId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + defenseId;
		result = prime * result + shipId;
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
		ShipDefenseTokenId other = (ShipDefenseTokenId) obj;
		if (defenseId != other.defenseId)
			return false;
		if (shipId != other.shipId)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ShipDefenseTokenId [shipId=" + shipId + ", defenseId=" + defenseId + "]";
	}

}

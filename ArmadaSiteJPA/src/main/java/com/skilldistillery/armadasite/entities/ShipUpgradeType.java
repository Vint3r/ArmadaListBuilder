package com.skilldistillery.armadasite.entities;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "ship_upgrade_type")
public class ShipUpgradeType {

	// FIELDS

	@EmbeddedId
	private ShipUpgradeTypeId id;
	private int amount;
	private boolean filled;

	// RELATIONSHIPS

	@ManyToOne
	@JoinColumn(name = "ship_id")
	@MapsId(value = "shipId")
	private Ship ship;

	@ManyToOne
	@JoinColumn(name = "upgrade_type_id")
	@MapsId(value = "upgradeId")
	private UpgradeType upgradeType;

	//CONSTUCTORS
	
	public ShipUpgradeType() {
		super();
	}

	public ShipUpgradeType(ShipUpgradeTypeId id, int amount, boolean filled, Ship ship, UpgradeType upgrade) {
		super();
		this.id = id;
		this.amount = amount;
		this.filled = filled;
		this.ship = ship;
		this.upgradeType = upgrade;
	}
	
	//METHODS

	public ShipUpgradeTypeId getId() {
		return id;
	}

	public void setId(ShipUpgradeTypeId id) {
		this.id = id;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public boolean isFilled() {
		return filled;
	}

	public void setFilled(boolean filled) {
		this.filled = filled;
	}

	public Ship getShip() {
		return ship;
	}

	public void setShip(Ship ship) {
		this.ship = ship;
	}

	public UpgradeType getUpgradeType() {
		return upgradeType;
	}

	public void setUpgradeType(UpgradeType upgrade) {
		this.upgradeType = upgrade;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + amount;
		result = prime * result + (filled ? 1231 : 1237);
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((ship == null) ? 0 : ship.hashCode());
		result = prime * result + ((upgradeType == null) ? 0 : upgradeType.hashCode());
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
		ShipUpgradeType other = (ShipUpgradeType) obj;
		if (amount != other.amount)
			return false;
		if (filled != other.filled)
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
		if (upgradeType == null) {
			if (other.upgradeType != null)
				return false;
		} else if (!upgradeType.equals(other.upgradeType))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ShipUpgradeType [id=" + id + ", amount=" + amount + ", filled=" + filled + ", ship=" + ship
				+ ", upgrade=" + upgradeType + "]";
	}

}

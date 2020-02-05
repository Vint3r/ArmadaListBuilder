package com.skilldistillery.armadasite.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ShipUpgradeTypeId implements Serializable {
	private static final long serialVersionUID = 1L;

	// FIELDS

	@Column(name = "ship_id")
	private int shipId;
	@Column(name = "upgrade_type_id")
	private int upgradeId;

	// CONSTRUCTORS

	public ShipUpgradeTypeId() {
		super();
	}

	public ShipUpgradeTypeId(int shipId, int upgradeId) {
		super();
		this.shipId = shipId;
		this.upgradeId = upgradeId;
	}

	// METHODS
	
	public int getShipId() {
		return shipId;
	}

	public void setShipId(int shipId) {
		this.shipId = shipId;
	}

	public int getUpgradeId() {
		return upgradeId;
	}

	public void setUpgradeId(int upgradeId) {
		this.upgradeId = upgradeId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + shipId;
		result = prime * result + upgradeId;
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
		ShipUpgradeTypeId other = (ShipUpgradeTypeId) obj;
		if (shipId != other.shipId)
			return false;
		if (upgradeId != other.upgradeId)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ShipUpgradeTypeId [shipId=" + shipId + ", upgradeId=" + upgradeId + "]";
	}

}

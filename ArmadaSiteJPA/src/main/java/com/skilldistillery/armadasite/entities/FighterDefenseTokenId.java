package com.skilldistillery.armadasite.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class FighterDefenseTokenId implements Serializable {
	private static final long serialVersionUID = 1L;

	// FIELDS

	@Column(name = "fighter_id")
	private int fighterId;
	@Column(name = "defense_token_id")
	private int defenseId;

	//CONSTRUCTORS
	
	public FighterDefenseTokenId() {
		super();
	}

	public FighterDefenseTokenId(int fighterId, int defenseId) {
		super();
		this.fighterId = fighterId;
		this.defenseId = defenseId;
	}

	//METHODS
	
	public int getFighterId() {
		return fighterId;
	}

	public void setFighterId(int fighterId) {
		this.fighterId = fighterId;
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
		result = prime * result + fighterId;
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
		FighterDefenseTokenId other = (FighterDefenseTokenId) obj;
		if (defenseId != other.defenseId)
			return false;
		if (fighterId != other.fighterId)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "FighterDefenseTokenId [fighterId=" + fighterId + ", defenseId=" + defenseId + "]";
	}

}

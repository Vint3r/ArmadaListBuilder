package com.skilldistillery.armadasite.entities;

import javax.persistence.CascadeType;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "fighter_defense_token")
public class FighterDefenseToken {
	
	//FIELDS
	
	@EmbeddedId
	private FighterDefenseTokenId id;
	private int amount;
	
	//RELATIONSHIPS
	
	@ManyToOne(cascade = {CascadeType.PERSIST})
	@JoinColumn(name = "fighter_id")
	@MapsId(value = "fighterId")
	@JsonIgnore
	private Fighter fighter;
	
	@ManyToOne(cascade = {CascadeType.PERSIST})
	@JoinColumn(name = "defense_token_id")
	@MapsId(value = "defenseId")
	private DefenseToken defenseToken;

	//CONSTRUCTORS
	
	public FighterDefenseToken() {
		super();
	}

	public FighterDefenseToken(FighterDefenseTokenId id, int amount, Fighter fighter, DefenseToken defenseToken) {
		super();
		this.id = id;
		this.amount = amount;
		this.fighter = fighter;
		this.defenseToken = defenseToken;
	}
	
	//METHODS

	public FighterDefenseTokenId getId() {
		return id;
	}

	public void setId(FighterDefenseTokenId id) {
		this.id = id;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public Fighter getFighter() {
		return fighter;
	}

	public void setFighter(Fighter fighter) {
		this.fighter = fighter;
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
		result = prime * result + ((fighter == null) ? 0 : fighter.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
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
		FighterDefenseToken other = (FighterDefenseToken) obj;
		if (amount != other.amount)
			return false;
		if (defenseToken == null) {
			if (other.defenseToken != null)
				return false;
		} else if (!defenseToken.equals(other.defenseToken))
			return false;
		if (fighter == null) {
			if (other.fighter != null)
				return false;
		} else if (!fighter.equals(other.fighter))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "FighterDefenseToken [id=" + id + ", amount=" + amount + ", fighter=" + fighter + ", defenseToken="
				+ defenseToken + "]";
	}
	
	

}

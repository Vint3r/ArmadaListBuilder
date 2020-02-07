package com.skilldistillery.armadasite.entities;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "list_fighter")
public class ListFighter {

	// FIELDS

	@EmbeddedId
	private ListFighterId id;
	private int amount;

	// RELATIONSHIPS

	@ManyToOne
	@JoinColumn(name = "fighter_id")
	@MapsId(value = "fighterId")
	private Fighter fighter;

	@ManyToOne
	@JoinColumn(name = "list_id")
	@MapsId(value = "listId")
	private ListBuild list;

	//CONSTRUCTORS
	
	public ListFighter() {
		super();
	}

	public ListFighter(ListFighterId id, int amount, Fighter fighter, ListBuild list) {
		super();
		this.id = id;
		this.amount = amount;
		this.fighter = fighter;
		this.list = list;
	}

	//METHODS
	
	public ListFighterId getId() {
		return id;
	}

	public void setId(ListFighterId id) {
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

	public ListBuild getList() {
		return list;
	}

	public void setList(ListBuild list) {
		this.list = list;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + amount;
		result = prime * result + ((fighter == null) ? 0 : fighter.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((list == null) ? 0 : list.hashCode());
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
		ListFighter other = (ListFighter) obj;
		if (amount != other.amount)
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
		if (list == null) {
			if (other.list != null)
				return false;
		} else if (!list.equals(other.list))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ListFighter [id=" + id + ", amount=" + amount + ", fighter=" + fighter + ", list=" + list + "]";
	}

}

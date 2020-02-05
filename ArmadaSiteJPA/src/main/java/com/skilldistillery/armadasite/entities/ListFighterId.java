package com.skilldistillery.armadasite.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ListFighterId implements Serializable {
	private static final long serialVersionUID = 1L;
	
	//FIELDS
	
	@Column(name = "fighter_id")
	private int fighterId;
	@Column(name = "list_id")
	private int listId;
	
	//CONSTRUCTORS
	
	public ListFighterId() {
		super();
	}

	public ListFighterId(int fighterId, int listId) {
		super();
		this.fighterId = fighterId;
		this.listId = listId;
	}

	//METHODS
	
	public int getFighterId() {
		return fighterId;
	}

	public void setFighterId(int fighterId) {
		this.fighterId = fighterId;
	}

	public int getListId() {
		return listId;
	}

	public void setListId(int listId) {
		this.listId = listId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + fighterId;
		result = prime * result + listId;
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
		ListFighterId other = (ListFighterId) obj;
		if (fighterId != other.fighterId)
			return false;
		if (listId != other.listId)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ListFighterId [fighterId=" + fighterId + ", listId=" + listId + "]";
	}

}

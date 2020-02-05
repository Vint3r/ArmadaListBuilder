package com.skilldistillery.armadasite.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Speed {
	
	//FIELDS
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "speed_one")
	private String speedOne;
	@Column(name = "speed_two")
	private String speedTwo;
	@Column(name = "speed_three")
	private String speedThree;
	@Column(name = "speed_four")
	private String speedFour;
	
	//CONSTRUCTORS
	
	public Speed() {
		super();
	}
	
	public Speed(int id, String speedOne, String speedTwo, String speedThree, String speedFour) {
		super();
		this.id = id;
		this.speedOne = speedOne;
		this.speedTwo = speedTwo;
		this.speedThree = speedThree;
		this.speedFour = speedFour;
	}
	
	//METHODS

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSpeedOne() {
		return speedOne;
	}
	public void setSpeedOne(String speedOne) {
		this.speedOne = speedOne;
	}
	public String getSpeedTwo() {
		return speedTwo;
	}
	public void setSpeedTwo(String speedTwo) {
		this.speedTwo = speedTwo;
	}
	public String getSpeedThree() {
		return speedThree;
	}
	public void setSpeedThree(String speedThree) {
		this.speedThree = speedThree;
	}
	public String getSpeedFour() {
		return speedFour;
	}
	public void setSpeedFour(String speedFour) {
		this.speedFour = speedFour;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result + ((speedFour == null) ? 0 : speedFour.hashCode());
		result = prime * result + ((speedOne == null) ? 0 : speedOne.hashCode());
		result = prime * result + ((speedThree == null) ? 0 : speedThree.hashCode());
		result = prime * result + ((speedTwo == null) ? 0 : speedTwo.hashCode());
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
		Speed other = (Speed) obj;
		if (id != other.id)
			return false;
		if (speedFour == null) {
			if (other.speedFour != null)
				return false;
		} else if (!speedFour.equals(other.speedFour))
			return false;
		if (speedOne == null) {
			if (other.speedOne != null)
				return false;
		} else if (!speedOne.equals(other.speedOne))
			return false;
		if (speedThree == null) {
			if (other.speedThree != null)
				return false;
		} else if (!speedThree.equals(other.speedThree))
			return false;
		if (speedTwo == null) {
			if (other.speedTwo != null)
				return false;
		} else if (!speedTwo.equals(other.speedTwo))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Speed [id=" + id + ", speedOne=" + speedOne + ", speedTwo=" + speedTwo + ", speedThree=" + speedThree
				+ ", speedFour=" + speedFour + "]";
	}
	

}

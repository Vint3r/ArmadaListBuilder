package com.skilldistillery.armadasite.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@Table(name = "list")
public class ListBuild {

	//FIELDS
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	@Column(name = "desired_cost")
	private int desiredCost;
	@Column(name = "actual_cost")
	private int actualCost;
	@Column(name = "point_sway")
	private int pointSway;
	
	//RELATIONSHIPS
	
	@OneToMany(mappedBy = "list")
	@JsonIgnoreProperties({"list"})
	private List<ListFighter> fighters;
	
	@ManyToMany
	@JoinTable(name = "list_ship", joinColumns = @JoinColumn(name = "list_id"), inverseJoinColumns = @JoinColumn(name = "ship_build_id"))
	private List<ShipBuild> shipBuilds;
	
	@ManyToMany(mappedBy = "lists")
	@JsonIgnore
	private List<User> users;

	//CONSTRUCTORS
	
	public ListBuild() {
		super();
	}

	public ListBuild(int id, String name, int desiredCost, int actualCost, int pointSway, List<ListFighter> fighters,
			List<ShipBuild> shipBuilds, List<User> users) {
		super();
		this.id = id;
		this.name = name;
		this.desiredCost = desiredCost;
		this.actualCost = actualCost;
		this.fighters = fighters;
		this.shipBuilds = shipBuilds;
		this.users = users;
		this.pointSway = pointSway;
	}


	//METHODS

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPointSway() {
		return pointSway;
	}

	public void setPointSway(int pointSway) {
		this.pointSway = pointSway;
	}

	public int getDesiredCost() {
		return desiredCost;
	}

	public void setDesiredCost(int desiredCost) {
		this.desiredCost = desiredCost;
	}

	public int getActualCost() {
		return actualCost;
	}

	public void setActualCost(int actualCost) {
		this.actualCost = actualCost;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<ListFighter> getFighters() {
		return fighters;
	}

	public void setFighters(List<ListFighter> fighters) {
		this.fighters = fighters;
	}

	public List<ShipBuild> getShipBuilds() {
		return shipBuilds;
	}

	public void setShipBuilds(List<ShipBuild> shipBuilds) {
		this.shipBuilds = shipBuilds;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + actualCost;
		result = prime * result + desiredCost;
		result = prime * result + ((fighters == null) ? 0 : fighters.hashCode());
		result = prime * result + id;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + pointSway;
		result = prime * result + ((users == null) ? 0 : users.hashCode());
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
		ListBuild other = (ListBuild) obj;
		if (actualCost != other.actualCost)
			return false;
		if (desiredCost != other.desiredCost)
			return false;
		if (fighters == null) {
			if (other.fighters != null)
				return false;
		} else if (!fighters.equals(other.fighters))
			return false;
		if (id != other.id)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (pointSway != other.pointSway)
			return false;
		if (shipBuilds == null) {
			if (other.shipBuilds != null)
				return false;
		} else if (!shipBuilds.equals(other.shipBuilds))
			return false;
		if (users == null) {
			if (other.users != null)
				return false;
		} else if (!users.equals(other.users))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ListBuild [id=" + id + ", name=" + name + ", desiredCost=" + desiredCost + ", actualCost=" + actualCost
				+ ", pointSway=" + "]";
	}
	
	public void addListFighter(ListFighter fighter) {
		if (fighters == null) {
			fighters = new ArrayList<>();
		}
		
		if (!fighters.contains(fighter)) {
			fighters.add(fighter);
			if (fighter.getList() != null) {
				fighter.getList().getFighters().remove(fighter);
			}
			fighter.setList(this);
		}
	}
	
	public void removeListFighter(ListFighter fighter) {
		fighter.setFighter(null);
		if (fighters != null) {
			fighters.remove(fighter);
		}
	}
	
	public void addShipBuild(ShipBuild ship) {
		if (shipBuilds == null) {
			shipBuilds = new ArrayList<>();
		}

		if (!shipBuilds.contains(ship)) {
			shipBuilds.add(ship);
			ship.addList(this);
		}
	}

	public void removeShipBuild(ShipBuild ship) {
		if (shipBuilds != null && shipBuilds.contains(ship)) {
			shipBuilds.remove(ship);
			ship.removeList(this);
		}
	}
	
	public void addUser(User user) {
		if (users == null) {
			users = new ArrayList<>();
		}

		if (!users.contains(user)) {
			users.add(user);
			user.addList(this);
		}
	}

	public void removeUser(User user) {
		if (users != null && users.contains(user)) {
			users.remove(user);
			user.removeList(this);
		}
	}
}

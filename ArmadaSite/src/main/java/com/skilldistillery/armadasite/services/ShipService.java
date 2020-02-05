package com.skilldistillery.armadasite.services;

import java.util.List;

import com.skilldistillery.armadasite.entities.Ship;

public interface ShipService {
	
	public List<Ship> getAllShips();
	public Ship getShipById(int id);
	public List<Ship> getAllShipsByAlign(String align);
	public List<Ship> getAllShipsByClass(String keyword);
	public List<Ship> getAllShipsBelowCost(int cost);
	public List<Ship> getAllShipsByUpType(int upTypeId);

}

package com.skilldistillery.armadasite.services;

import java.util.List;

import com.skilldistillery.armadasite.entities.ShipBuild;

public interface ShipBuildService {

	public ShipBuild createShipBuild(ShipBuild ship);
	public ShipBuild updateShipBuild(ShipBuild ship);
	public boolean deleteShipBuild(int id);
	public ShipBuild getShipBuildById(int id);
	public List<ShipBuild> getAllShipBuilds();
	public List<ShipBuild> getAllShipBuildsByListId(int listId);
}

package com.skilldistillery.armadasite.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.armadasite.entities.ShipBuild;

public interface ShipBuildRepository extends JpaRepository<ShipBuild, Integer> {
	
	public List<ShipBuild> findByListsId(int id);
}

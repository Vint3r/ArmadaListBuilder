package com.skilldistillery.armadasite.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.armadasite.entities.Ship;

public interface ShipRepository extends JpaRepository<Ship, Integer> {

	public List<Ship> findByAlignmentOrderByCost(String align);
	public List<Ship> findByNameLikeOrderByCost(String keyword);
	public List<Ship> findByCostLessThanEqualOrderByCost(int cost);
	public List<Ship> findByUpgradeTypes_UpgradeType_Id(int id);
}

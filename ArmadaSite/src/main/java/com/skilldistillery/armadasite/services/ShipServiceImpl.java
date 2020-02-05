package com.skilldistillery.armadasite.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.armadasite.entities.Ship;
import com.skilldistillery.armadasite.repositories.ShipRepository;

@Service
public class ShipServiceImpl implements ShipService{
	
	@Autowired
	private ShipRepository shipRepo;

	@Override
	public List<Ship> getAllShips() {
		return shipRepo.findAll();
	}

	@Override
	public Ship getShipById(int id) {
		Ship ship = null;
		
		Optional<Ship> temp = shipRepo.findById(id);
		
		if(temp.isPresent()) {
			ship = temp.get();
		}
		
		return ship;
	}

	@Override
	public List<Ship> getAllShipsByAlign(String align) {
		return shipRepo.findByAlignmentOrderByCost(align);
	}

	@Override
	public List<Ship> getAllShipsByClass(String keyword) {
		String key = "%" + keyword + "%";
		return shipRepo.findByNameLikeOrderByCost(key);
	}

	@Override
	public List<Ship> getAllShipsBelowCost(int cost) {
		return shipRepo.findByCostLessThanEqualOrderByCost(cost);
	}

	@Override
	public List<Ship> getAllShipsByUpType(int upTypeId) {
		return shipRepo.findByUpgradeTypes_UpgradeType_Id(upTypeId);
	}

}

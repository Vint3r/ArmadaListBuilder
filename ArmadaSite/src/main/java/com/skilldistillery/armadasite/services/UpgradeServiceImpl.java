package com.skilldistillery.armadasite.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.armadasite.entities.Upgrade;
import com.skilldistillery.armadasite.repositories.UpgradeRepository;

@Service
public class UpgradeServiceImpl implements UpgradeService {
	
	@Autowired
	private UpgradeRepository upgradeRepo;

	@Override
	public List<Upgrade> getAllUpgrades() {
		return upgradeRepo.findAll();
	}

	@Override
	public Upgrade getUpgradeById(int id) {
		Upgrade upgrade = null;
		
		Optional<Upgrade> temp = upgradeRepo.findById(id);
		
		if(temp.isPresent()) {
			upgrade = temp.get();
		}
		
		return upgrade;
	}

	@Override
	public List<Upgrade> getUpgradeByType(int upTypeId) {
		return upgradeRepo.findByType_Id(upTypeId);
	}

}
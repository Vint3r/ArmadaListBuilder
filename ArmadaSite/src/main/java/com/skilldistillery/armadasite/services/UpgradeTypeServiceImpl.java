package com.skilldistillery.armadasite.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.armadasite.entities.UpgradeType;
import com.skilldistillery.armadasite.repositories.UpgradeTypeRepository;

@Service
public class UpgradeTypeServiceImpl implements UpgradeTypeService {

	@Autowired
	private UpgradeTypeRepository upTypeRepo;
	
	@Override
	public List<UpgradeType> getAllUpgradeTypes() {
		return upTypeRepo.findAll();
	}

	@Override
	public UpgradeType getUpgradeTypeById(int id) {
		UpgradeType upType = null;
		
		Optional<UpgradeType> temp = upTypeRepo.findById(id);
		
		if(temp.isPresent()) {
			upType = temp.get();
		}
		
		return upType;
	}

}

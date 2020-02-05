package com.skilldistillery.armadasite.services;

import java.util.List;

import com.skilldistillery.armadasite.entities.UpgradeType;

public interface UpgradeTypeService {

	public List<UpgradeType> getAllUpgradeTypes();
	public UpgradeType getUpgradeTypeById(int id);
}

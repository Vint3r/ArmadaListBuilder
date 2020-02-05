package com.skilldistillery.armadasite.services;

import java.util.List;

import com.skilldistillery.armadasite.entities.Upgrade;

public interface UpgradeService {

	public List<Upgrade> getAllUpgrades();
	public Upgrade getUpgradeById(int id);
	public List<Upgrade> getUpgradeByType(int upTypeId);
}

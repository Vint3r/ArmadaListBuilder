package com.skilldistillery.armadasite.services;

import java.util.List;

import com.skilldistillery.armadasite.entities.Fighter;

public interface FighterService {

	public List<Fighter> getAllFighters();
	public Fighter getFighterById(int id);
	public List<Fighter> getAllFightersByAlign(String align);
	public List<Fighter> getAllFightersByName(String keyword);
	public List<Fighter> getFightersByCardKey(int keyId);
	public List<Fighter> getFightersByCost(int cost);
}

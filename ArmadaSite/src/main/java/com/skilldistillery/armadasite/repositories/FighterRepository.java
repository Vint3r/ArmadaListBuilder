package com.skilldistillery.armadasite.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.armadasite.entities.Fighter;

public interface FighterRepository extends JpaRepository<Fighter, Integer> {

	public List<Fighter> findByAlignmentLikeOrderByCost(String keyword);
	public List<Fighter> findByNameLikeOrModelLikeOrderByCost(String keyName, String keyModel);
	public List<Fighter> findByKeywordsIdOrderByCost(int id);
	public List<Fighter> findByCostLessThanEqualOrderByCost(int cost);
}

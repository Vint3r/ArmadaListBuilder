package com.skilldistillery.armadasite.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.armadasite.entities.Upgrade;

public interface UpgradeRepository extends JpaRepository<Upgrade, Integer> {

	public List<Upgrade> findByType_Id(int id);
}

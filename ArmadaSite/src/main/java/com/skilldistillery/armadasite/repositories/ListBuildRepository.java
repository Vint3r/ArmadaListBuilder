package com.skilldistillery.armadasite.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.armadasite.entities.ListBuild;

public interface ListBuildRepository extends JpaRepository<ListBuild, Integer> {

	public List<ListBuild> findByUsersId(int id);
}

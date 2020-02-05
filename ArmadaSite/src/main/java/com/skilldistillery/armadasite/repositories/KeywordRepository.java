package com.skilldistillery.armadasite.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.armadasite.entities.Keyword;

public interface KeywordRepository extends JpaRepository<Keyword, Integer> {

}

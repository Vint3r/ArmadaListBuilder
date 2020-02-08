package com.skilldistillery.armadasite.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.armadasite.entities.ListFighter;
import com.skilldistillery.armadasite.entities.ListFighterId;

public interface ListFighterRepository extends JpaRepository<ListFighter, ListFighterId> {

}

package com.skilldistillery.armadasite.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.armadasite.entities.DefenseToken;

public interface DefenseTokenRepository extends JpaRepository <DefenseToken, Integer> {

}

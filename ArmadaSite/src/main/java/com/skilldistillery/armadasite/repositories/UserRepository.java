package com.skilldistillery.armadasite.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.armadasite.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

}

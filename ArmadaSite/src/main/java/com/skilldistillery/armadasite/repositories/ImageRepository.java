package com.skilldistillery.armadasite.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.armadasite.entities.Image;

public interface ImageRepository extends JpaRepository<Image, Integer> {

}

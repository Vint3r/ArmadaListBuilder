package com.skilldistillery.armadasite.services;

import java.util.List;

import com.skilldistillery.armadasite.entities.Image;

public interface ImageService {

	public List<Image> getAllImages();
	public Image getImageById(int id);
}

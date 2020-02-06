package com.skilldistillery.armadasite.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.armadasite.entities.Image;
import com.skilldistillery.armadasite.services.ImageService;

@RestController
@RequestMapping("api/image")
@CrossOrigin({ "*", "http://localhost:4400" })
public class ImageController {

	@Autowired
	private ImageService imageSvc;
	
	@GetMapping
	private List<Image> index() {
		return imageSvc.getAllImages();
	}
	
	@GetMapping("{id}")
	private Image show(@PathVariable int id, HttpServletResponse response) {
		Image img = null;

		try {
			img = imageSvc.getImageById(id);

			if (img == null) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return img;
	}
	
}

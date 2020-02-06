package com.skilldistillery.armadasite.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.armadasite.entities.ShipBuild;
import com.skilldistillery.armadasite.services.ShipBuildService;

@RestController
@RequestMapping("api/shipbuild")
@CrossOrigin({ "*", "http://localhost:4400" })
public class ShipBuildController {

	@Autowired
	private ShipBuildService buildSvc;
	
	@GetMapping
	private List<ShipBuild> index() {
		return buildSvc.getAllShipBuilds();
	}
	
	@GetMapping("{id}")
	private ShipBuild show(@PathVariable int id, HttpServletResponse response) {
		ShipBuild build = null;

		try {
			build = buildSvc.getShipBuildById(id);

			if (build == null) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return build;
	}
}

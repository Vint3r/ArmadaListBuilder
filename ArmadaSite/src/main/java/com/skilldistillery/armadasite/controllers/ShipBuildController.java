package com.skilldistillery.armadasite.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	@GetMapping("list/{lid}")
	private List<ShipBuild> indexShipBuildsForList(@PathVariable int lid, HttpServletResponse response) {
		List<ShipBuild> builds = null;
		
		try {
			builds = buildSvc.getAllShipBuildsByListId(lid);
			
			if(builds == null) {
				response.setStatus(404);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}
		
		return builds;
	}
	
	@PostMapping("update/{id}")
	private ShipBuild updateShipBuild(@PathVariable int id, @RequestBody ShipBuild build, HttpServletResponse response) {
		ShipBuild updatedBuild = null;

		try {
			updatedBuild = buildSvc.updateShipBuild(id, build);

			if (updatedBuild == null) {
				response.setStatus(404);
				return null;
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return updatedBuild;
	}

	@PutMapping("create")
	private ShipBuild createShipBuild(@RequestBody ShipBuild build, HttpServletResponse response,
			HttpServletRequest request) {
		ShipBuild created = null;
		try {
			created = buildSvc.createShipBuild(build);

			if (created != null) {
				response.setStatus(201);
				StringBuffer url = request.getRequestURL();

				url.append("/").append(created.getId());

				response.addHeader("Location", url.toString());
			} else {
				response.setStatus(404);
				return null;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return created;
	}

	@DeleteMapping("delete/{id}")
	private void deleteShipBuild(@PathVariable int id, HttpServletResponse response) {
		try {
			if (buildSvc.deleteShipBuild(id)) {
				response.setStatus(204);
			} else {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
		}
	}
}

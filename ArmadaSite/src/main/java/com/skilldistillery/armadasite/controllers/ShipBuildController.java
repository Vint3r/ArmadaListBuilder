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
	private ShipBuild show(@PathVariable String id, HttpServletResponse response) {
		ShipBuild build = null;

		try {
			
			int intId = Integer.parseInt(id);
			build = buildSvc.getShipBuildById(intId);

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
	private List<ShipBuild> indexShipBuildsForList(@PathVariable String lid, HttpServletResponse response) {
		List<ShipBuild> builds = null;
		
		try {
			
			int intId = Integer.parseInt(lid);
			builds = buildSvc.getAllShipBuildsByListId(intId);
			
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
	private ShipBuild updateShipBuild(@PathVariable String id, @RequestBody ShipBuild build, HttpServletResponse response) {
		ShipBuild updatedBuild = null;

		try {
			
			int intId = Integer.parseInt(id);
			updatedBuild = buildSvc.updateShipBuild(intId, build);

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
	private void deleteShipBuild(@PathVariable String id, HttpServletResponse response) {
		try {
			
			int intId = Integer.parseInt(id);
			
			if (buildSvc.deleteShipBuild(intId)) {
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

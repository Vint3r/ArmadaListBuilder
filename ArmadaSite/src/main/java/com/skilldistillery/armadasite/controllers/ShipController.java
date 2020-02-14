package com.skilldistillery.armadasite.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.armadasite.entities.Ship;
import com.skilldistillery.armadasite.services.ShipService;

@RestController
@RequestMapping("api/ship")
@CrossOrigin({ "*", "http://localhost:4400" })
public class ShipController {

	@Autowired
	private ShipService shipSvc;

	@GetMapping
	private List<Ship> index() {
		return shipSvc.getAllShips();
	}

	@GetMapping("{id}")
	private Ship show(@PathVariable String id, HttpServletResponse response) {
		Ship ship = null;

		try {
			
			int intId = Integer.parseInt(id);
			ship = shipSvc.getShipById(intId);

			if (ship == null) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return ship;
	}

	@GetMapping("alignment/{align}")
	private List<Ship> indexByAlignment(@PathVariable String align, HttpServletResponse response) {
		List<Ship> ships = null;

		try {
			ships = shipSvc.getAllShipsByAlign(align);

			if (ships == null || ships.size() <= 0) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return ships;
	}

	@GetMapping("class/{keyword}")
	private List<Ship> indexByClass(@PathVariable String keyword, HttpServletResponse response) {
		List<Ship> ships = null;

		try {
			ships = shipSvc.getAllShipsByClass(keyword);

			if (ships == null || ships.size() <= 0) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return ships;
	}

	@GetMapping("cost/{cost}")
	private List<Ship> indexByCost(@PathVariable String cost, HttpServletResponse response) {
		List<Ship> ships = null;

		try {
			
			int intCost = Integer.parseInt(cost);
			ships = shipSvc.getAllShipsBelowCost(intCost);

			if (ships == null || ships.size() <= 0) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return ships;
	}

	@GetMapping("upgradetype/{id}")
	private List<Ship> indexByUpgradeType(@PathVariable String id, HttpServletResponse response) {
		List<Ship> ships = null;

		try {
			
			int intId = Integer.parseInt(id);
			ships = shipSvc.getAllShipsByUpType(intId);

			if (ships == null || ships.size() <= 0) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return ships;
	}
}

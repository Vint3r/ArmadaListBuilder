package com.skilldistillery.armadasite.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.armadasite.entities.Upgrade;
import com.skilldistillery.armadasite.services.UpgradeService;

@RestController
@RequestMapping("api/upgrade")
@CrossOrigin({ "*", "http://localhost:4400" })
public class UpgradeController {

	@Autowired
	private UpgradeService upgradeSvc;

	@GetMapping
	private List<Upgrade> index() {
		return upgradeSvc.getAllUpgrades();
	}

	@GetMapping("{id}")
	private Upgrade show(@PathVariable String id, HttpServletResponse response) {
		Upgrade upgrade = null;

		try {
			
			int intId = Integer.parseInt(id);
			upgrade = upgradeSvc.getUpgradeById(intId);

			if (upgrade == null) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return upgrade;
	}

	@GetMapping("upgradetype/{id}")
	private List<Upgrade> indexByUpgradeType(@PathVariable String id, HttpServletResponse response) {
		List<Upgrade> upgrade = null;

		try {
			
			int intId = Integer.parseInt(id);
			upgrade = upgradeSvc.getUpgradeByType(intId);

			if (upgrade == null) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return upgrade;
	}
}

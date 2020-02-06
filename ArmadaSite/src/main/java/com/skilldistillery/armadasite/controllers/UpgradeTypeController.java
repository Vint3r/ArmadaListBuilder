package com.skilldistillery.armadasite.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.armadasite.entities.UpgradeType;
import com.skilldistillery.armadasite.services.UpgradeTypeService;

@RestController
@RequestMapping("api/upgradetype")
@CrossOrigin({ "*", "http://localhost:4400" })
public class UpgradeTypeController {
	
	@Autowired
	private UpgradeTypeService upTypeSvc;
	
	@GetMapping
	private List<UpgradeType> index() {
		return upTypeSvc.getAllUpgradeTypes();
	}
	
	@GetMapping("{id}")
	private UpgradeType show(@PathVariable int id, HttpServletResponse response) {
		UpgradeType upType = null;

		try {
			upType = upTypeSvc.getUpgradeTypeById(id);

			if (upType == null) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return upType;
	}

}

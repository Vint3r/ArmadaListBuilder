package com.skilldistillery.armadasite.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.armadasite.entities.Fighter;
import com.skilldistillery.armadasite.services.FighterService;

@RestController
@RequestMapping("api/fighter")
@CrossOrigin({ "*", "http://localhost:4400" })
public class FighterController {

	@Autowired
	private FighterService fighterSvc;

	@GetMapping
	private List<Fighter> index() {
		return fighterSvc.getAllFighters();
	}

	@GetMapping("{id}")
	private Fighter show(@PathVariable String id, HttpServletResponse response) {
		Fighter fighter = null;

		try {
			int idInt = Integer.parseInt(id);
			fighter = fighterSvc.getFighterById(idInt);

			if (fighter == null) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return fighter;
	}

	@GetMapping("alignment/{align}")
	private List<Fighter> indexByAlignment(@PathVariable String align, HttpServletResponse response) {
		List<Fighter> fighters = null;

		try {
			fighters = fighterSvc.getAllFightersByAlign(align);

			if (fighters == null || fighters.size() <= 0) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return fighters;
	}

	@GetMapping("n&m/{keyword}")
	private List<Fighter> indexByNameOrModel(@PathVariable String keyword, HttpServletResponse response) {
		List<Fighter> fighters = null;

		try {
			fighters = fighterSvc.getAllFightersByName(keyword);

			if (fighters == null || fighters.size() <= 0) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return fighters;
	}

	@GetMapping("key/{keywordId}")
	private List<Fighter> indexByKeyword(@PathVariable String keywordId, HttpServletResponse response) {
		List<Fighter> fighters = null;

		try {
			int keyId = Integer.parseInt(keywordId);
			fighters = fighterSvc.getFightersByCardKey(keyId);

			if (fighters == null || fighters.size() <= 0) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return fighters;
	}

	@GetMapping("cost/{cost}")
	private List<Fighter> indexByCost(@PathVariable String cost, HttpServletResponse response) {
		List<Fighter> fighters = null;

		try {
			int costInt = Integer.parseInt(cost);
			fighters = fighterSvc.getFightersByCost(costInt);

			if (fighters == null || fighters.size() <= 0) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return fighters;
	}
}

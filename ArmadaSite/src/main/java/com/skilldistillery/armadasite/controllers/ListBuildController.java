package com.skilldistillery.armadasite.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.armadasite.entities.ListBuild;
import com.skilldistillery.armadasite.services.ListBuildService;

@RestController
@RequestMapping("api/list")
@CrossOrigin({ "*", "http://localhost:4400" })
public class ListBuildController {

	@Autowired
	private ListBuildService listSvc;
	
	@GetMapping
	private List<ListBuild> index() {
		return listSvc.getAllLists();
	}
	
	@GetMapping("{id}")
	private ListBuild show(@PathVariable int id, HttpServletResponse response) {
		ListBuild list = null;

		try {
			list= listSvc.getListById(id);

			if (list == null) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return list;
	}
}

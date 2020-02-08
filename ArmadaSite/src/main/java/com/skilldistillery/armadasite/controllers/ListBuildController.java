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
	private ListBuild show(@PathVariable String id, HttpServletResponse response) {
		ListBuild list = null;

		try {
			int listId = Integer.parseInt(id);
			list = listSvc.getListById(listId);

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

	@GetMapping("user/{uid}")
	private List<ListBuild> indexListsForUser(@PathVariable String uid, HttpServletResponse response) {
		List<ListBuild> lists = null;

		try {
			int userId = Integer.parseInt(uid);
			lists = listSvc.getAllListsByUser(userId);

			if (lists == null) {
				response.setStatus(404);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return lists;
	}

	@GetMapping("user/{uid}/{lid}")
	private ListBuild showSingleForUser(@PathVariable String uid, @PathVariable String lid, HttpServletResponse response) {
		ListBuild list = null;

		try {
			int userId = Integer.parseInt(uid);
			int listId = Integer.parseInt(lid);
			list = listSvc.getSingleListByUser(listId, userId);

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

	@PostMapping("update/{id}")
	private ListBuild updateList(@PathVariable String id, @RequestBody ListBuild list, HttpServletResponse response) {
		ListBuild updatedList = null;

		try {
//			list = listSvc.updateFightersForList(list);
			int listId = Integer.parseInt(id);
			updatedList = listSvc.updateList(listId, list);

			if (updatedList == null) {
				response.setStatus(404);
				return null;
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(400);
			return null;
		}

		return updatedList;
	}

	@PutMapping("create")
	private ListBuild createList(@RequestBody ListBuild list, HttpServletResponse response,
			HttpServletRequest request) {
		ListBuild created = null;
		try {
			created = listSvc.createList(list);

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
	private void deleteList(@PathVariable String id, HttpServletResponse response) {
		try {
			int listId = Integer.parseInt(id);
			
			if (listSvc.deleteList(listId)) {
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

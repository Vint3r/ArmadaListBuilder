package com.skilldistillery.armadasite.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.armadasite.entities.ListBuild;
import com.skilldistillery.armadasite.repositories.ListBuildRepository;

@Service
public class ListBuildServiceImpl implements ListBuildService {

	@Autowired
	private ListBuildRepository listRepo;
	
	@Override
	public ListBuild createList(ListBuild list) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ListBuild updateList(ListBuild list) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteList(ListBuild list) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<ListBuild> getAllLists() {
		return listRepo.findAll();
	}

	@Override
	public List<ListBuild> getAllListsByUser(int userId) {
		return listRepo.findByUsersId(userId);
	}

	@Override
	public ListBuild getSingleListByUser(int listId, int userId) {
		List<ListBuild> lists = listRepo.findByUsersId(userId);
		ListBuild result = null;
		
		for (ListBuild listBuild : lists) {
			if(listBuild.getId() == listId) {
				result = listBuild;
				break;
			}
		}
		
		return result;
	}

	@Override
	public ListBuild getListById(int id) {
		ListBuild result = null;
		
		Optional<ListBuild> temp = listRepo.findById(id);
		
		if(temp.isPresent()) {
			result = temp.get();
		}
		
		return result;
	}

}

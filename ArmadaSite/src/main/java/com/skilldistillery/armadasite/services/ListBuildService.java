package com.skilldistillery.armadasite.services;

import java.util.List;

import com.skilldistillery.armadasite.entities.ListBuild;
import com.skilldistillery.armadasite.entities.ListFighter;

public interface ListBuildService {
	
	public ListBuild createList(ListBuild list);
	public ListBuild updateList(int id, ListBuild list);
	public boolean deleteList(int id);
	public List<ListBuild> getAllLists();
	public List<ListBuild> getAllListsByUser(int userId);
	public ListBuild getSingleListByUser(int listId, int userId);
	public ListBuild getListById(int id);
	public List<ListFighter> updateFightersForList(ListBuild toUpdate, ListBuild updatedTo);
}

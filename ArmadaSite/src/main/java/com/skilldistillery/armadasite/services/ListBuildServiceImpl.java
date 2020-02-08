package com.skilldistillery.armadasite.services;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.armadasite.entities.ListBuild;
import com.skilldistillery.armadasite.entities.ListFighter;
import com.skilldistillery.armadasite.repositories.ListBuildRepository;
import com.skilldistillery.armadasite.repositories.ListFighterRepository;

@Service
public class ListBuildServiceImpl implements ListBuildService {

	@Autowired
	private ListBuildRepository listRepo;
	
	@Autowired
	private ListFighterRepository fighterRepo;

	@Override
	public ListBuild createList(ListBuild list) {
		ListBuild result = null;
		try {
			result = listRepo.saveAndFlush(list);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	@Override
	public ListBuild updateList(int id, ListBuild list) {
		ListBuild toUpdate = null;

		Optional<ListBuild> toUpdateTemp = listRepo.findById(list.getId());
		if (toUpdateTemp.isPresent()) {
			toUpdate = toUpdateTemp.get();

			toUpdate.setActualCost(list.getActualCost());
			toUpdate.setPointSway(list.getPointSway());

			if (list.getFighters() != null && list.getFighters().size() > 0) {
				System.out.println(toUpdate.getFighters());
				System.out.println(list.getFighters());
				toUpdate.setFighters(updateFightersForList(toUpdate, list));
				toUpdate.setFighters(list.getFighters());
				System.out.println(toUpdate.getFighters());
			}

			if (list.getShipBuilds() != null && list.getShipBuilds().size() > 0) {
				toUpdate.setShipBuilds(list.getShipBuilds());
			}

			if (list.getDesiredCost() > 0) {
				toUpdate.setDesiredCost(list.getDesiredCost());
			}

			if (list.getName() != null) {
				toUpdate.setName(list.getName());
			}

			listRepo.saveAndFlush(toUpdate);
		}

		return toUpdate;
	}

	@Override
	public boolean deleteList(int id) {
		boolean success = false;
		ListBuild listDel = null;

		Optional<ListBuild> temp = listRepo.findById(id);

		if (temp.isPresent()) {
			listDel = temp.get();

			try {
				listRepo.delete(listDel);
			} catch (Exception e) {
				e.printStackTrace();
				return success;
			}

			success = true;
		}

		return success;
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
			if (listBuild.getId() == listId) {
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

		if (temp.isPresent()) {
			result = temp.get();
		}

		return result;
	}

	public List<ListFighter> updateFightersForList(ListBuild toUpdate, ListBuild updateTo) {
		Comparator<ListFighter> compareById = (ListFighter o1,
				ListFighter o2) -> o1.getId().hashCode() > o2.getId().hashCode() ? -1 : 1;

		Collections.sort(updateTo.getFighters(), compareById);
		Collections.sort(toUpdate.getFighters(), compareById);

		for (int i = 0; i < updateTo.getFighters().size(); i++) {
			System.out.println(updateTo);
			
			if (toUpdate.getFighters().size() > i) {
				if (updateTo.getFighters().get(i).getId().getFighterId() != toUpdate.getFighters().get(i).getId().getFighterId()) {
					updateTo.getFighters().get(i).setList(updateTo);
					fighterRepo.saveAndFlush(updateTo.getFighters().get(i));
				}
			} else {
				fighterRepo.saveAndFlush(updateTo.getFighters().get(i));
			}
		}

		return updateTo.getFighters();
	}
}

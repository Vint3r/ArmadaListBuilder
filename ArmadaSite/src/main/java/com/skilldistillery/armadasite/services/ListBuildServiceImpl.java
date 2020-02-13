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
import com.skilldistillery.armadasite.repositories.ShipBuildRepository;

@Service
public class ListBuildServiceImpl implements ListBuildService {

	@Autowired
	private ListBuildRepository listRepo;

	@Autowired
	private ListFighterRepository fighterRepo;

	@Autowired
	private ShipBuildRepository shipRepo;

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

				for (int i = 0; i < list.getFighters().size(); i++) {
					list.getFighters().get(i).setList(list);

					if (i < toUpdate.getFighters().size()) {
						fighterRepo.delete(toUpdate.getFighters().get(i));
						toUpdate.removeListFighter(toUpdate.getFighters().get(i));
					}

					try {
						fighterRepo.saveAndFlush(list.getFighters().get(i));
					} catch (Exception e) {
						e.printStackTrace();
						return null;
					}
				}
				toUpdate.setFighters(list.getFighters());
			}

			if (list.getShipBuilds() != null && list.getShipBuilds().size() > 0) {
				System.out.println("IN THE IF");
				toUpdate.setShipBuilds(list.getShipBuilds());

				for (int i = 0; i < toUpdate.getShipBuilds().size(); i++) {
					toUpdate.getShipBuilds().get(i).addList(list);

					try {
						shipRepo.saveAndFlush(toUpdate.getShipBuilds().get(i));
					} catch (Exception e) {
						e.printStackTrace();
						return null;
					}
				}

			}

			if (list.getDesiredCost() > 0) {
				toUpdate.setDesiredCost(list.getDesiredCost());
			}

			if (list.getName() != null) {
				toUpdate.setName(list.getName());
			}

			try {
				listRepo.saveAndFlush(toUpdate);
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
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
				
				for (int i = 0; i < listDel.getFighters().size(); i++) {
					fighterRepo.delete(listDel.getFighters().get(i));
				}
				
				listDel.removeUser(listDel.getUsers().get(0));
				
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

	public List<ListFighter> updateFightersForList(ListBuild updateTo, ListBuild toUpdate) {
		Comparator<ListFighter> compareById = (ListFighter o1,
				ListFighter o2) -> o1.getId().hashCode() > o2.getId().hashCode() ? -1 : 1;

		Collections.sort(updateTo.getFighters(), compareById);
		Collections.sort(toUpdate.getFighters(), compareById);

		for (int i = 0; i < updateTo.getFighters().size(); i++) {

			if (toUpdate.getFighters().size() > i) {

				if (updateTo.getFighters().get(i).getId().getFighterId() != toUpdate.getFighters().get(i).getId()
						.getFighterId()) {
					toUpdate.removeListFighter(updateTo.getFighters().get(i));
				} else {
					updateTo.getFighters().get(i).setList(updateTo);
					fighterRepo.saveAndFlush(updateTo.getFighters().get(i));
				}

			} else {
				updateTo.getFighters().get(i).setList(updateTo);
				fighterRepo.saveAndFlush(updateTo.getFighters().get(i));
			}
		}

		return updateTo.getFighters();
	}
}

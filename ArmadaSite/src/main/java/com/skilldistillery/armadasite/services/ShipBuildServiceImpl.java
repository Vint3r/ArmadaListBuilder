package com.skilldistillery.armadasite.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.armadasite.entities.ShipBuild;
import com.skilldistillery.armadasite.repositories.ShipBuildRepository;

@Service
public class ShipBuildServiceImpl implements ShipBuildService {

	@Autowired
	private ShipBuildRepository buildRepo;

	@Override
	public ShipBuild createShipBuild(ShipBuild ship) {
		ShipBuild result = null;
		try {
			result = buildRepo.saveAndFlush(ship);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public ShipBuild updateShipBuild(int id, ShipBuild ship) {
		ShipBuild toUpdate = null;

		Optional<ShipBuild> temp = buildRepo.findById(ship.getId());
		if (temp.isPresent()) {
			toUpdate = temp.get();

			toUpdate.setUpgrades(ship.getUpgrades());
			
			if (ship.getShip() != null) {
				toUpdate.setShip(ship.getShip());
			}

			if (ship.getLists() != null && ship.getLists().size() > 0) {
				toUpdate.setLists(ship.getLists());
				;
			}

			if (!toUpdate.equals(ship)) {
				buildRepo.saveAndFlush(toUpdate);
			}
			
		}

		return toUpdate;
	}

	@Override
	public boolean deleteShipBuild(int id) {
		ShipBuild toDel = null;
		boolean success = false;

		Optional<ShipBuild> temp = buildRepo.findById(id);
		if (temp.isPresent()) {
			toDel = temp.get();

			try {
				buildRepo.delete(toDel);
			} catch (Exception e) {
				e.printStackTrace();
				return success;
			}

			success = true;
		}

		return success;
	}

	@Override
	public ShipBuild getShipBuildById(int id) {
		ShipBuild build = null;

		Optional<ShipBuild> temp = buildRepo.findById(id);

		if (temp.isPresent()) {
			build = temp.get();
		}

		return build;
	}

	@Override
	public List<ShipBuild> getAllShipBuilds() {
		return buildRepo.findAll();
	}

	@Override
	public List<ShipBuild> getAllShipBuildsByListId(int listId) {
		return buildRepo.findByListsId(listId);
	}

}

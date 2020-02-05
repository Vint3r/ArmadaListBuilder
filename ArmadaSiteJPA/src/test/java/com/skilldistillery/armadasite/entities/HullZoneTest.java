package com.skilldistillery.armadasite.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class HullZoneTest {
	
	private static EntityManagerFactory emf;
	private static EntityManager em;
	private HullZone hullZone;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("Armada");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		hullZone = em.find(HullZone.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		hullZone = null;
	}

	@Test
	@DisplayName("Testing basic HullZone fields")
	void testFields() {
		assertNotNull(hullZone);
		assertTrue(hullZone.getLocation().equals("Forward"));
		assertEquals(hullZone.getShields(), 4);
		assertEquals(hullZone.getAsBlack(), 2);
		assertEquals(hullZone.getAsBlue(), 3);
		assertEquals(hullZone.getAsRed(), 0);
	}
	
	@Test
	@DisplayName("Testing relationship between HullZone and Ship")
	void testShipRelationship() {
		assertNotNull(hullZone.getShips());
		assertTrue(hullZone.getShips().size() > 0);
		assertTrue(hullZone.getShips().get(0).getName().equals("MC-75 Armored Cruiser"));
		assertEquals(hullZone.getShips().get(0).getHull(), 9);
		assertEquals(hullZone.getShips().get(0).getCost(), 104);
	}

}

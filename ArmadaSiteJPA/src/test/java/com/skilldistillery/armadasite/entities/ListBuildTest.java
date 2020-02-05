package com.skilldistillery.armadasite.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class ListBuildTest {

	private static EntityManagerFactory emf;
	private static EntityManager em;
	private ListBuild list;

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
		list = em.find(ListBuild.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		list = null;
	}

	@Test
	@DisplayName("Testing basic fields in ListBuild class")
	void testFields() {
		assertNotNull(list);
		assertTrue(list.getName().equals("First Build"));
		assertEquals(list.getActualCost(), 354);
		assertEquals(list.getDesiredCost(), 500);
		assertEquals(list.getPointSway(), 15);
	}
	
	@Test
	@DisplayName("Testing relationship between ListBuild and Fighter")
	void testFighterRelationship() {
		assertNotNull(list.getFighters());
		assertEquals(list.getFighters().get(0).getAmount(), 1);
		assertTrue(list.getFighters().get(0).getFighter().getName().equals("Wedge Antillies"));
		assertEquals(list.getFighters().get(1).getAmount(), 5);
		assertTrue(list.getFighters().get(1).getFighter().getName().equals("X-Wing Squadron"));
	}
	
	@Test
	@DisplayName("Testing relationship between ListBuild and ShipBuild")
	void testShipBuildRelationship() {
		assertNotNull(list.getShipBuilds());
		assertEquals(list.getShipBuilds().get(0).getShip().getId(), 1);
		assertEquals(list.getShipBuilds().get(1).getShip().getId(), 3);
	}

}

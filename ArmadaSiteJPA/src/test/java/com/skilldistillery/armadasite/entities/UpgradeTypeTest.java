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
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class UpgradeTypeTest {

	private static EntityManagerFactory emf;
	private static EntityManager em;
	private UpgradeType type;

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
		type = em.find(UpgradeType.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		type = null;
	}

	@Test
	@DisplayName("Testing basic fields for UpgradeType")
	void testFields() {
		assertNotNull(type);
		assertTrue(type.getType().equals("Commander"));
	}
	
	@Test
	@DisplayName("Testing relationship between UpgradeType and ship")
	void testShipRelationship() {
		assertNotNull(type.getShips());
		assertTrue(type.getShips().get(0).getShip().getAlignment().equals("Rebel Alliance"));
		assertEquals(type.getShips().get(0).getShip().getCommand(), 3);
	}
	
	@Test
	@Disabled
	@DisplayName("Testing relationship between UpgradeType and Image")
	void testImageRelationship() {
		assertNotNull(type.getImage());
		assertTrue(type.getImage().getPhotoUrl().equals(""));
	}

}

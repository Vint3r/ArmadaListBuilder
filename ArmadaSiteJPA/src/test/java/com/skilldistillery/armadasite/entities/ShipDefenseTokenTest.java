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

class ShipDefenseTokenTest {

	private static EntityManagerFactory emf;
	private static EntityManager em;
	private ShipDefenseToken shipToken;

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
		ShipDefenseTokenId id = new ShipDefenseTokenId(1, 1);
		shipToken = em.find(ShipDefenseToken.class, id);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		shipToken = null;
	}

	@Test
	@DisplayName("Testing basic fields for ShipDefenseToken")
	void testFields() {
		assertNotNull(shipToken);
		assertEquals(shipToken.getAmount(), 1);
	}
	
	@Test
	@DisplayName("Testing relationship between ShipDefenseToken and Ship")
	void testShipRelationship() {
		assertNotNull(shipToken.getShip());
		assertTrue(shipToken.getShip().getName().equals("MC-75 Armored Cruiser"));
		assertEquals(shipToken.getShip().getHull(), 9);
	}
	
	@Test
	@DisplayName("Testing relationship between ShipDefenseToken and DefenseToken")
	void testDefenseTokenRelationship() {
		assertNotNull(shipToken.getDefenseToken());
		assertTrue(shipToken.getDefenseToken().getName().equals("Brace"));
		assertTrue(shipToken.getDefenseToken().getEffect().equals("After damage is totaled, the defender reduces the total by half, rounded up."));
	}

}

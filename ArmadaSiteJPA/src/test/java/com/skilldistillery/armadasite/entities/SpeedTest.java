package com.skilldistillery.armadasite.entities;

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

class SpeedTest {

	private static EntityManagerFactory emf;
	private static EntityManager em;
	private Speed speed;

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
		speed = em.find(Speed.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		speed = null;
	}

	@Test
	@DisplayName("Testing basic fields for Speed class")
	void testFields() {
		assertNotNull(speed);
		assertTrue(speed.getSpeedOne().equals("2"));
		String ticks[] = speed.getSpeedTwo().split("-");
		assertTrue(ticks[0].equals("1"));
		assertTrue(ticks[1].equals("1"));
	}
	
}

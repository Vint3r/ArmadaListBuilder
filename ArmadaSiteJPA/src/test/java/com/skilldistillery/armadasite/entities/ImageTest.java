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

class ImageTest {

	private static EntityManagerFactory emf;
	private static EntityManager em;
	private Image img;

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
		img = em.find(Image.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		img = null;
	}
	
	@Test
	@DisplayName("Testing basic fields in Image class")
	void testImage() {
		assertNotNull(img);
		assertTrue(img.getPhotoUrl().equals(""));
	}
	
	@Test
	@DisplayName("Testing relationship bewteen Image and Ships")
	void testShip() {
		assertNotNull(img.getShips());
		assertEquals(img.getShips().get(0).getCommand(), 3);
		
	}

}

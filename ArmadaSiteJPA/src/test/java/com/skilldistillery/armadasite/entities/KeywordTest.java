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

class KeywordTest {

	private static EntityManagerFactory emf;
	private static EntityManager em;
	private Keyword keyword;

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
		keyword = em.find(Keyword.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		keyword = null;
	}

	@Test
	@DisplayName("Testing basic fields for Keyword class")
	void testFields() {
		assertNotNull(keyword);
		assertTrue(keyword.getName().equals("Assault"));
		assertTrue(keyword.getDescription().equals("While attacking a ship, you may spend 1 die with a hit icon. If you do, the defender gains 1 raid token of your choice."));
	}
	
	@Test
	@DisplayName("Testing relationship between Fighter and Keyword")
	void testKeywordRelationship() {
		assertNotNull(keyword.getFighters());
		assertTrue(keyword.getFighters().get(0).getName().equals("Gar Saxon"));
		assertTrue(keyword.getFighters().get(1).getName().equals("Mandalorian Gauntlet Fighter"));
	}
}

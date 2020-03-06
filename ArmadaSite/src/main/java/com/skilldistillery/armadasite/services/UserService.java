package com.skilldistillery.armadasite.services;

import com.skilldistillery.armadasite.entities.User;

public interface UserService {

	public User getSingleUser(int id);
	public User logIn(String username, String password);
	public User updateUser(User user);
	public User createUser(User user);
	public void deleteUser(User user);
}

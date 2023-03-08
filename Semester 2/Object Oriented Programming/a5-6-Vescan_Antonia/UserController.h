#pragma once
#include "Repository.h"
#include "UserRepo.h"

class UserController {
private:
	Repository* repository;
	UserRepository* userRepository;
public:
	/// <summary>
	/// constructor for the user controller
	/// </summary>
	/// <param name="repository1"></param>
	/// <param name="userRepository1"></param>
	UserController(Repository* repository1, UserRepository* userRepository1);
	/// <summary>
	/// gets all the elements from the array
	/// </summary>
	/// <returns></returns>
	Dog* getAllUserController();
	/// <summary>
	/// gets the nr of elements from the array
	/// </summary>
	/// <returns></returns>
	int getNrElementsUserController();
	/// <summary>
	/// gets the capacity of the array
	/// </summary>
	/// <returns></returns>
	int getCapacityUserController();
	/// <summary>
	/// adds the given dog to the adoption list
	/// </summary>
	/// <param name="dog"></param>
	void addUserController(Dog dog);
	/// <summary>
	/// gets the filtered dogs
	/// </summary>
	/// <param name="valid_dogs"></param>
	/// <param name="given_breed"></param>
	/// <param name="given_age"></param>
	/// <returns></returns>
	int getFilteredDogs(Dog* valid_dogs, string given_breed, int given_age);
	///<summary>
	///destructor
	/// </summary>
	/// <returns></returns>
	~UserController();
};
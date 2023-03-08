#pragma once
#include "Controller.h"
#include "UserController.h"
#include "Validators.h"

class UI {
private:
	Controller& controller;
	UserController& usercontroller;
	Validator& validator;
public:
	UI(Controller& controller, UserController& usercontroller, Validator& validator);
	/// <summary>
	/// function to print the menu for the user
	/// </summary>
	static void printMenu();

	/// <summary>
	/// function to print the repo menu
	/// </summary>
	static void printRepositoryMenu();

	/// <summary>
	/// function to print the adoption menu
	/// </summary>
	static void printAdoptionListMenu();
	void addDogToRepo();
	void removeDogFromRepo();
	void updateDogRepo();
	void listAll();
	void listDogsOneByOne();
	void listFilteredDogs();
	void listAdoptionList();
	void openFile();
	void administratorMode();
	void userMode();
	void run();
	~UI();
};
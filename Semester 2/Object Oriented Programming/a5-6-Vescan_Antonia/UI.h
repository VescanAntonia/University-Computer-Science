#pragma once
#include "Controller.h"
#include "UserController.h"

class UI
{
private:
	Controller *ctrl;
	UserController *userctrl;
public:
	/// <summary>
	/// constructor for the ui
	/// </summary>
	/// <param name="ctrl"></param>
	/// <param name="userctrl"></param>
	UI(Controller* ctrl, UserController* userctrl);
	/// <summary>
	/// the function that runs the program
	/// </summary>
	void run();
private:
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

	/// <summary>
	/// adds the dog to the repository
	/// </summary>
	void addDogToRepository();

	/// <summary>
	/// gets all dogs to be displayed
	/// </summary>
	void displayalldogsRepo();
	
	static bool stringValidator(string givenString);
	/// <summary>
	/// removes a dog from the repo
	/// </summary>
	void removeDogFromRepository();
	/// <summary>
	/// updates a dog with the given information
	/// </summary>
	void updateDogFromRepository();
	/*/// <summary>
	/// adds a dog to the adoption list
	/// </summary>
	void addDogAdoptionList();*/
	
	/// <summary>
	/// function for the user mode
	/// </summary>
	void userMode();
	/// <summary>
	/// function for the administrator mode
	/// </summary>
	void administratorMode();
	/// <summary>
	/// prints the dogs one by one
	/// </summary>
	void listDogsUserOneByOne();
	/// <summary>
	/// lists the filter dogs by breed and given age
	/// </summary>
	void listFilteredUserDogs();
	/// <summary>
	/// prints the list with the addopte dogs
	/// </summary>
	void listAdoptionList();
	///<summary>
	///destructor
	/// </summary>
	/// <returns></returns>
	~UI();
};
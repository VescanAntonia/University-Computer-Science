#pragma once
#include "Repository.h"


class Controller
{
private:
	Repository *repo;
	//AdoptionList* adoptionlist;
	//int current;
public:
	/// <summary>
	/// constructor for the controller
	/// </summary>
	/// <param name="repos">the repository</param>
	Controller(Repository* repos);
	
	/// <summary>
	/// adds a dog to the repo
	/// </summary>
	/// <param name="breed">the breed of the dog</param>
	/// <param name="name">the name of the dog</param>
	/// <param name="age">the age of the dog</param>
	/// <param name="photograph">the photograph of the dog</param>
	/// <returns></returns>
	int addDogRepository(string breed, string name, int age, string photograph);

	/// <summary>
	/// removes a dog from the repo
	/// </summary>
	/// <param name="breed"></param>
	/// <param name="name"></param>
	/// <returns></returns>
	int removeDogRepository(string breed, string name);
	/// <summary>
	/// updates a dog with the given info
	/// </summary>
	/// <param name="breed"></param>
	/// <param name="name"></param>
	/// <param name="newbreed"></param>
	/// <param name="newname"></param>
	/// <param name="newage"></param>
	/// <param name="newphotograph"></param>
	/// <returns></returns>
	int updateDogRepository(string breed, string name, string newbreed, string newname,int newage, string newphotograph);

	/// <summary>
	/// gets all the dogs to be printed
	/// </summary>
	/// <returns></returns>
	Dog* getAllController();
	
	
	/// <summary>
	/// gets the nr of elements in the list of dogs
	/// </summary>
	/// <returns>the nr of elements</returns>
	int getNrElController();
	/// <summary>
	/// gets the capacity 
	/// </summary>
	/// <returns>the capacity</returns>
	int getCapacityController();
	///<summary>
	///destructor
	/// </summary>
	/// <returns></returns>
	~Controller();
};
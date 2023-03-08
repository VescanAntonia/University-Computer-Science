#pragma once
#include "Dog.h"
#include "DynamicVector.h"

class Repository
{
private:
	DynamicVector<Dog>* Dogs;
public:
	/// <summary>
	/// constructor for the repository
	/// </summary>
	/// <param name="repo_array"></param>
	Repository(DynamicVector<Dog>* repo_array);
	/// <summary>
	/// adds a dog to the repo
	/// </summary>
	/// <param name="dog"></param>
	/// <returns></returns>
	void addRepo(const Dog& dog);
	/// <summary>
	/// initiates the repo with the list of dogs
	/// </summary>
	void init_repo();
	/// <summary>
	/// finds a dog by breed and name
	/// </summary>
	/// <param name="breed"></param>
	/// <param name="name"></param>
	/// <returns></returns>
	//Dog findByBreedAndName(const std::string& breed, const std::string& name);
	/// <summary>
	/// removes a dog from the given position
	/// </summary>
	/// <param name="pos"></param>
	/// <returns></returns>
	void removeRepo(int pos);
	/// <summary>
	/// updates a dog with the given information
	/// </summary>
	/// <param name="dog1"></param>
	/// <param name="dog2"></param>
	/// <returns></returns>
	void updateRepo(int pos, const Dog& dog2);
	/// <summary>
	/// finds the position of a dog by its name and breed
	/// </summary>
	/// <param name="breed"></param>
	/// <param name="name"></param>
	/// <returns>an integer which is the position</returns>
	int findPosByBreedAndName(string breed, string name);
	/// <summary>
	/// gets all the repo data
	/// </summary>
	/// <returns></returns>
	Dog* getAllRepo();
	/// <summary>
	/// returns the number of elements in the list
	/// </summary>
	/// <returns></returns>
	int getNrElRepo();
	/// <summary>
	/// gets the capacity of the vector
	/// </summary>
	/// <returns></returns>
	int getCapacityRepo();
	///<summary>
	///destructor
	/// </summary>
	/// <returns></returns>
	~Repository();
};
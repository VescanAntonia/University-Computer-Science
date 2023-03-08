#pragma once
#include "DynamicVector.h"

class UserRepository 
{
private:
	DynamicVector<Dog>* adoptionList;
public:
	/// <summary>
	/// constructor for the user repository
	/// </summary>
	/// <param name="adoptionList2"></param>
	UserRepository(DynamicVector<Dog>* adoptionList2);
	/// <summary>
	/// gets all the elemets from the array
	/// </summary>
	/// <returns></returns>
	Dog* getAllUserRepo();
	/// <summary>
	/// gets the nr of elements from the array
	/// </summary>
	/// <returns></returns>
	int getNrElems();
	/// <summary>
	/// gets the capacity of the array
	/// </summary>
	/// <returns></returns>
	int getCapacity();
	/// <summary>
	/// adds a dog to the adoption list
	/// </summary>
	/// <param name="dog"></param>
	void addUserRepo(const Dog& dog);
	///<summary>
	///destructor
	/// </summary>
	/// <returns></returns>
	~UserRepository();
};
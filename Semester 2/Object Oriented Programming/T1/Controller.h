#pragma once
#include "Repository.h"

class Controller
{
private:
	Repository repo;
public:
	/// <summary>
	/// onstructor for the controller
	/// </summary>
	/// <param name="r"></param>
	Controller (const Repository& r) : repo(r) {};

	/// <summary>
	/// gets the list of patients to be displayed
	/// </summary>
	/// <returns></returns>
	Patient* get_patientscontroller();
	/// <summary>
	/// this function adds a given patient to the list
	/// </summary>
	/// <param name="name">the name</param>
	/// <param name="age">the age</param>
	/// <param name="infected">if it is infected</param>
	/// <param name="room">the room</param>
	/// <param name="quarantined">if it is quarantied</param>
	/// <returns></returns>
	int addController(const std::string&name, int age, bool infected, int room, bool quarantined);
	/// <summary>
	/// removed the given patient from the list
	/// </summary>
	/// <param name="name"></param>
	/// <returns></returns>
	int removeController(const std::string& name);
	/// <summary>
	/// returns the nr of elements in the list
	/// </summary>
	/// <returns></returns>
	int getNRelController();


};
#pragma once
#include "DynamicVector.h"
#include "Patient.h"

class Repository
{
private:
	DynamicVector<Patient> patients;
public:
	/// <summary>
	/// constructor for the repository
	/// </summary>
	Repository(){};
	/// <summary>
	/// gets the list of patients
	/// </summary>
	/// <returns></returns>
	Patient* get_patients_repo();
	/// <summary>
	/// removes a patient
	/// </summary>
	/// <param name="pos"></param>
	/// <returns></returns>
	int removeRepo(int pos);
	/// <summary>
	/// gets the number of patients from the list
	/// </summary>
	/// <returns></returns>
	int getNrelRepo();

	/// <summary>
	/// adds patients to the list
	/// </summary>
	/// <param name="p"></param>
	/// <returns></returns>
	int addRepo(const Patient& p);
	/// <summary>
	/// checks if there is a patient with the given name
	/// </summary>
	/// <param name="name"></param>
	/// <returns></returns>
	int existsByName(const std::string& name);
};